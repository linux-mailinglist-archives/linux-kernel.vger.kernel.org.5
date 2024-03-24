Return-Path: <linux-kernel+bounces-116068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B9889755
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DB7B3BF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53A82853D3;
	Mon, 25 Mar 2024 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA4SrdTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601713C677;
	Sun, 24 Mar 2024 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323489; cv=none; b=pC2UF7FNOszApE0QGikF8XbmchA+Xm3ymtll4Q/nm0/Vloy2rKRDCh6dTNqlOmi/IHRNWRo49ABgJlNks/5HXQlq7tXlFfEAPmUT5QQLIrpJg8BLBcRMOa7mE6CECrAFVQwd3ThpFNFU+RfrS4gSfoDFwEHy2qSiLxT72XlusrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323489; c=relaxed/simple;
	bh=WReDACMQmPunMLZC8QVpYUoZg04+20qLAGtip4GPPPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a31pwMdNqU49d6C7q1LHMX0oPdS/UPD5HeS96CrC8zrU7Dm2hhS2lsF4JqI6YPLE5A72pmQFgQxXOTWNbndzazJKMBWVgZ78w5cH/JfmOXpF5lRMMHGp0MOhrVavNP276uk584Xz++ojJgIsx95CdBWS+b/YN+oSE0dZbL0Ey2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA4SrdTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646D1C43394;
	Sun, 24 Mar 2024 23:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323489;
	bh=WReDACMQmPunMLZC8QVpYUoZg04+20qLAGtip4GPPPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lA4SrdTpO9wFpGR/+AMDDeshis+NlvekEk9CzPqgZuPbLKSi+8x1UYoHFBzM7VmwO
	 r9BZ3yhlnnX8QjridWaSvq12vbSEqVUZcKNiZuKT1XA1AJzlunZh5FaaTbXDWtVKrK
	 3/npExh7X8qzW1RBg7Sd6joYRARF8Yv+EQIwzgbZ/MTcxEUKF9en+Tozo2HnldLPNZ
	 pMzNTIVspJPRuoYQ4pTc3M0TGWUzBjB3Vl/ACUwO7ZJiGc+SMnFH5K+/RMDypk/wQK
	 QEb/wfRDOhkXSgGawk1dG2mxv3ll6KcF5BEqO+2QBfdu9xFzj8Hgc7ija553qf5A0h
	 Gg8LEmGLs4xpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 194/317] PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
Date: Sun, 24 Mar 2024 19:32:54 -0400
Message-ID: <20240324233458.1352854-195-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 2a026183f06b3..bc14386ba440c 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1614,7 +1614,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	rc = switchtec_init_isr(stdev);
 	if (rc) {
 		dev_err(&stdev->dev, "failed to init isr.\n");
-		goto err_put;
+		goto err_exit_pci;
 	}
 
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
@@ -1635,6 +1635,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 
 err_devadd:
 	stdev_kill(stdev);
+err_exit_pci:
+	switchtec_exit_pci(stdev);
 err_put:
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	put_device(&stdev->dev);
-- 
2.43.0


