Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FEE75AB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGTJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGTJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:49:27 -0400
Received: from out-34.mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E1189
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:47:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYyPqspkOuXVMavHO7B8mxFBAqzpe8Xduz/Ay3699EE=;
        b=pw5sQb18kA//kymlNb+qvXIDo6jCV6+mmT0zU6VFQozPJNN8PoBdLacoMJrd/1FqdpJvcW
        VwuVolXq85zUUtFfX40ZQSiEGTsPAgEbohducF49YxBq9Q/Wf59Odv9Bl0BlUS6IqohIJQ
        /iml5vko4ls+yXcePH2pF7w/oW2Of3U=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 6/6] sbitmap: check ws_active before check waitqueues
Date:   Thu, 20 Jul 2023 17:45:55 +0800
Message-ID: <20230720094555.1397621-7-chengming.zhou@linux.dev>
In-Reply-To: <20230720094555.1397621-1-chengming.zhou@linux.dev>
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

When !ws_active, we don't need to check waitqueues at all. So add
this check in sbitmap_queue_wake_all(), like we do in
sbitmap_queue_wake_up().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 6778ab3fc6a5..38c265e4ef9d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -672,6 +672,10 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq)
 	 * sbitmap_queue_wake_up().
 	 */
 	smp_mb();
+
+	if (!atomic_read(&sbq->ws_active))
+		return;
+
 	wake_index = READ_ONCE(sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
-- 
2.41.0

