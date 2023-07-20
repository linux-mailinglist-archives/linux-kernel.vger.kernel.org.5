Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1842475AB62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGTJs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjGTJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:11 -0400
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [IPv6:2001:41d0:1004:224b::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974AB2708
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:47:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HexLk5YdZ9UMqQVRKs36MeqJ3bE8mocAttG9oHtUF6A=;
        b=T3g0daIqsxUtbedfWKPmCc61Qc12FtWKResFJpeO2mr/aRXdYhFQp9Pq27ndDZNyrYc5Kt
        7uDJsxRP4E45zPxPxh7vmCqiZoRPQfuQmeTGRkOu8Atn66cRWwHReZ+iWGrbu+ify0SdMJ
        eCiiqpd8AYC3WMEkSJGYMsndmZ5Jq5E=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 2/6] sbitmap: fix round-robin non-wrap find with hint > 0
Date:   Thu, 20 Jul 2023 17:45:51 +0800
Message-ID: <20230720094555.1397621-3-chengming.zhou@linux.dev>
In-Reply-To: <20230720094555.1397621-1-chengming.zhou@linux.dev>
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

If we have alloc_hint > 0 and don't wrap, we need to recheck
sb->map[index] with hint == 0 to exhaust the map.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 5ed6c2adf58e..ccb96d1f92ba 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -192,10 +192,18 @@ static int sbitmap_find_bit(struct sbitmap *sb,
 			    unsigned int alloc_hint,
 			    bool wrap)
 {
+	unsigned int map_nr = sb->map_nr;
 	unsigned int i;
 	int nr = -1;
 
-	for (i = 0; i < sb->map_nr; i++) {
+	/*
+	 * If we have alloc_hint > 0 and don't wrap, we need to
+	 * recheck sb->map[index] with hint == 0 to exhaust the map.
+	 */
+	if (alloc_hint && !wrap)
+		map_nr += 1;
+
+	for (i = 0; i < map_nr; i++) {
 		nr = sbitmap_find_bit_in_word(&sb->map[index],
 					      min_t(unsigned int,
 						    __map_depth(sb, index),
-- 
2.41.0

