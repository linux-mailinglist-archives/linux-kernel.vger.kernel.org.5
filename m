Return-Path: <linux-kernel+bounces-50374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627884782E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD08D2874F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88850130AE3;
	Fri,  2 Feb 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5Pj40U4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE49130ACB;
	Fri,  2 Feb 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899226; cv=none; b=bNzZtw0kX5UB6QbpR3p7148Cmg1ocFOI/o5KeFsIHbZ43+EqAIaqQ1TM47FX6ZNIABdgt7StR0M+ZvVhKDhHRG4voHCkEoplPY2F5vBCvA+aS9gVZNnaX8mG6yX2e8mU6EazkuezW/yKy0IHL/hsbTdrQ5/yudxhjOqJPOQbhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899226; c=relaxed/simple;
	bh=8uI8rUl6OzeKUVKQZTFuUDL/6XSmSsjGbKds+GGPXcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrXFh7sVcBFAW6Z4dphODvBeMG0tqRIfrr42cDvShiqlrwjpWp7svG/D5mk6mG8Z6zFYQLJownls4bZeaoErUXTBCAms9gFfsd9ynaNxveZ1JyGe4oV77JqG+epMLfkdiy8Z6/IxJF4n/OSCyZCcQaqVNncorL/1Ka+FkHOU8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5Pj40U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D830EC43390;
	Fri,  2 Feb 2024 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899226;
	bh=8uI8rUl6OzeKUVKQZTFuUDL/6XSmSsjGbKds+GGPXcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5Pj40U4Jk7EW5Dsd4kv/MyQS3pJXsosSf//Dh69PeYaqJ4jgoasRt8eZ/dHKcBZU
	 redJHxf4LM9YbMWvTfKtizx6tk6SjkXjKBPF5ElBOYCS0ul167Hu4CsPzYFU7pM67L
	 y7DB4PsMaucyEoxsYttO6nU639Bc18y1a2nv2/icwyzhnwkCZOKCwjmuXBS8in8X3P
	 nLRhnQYWR8p9VZCBFQlXfCvMO+0S3+3JZckKGmfRJvzjIxJpE/V8UzIO1K/FXp3bOH
	 WofNSD+8RTG0wfCRQ3j3rUWYRfds5QyqMAdgOV5oekeyXjAswkPdp5RTJ7Q0xnpSad
	 HDXIwC+VC8yRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/21] spi: intel-pci: Add support for Arrow Lake SPI serial flash
Date: Fri,  2 Feb 2024 13:39:53 -0500
Message-ID: <20240202184015.540966-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
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


