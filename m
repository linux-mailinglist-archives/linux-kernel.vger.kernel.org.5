Return-Path: <linux-kernel+bounces-113302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3747288833D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694BC1C23512
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F77C191075;
	Sun, 24 Mar 2024 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajPnLo+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E8191056;
	Sun, 24 Mar 2024 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320102; cv=none; b=PyDkqWgeZd80Fzx/zcKbadSC6F9Myp1735/OPpzAeeaFpfmkHluUBOapnRT1xO0SWeDdIXrkd8NAq/VHcDdohe/hmTikO2iKaTzq4E4CHuTMW3U3X79Zvq3F2j3LvaWvFwa9/mxc8UE5i/5qvb2+PDUh+xx5X4wp4aXpj74Bg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320102; c=relaxed/simple;
	bh=+9L2sOYcn70slea3K+0x6ySDW9NT356ZLSJHuWQ40e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKgzjaQSXP+0knI3DQnyBezfsZTjlW9/Ztj9AVD3Hdvmu2KxqDdlDUX3TTcfHhLpURUeatcjOycuKq9XeJ2k8jmnRObMFg+T7FUjd4ga+cg/+lehWDl0l8klKK4sFnT9O25rH9TpD20lzq6H4WWM77w48dor/Zp7PyITWw2JVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajPnLo+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6840C433C7;
	Sun, 24 Mar 2024 22:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320101;
	bh=+9L2sOYcn70slea3K+0x6ySDW9NT356ZLSJHuWQ40e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajPnLo+znFgyGtiEpIp3UoAQy1dcyxSxTUnUULY6z6m8joLdT4iCCr02HYSelEhJu
	 /1rmT0dxN54el2bcCH62Be923+yS/dYrWaUmktNbzesV4pqLpZk+88R49mBaZhg/qC
	 huQ1UtVH/v0ONv99wTfIdcjUw+7obrDeKmZF6sPnKVJU4/N3a5CmgHw4u2dZMWL9uQ
	 gzF98sd32cEDH9ozunV9jYw1gfS4Wwo9mXCE2CGZmcgNcO/AF1nRWe/PZL82V5uJoH
	 3HGb0xLvOWVfmGyhOiePBVTWhHtB4IwdYG3dznc63ufKjwMPiriJKGkfQuM0Qb4eRX
	 kW4h4SsFliheQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 410/715] PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
Date: Sun, 24 Mar 2024 18:29:49 -0400
Message-ID: <20240324223455.1342824-411-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit dec529b0b0572b32f9eb91c882dd1f08ca657efb ]

The commit in Fixes changed the logic on how resources are released and
introduced a new switchtec_exit_pci() that need to be called explicitly in
order to undo a corresponding switchtec_init_pci().

This was done in the remove function, but not in the probe.

Fix the probe now.

Fixes: df25461119d9 ("PCI: switchtec: Fix stdev_release() crash after surprise hot remove")
Link: https://lore.kernel.org/r/01446d2ccb91a578239915812f2b7dfbeb2882af.1703428183.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/switch/switchtec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 1804794d0e686..5a4adf6c04cf8 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1672,7 +1672,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	rc = switchtec_init_isr(stdev);
 	if (rc) {
 		dev_err(&stdev->dev, "failed to init isr.\n");
-		goto err_put;
+		goto err_exit_pci;
 	}
 
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
@@ -1693,6 +1693,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 
 err_devadd:
 	stdev_kill(stdev);
+err_exit_pci:
+	switchtec_exit_pci(stdev);
 err_put:
 	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	put_device(&stdev->dev);
-- 
2.43.0


