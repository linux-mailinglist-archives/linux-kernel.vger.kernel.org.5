Return-Path: <linux-kernel+bounces-114018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A183F888F13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563771F328E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9101FB08B;
	Sun, 24 Mar 2024 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goDebecm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05012FB04;
	Sun, 24 Mar 2024 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321291; cv=none; b=EHXN7cZZrcajYGeO/Cq7+JxqtMP+ZrdX5kmbu4/9y5FBO1Sezug/DKOUSN7HeJTDTHYHDPe2SMWMME06f+AzXHzDl1ZE8+TwPDviG3F2AeY8x/rxBSfWiBQ+vtsva/+PDscKBAsnHBnw8rzGxqlc55vzKYc2LdbZifEIivMSgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321291; c=relaxed/simple;
	bh=W4RwcyHV3K6Low51NVIhVtApOG+DXghL1IwfkGZklV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMKI3l8gKqSV+0cebrrPGqYuXrgrhppamNtkAJIPGWf7s8dYVrQlJIkjjxY2LpOLQwMjNUvrkdgycJhVVASrp8s0pqWiqrnTI5nRMMm7T1UeLERB/j+hBRXP0508tmry4NMnMSnB8Uxbt2U7C+7j+A5XnxT5y0G5u1dFO1apzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goDebecm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EF0C43390;
	Sun, 24 Mar 2024 23:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321290;
	bh=W4RwcyHV3K6Low51NVIhVtApOG+DXghL1IwfkGZklV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=goDebecmuMH7Upr1ZillyK6ZRXQHR6Fdw0O9ol084MpvkGCB5J51woHUfV0yZX0PJ
	 Yd544YCTlkgo1evh1Ef8wZYk9dcCXtU/c075KVUy3i9vrOPUsXS8x7vb9O9+uddBfU
	 QiPkeFj0eIf5mYbzIit+ZBr3mJaGIT3YcbF7UTOm3NQTTk0iZa5GL5nysFYyod1ORe
	 grk08+KpBvbVZosyEO9Aq9+JlUQp++cr2neyq5fqFxrUQkYeWBmeBd6EK0DNfG4XOq
	 DU2fWzKm33g0AKYjcFMNnnj37OoF1gJKuEnJ6/VQGHNIMcQUdEV8+supQVXG29MjV5
	 agnDbpcywKWZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 012/638] spi: intel-pci: Add support for Lunar Lake-M SPI serial flash
Date: Sun, 24 Mar 2024 18:50:49 -0400
Message-ID: <20240324230116.1348576-13-sashal@kernel.org>
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
index 07d20ca1164c3..4337ca51d7aa2 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -85,6 +85,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa823), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.43.0


