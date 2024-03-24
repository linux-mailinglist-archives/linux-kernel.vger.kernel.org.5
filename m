Return-Path: <linux-kernel+bounces-113839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE05C8886E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77879B21351
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3AD2036FC;
	Sun, 24 Mar 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD7Ge3zx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F1147C9B;
	Sun, 24 Mar 2024 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320878; cv=none; b=NjwCLzjgki83Z0lp+pD0z+4Afj1GJrZ+fG3uQ5S3wIY31Wea2xRk/Mf5jaNCXUv7pGhEip1zrWwyDHf/LRbP874YzySG/j3rsHB2GWzU4a40e0oOyDnMjPmAQzhQhHctbifnVuzq1gp9RS0wzAScKGJnLpLwYcE9s5g/8tt4uZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320878; c=relaxed/simple;
	bh=+9L2sOYcn70slea3K+0x6ySDW9NT356ZLSJHuWQ40e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7qNxNnOoIo8LI9ItAI+A/AX8a8rAhaw5YyaKrmlbFpVDsf3X2RQLo4NVxFk6IoJ+EIQSLGz/9CuFVSkvtcQhtKCWxSWs9qmCfa1N7t5gho/shTIhmjhzx7CvEtuv9LO5Eulhk5awF2VVyL9UTxS8jtYgmLx4tX9GtQXUqSUXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD7Ge3zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D577CC43390;
	Sun, 24 Mar 2024 22:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320877;
	bh=+9L2sOYcn70slea3K+0x6ySDW9NT356ZLSJHuWQ40e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mD7Ge3zxfnR0HTIjAfJVbgHOBY0OmqZxhMOMlGgX8ktvEEX2fcdycsI01/b4vGnET
	 axkmH82/yovHpdSRyRZElzdIKgqnp6PwLieP3+2Xh6R/LI7noD5FtmHyodKjvO2kSK
	 Z1AKjvvHriWHc0xHTZ97N3mEZxBf3O3jqAUxXGTFfcXpJLvxmIrznPX6xHeTOy8pvY
	 EvBgrFqZ+L0B+uy134Ez5X/R2Wm63ltwv/Yq/E9UY1zanCauHpLvnlr9fy92P24xP2
	 QPJMnXOGl+8wKAiGyWBN05QrmyY2cWisJy6gV1G0wW5yAYS7Yn0XWIl8FSDnsuhBle
	 toaih+QKxV5Xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 442/713] PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
Date: Sun, 24 Mar 2024 18:42:48 -0400
Message-ID: <20240324224720.1345309-443-sashal@kernel.org>
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


