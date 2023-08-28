Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3961A78B291
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjH1OE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjH1OEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B1BA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 931D3648EE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC948C433C9;
        Mon, 28 Aug 2023 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693231467;
        bh=f4hmSgSOl/WVTXPEKDNSnKlH4/2yov+TX2iMMY7IA4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8Wj07gI/g/O9qcP2we66ARXQXmRJvil5y8pL7H2GiyLjJkKrTrxymWoYtvmDmYmj
         pLeNELmV1ffI0hnTVjVUEUKtPAZD4wk8W3I9KSrONeBecs6V7agzrZFfAoc2Mteup5
         iZ3haCpylhrAYFx1PRQsm1tmRDnrbwLNPeCRmhw45FQM4+w9vpkVXLjqxDd0o/2wmL
         cyzJLsVCYzYBtqKt5Yosphi2kDT0L3KywRQvB0Kwc9sjpWGN+Fr4gcbpJxtJ4ktbDT
         jAhzTks8y1Op6YMFpiRWXBXy4WePcllqP8zamU7D2x1kb5+HPKyc6D0FOk3asofH0l
         w7mhNGD+URr7w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs: compress: fix to avoid redundant compress extension
Date:   Mon, 28 Aug 2023 22:04:17 +0800
Message-Id: <20230828140417.2951796-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828140417.2951796-1-chao@kernel.org>
References: <20230828140417.2951796-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With below script, redundant compress extension will be parsed and added
by parse_options(), because parse_options() doesn't check whether the
extension is existed or not, fix it.

1. mount -t f2fs -o compress_extension=so /dev/vdb /mnt/f2fs
2. mount -t f2fs -o remount,compress_extension=so /mnt/f2fs
3. mount|grep f2fs

/dev/vdb on /mnt/f2fs type f2fs (...,compress_extension=so,compress_extension=so,...)

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Fixes: 151b1982be5d ("f2fs: compress: add nocompress extensions support")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8d9d2ee7f3c7..68895be6407f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -547,6 +547,29 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
+static bool is_compress_extension_exist(struct f2fs_sb_info *sbi,
+					const char *new_ext, bool is_ext)
+{
+	unsigned char (*ext)[F2FS_EXTENSION_LEN];
+	int ext_cnt;
+	int i;
+
+	if (is_ext) {
+		ext = F2FS_OPTION(sbi).extensions;
+		ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
+	} else {
+		ext = F2FS_OPTION(sbi).noextensions;
+		ext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+	}
+
+	for (i = 0; i < ext_cnt; i++) {
+		if (!strcasecmp(new_ext, ext[i]))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * 1. The same extension name cannot not appear in both compress and non-compress extension
  * at the same time.
@@ -1149,6 +1172,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			}
 
+			if (is_compress_extension_exist(sbi, name, true)) {
+				kfree(name);
+				break;
+			}
+
 			strcpy(ext[ext_cnt], name);
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
@@ -1173,6 +1201,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			}
 
+			if (is_compress_extension_exist(sbi, name, false)) {
+				kfree(name);
+				break;
+			}
+
 			strcpy(noext[noext_cnt], name);
 			F2FS_OPTION(sbi).nocompress_ext_cnt++;
 			kfree(name);
-- 
2.40.1

