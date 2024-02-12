Return-Path: <linux-kernel+bounces-61418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783385121F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024F8283154
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB6D39AC2;
	Mon, 12 Feb 2024 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taRsQhk7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE82BAE7;
	Mon, 12 Feb 2024 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737029; cv=none; b=ccHYdL/8+LPg5wtUb1wQ28sPDPNlJ425F+c6+7wNfsKacqWskp4hS0toMdxDXleheVEcXn+RRtk+hQV6FTH52fprEk+D8387LbWZIkEEBrUWsc8HC20dvJD/W2IpTkxQH45GF7z5iNrfX0KPZ6IErSHUKO+JEzQ8aY/ZJF2xC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737029; c=relaxed/simple;
	bh=QWBljQ37tVO9zYHpDIfIS7N57SgyU4Ob3klCDZ6vAGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LSOxOVrfwSRyE574JLjJT/0KVyKorFJTNouhjBwjwIixztKRXUzRg1o7WF4i8b1d6uOYZDgHg23GVlCUQzeNLAPxcukxkY7+LnXaO/LZvoVEWTzGrL2UocJofBmjzZBMti4mJ8p8WB3SdDlbCBDlFtubh15XKxKeNVcYPG9+7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taRsQhk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F35C433C7;
	Mon, 12 Feb 2024 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707737028;
	bh=QWBljQ37tVO9zYHpDIfIS7N57SgyU4Ob3klCDZ6vAGI=;
	h=From:To:Cc:Subject:Date:From;
	b=taRsQhk7qi6FZ2wfVKxUhQnWohy/ynKu5x/Bs7k7woKlhf2XofhnCymJgSM3AFa2a
	 3+pDcgzfZnp7rg9XH7aeyMaDPh6O4fL8m6Tx/B4w/rnZkJly3eDzwP9A75DBEpWAy4
	 ho1uRuyQMnmPA4aplPMfWBDC52Oh3PPWbL41lLVuCwbTZcWGNWE9HJltrRTgHsk9mp
	 iYxxAfIRuKbz+WsNPiRiBJJJ0jppet9Ab4IHzOTOxhgIuLn+y3SuXchunBJu4Ve0IY
	 Zazigy2p8nfPCsEcDB3KyASgbLjO/8SgY0ffCSYiRCxqbMbzrTJCn7dyxQiCf3KSOs
	 bNZFq2J7w98pA==
From: Arnd Bergmann <arnd@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Alon Giladi <alon.giladi@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: fix #ifdef CONFIG_ACPI check
Date: Mon, 12 Feb 2024 12:23:36 +0100
Message-Id: <20240212112343.1148931-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The #ifdef check around the function definitionm for two functions was
changed without also changing the one on the declaration:

drivers/net/wireless/intel/iwlwifi/fw/uefi.c:359:6: error: redefinition of 'iwl_uefi_get_sgom_table'
  359 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
      |      ^~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/net/wireless/intel/iwlwifi/fw/uefi.c:11:
drivers/net/wireless/intel/iwlwifi/fw/uefi.h:294:6: note: previous definition of 'iwl_uefi_get_sgom_table' with type 'void(struct iwl_trans *, struct iwl_fw_runtime *)'
  294 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
      |      ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/fw/uefi.c:392:5: error: redefinition of 'iwl_uefi_get_uats_table'
  392 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
      |     ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/fw/uefi.h:299:5: note: previous definition of 'iwl_uefi_get_uats_table' with type 'int(struct iwl_trans *, struct iwl_fw_runtime *)'
  299 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
      |     ^~~~~~~~~~~~~~~~~~~~~~~

Adapt it by merging the declarations into the existing #ifdef block.

Fixes: 74f4cd710705 ("wifi: iwlwifi: take SGOM and UATS code out of ACPI ifdef")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 39053290bd59..303cc299d1bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -204,6 +204,9 @@ int iwl_uefi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk);
 int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value);
+void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
+int iwl_uefi_get_uats_table(struct iwl_trans *trans,
+			    struct iwl_fw_runtime *fwrt);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -283,13 +286,7 @@ static inline int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt,
 {
 	return -ENOENT;
 }
-#endif /* CONFIG_EFI */
 
-#if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
-void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
-int iwl_uefi_get_uats_table(struct iwl_trans *trans,
-			    struct iwl_fw_runtime *fwrt);
-#else
 static inline
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
 {
@@ -301,5 +298,5 @@ int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 {
 	return 0;
 }
-#endif
+#endif /* CONFIG_EFI */
 #endif /* __iwl_fw_uefi__ */
-- 
2.39.2


