Return-Path: <linux-kernel+bounces-114292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519B1888F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834CE1C2BF00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F52139583;
	Sun, 24 Mar 2024 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa3r22Ff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF21ED0DC;
	Sun, 24 Mar 2024 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321666; cv=none; b=HkIxobVbO0kQFv6NfCWEETQEKMpWeiP8da99ghKpMlYowej9MGj87CD+gpkTeOQShPHP1cjvtLRcIxj+7pAN4B//oeEuk1Cf8MdGvoCuJTSlCvbeDLAeR6g94od9EOgaqjMmTBXf0IAMTDxpC+YOhH0rFukWWqIcJ2+r3aS8uqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321666; c=relaxed/simple;
	bh=+9L2sOYcn70slea3K+0x6ySDW9NT356ZLSJHuWQ40e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPhlhHCjtIyzlZbS6NsJMVs3KcHFYakg2FJvUEwt7tHwecEjmGM9GNRpaTorHsZC+gG/O1i4Hm7EkW3dc3Tw6sItEl4f5mZSr+l79ItAZuzNZu4if5N3AagTUmTjvfLbIVpFup9jnC/f9Sl2NOWgRs8wR+OdwT+apxAOWDNDAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa3r22Ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BBBC433F1;
	Sun, 24 Mar 2024 23:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321665;
	bh=+9L2sOYcn70slea3K+0x6ySDW9NT356ZLSJHuWQ40e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oa3r22FfKiaVFBd7hzDb880k3zcQlVMWbhdnEPpjbVnRHzjaB84EZIJ+sc/TT7spt
	 JfEeH54ik8v5y/ohXpxPqcyGe10F2D0jn07ai0agIfFhhD9UZZsAcpQ3JA97PdFM9H
	 o4MkwhPMtbspFb/R5/lMy6XmwyB06vHYEFVbLAsF09mg2b9cf/uErYrh/TEe1+M/8i
	 KN3UcQtapYIAT2SRqv46AkSOOknCO5ncaMo0GcdbQsSKUTcpovYGnPMeDNVyySm6mW
	 BDLj6j4q9moG+ulX1fOuQtddHrKK4r7QM2bVSCmWz7sUkvAOvon7KmCXLgHDirsDwe
	 EQrUHE+GGT3xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 395/638] PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
Date: Sun, 24 Mar 2024 18:57:12 -0400
Message-ID: <20240324230116.1348576-396-sashal@kernel.org>
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


