Return-Path: <linux-kernel+bounces-86963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D942786CDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788ED1F22439
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7233315AAD0;
	Thu, 29 Feb 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+EhxsMb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F015AAB5;
	Thu, 29 Feb 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221759; cv=none; b=n+kaaTOOak4xPKLHv4drf2sKp+WuyuxkQqVIdc/gqi2a8SBzC6jSN8UUeYfcMudiEXvfa94oQYnY6nc3kFtHl9jwDoQDyulTWWeWgSZuXpL5WoShRxCrhx6SnNhi+gXu5UHQoaU84T53WoD3isDhXZRUSKTY/aoqfi32pVcrqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221759; c=relaxed/simple;
	bh=ahljWZASvX2kS6BxxWe+59kfhpUL4bb0AA763OsLt5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWchTK3smZ9MiUe4LccM5+FPO+/26C0Znr/EKPZTT6s/1BJXemkuZP2e6qyydxB4ATsAMUmw3TwxFK/92wPX1u50GQ6IT1Xlu1NrXGIdclH71WRpeAaR0bBQqMsQZcLm2ufhjjoXraG/qhWKnBncq/DwtaAgae9RwQu66Bm0DVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+EhxsMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917AEC433C7;
	Thu, 29 Feb 2024 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221759;
	bh=ahljWZASvX2kS6BxxWe+59kfhpUL4bb0AA763OsLt5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+EhxsMbjIFMxR+BCUAQGyhKGDw9iiDPGndGR4Khe83Ob3/1Dno85hUKG+8oiQUjU
	 XuQHE5BtAJfR6wHeQeBx3PF9ciZqPx51vpstuJ1yTR6zkpj+SSjeB9uXYofKGzrgok
	 D9aAhqljgkwEZqtDTD6o1cziQiSqow6j40bZWoUHl5K5wdfA1Axrgq0WR8E4ufkytH
	 uqTum+fg59wuJv4xeXKFOO2sBgr72k5ONZ7Q504m4dj3ivbAmgslcK99VUjFl1nwtQ
	 JEz31egyeSg0FUL1y7VwN0n45sfrb3jIjlEl/xAfJVHEO9Lknh+2O1wZPnu2UfqLP/
	 HvIKT0PhvqxVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 15/26] spi: intel-pci: Add support for Lunar Lake-M SPI serial flash
Date: Thu, 29 Feb 2024 10:48:34 -0500
Message-ID: <20240229154851.2849367-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


