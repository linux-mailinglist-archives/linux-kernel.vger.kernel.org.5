Return-Path: <linux-kernel+bounces-50351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E47847823
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 783C7B2BC9D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C90157E64;
	Fri,  2 Feb 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZaFZonZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D3155A32;
	Fri,  2 Feb 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899178; cv=none; b=kgJFkGiRC1Dbwpory6zx38knu+of8y0LAZIbE2MH2jYaIH+JrcCkD2wlLnPjQUklyDYU7z1qHA/TzAgDeZ8ZBcPAa8DsWGA4y4UQTcJ4khfqHHxF9KxuoJqOWYOIVBIgzUUxp+IB+q3fPS+/R/WYbzvLsGuHfYukZZC2l5zLDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899178; c=relaxed/simple;
	bh=8uI8rUl6OzeKUVKQZTFuUDL/6XSmSsjGbKds+GGPXcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsJbbBMjX2JkkFgeMsKQeUQq3zk+uRa2eDiI6S8Ehl5kkOUqs3idqTf+JZS61CWsAKmkSiXUBTtxouxblc8apo/ExcStmTaXJqsmMKl+tXTABtWrI91k979fapXIsIu8elJHNG1VW/p2d9MCduBmw0COZJGOheoC/EfQ9/s02k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZaFZonZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7789C43394;
	Fri,  2 Feb 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899178;
	bh=8uI8rUl6OzeKUVKQZTFuUDL/6XSmSsjGbKds+GGPXcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZaFZonZ0YIe39DYb+wmcho0rIeTR+Y0cYJOH23bfFx/PTLeA2EK1h6qfaR8pdXE9
	 DZ+QeC28rxY5ORRJzmqA6VUgv8S1PpgFvJktHOqXZxE2rl3SmEC1xfLR26X7vMK2Ky
	 01eld+mjtbhWEWgz1P/yeOvIVt0eXvq7nHhUVxnpbv3LDzFju1jHNNayFYxv5ZpRw0
	 hB2qWF+m1N/D5kp0ITzR46/pTiYM3L5SZskMzwTrLxwXR/FY6f0Bw6gja9Qc8wdstw
	 56DFe1NFpN2ATmg1mf+IiObcGbXxoWCRrZIQeRyIz0K8KU8bdHu9WA/+kYU0drQk97
	 wFCz/taGiEjjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 07/23] spi: intel-pci: Add support for Arrow Lake SPI serial flash
Date: Fri,  2 Feb 2024 13:39:03 -0500
Message-ID: <20240202183926.540467-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 8afe3c7fcaf72fca1e7d3dab16a5b7f4201ece17 ]

This adds the PCI ID of the Arrow Lake and Meteor Lake-S PCH SPI serial
flash controller. This one supports all the necessary commands Linux
SPI-NOR stack requires.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://msgid.link/r/20240122120034.2664812-3-mika.westerberg@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 57d767a68e7b..f547f1297375 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -76,6 +76,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x9d24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x9da4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa0a4), (unsigned long)&cnl_info },
-- 
2.43.0


