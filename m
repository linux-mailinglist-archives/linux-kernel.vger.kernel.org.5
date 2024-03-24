Return-Path: <linux-kernel+bounces-113620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F2B888E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E0A296C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BACC1422B2;
	Sun, 24 Mar 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilHCmdxH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0FC763FA;
	Sun, 24 Mar 2024 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320454; cv=none; b=ZfvUFTOW2fv4+gX1ojtoEgTqxC4QUMdoNB8s4YX1zRrFQrOCYEQqERMmz2GCreArMsh7U2jRM9+aEqz34kELQ9sdGvHB4huzeMDwDJN1+qgJXA9YuB+cEkYte9jFJqBxDmyffA4ZKUrQAkFGpMmRgEW6sFUVptiFNy+/OsVTtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320454; c=relaxed/simple;
	bh=W4RwcyHV3K6Low51NVIhVtApOG+DXghL1IwfkGZklV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJpLIkwlcQL8GRmHENigMjVpLs/+UUzmPX+LhmASzDwbpQ6//VNtODkLgujsQV/ynTKM87UCb2EoeJXr+BVoPccxPThK3kzQG5R3cCCrdl4M0RFPT6wbj0IxyBPcNNFmzwLr6H83JaEt6V0wkXLEvcz6jNlnRhUS8cjdrCAf818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilHCmdxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2600FC43390;
	Sun, 24 Mar 2024 22:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320454;
	bh=W4RwcyHV3K6Low51NVIhVtApOG+DXghL1IwfkGZklV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilHCmdxHzgpz1zNcJ0enSHS7iPYk7cDhi+E2IrQ/MtHCEgQY8RDgWU9hAvOuXtWZV
	 TFwzdBfYQapbGn71pNi84r2ukzs4NT7nod5zr2ciFEv411UT9xLnPmaXYYCXQdWdFi
	 Hc1G2PZEqmRy4rJGkZ2NEdwwKm9EiYhHVGYFI6ESN+V39/spaYIeThCfaGwYQBxbNu
	 KoXb43hoRGNPl8Ck6V8W2yToGPR45W5axQ1v9KpuVPwnIY/fqQ66C9DSxYA+Iwct7R
	 Q1DNglAbGUOaJUgSQBnaT3B5jVoD006JF44V1q99uI8aa3/rxQEPThJiUWNU8B9+Vf
	 9Uvs8D5j+6K7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 013/713] spi: intel-pci: Add support for Lunar Lake-M SPI serial flash
Date: Sun, 24 Mar 2024 18:35:39 -0400
Message-ID: <20240324224720.1345309-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


