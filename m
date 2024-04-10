Return-Path: <linux-kernel+bounces-138459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB7A89F18F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E16C1C22EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71BB15B123;
	Wed, 10 Apr 2024 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6+1JWy2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3915B100
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750323; cv=none; b=HOlJlHHVFUfpb9WIx0B633kWLmc595poMSczKwcnpRjSIO0NeG8oCkYlXCd+svIb8vBboC3xHgQzod2SZMRkLUFCONmAsOjUUv1WodDtsccx8bpZfqi3+XvPAblekD94S2KP6OE1W7XWAueFzmq0Jz10DOdSKkvrGwQRxOIRHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750323; c=relaxed/simple;
	bh=hLF5VZ17pcPT+iEdSikbSqPPdiOP/ae+ULNTI7IT42U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9CmxL6qrp7pkWemFyJ3xzfPBHew8tnpE7z69HBpt4Cu9We0fv4nHmPFAXdA08F6UWg7DhG0egEpudIUVjVYBn+wTAWUQH6OOLO9e1LwHF4XICSd1dozPyfaMZ5C+OuoekmNYlrPca1tS8JaVKNMZlKmjHbFkwG81iWZzmhzpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6+1JWy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A5BC43390;
	Wed, 10 Apr 2024 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712750322;
	bh=hLF5VZ17pcPT+iEdSikbSqPPdiOP/ae+ULNTI7IT42U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6+1JWy2ltqVeLACEyfTQQ8B+ANNmaXO+i0uHM7LnBIiDhS1LVx6wLMBWvpq4UqAh
	 zWU3yRPQs2pq5PSPzXMOwdKbEQqkQr2U8unUIwUM4PvfhQyDpoOYk+dZNInNtTtUS4
	 6ppi8bYj/seXUUzuAhIDE5P8hzJEZ9YVQID5aiNMntUxHpoyMNIHrNbdUsVOuUVL8G
	 WjZC5VblrRl7YHzpdl21FfZpPC1F0r0O1V8IYzh3NetWJ6s3d1jPIv2HKl53/5icQY
	 CM9EDjCCZxcRoWthEsmsuV/zS+SKcSCoD2RNLV6TZjgqEvtPeMuvh8T8Jw/QTIoG/h
	 wXyzcc/GWqRBA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] firmware: microchip: support writing bitstream info to flash
Date: Wed, 10 Apr 2024 12:58:04 +0100
Message-ID: <20240410-shabby-fineness-6e8662cf44e2@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410-opulently-epic-8654bdac3422@spud>
References: <20240410-opulently-epic-8654bdac3422@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4272; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Mheo3lXIW1m+cEZnaJh1zYtTPgF5wFDCI953hFakqwY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlidVe62P1CVnpYFjuaKwXP62QWc3Jrz97DM+0aE1N6f WLQ1A8dpSwMYhwMsmKKLIm3+1qk1v9x2eHc8xZmDisTyBAGLk4BmEjQQkaGbX8bv/nsVs6/Zzg1 xar7tOK50F95VywLck++bknStJ69l+EP11/9D2nJW8xXhEm0H5+f/NTF7eR7J7cbLucUOzcvfCn NCQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Updating the FPGA image might bring with it changes visible to Linux,
so it is helpful to also co-locate dt-overlays that describe the new
image contents. If these are packaged in a specific format [1] (detected
by first 4 bytes being MCHP, since FPGA images have no magic), load
the file to the reserved 1 MiB region immediately after the directory in
flash. The Beagle-V Fire's "gateware" already creates these files and
puts them in flash [2].

Link: exists on confluence, needs to be made public
Link: https://openbeagle.org/beaglev-fire/gateware/-/blob/main/gateware_scripts/generate_gateware_overlays.py?ref_type=heads [2]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/firmware/microchip/mpfs-auto-update.c | 47 +++++++++++++++----
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 32394c24b37d..33343e83373c 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -71,8 +71,9 @@
 #define AUTO_UPDATE_UPGRADE_DIRECTORY	(AUTO_UPDATE_DIRECTORY_WIDTH * AUTO_UPDATE_UPGRADE_INDEX)
 #define AUTO_UPDATE_BLANK_DIRECTORY	(AUTO_UPDATE_DIRECTORY_WIDTH * AUTO_UPDATE_BLANK_INDEX)
 #define AUTO_UPDATE_DIRECTORY_SIZE	SZ_1K
