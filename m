Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA89475E7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGXBf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjGXBfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:35:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8C046A8;
        Sun, 23 Jul 2023 18:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E93660F6D;
        Mon, 24 Jul 2023 01:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F91C433C8;
        Mon, 24 Jul 2023 01:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162274;
        bh=Cwf9nx8+KvKrxKToNudI0zZPDzMtyKP9SFlfTc0URjM=;
        h=From:To:Cc:Subject:Date:From;
        b=ndnnWGZX80RmOV82w53f21JSPsY22fyWR2xrvq0CJz8Tfg8VoGvAWOxDeqtl+iunB
         oisrnoSTtEFuOvJY+VndMI53D+QsxVCV1GW0iIv/5IAyzATu4OExG5SALEh20rEMei
         hCJ9xIo5iOZ5Ol4FDKIV4jPdjxcwbxT4LCwA1+Hy0BTXBd5JrxUvAnGdbvp7+SDGw6
         gBs07+stilE1LaymfDHyNlgOJDxu25+aZR5LzCjYeGOto18GtdFpQuItZlf9MSl8LM
         dlVygXuckoRJ+oaSBYxgdS19wi9VxuXUZc0M5B7AroMdX4b2Z+ZQgl1iVc//iF5EsI
         xYJ/FuGpVKLDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anisse Astier <an.astier@criteo.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>, matt@codeblueprint.co.uk,
        ard.biesheuvel@linaro.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, matthew.garrett@nebula.com,
        jk@ozlabs.org, linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 1/4] efivarfs: expose used and total size
Date:   Sun, 23 Jul 2023 21:31:08 -0400
Message-Id: <20230724013111.2327251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anisse Astier <an.astier@criteo.com>

[ Upstream commit d86ff3333cb1d5f42d8898fb5fdb304e143c0237 ]

When writing EFI variables, one might get errors with no other message
on why it fails. Being able to see how much is used by EFI variables
helps analyzing such issues.

Since this is not a conventional filesystem, block size is intentionally
set to 1 instead of PAGE_SIZE.

x86 quirks of reserved size are taken into account; so that available
and free size can be different, further helping debugging space issues.

With this patch, one can see the remaining space in EFI variable storage
via efivarfs, like this:

   $ df -h /sys/firmware/efi/efivars/
   Filesystem      Size  Used Avail Use% Mounted on
   efivarfs        176K  106K   66K  62% /sys/firmware/efi/efivars

Signed-off-by: Anisse Astier <an.astier@criteo.com>
[ardb: - rename efi_reserved_space() to efivar_reserved_space()
       - whitespace/coding style tweaks]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/quirks.c |  8 +++++++
 drivers/firmware/efi/efi.c     |  1 +
 drivers/firmware/efi/vars.c    | 12 +++++++++++
 fs/efivarfs/super.c            | 39 +++++++++++++++++++++++++++++++++-
 include/linux/efi.h            | 11 ++++++++++
 5 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index b0b848d6933af..f0cc00032751d 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -114,6 +114,14 @@ void efi_delete_dummy_variable(void)
 				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
 }
 
+u64 efivar_reserved_space(void)
+{
+	if (efi_no_storage_paranoia)
+		return 0;
+	return EFI_MIN_RESERVE;
+}
+EXPORT_SYMBOL_GPL(efivar_reserved_space);
+
 /*
  * In the nonblocking case we do not attempt to perform garbage
  * collection if we do not have enough free space. Rather, we do the
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 34b9e78765386..91d986a741dad 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -211,6 +211,7 @@ static int generic_ops_register(void)
 	generic_ops.get_variable = efi.get_variable;
 	generic_ops.get_next_variable = efi.get_next_variable;
 	generic_ops.query_variable_store = efi_query_variable_store;
+	generic_ops.query_variable_info = efi.query_variable_info;
 
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
 		generic_ops.set_variable = efi.set_variable;
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index bfc5fa6aa47b6..e9dc7116daf13 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -245,3 +245,15 @@ efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	return status;
 }
 EXPORT_SYMBOL_NS_GPL(efivar_set_variable, EFIVAR);
+
+efi_status_t efivar_query_variable_info(u32 attr,
+					u64 *storage_space,
+					u64 *remaining_space,
+					u64 *max_variable_size)
+{
+	if (!__efivars->ops->query_variable_info)
+		return EFI_UNSUPPORTED;
+	return __efivars->ops->query_variable_info(attr, storage_space,
+			remaining_space, max_variable_size);
+}
+EXPORT_SYMBOL_NS_GPL(efivar_query_variable_info, EFIVAR);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 482d612b716bb..e028fafa04f38 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -13,6 +13,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/slab.h>
 #include <linux/magic.h>
+#include <linux/statfs.h>
 
 #include "internal.h"
 
@@ -23,8 +24,44 @@ static void efivarfs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
+static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	const u32 attr = EFI_VARIABLE_NON_VOLATILE |
+			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			 EFI_VARIABLE_RUNTIME_ACCESS;
+	u64 storage_space, remaining_space, max_variable_size;
+	efi_status_t status;
+
+	status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
+					    &max_variable_size);
+	if (status != EFI_SUCCESS)
+		return efi_status_to_err(status);
+
+	/*
+	 * This is not a normal filesystem, so no point in pretending it has a block
+	 * size; we declare f_bsize to 1, so that we can then report the exact value
+	 * sent by EFI QueryVariableInfo in f_blocks and f_bfree
+	 */
+	buf->f_bsize	= 1;
+	buf->f_namelen	= NAME_MAX;
+	buf->f_blocks	= storage_space;
+	buf->f_bfree	= remaining_space;
+	buf->f_type	= dentry->d_sb->s_magic;
+
+	/*
+	 * In f_bavail we declare the free space that the kernel will allow writing
+	 * when the storage_paranoia x86 quirk is active. To use more, users
+	 * should boot the kernel with efi_no_storage_paranoia.
+	 */
+	if (remaining_space > efivar_reserved_space())
+		buf->f_bavail = remaining_space - efivar_reserved_space();
+	else
+		buf->f_bavail = 0;
+
+	return 0;
+}
 static const struct super_operations efivarfs_ops = {
-	.statfs = simple_statfs,
+	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
 	.evict_inode = efivarfs_evict_inode,
 };
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 571d1a6e1b744..120af31a5136f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1042,6 +1042,7 @@ struct efivar_operations {
 	efi_set_variable_t *set_variable;
 	efi_set_variable_t *set_variable_nonblocking;
 	efi_query_variable_store_t *query_variable_store;
+	efi_query_variable_info_t *query_variable_info;
 };
 
 struct efivars {
@@ -1049,6 +1050,12 @@ struct efivars {
 	const struct efivar_operations *ops;
 };
 
+#ifdef CONFIG_X86
+u64 __attribute_const__ efivar_reserved_space(void);
+#else
+static inline u64 efivar_reserved_space(void) { return 0; }
+#endif
+
 /*
  * The maximum size of VariableName + Data = 1024
  * Therefore, it's reasonable to save that much
@@ -1087,6 +1094,10 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
 efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 				 u32 attr, unsigned long data_size, void *data);
 
+efi_status_t efivar_query_variable_info(u32 attr, u64 *storage_space,
+					u64 *remaining_space,
+					u64 *max_variable_size);
+
 #if IS_ENABLED(CONFIG_EFI_CAPSULE_LOADER)
 extern bool efi_capsule_pending(int *reset_type);
 
-- 
2.39.2

