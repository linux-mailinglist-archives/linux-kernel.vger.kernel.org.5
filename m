Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E8755C44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGQG6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGQG6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:58:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7426F10C6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:58:44 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76571dae5feso410442385a.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1689577123; x=1692169123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrMY6kjr/TWa2vf5zCji0/y76YkEG4cLXIAfa8PuWOk=;
        b=RNSGMmuAzOrPik9u5wmSsHa6+R3x+CA5yez/pevLChoMshUcbGsjmNCNkDXvkedq2a
         oPscAApDRxykDSy/5+idTYD+XpdNUtuffPNXSJYRanB5KCrj3feq2B492CmoUie+TXeO
         ZgjQ2h1614Hi/42uAFgXVmYbOVdxmQohn/GG8q/gFmNkDYnGO3o8c7Dl5U2hDv46hz/R
         TRZo+p3VfaCjmA0tEMPOd5bvp8EL0URdhipCKy1BuctFtf15LGx46k9g2NBRNQwWm1FC
         c1BHX2xHEgCoLTwbC5KTZwk/X8qcjq0p2yy8PuIJTBkjGMhiV5TYtHiEZRhJqQluq/s0
         EAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689577123; x=1692169123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrMY6kjr/TWa2vf5zCji0/y76YkEG4cLXIAfa8PuWOk=;
        b=fmkzQM+STt/q1buSMKnUVd2PdHBdDEwCd+Bns4RG0gOMgITknnhb/N25jLRgStYql2
         fYZ1BoWDLjq8ZZoR9F7zz50MhcSF+fou7xvKJPUl3I8ozf8j/Gv4YMppvKJRibUsFOR6
         2DvAMgAcracfAjdQV0TUZgWtQiAMfy3sQ15jE7KPPBG7tlM+5aBSvrpuDLZCZmjXAXQc
         OTb2Fy7UNz4fm6RNd8JvWPegd2op+BGVbJpnj5tZlR1KjRhnts9Y7xVP6zLAjLBg78VR
         h5Sc122VX6afcCE095YvzmdNkN2BPdajQP2k5OKakrRMaEOxNKL+hZJ79XbdZQqb8LV5
         FqOg==
X-Gm-Message-State: ABy/qLYNi4vVyDWwfkPc4Vquokslxgy66UY2DkuTVVlcRU1PLX+J7eYa
        jjsTS8XBOrFDHczHoLQGJhkLiQ==
X-Google-Smtp-Source: APBJJlEYgTNXkjfWjz5ceroR4emM3h1NVkCv+IL3ZDYwfUYkw0Em3CSz/hMTI41rBunpHcx2XWdc6Q==
X-Received: by 2002:a05:620a:1726:b0:767:352d:54f4 with SMTP id az38-20020a05620a172600b00767352d54f4mr13739339qkb.30.1689577123576;
        Sun, 16 Jul 2023 23:58:43 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b001b53953f314sm12218291pln.23.2023.07.16.23.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:58:43 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm/mm_init.c: drop node_start_pfn from adjust_zone_range_for_zone_movable()
Date:   Mon, 17 Jul 2023 06:58:11 +0000
Message-Id: <20230717065811.1262-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

node_start_pfn is not used in adjust_zone_range_for_zone_movable(), so
it is pointless to waste a function argument. Drop the parameter.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index a313d1828a6c..23d50541e1f7 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1105,7 +1105,6 @@ void __ref memmap_init_zone_device(struct zone *zone,
  */
 static void __init adjust_zone_range_for_zone_movable(int nid,
 					unsigned long zone_type,
-					unsigned long node_start_pfn,
 					unsigned long node_end_pfn,
 					unsigned long *zone_start_pfn,
 					unsigned long *zone_end_pfn)
@@ -1222,9 +1221,8 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
 	/* Get the start and end of the zone */
 	*zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
 	*zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
-	adjust_zone_range_for_zone_movable(nid, zone_type,
-				node_start_pfn, node_end_pfn,
-				zone_start_pfn, zone_end_pfn);
+	adjust_zone_range_for_zone_movable(nid, zone_type, node_end_pfn,
+					   zone_start_pfn, zone_end_pfn);
 
 	/* Check that this node has pages within the zone's required range */
 	if (*zone_end_pfn < node_start_pfn || *zone_start_pfn > node_end_pfn)
-- 
2.25.1

