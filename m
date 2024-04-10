Return-Path: <linux-kernel+bounces-138462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D75989F192
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEBD3B24412
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC3415D5B3;
	Wed, 10 Apr 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki2sL3Mh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A115CD56
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750328; cv=none; b=Q4/RUb/v8EF9OjUFt8zNKa4v0/ETKP5B8J+/tlbJHExFPtPnp3oxoNqqSwAslhUcsUhNU9yKKCNUaGckb1pO6pSfhqH9ZoPrS8y3A9TmPBnLk1vyyLjEvLylHzZSJqHX9eevf+BX5sX83JEaP7cv+/VYzjvqQCwvsdP1R+Ivlkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750328; c=relaxed/simple;
	bh=zozmtpGCyzauq3lW42w4fnyusZzE+3jFnWSCycg+74w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lomaPJYTwAZ+2H68pi/QQLk6wsgu7fdPGNvFKvtIu5n35SnbY6WTRNa4i+CtuFFFp5iGHjQx/bs9POghCbWF3K/JmW1WqbQLu0AmEOmGsT3qURJgoPAhZYTSGeJOcTCs+mWA/n6thkgzsQz4fBUP0wARkCvuRlkblxZvvDcJtqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki2sL3Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC8FC43390;
	Wed, 10 Apr 2024 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712750328;
	bh=zozmtpGCyzauq3lW42w4fnyusZzE+3jFnWSCycg+74w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ki2sL3MhTeMJTG3avbeH1rzNAe7ciJKLADcUu1fQX6z8ruJDN7zDZ+xQ8xSe28t4h
	 YhkH6vqfVaZHU9te9wWvdi5pPKlKDCnRBeBnjIV+Rc48jKhTKBYFD9oeQnL8J4GVZb
	 HVMEZKtFzlB2SOMIasbDU9Gzk2dtbZAuEFDIbmsoSKiape4vzIXXDm8sijBmwY5Sti
	 iWJMcaxZjcQBA1vjeI1rInOjnB4e6VQaeljR0Y+zBZYvOIb0L+mTukLCuWeoyiufay
	 ojFtgFrSaLueQnp9nfK2cr9h0aQ0arl+iRMn1B6ZC2csTJ49/U9Iqe4gmILb/nxfra
	 gCiQ6tAqghoyw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] firmware: microchip: move buffer allocation into mpfs_auto_update_set_image_address()
Date: Wed, 10 Apr 2024 12:58:07 +0100
Message-ID: <20240410-manhood-gathering-41ccbfdad649@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410-opulently-epic-8654bdac3422@spud>
References: <20240410-opulently-epic-8654bdac3422@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4105; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=wFllIaLoSb4Gw+0g2yEUZWRr6LUeHyCfKeT7QJ6ExZU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlidVd1lBOmeBjKi02Xe3uSP7V/Pf+C1dOcTPVPX1Z9I PRvlXV4RykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbS6srIMPltMsdPBVHxzU9W FgTfqeLbN4m7+g1P2V2hKvkzOg+vpjEyXJ/q3iv1ePUiRh2XM1fvnfeUiNvy4aifBX/iRq4z6fp 57AA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

This buffer is used exclusively by mpfs_auto_update_set_image_address(),
so move the management of it there, employing the recently added cleanup
infrastructure to avoid littering the function with gotos.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/firmware/microchip/mpfs-auto-update.c | 32 ++++++++-----------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 078ff328f261..d7ce27f4ba1b 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -9,6 +9,7 @@
  *
  * Author: Conor Dooley <conor.dooley@microchip.com>
  */
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/firmware.h>
 #include <linux/math.h>
@@ -233,15 +234,17 @@ static int mpfs_auto_update_verify_image(struct fw_upload *fw_uploader)
 	return ret;
 }
 
-static int mpfs_auto_update_set_image_address(struct mpfs_auto_update_priv *priv, char *buffer,
+static int mpfs_auto_update_set_image_address(struct mpfs_auto_update_priv *priv,
 					      u32 image_address, loff_t directory_address)
 {
 	struct erase_info erase;
-	size_t erase_size = AUTO_UPDATE_DIRECTORY_SIZE;
+	size_t erase_size = round_up(AUTO_UPDATE_DIRECTORY_SIZE, (u64)priv->flash->erasesize);
 	size_t bytes_written = 0, bytes_read = 0;
+	char *buffer __free(kfree) = kzalloc(erase_size, GFP_KERNEL);
 	int ret;
 
-	erase_size = round_up(erase_size, (u64)priv->flash->erasesize);
+	if (!buffer)
+		return -ENOMEM;
 
 	erase.addr = AUTO_UPDATE_DIRECTORY_BASE;
 	erase.len = erase_size;
@@ -287,7 +290,7 @@ static int mpfs_auto_update_set_image_address(struct mpfs_auto_update_priv *priv
 		return ret;
 
 	if (bytes_written != erase_size)
-		return ret;
+		return -EIO;
 
 	return 0;
 }
@@ -297,7 +300,6 @@ static int mpfs_auto_update_write_bitstream(struct fw_upload *fw_uploader, const
 {
 	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
 	struct erase_info erase;
-	char *buffer;
 	loff_t directory_address = AUTO_UPDATE_UPGRADE_DIRECTORY;
 	size_t erase_size = AUTO_UPDATE_DIRECTORY_SIZE;
 	size_t bytes_written = 0;
@@ -313,16 +315,12 @@ static int mpfs_auto_update_write_bitstream(struct fw_upload *fw_uploader, const
 		image_address = AUTO_UPDATE_BITSTREAM_BASE +
 				AUTO_UPDATE_UPGRADE_INDEX * priv->size_per_bitstream;
 
-	buffer = devm_kzalloc(priv->dev, erase_size, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
 	/*
 	 * For bitstream info, the descriptor is written to a fixed offset,
 	 * so there is no need to set the image address.
 	 */
 	if (!is_info) {
-		ret = mpfs_auto_update_set_image_address(priv, buffer, image_address, directory_address);
+		ret = mpfs_auto_update_set_image_address(priv, image_address, directory_address);
 		if (ret) {
 			dev_err(priv->dev, "failed to set image address in the SPI directory: %d\n", ret);
 			return ret;
@@ -345,7 +343,7 @@ static int mpfs_auto_update_write_bitstream(struct fw_upload *fw_uploader, const
 	dev_info(priv->dev, "Erasing the flash at address (0x%x)\n", image_address);
 	ret = mtd_erase(priv->flash, &erase);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * No parsing etc of the bitstream is required. The system controller
@@ -355,19 +353,15 @@ static int mpfs_auto_update_write_bitstream(struct fw_upload *fw_uploader, const
 	dev_info(priv->dev, "Writing the image to the flash at address (0x%x)\n", image_address);
 	ret = mtd_write(priv->flash, (loff_t)image_address, size, &bytes_written, data);
 	if (ret)
-		goto out;
+		return ret;
 
-	if (bytes_written != size) {
-		ret = -EIO;
-		goto out;
-	}
+	if (bytes_written != size)
+		return -EIO;
 
 	*written = bytes_written;
 	dev_info(priv->dev, "Wrote 0x%zx bytes to the flash\n", bytes_written);
 
-out:
-	devm_kfree(priv->dev, buffer);
-	return ret;
+	return 0;
 }
 
 static enum fw_upload_err mpfs_auto_update_write(struct fw_upload *fw_uploader, const u8 *data,
-- 
2.43.0


