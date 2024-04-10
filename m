Return-Path: <linux-kernel+bounces-138461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4189F191
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808D41F216B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA715B568;
	Wed, 10 Apr 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5pvV5Zz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B1C15ADB6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750326; cv=none; b=Mg2ZonSeBr2DObEyeoIf7Io4BcUjEuyJoc9UJ8wBM9LNY6vxQqctEwvuuPt1R+s4EDBdvJwzv8rFSU57Vv9eRdJAGK3e1pmyrI1T1D2e1tm2me1+DAirdIoTeaDDJYIbdwjtJStLuxJO6kEiE0E7IGXSXzZzjVaCCrGXMLuf9Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750326; c=relaxed/simple;
	bh=I0ucffUjI9S2cz08Ial3I81TqrYvCDbjo9pZBliGHHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inI1TpQA9XLWPXg1yRRRNmQ/6ejTF4GjVV2de3ccX3DMH+8S6pvmw7mY3qdUIp4Soc0mlUHA4y/Z/G+tr+k1X1QemYsMjPMozfKk9lbJkG8TnZ/YZhxOQpsAovrYqVPKMk4Ea5tv2DImSAjVsZsHd8mpeE4Is6O5qHwBHTWEjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5pvV5Zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224EEC43390;
	Wed, 10 Apr 2024 11:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712750326;
	bh=I0ucffUjI9S2cz08Ial3I81TqrYvCDbjo9pZBliGHHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5pvV5ZzYr/RzporQ5oxS0aMfiV+V0q4Y2GxhgF1z79jFoCE0gBmPkJy7lhMoquBE
	 x5z4w5o7IMU/EeUHyW97iTep8pYcNF6KIh+C6IB1CYcLFVxgjZNCMMTbCIvMFB+BwK
	 Szme+Lh+6kyqU/xCcuo6woWbxG6NduD1jomFGw6DXp9AdBzEZ/tjEm8rGLIakgd0RY
	 npZInp/oD3QhFqLgV5ZO/OlqiFRHKixUjPiQCLE4yCKluiRNE6DxYAHJqYLS8Chb01
	 R6SpQ+opJhACIPLeF7JZyq61Arnb3jTq/ZCsAu1QCNK1g8CO+Q5qModKWlw/T5WglX
	 0v98rHwxKfdJA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] firmware: microchip: clarify that sizes and addresses are in hex
Date: Wed, 10 Apr 2024 12:58:06 +0100
Message-ID: <20240410-elk-staleness-285063ef0433@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410-opulently-epic-8654bdac3422@spud>
References: <20240410-opulently-epic-8654bdac3422@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=BNSIAOq6X1LAhr9L0BQrr3EsDDjmIu+xC/kpYkZfVl4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlidVfOqLZ/vnLjSxXD8h3G/DkLbvKtbNCIX7r23GEmu ZX9mnmSHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZgImxEjw9U517olFpwtyuQL X5PH7H3p4OtWvTtsN/foftl8pObDp7cM/5PmMj+azXDi/pYJrpMub31nvWG+4a3j7w7zqk1h1wz beJQFAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

As it says on the tin. It can be kinda confusing when "22830" is in hex,
so prefix the hex numbers with a "0x".

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/firmware/microchip/mpfs-auto-update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 298ad21e139b..078ff328f261 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -279,7 +279,7 @@ static int mpfs_auto_update_set_image_address(struct mpfs_auto_update_priv *priv
 	       AUTO_UPDATE_DIRECTORY_WIDTH);
 	memset(buffer + AUTO_UPDATE_BLANK_DIRECTORY, 0x0, AUTO_UPDATE_DIRECTORY_WIDTH);
 
-	dev_info(priv->dev, "Writing the image address (%x) to the flash directory (%llx)\n",
+	dev_info(priv->dev, "Writing the image address (0x%x) to the flash directory (0x%llx)\n",
 		 image_address, directory_address);
 
 	ret = mtd_write(priv->flash, 0x0, erase_size, &bytes_written, (u_char *)buffer);
@@ -342,7 +342,7 @@ static int mpfs_auto_update_write_bitstream(struct fw_upload *fw_uploader, const
 	erase.len = round_up(size, (size_t)priv->flash->erasesize);
 	erase.addr = image_address;
 
-	dev_info(priv->dev, "Erasing the flash at address (%x)\n", image_address);
+	dev_info(priv->dev, "Erasing the flash at address (0x%x)\n", image_address);
 	ret = mtd_erase(priv->flash, &erase);
 	if (ret)
 		goto out;
@@ -352,7 +352,7 @@ static int mpfs_auto_update_write_bitstream(struct fw_upload *fw_uploader, const
 	 * will do all of that itself - including verifying that the bitstream
 	 * is valid.
 	 */
-	dev_info(priv->dev, "Writing the image to the flash at address (%x)\n", image_address);
+	dev_info(priv->dev, "Writing the image to the flash at address (0x%x)\n", image_address);
 	ret = mtd_write(priv->flash, (loff_t)image_address, size, &bytes_written, data);
 	if (ret)
 		goto out;
-- 
2.43.0


