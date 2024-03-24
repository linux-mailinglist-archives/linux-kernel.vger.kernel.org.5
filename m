Return-Path: <linux-kernel+bounces-114141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD60A8888A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEFD1C22B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48612429F1;
	Sun, 24 Mar 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeYFv661"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11819133420;
	Sun, 24 Mar 2024 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321452; cv=none; b=kunmURJnWXics1rAJRPktNwGglhS/SdMtYrIJnw+XOosXq3+cBakufia+Ec0EKmIaYo7M1sTasiMmwv2AERGjCByqPZWhU+eJxvt1+zxfQZoW+T0lANsbyxNVgZn2wwqkTqfFF3N6nTyXa5awxqxhJGUliNQFK1YR9mD1iHuY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321452; c=relaxed/simple;
	bh=R5MgffQAqsovV9p+t6iCvXpyZJGJXls0j6QgS0aphW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdKyntdK9TfF4KEpvud4jIW8VpPpG8goq4/Ix8/VA4dt/+zqzYOdmNv1LnEK+pOmIk74Ct9svKUphHkXmFggI6mJqvhw3t+6VBKPBYs2H8NWNPh5F1M99CPQ2HCL1u0y0dQ8w6WB4srmw2GfFOnRwQWrivJe9Uhlzyi15giAnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeYFv661; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8FFC43394;
	Sun, 24 Mar 2024 23:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321450;
	bh=R5MgffQAqsovV9p+t6iCvXpyZJGJXls0j6QgS0aphW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OeYFv661/ftj6rJjwduF2Sc9MfvDd1RFxHiDZNUZzYDsXW9QiHO3ETH+fAN5FoiBJ
	 sqrwNKQ5VA7OK+LCh5IAG9mGBo4lsIHb16G1hqAUDfQ0ZO89M7yhzkKB589tHQax3y
	 IRH8wkRwBGbubWlhqsJqcaufnHOT9/1FyGqfim3t87wMGNNG7WMx7Ahfdm+E+Tw0+J
	 CQxR4WGNmCXSYBIVRh2jfP48R01d2MmJdxcpVuTWkB3vsBR4b8DPlZ7XQCBMbYBo/t
	 1rp3Mg58WylZPRWHnPgMbzErUv0CCn7VEZw3NqcE/7PizC4Hb3Fl0DGrmifonlCa3M
	 r+QQ3thmo2LpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 175/638] wifi: iwlwifi: read BIOS PNVM only for non-Intel SKU
Date: Sun, 24 Mar 2024 18:53:32 -0400
Message-ID: <20240324230116.1348576-176-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


