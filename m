Return-Path: <linux-kernel+bounces-115118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D54C18893EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8BEB31449
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431D22FD86F;
	Mon, 25 Mar 2024 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl1Nnebd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FBE181B90;
	Sun, 24 Mar 2024 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324114; cv=none; b=KYQTxg0kFLNxGAH0moM06Lyb4I6Xy5D0YsUt2/U14t5ThmqcXhvMSTtQ09aEn9FM/5wXWZoRE85B/aT3NF/zvjCAUPRLPg2mGsdJq/Cb8TKIxNDQJq0cEoB96ahcywx6f3pSPCmHgRYaEtnNbC9zINCFUGGg8+bges1mUao8/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324114; c=relaxed/simple;
	bh=tVb2DaertyoHviz3jSJZK0KQO3vS7370E6vkFxCRL60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1/cfXU8/7CIcY5HyyI/UgRuEZ8BPMYGzmvLCyM5tvrHAoyz/W0YppyfQzfCQy1ToAYqvTiaO+bRzPvwF52L4bUngjL0C20KTH10+xWmfHmcxwyozuKNdkF6PGvG0rpb6b+MvmfVl0BabDw62S/RecWdaI6HqFjHO2Op1oLcGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl1Nnebd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE7BC43394;
	Sun, 24 Mar 2024 23:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324113;
	bh=tVb2DaertyoHviz3jSJZK0KQO3vS7370E6vkFxCRL60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yl1NnebdjBYddswj39RhGuLk9OG93o+FXPmzmuycq4g+9Y39VVHOP000lCOXecEFS
	 zosihZl2WmrKzM7UA6eaaah0BPDtitubA0/fkfO+DRB5Mgn+nrWZUKklWInVGtPSCo
	 6bPaJ20Dh6DidKhcWdjeraEFz+rEe0FMTZdNmHJiMGxYuznFY55/SwIf90denlF7Ul
	 8G3HKzMiQn8+M+btk6LRxQp0FjiIRNpmSqyOCX4mNYPC0Sz34Vv9EsQLoMuuCDenoJ
	 EI9M1YEmdI5zZ9lRf1yJRFvWGPOnge+Ai/3fj9HA+m67iAFFmNSqJ5Q/LEiW5d/5PZ
	 FSXe2cyKB5WeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 112/183] PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
Date: Sun, 24 Mar 2024 19:45:25 -0400
Message-ID: <20240324234638.1355609-113-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 0037f368f62b9..0b83252358527 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1433,7 +1433,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	rc = switchtec_init_isr(stdev);
 	if (rc) {
 		dev_err(&stdev->dev, "failed to init isr.\n");
-		goto err_put;
+		goto err_exit_pci;
 	}
 
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
@@ -1454,6 +1454,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 
 err_devadd:
 	stdev_kill(stdev);
+err_exit_pci:
+	switchtec_exit_pci(stdev);
 err_put:
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	put_device(&stdev->dev);
-- 
2.43.0