-#define AUTO_UPDATE_RESERVED_SIZE	SZ_1M
-#define AUTO_UPDATE_BITSTREAM_BASE	(AUTO_UPDATE_DIRECTORY_SIZE + AUTO_UPDATE_RESERVED_SIZE)
+#define AUTO_UPDATE_INFO_BASE		AUTO_UPDATE_DIRECTORY_SIZE
+#define AUTO_UPDATE_INFO_SIZE		SZ_1M
+#define AUTO_UPDATE_BITSTREAM_BASE	(AUTO_UPDATE_DIRECTORY_SIZE + AUTO_UPDATE_INFO_SIZE)
 
 #define AUTO_UPDATE_TIMEOUT_MS		60000
 
@@ -86,6 +87,17 @@ struct mpfs_auto_update_priv {
 	bool cancel_request;
 };
 
+static bool mpfs_auto_update_is_bitstream_info(const u8 *data, u32 size)
+{
+	if (size < 4)
+		return false;
+
+	if (data[0] == 0x4d && data[1] == 0x43 && data[2] == 0x48 && data[3] == 0x50)
+		return true;
+
+	return false;
+}
+
 static enum fw_upload_err mpfs_auto_update_prepare(struct fw_upload *fw_uploader, const u8 *data,
 						   u32 size)
 {
@@ -287,22 +299,37 @@ static int mpfs_auto_update_write_bitstream(struct fw_upload *fw_uploader, const
 	loff_t directory_address = AUTO_UPDATE_UPGRADE_DIRECTORY;
 	size_t erase_size = AUTO_UPDATE_DIRECTORY_SIZE;
 	size_t bytes_written = 0;
+	bool is_info = mpfs_auto_update_is_bitstream_info(data, size);
 	u32 image_address;
 	int ret;
 
 	erase_size = round_up(erase_size, (u64)priv->flash->erasesize);
 
-	image_address = AUTO_UPDATE_BITSTREAM_BASE +
-		AUTO_UPDATE_UPGRADE_INDEX * priv->size_per_bitstream;
+	if (is_info)
+		image_address = AUTO_UPDATE_INFO_BASE;
+	else
+		image_address = AUTO_UPDATE_BITSTREAM_BASE +
+				AUTO_UPDATE_UPGRADE_INDEX * priv->size_per_bitstream;
 
 	buffer = devm_kzalloc(priv->dev, erase_size, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
-	ret = mpfs_auto_update_set_image_address(priv, buffer, image_address, directory_address);
-	if (ret) {
-		dev_err(priv->dev, "failed to set image address in the SPI directory: %d\n", ret);
-		goto out;
+	/*
+	 * For bitstream info, the descriptor is written to a fixed offset,
+	 * so there is no need to set the image address.
+	 */
+	if (!is_info) {
+		ret = mpfs_auto_update_set_image_address(priv, buffer, image_address, directory_address);
+		if (ret) {
+			dev_err(priv->dev, "failed to set image address in the SPI directory: %d\n", ret);
+			return ret;
+		}
+	} else {
+		if (size > AUTO_UPDATE_INFO_SIZE) {
+			dev_err(priv->dev, "bitstream info exceeds permitted size\n");
+			return -ENOSPC;
+		}
 	}
 
 	/*
@@ -334,6 +361,7 @@ static int mpfs_auto_update_write_bitstream(struct fw_upload *fw_uploader, const
 	}
 
 	*written = bytes_written;
+	dev_info(priv->dev, "Wrote 0x%zx bytes to the flash\n", bytes_written);
 
 out:
 	devm_kfree(priv->dev, buffer);
@@ -360,6 +388,9 @@ static enum fw_upload_err mpfs_auto_update_write(struct fw_upload *fw_uploader,
 		goto out;
 	}
 
+	if (mpfs_auto_update_is_bitstream_info(data, size))
+		goto out;
+
 	ret = mpfs_auto_update_verify_image(fw_uploader);
 	if (ret)
 		err = FW_UPLOAD_ERR_FW_INVALID;
-- 
2.43.0


