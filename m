Return-Path: <linux-kernel+bounces-86988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0AC86CDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F147E1C23128
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16F014126A;
	Thu, 29 Feb 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f17Uge0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF2141256;
	Thu, 29 Feb 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221812; cv=none; b=HEj/lV2xbXliUudvLB9iNSwQc0CfOsBvoC0U3i7/8lRQ4vqYqenKDxmyEGW7Yky5obYlaQaFO5zuQ2KN2c3eK0fl2JLxxnl1nxcCEC/bneOeffgVMLKGCM4ujSg0pjM0CBpB8/H3KqcY8RHA48Lvuprv3DfjT5iaLighzaRsSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221812; c=relaxed/simple;
	bh=ahljWZASvX2kS6BxxWe+59kfhpUL4bb0AA763OsLt5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDydUoKaZ82ZHf7FN3M6z+joyKslww2lwDNaD9vE7lOP+s7wSo15DNQ6czi6arAka1Q8vYLSajyrQrcRTjSkGgQCH9mGkXhsLZgZLHVL1Qvzkh9lPY40g0+lC26xg77eqrwDG798XaZJcH1ZufjCtZ+As7CkKtObafsy3gZP6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f17Uge0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D95CC43394;
	Thu, 29 Feb 2024 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221811;
	bh=ahljWZASvX2kS6BxxWe+59kfhpUL4bb0AA763OsLt5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f17Uge0NecDbwq2c9umWpOAWTBrpnId+Up5PQxk/BJYIKCY9tDw9L2nLnSdUyXhm7
	 ZXNS2aOaNaH0tQJM7f1PbXOrwkiH3JftK+EUKhxvOcsPnRhwLUjc4xws5jpXFpngKY
	 jDKGosd/xKP6C7eexk6A4U/YjBEHhi8h4JRRhy+aZQcktERvegaVrQaQq4YZ5z6IH9
	 kWOez5Hy+2zxEh/STaedDx9hpDw/SFSm/S76Ot/gkUg1Pm+nMlJoU38fUM2WCd1O3L
	 uH2jYT2QGNAgXfG8wr4FtwYCjH+YUOxYG7rt7Dr7rVHyJtlfQFlAUyWIeXrey5vFqR
	 sGiPeV5YU1Y3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/21] spi: intel-pci: Add support for Lunar Lake-M SPI serial flash
Date: Thu, 29 Feb 2024 10:49:33 -0500
Message-ID: <20240229154946.2850012-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 8f44e3808200c1434c26ef459722f88f48b306df ]

Add Intel Lunar Lake-M PCI ID to the driver list of supported devices.
This is the same controller found in previous generations.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://msgid.link/r/20240212082027.2462849-1-mika.westerberg@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index b9918dcc38027..fef9271b04d07 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -84,6 +84,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa823), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.43.0


