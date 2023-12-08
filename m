Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91BC809FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjLHJpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjLHJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:45:37 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42E690
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:45:43 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fafbf42404so3430617fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 01:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702028743; x=1702633543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAjnMRUxSxfpb3qrgmgdoXzAqWKDHCjSJPqxcRRXhMM=;
        b=N/QoSoNo58HZc0BVcFlhU80nqWP99H1Agtt4JMw1QJ6TOSJBQg4uavy9Sjky6QZ7/f
         8bOjkmwI3u6+mOIg44Gvu4aIWw2endt9wjJAci+C4G40HO9m0L8tCSC1olXmRD8625L7
         GQeUtGg0jQCeLEIIb172M1+zgFuxNeOmY8IGLeeJkRHEMnWQ3Q/WVSbMk7OSMyC9X/Ye
         v5di/8C9+T7icYqrn482K5wuoyT03kOOMRY2lubJwCrauC8TmnKaN2u6UnUf4j+/kJuo
         KST2Fh0oDzCNGz07sjtQB+AyJYXNrwi9cnHVQrwIQFg5jGE217R1kABSMnBL62AuJ9oD
         +sQQ==
X-Gm-Message-State: AOJu0YwvQ6nhfwC6ZEEH0f3BQdSnwCtaJYEnDY+feoeZyzG+gGtIs8vN
        DjfvGdhjJ41J0x3axVAFfl9OOJd2zYR0LfjInDWB2WmcZPU+r2A=
X-Google-Smtp-Source: AGHT+IHoYiT6dgRRk/BQldHBRt2W/ufg4Eu51LcU7njT8M2Mk0qPeF96Hi93e1MBOhUeLkEOkrrbtSF5w5HW5V6ONsfG1gNjOmra
MIME-Version: 1.0
X-Received: by 2002:a05:6870:2409:b0:1fa:ed68:afc1 with SMTP id
 n9-20020a056870240900b001faed68afc1mr5100367oap.4.1702028743280; Fri, 08 Dec
 2023 01:45:43 -0800 (PST)
Date:   Fri, 08 Dec 2023 01:45:43 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a414b7060bfc72b3@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 976b9bd02a1b..b98e9f2c24ac 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -55,6 +55,8 @@ struct kmem_cache *radix_tree_node_cachep;
 #define IDR_MAX_PATH		(DIV_ROUND_UP(IDR_INDEX_BITS, \
 						RADIX_TREE_MAP_SHIFT))
 #define IDR_PRELOAD_SIZE	(IDR_MAX_PATH * 2 - 1)
+static bool __radix_tree_delete(struct radix_tree_root *root,
+				struct radix_tree_node *node, void __rcu **slot);
 
 /*
  * Per-cpu pool of preloaded nodes
@@ -714,8 +716,10 @@ int radix_tree_insert(struct radix_tree_root *root, unsigned long index,
 		return error;
 
 	error = insert_entries(node, slot, item);
-	if (error < 0)
+	if (error < 0) {
+		__radix_tree_delete(root, node, slot);
 		return error;
+	}
 
 	if (node) {
 		unsigned offset = get_slot_offset(node, slot);
-- 
2.43.0

