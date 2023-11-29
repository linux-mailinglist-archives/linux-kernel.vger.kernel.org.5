Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D67FD912
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjK2OPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjK2OPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:15:46 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795DDB6;
        Wed, 29 Nov 2023 06:15:52 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cde104293fso24144b3a.0;
        Wed, 29 Nov 2023 06:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701267352; x=1701872152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vb8g66mfFbIMjCeR2wNWdnqsBfEhhzuBJzKufy7dmOQ=;
        b=CCgUwRvBggVg4HBwL79t3m6++bXrI68b1/s6ZMdrj09SYfTdfiv6py1dxwvcq9pkdC
         gXLDIDRJlP2VTOAMnAltDmGljqHwtIXDc9FuSbFHJlwzg3xykDVPHedYkZka1VsykAOj
         2x/Kam/5kDAuqqEOfNaXrTNdtfxk/8elx8MdW7sx8SX2mGk4rm03pHNNVseUX4DH2+MM
         4/0XuS009RS9ubt/i1zOUZ/C4SkwFqa4QgRLRmh8O7waU6SeiaooUhHOm/10Ntd5KARa
         G3DfXZT/h6GaX7T8M0MW1xplmmfMJ9RHBWKU4ibSQ0/6a2JWwegXVLE10SEoTw7CVlb7
         NsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267352; x=1701872152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vb8g66mfFbIMjCeR2wNWdnqsBfEhhzuBJzKufy7dmOQ=;
        b=BFbK9ai5LKjBDCLVLnhkHh0h4LcGWDN4g9L/3mi3Snk42sddEITZosMeude1Up1PcA
         FjAW9BsjfY4TgVndC/oXpRAXe8vXc70cgaZz7tGowc+DQuM8AzZnDbMcxeySbUignjhs
         3VtTB+uD1GCLo+H7UxDqTRGtfRBz4ZIiGNlRXjurLfrM0WIZtYozn0yck88bOtW9rEzz
         yIePsUAcLWaj/jApjganLPcSf9kRv52KRgOmmc6UVMrJgiOFEIm89ut8Z8j0QRSOegFG
         mwjedE0CtSgoXfk7ZXAwCb093Tz4aXLvvgWShkIH0i3S4+L1FfSgFssiUMwp5EFHCBwc
         9Dtg==
X-Gm-Message-State: AOJu0Yy+8oW4P9XyKh/hXaaMQiTK9rTeH+2uHYsNw01d+XO6VL4J0bCM
        DJaspNPTZsgm3HkoAthXjHphaVYjhm0=
X-Google-Smtp-Source: AGHT+IEhwSJndRMe5XgIgpVlPbAoYpAql6MLLqo4z72b5wYkM/HeCrkAA1F7etxiYGN5p1wfQj4FXw==
X-Received: by 2002:a05:6a00:f8a:b0:690:d620:7801 with SMTP id ct10-20020a056a000f8a00b00690d6207801mr18137408pfb.11.1701267351701;
        Wed, 29 Nov 2023 06:15:51 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id u26-20020a62ed1a000000b006cbcd08ed56sm10753018pfh.56.2023.11.29.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:15:51 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: fix missing error check for sb_set_blocksize call
Date:   Wed, 29 Nov 2023 23:15:47 +0900
Message-Id: <20231129141547.4726-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mounting a filesystem image with a block size larger than the
page size, nilfs2 repeatedly outputs long error messages with stack
traces to the kernel log, such as the following:

 getblk(): invalid block size 8192 requested
 logical block size: 512
 ...
 Call Trace:
  dump_stack_lvl+0x92/0xd4
  dump_stack+0xd/0x10
  bdev_getblk+0x33a/0x354
  __breadahead+0x11/0x80
  nilfs_search_super_root+0xe2/0x704 [nilfs2]
  load_nilfs+0x72/0x504 [nilfs2]
  nilfs_mount+0x30f/0x518 [nilfs2]
  legacy_get_tree+0x1b/0x40
  vfs_get_tree+0x18/0xc4
  path_mount+0x786/0xa88
  __ia32_sys_mount+0x147/0x1a8
  __do_fast_syscall_32+0x56/0xc8
  do_fast_syscall_32+0x29/0x58
  do_SYSENTER_32+0x15/0x18
  entry_SYSENTER_32+0x98/0xf1
 ...

This overloads the system logger.  And to make matters worse, it
sometimes crashes the kernel with a memory access violation.

This is because the return value of the sb_set_blocksize() call, which
should be checked for errors, is not checked.

The latter issue is due to out-of-buffer memory being accessed based
on a large block size that caused sb_set_blocksize() to fail for
buffers read with the initial minimum block size that remained
unupdated in the super_block structure.

Since nilfs2 mkfs tool does not accept block sizes larger than the
system page size, this has been overlooked.  However, it is possible
to create this situation by intentionally modifying the tool or by
passing a filesystem image created on a system with a large page size
to a system with a smaller page size and mounting it.

Fix this issue by inserting the expected error handling for the call
to sb_set_blocksize().

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
Andrew, please apply this as a bugfix.  This fixes a memory access
violation and flood of log output when trying to mount a filesystem
image with a block size larger than the page size.

fs/nilfs2/the_nilfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 0f0667957c81..71400496ed36 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -716,7 +716,11 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 			goto failed_sbh;
 		}
 		nilfs_release_super_block(nilfs);
-		sb_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize)) {
+			nilfs_err(sb, "bad blocksize %d", blocksize);
+			err = -EINVAL;
+			goto out;
+		}
 
 		err = nilfs_load_super_block(nilfs, sb, blocksize, &sbp);
 		if (err)
-- 
2.34.1

