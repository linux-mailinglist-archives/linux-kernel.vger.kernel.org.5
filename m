Return-Path: <linux-kernel+bounces-115004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4433E888C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04CA285BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431D12E6C95;
	Mon, 25 Mar 2024 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW1YkfrB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EC17BB36;
	Sun, 24 Mar 2024 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323768; cv=none; b=IjbZPBZTL6MFprLtFqu7Sf01AiEs29WzYThyGbvRmo+s2FU4KPOs2PhNysgzgg1RJyBrVkMMOa4yjfnStmFXfDPcC/xq+KwoKmSTLaJxK5sg8clFgMXsq4yxFHavlcBPChhP8qp60T/gx0Licin4SsDSWv9gfOnFFBJ7PSRmu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323768; c=relaxed/simple;
	bh=hwQzLx+b0pzbl2REzzGMcPpe4qgg4cQhQTmzuqjgsrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqT60pIPgH1IhXyi4deUnWKmVPGrS8g2dpqTKE6n5bzXo+EcMZLcahXJ8Opd0pjWIZTa/YUKHymbcnGRZ9o8PwXlvMmoAL8OLCJ46mRDv4xv4snsLgfxusQqLAvARG/mrolB4vlUsP3ga/N2PkdqlGabyZromAwF9oILtxn5oFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW1YkfrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264CFC43390;
	Sun, 24 Mar 2024 23:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323766;
	bh=hwQzLx+b0pzbl2REzzGMcPpe4qgg4cQhQTmzuqjgsrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nW1YkfrB1Jw0rWBg1UlGKQHC32UQrbBTtC3ggg/FyFWcQd7V1EtOC57FrqsUIR8BK
	 6/1aLOvaxc+bFzcgEeKr3TKEI3+6HCaW2DobYvgl+qWs/HFq4NJP1pBqxZ1c6vI7wt
	 LVLf9Rz9qi9cOGc/byF0kILCrvyb67OYFFavVmfYAPMRLKts3Al39hrdcWiKXsEOMJ
	 KPeFSawgGHoxMNzKz2KLy12CCAZbD5Hl2ulo5E7/OI09kytQDJpqbK1tZ6HxLNKvIl
	 /uoii+kqWq3Ewz8nBRyUe4gCo/MY+r5bqYdzVlT/cw8Uo+QerFjFH47A+fsAgu5n5r
	 qFLJnVFKNOwkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 142/238] PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
Date: Sun, 24 Mar 2024 19:38:50 -0400
Message-ID: <20240324234027.1354210-143-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 5cea3ad290c54..9aa230c3208ab 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1615,7 +1615,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	rc = switchtec_init_isr(stdev);
 	if (rc) {
 		dev_err(&stdev->dev, "failed to init isr.\n");
-		goto err_put;
+		goto err_exit_pci;
 	}
 
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
@@ -1636,6 +1636,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 
 err_devadd:
 	stdev_kill(stdev);
+err_exit_pci:
+	switchtec_exit_pci(stdev);
 err_put:
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	put_device(&stdev->dev);
-- 
2.43.0


