Return-Path: <linux-kernel+bounces-113020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282448880D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C1F281BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123D137C37;
	Sun, 24 Mar 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fjed9SvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE113793D;
	Sun, 24 Mar 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319831; cv=none; b=Tbm40qHgc8LMFLscDgFFCbvvKRsB3td+Xln8lsuzM6QvHCLNvGtOtFOMQvDoUxeIiRr3jNbPhobb4ti71Rt+RBMrlKco4SnZjjFu2K0Jbt3afdYa5B7jSPWDzvy7l94InaPqq0h/iQwSv29v2soAcU6Ln/060Bh4tCiCPNbhlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319831; c=relaxed/simple;
	bh=R5MgffQAqsovV9p+t6iCvXpyZJGJXls0j6QgS0aphW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IydbbqI4A1ABKm3ZeXtovjvKnDfKL5cipIaVvjYbL1jjivBS680JryV4sqwuSMZgvEYhoqEn6qcNycX7jKrUN/mt8o4t71qUg7fiITUi+6K/7g+rnIVfEZsMHBu7UTbDqwh6g77eBPXyVUpuj+BQtPBtBblueY4s/z6pwlLiHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fjed9SvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A39C433B2;
	Sun, 24 Mar 2024 22:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319830;
	bh=R5MgffQAqsovV9p+t6iCvXpyZJGJXls0j6QgS0aphW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fjed9SvLHpCit5qCPkiJ7G32p7ypxB+7OdjpchehUAKOjUufS5FchDh9ig0CyAkj+
	 o6dNNBw53ZquHre/dexowUqJTAvQoIY9GknjtN4o054BokXkZJ21qTjorZdWHH8EJY
	 v+AKX04pnH04MtesUqxy46QZjRRvZur2iXCFU1pFd0FpK+EmpAQbCsrfGz6W6+TpqN
	 n62wFzjJnQOJ71ouV0YcD+eX7YchvAZ/Y1DJUjz99cPKLEf0fggObEz9lRjG4psMp6
	 AaSTlkaNQFjpYCux+mIFYjOsNb6YajZR8H4N2t12i4ly00QUl0MG/YzmHe2BXxqrPf
	 S4DN4QNOdDoSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 133/715] wifi: iwlwifi: read BIOS PNVM only for non-Intel SKU
Date: Sun, 24 Mar 2024 18:25:12 -0400
Message-ID: <20240324223455.1342824-134-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit c868a189ecfe8cc0b3173c2eaa7f0b659326c151 ]

The driver is supposed to read the PNVM from BIOS only for non-Intel
SKUs. For Intel SKUs the OEM ID will be 0.
Read BIOS PNVM only when a non-Intel SKU is indicated.

Fixes: b99e32cbfdf6 ("wifi: iwlwifi: Take loading and setting of pnvm image out of parsing part")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://msgid.link/20240131091413.3625cf1223d3.Ieffda5f506713b1c979388dd7a0e1c1a0145cfca@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 30 ++++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 650e4bde9c17b..56ee0ceed78ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -255,21 +255,27 @@ static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len)
 	struct pnvm_sku_package *package;
 	u8 *image = NULL;
 
-	/* First attempt to get the PNVM from BIOS */
-	package = iwl_uefi_get_pnvm(trans_p, len);
-	if (!IS_ERR_OR_NULL(package)) {
-		if (*len >= sizeof(*package)) {
-			/* we need only the data */
-			*len -= sizeof(*package);
-			image = kmemdup(package->data, *len, GFP_KERNEL);
+	/* Get PNVM from BIOS for non-Intel SKU */
+	if (trans_p->sku_id[2]) {
+		package = iwl_uefi_get_pnvm(trans_p, len);
+		if (!IS_ERR_OR_NULL(package)) {
+			if (*len >= sizeof(*package)) {
+				/* we need only the data */
+				*len -= sizeof(*package);
+				image = kmemdup(package->data,
+						*len, GFP_KERNEL);
+			}
+			/*
+			 * free package regardless of whether kmemdup
+			 * succeeded
+			 */
+			kfree(package);
+			if (image)
+				return image;
 		}
-		/* free package regardless of whether kmemdup succeeded */
-		kfree(package);
-		if (image)
-			return image;
 	}
 
-	/* If it's not available, try from the filesystem */
+	/* If it's not available, or for Intel SKU, try from the filesystem */
 	if (iwl_pnvm_get_from_fs(trans_p, &image, len))
 		return NULL;
 	return image;
-- 
2.43.0


