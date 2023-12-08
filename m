Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C598A809C12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjLHF5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjLHF5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:57:06 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17F1FEE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:56:45 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fb28b4b7e2so2440156fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702015004; x=1702619804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isVzN1pEksgo9KbKcT6Bm9NG+s2hsO68xC5mltUUwTs=;
        b=wzmomigeMlbRxAVD11uGMpDBUbR5HFdyLpS3IX8Dt0D2HO57RR0CqoDRyy+CZa37Ln
         UFOWOkTX8+WHef6B+Avx6EP4Si+SuhI8MloRGKlydvomzicXDQKstCMGG0FqkmwgnhYG
         6rACVBWzljmxKST1UqDJlVtAyAi0sI35HO2++dkvT6S8aKGbKRLi2ibY1z6Tq7xNUlXe
         Dg+1ANckOt/jUoJQQ/9zvDMJa6FfIUkmHWzh23zqkzM0fmkB+cFqr8XOxIEigbqpxE31
         erAOJR9iAM6NZzfvROPdYmBlx8KF2YkrH39FxAg96yMfZXlCTdb2jrNWGwMuDUfE/Dko
         xREQ==
X-Gm-Message-State: AOJu0Yw/HDLL234mTTZSAlM9wVqQbmwzymlKQc3hpcx5477bc87M/2Qa
        3HdaqEBtqp6Ae4oRIOcg5ZP61zmRFCUSSxiKP38mWzDxH8P3bh8=
X-Google-Smtp-Source: AGHT+IGqOqYJK/acjaTE0RfjziknRlrBU1MUKVC04Ts/L7PcUpReAlX28mRbt8iKBn4D/R5W+U9iQbXQz5xmGbFSYNay3SDiTBhS
MIME-Version: 1.0
X-Received: by 2002:a05:6870:390a:b0:1fb:2a24:f0a9 with SMTP id
 b10-20020a056870390a00b001fb2a24f0a9mr411291oap.1.1702015004548; Thu, 07 Dec
 2023 21:56:44 -0800 (PST)
Date:   Thu, 07 Dec 2023 21:56:44 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfa614060bf93f2b@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [arm-msm?] [net?] memory leak in radix_tree_insert
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33cc938e65a9

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..5c2f9d8f2c3e 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -714,8 +714,10 @@ int radix_tree_insert(struct radix_tree_root *root, unsigned long index,
 		return error;
 
 	error = insert_entries(node, slot, item);
-	if (error < 0)
+	if (error < 0) {
+		__radix_tree_delete(root, node, slot);
 		return error;
+	}
 
 	if (node) {
 		unsigned offset = get_slot_offset(node, slot);
@@ -55,6 +55,8 @@ struct kmem_cache *radix_tree_node_cachep;
 #define IDR_MAX_PATH		(DIV_ROUND_UP(IDR_INDEX_BITS, \
 						RADIX_TREE_MAP_SHIFT))
 #define IDR_PRELOAD_SIZE	(IDR_MAX_PATH * 2 - 1)
+static bool __radix_tree_delete(struct radix_tree_root *root,
+				struct radix_tree_node *node, void __rcu **slot);
 
 /*
  * Per-cpu pool of preloaded nodes
