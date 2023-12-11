Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BCA80CCA1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbjLKOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbjLKOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A8E47AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702303199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jNtOY4LpZQRmFFwaKjy6gBWig0U9E1fsIgKhcHzr1a8=;
        b=JLUZYGk0tqtYaPJ5kVPbIjFzzfHonixcfZP0yrCmCO8K54K7BensbDTstb4FMgU/QszSQl
        /8X1w74FjmOe5EtlzRd6cR/rfBZxCVy5YanV436wY2/bYOmH5eS0AabyG8IMwtErBLPA9W
        28YNXI2TBVfL9DRSk535gQnFpk827iE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-_PvnCrkVPaSjqHyG2M3OuQ-1; Mon, 11 Dec 2023 08:59:58 -0500
X-MC-Unique: _PvnCrkVPaSjqHyG2M3OuQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ce6fa748c5so5309531b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303197; x=1702907997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNtOY4LpZQRmFFwaKjy6gBWig0U9E1fsIgKhcHzr1a8=;
        b=k+pCe8xC+zQRzGgkIDlb/pWlZXxMEAKL5IsqEoxbvR2FREcbCNyZg/wC/1oscunJpe
         cuvxLSOihnnhOHTaYuSBS19y8h+iFASTDPCWXwAkz9D0p0qirQprmw0i2y8hdO7uqwf8
         5ZXXqXuCWeGXUkYBGGg7aH+/dosNwBmJUBVrnfWxf5vQJsMn94EQSM/X71S7w8o8kRnL
         UI6bxwQ2DzutxiVTrqMuJXxZVOII/LSXOHa8p0uJuHcDb5R6uLRhODLi3tWRMvf4SxFp
         Nl5dUTLjq1N1apMzWlMqM29uE6SlzR23EPaqkquzfm3le77mJSId/ZZPw5ZFbRVbiyHu
         YYFA==
X-Gm-Message-State: AOJu0Yye3ooGUw3iuRhgQ/4qyJIWkz+fyY8CMobJvxYTfCgGiBaeLG64
        uWM5uqLHSWdXpZFJIEQlY1fwqlkWnPFSph32P3+ZZrXKIVGFhqRnpbgmADq/UIWExhXfejvyYjs
        qTMF3R9eCxtxkDHax8tZOmmAsC2TPyfKA
X-Received: by 2002:a05:6a00:4b05:b0:6cd:8a19:c324 with SMTP id kq5-20020a056a004b0500b006cd8a19c324mr5065046pfb.3.1702303196832;
        Mon, 11 Dec 2023 05:59:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH8pcpJUYWrPme/AvUNGcFfSPB3UcpRig9J/TmAImLAZ/9Rz5Hmp0l8B3NXjdGvBgSAZW9vA==
X-Received: by 2002:a05:6a00:4b05:b0:6cd:8a19:c324 with SMTP id kq5-20020a056a004b0500b006cd8a19c324mr5065039pfb.3.1702303196506;
        Mon, 11 Dec 2023 05:59:56 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id ei43-20020a056a0080eb00b006ce6e431292sm6280383pfb.38.2023.12.11.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:59:56 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     dhowells@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] crypto: af_alg/hash: Fix uninit-value access in af_alg_free_sg()
Date:   Mon, 11 Dec 2023 22:59:49 +0900
Message-ID: <20231211135949.689204-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reported the following uninit-value access issue:

=====================================================
BUG: KMSAN: uninit-value in af_alg_free_sg+0x1c1/0x270 crypto/af_alg.c:547
 af_alg_free_sg+0x1c1/0x270 crypto/af_alg.c:547
 hash_sendmsg+0x188f/0x1ce0 crypto/algif_hash.c:172
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x997/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x2fa/0x4a0 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x103/0x9e0 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5d5/0x9b0 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x118/0x410 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 sock_kmalloc+0x104/0x1a0 net/core/sock.c:2681
 hash_accept_parent_nokey crypto/algif_hash.c:418 [inline]
 hash_accept_parent+0xbc/0x470 crypto/algif_hash.c:445
 af_alg_accept+0x1d8/0x810 crypto/af_alg.c:439
 hash_accept+0x368/0x800 crypto/algif_hash.c:254
 do_accept+0x803/0xa70 net/socket.c:1927
 __sys_accept4_file net/socket.c:1967 [inline]
 __sys_accept4+0x170/0x340 net/socket.c:1997
 __do_sys_accept4 net/socket.c:2008 [inline]
 __se_sys_accept4 net/socket.c:2005 [inline]
 __x64_sys_accept4+0xc0/0x150 net/socket.c:2005
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 14168 Comm: syz-executor.2 Not tainted 6.7.0-rc4-00009-gbee0e7762ad2 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
=====================================================

In hash_sendmsg(), hash_alloc_result() may fail and return -ENOMEM if
sock_kmalloc() fails. In this case, hash_sendmsg() jumps to the unlock_free
label and calls af_alg_free_sg() with ctx->sgl.sgt.sgl uninitialized. This
causes the above uninit-value access issue for ctx->sgl.sgt.sgl.

This patch fixes this issue by initializing ctx->sgl.sgt.sgl when the
structure is allocated in hash_accept_parent_nokey().

Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 crypto/algif_hash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 82c44d4899b9..a51b58d36d60 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -419,6 +419,7 @@ static int hash_accept_parent_nokey(void *private, struct sock *sk)
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->sgl.sgt.sgl = NULL;
 	ctx->result = NULL;
 	ctx->len = len;
 	ctx->more = false;
-- 
2.41.0

