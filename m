Return-Path: <linux-kernel+bounces-126081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB418931CE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB321C20C16
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14729145B22;
	Sun, 31 Mar 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ITPXHysp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4Ervmmk"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D714535F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711893054; cv=none; b=VI5t6VUm7CCKn+BIwXv+l0qeRAk/rssB8GMRF26Sq0nwgdm80X8/s1oO8MHe9kHoSI4rPRClyGpAJBfJKkjyrFY+4ppYFqd+V14pMM7qdqZMvOiu9XrQb0DYnGjlyvOGTdBD6ccgd/yk/5770zQI65vm2tjetmoRO6YjdkOyO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711893054; c=relaxed/simple;
	bh=Bm799p878xi8cCkGjfKPw5pJvYx9lsp1ujzntTHoG4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsZ4ej7K8J0s3DzumCr2ILUCuhct5xQSYq2kUqOpyji/PYVzSrzmJ77b2A79UXpXgLzQ6XplHJxm2sxkoIDAK9eXmMHKrZoIfGTHEqyZz3tLhjtwpb/WQt4j+7o4aTama/ZNPTqyicXauEDfS74V5PbNq036SSvY6A6E4d/NjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ITPXHysp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4Ervmmk; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8867518000EF;
	Sun, 31 Mar 2024 09:50:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 31 Mar 2024 09:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711893051; x=
	1711979451; bh=uOw+tg91pvfmeSLmBzCONKSxkv2GqAof7vSFCeSIuA4=; b=I
	TPXHysp+bNhFDtP00nyfPo+nL4VIjghkX1158R/Ts6LggcU0NmYyfEAC7A3bVpRh
	Abf81gWvU7MpzT+We7a/cfEuJwp5dYjV0uIb6z/I/ElZ+sIvc6bKRGa/lJQzanSf
	5d+hYheRoLBNUnxhFbeFxyXR9W+gFxp82O8xuyyEO+U4drc84k6f5cUmKQ/qYNit
	lTM+4ANd0Gw3IMv1SJ9hbFIhtYPN7vmg8GhkcXTItNMJEvlajUADw6nVKtP1NbcP
	SZORAO5hwNx1wuW+n7y8SL+VrIqHNJFHq8uVpzNjQyxPGjA87B0Y/80Ch20bAInN
	tDjdnAZzZPp804QKZzG/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711893051; x=
	1711979451; bh=uOw+tg91pvfmeSLmBzCONKSxkv2GqAof7vSFCeSIuA4=; b=P
	4Ervmmksa0SEV6ADejD5SPyKegJzR+dc3/jFAcF/F2y9fhyl9k7M07apaM2EvE7y
	CcFqRmXWTPbCbpo5kQTCaG8c2kdR3Igv9IhDmxKtjLVqjamekmB3X+io57OG4HvM
	ZmJq4xB2gzPeXRHPj3YuguBmEQAYLi1muLOSIlsbu0nJd37vh42Ann4mblmdtip9
	azoG/YplDXB4y4Y02B9FTdOIwregSg7ah4Lyvhp08ZLGaa9BvIeulJQP2ngVNVZr
	hhu3U7pylPvAP+T1SyUh/QUW+VvwBVhoUByor3y1QW/SThO6BMXMF/TiRNgjspr6
	2D+w/cDwyTAEBvFEUyrvg==
X-ME-Sender: <xms:OmoJZtCiC8tavsglToLlBl5IC0t87W10OfNRb5TU7PglaeXSKlfKkQ>
    <xme:OmoJZrhO8ae0sHlvmm9jKSius_xYq3r5go6Mg32-e8AB-tz13r9_1QfkhNfV1arsJ
    Xe1Vwivg5xTlLvibZk>
X-ME-Received: <xmr:OmoJZokseGc0dr2Mw6TFdGOzvFAPJfV576dqO15AKZoKwH2EUq7Repv2rUP-lhsQGwm07s0lTm04MqCsEEp3pnBk3caVVY0SqqlvtJ6If2m0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:OmoJZnx4XSf2LLXP8AjI51VgckOWugqH-iKuc_6GA9zO2uJoS-p9cA>
    <xmx:OmoJZiR5n5NfjTD9trj2ydAegelQAoKARk9vrHOpxY85StsnPCQEOA>
    <xmx:OmoJZqaI04fViV7-y0GdajseNtF8ftanUA1f7t8GZ6xoiGBf_Xx_iQ>
    <xmx:OmoJZjTke0EKb-aWmC_bI4OkFTMHKcNcjoLvQA1dFG8v22e7kl-_WA>
    <xmx:O2oJZgcdyqNMfaBbIJEXTGEUwhWqKviO5sKi0T2nrE4E8fPVsjhXoHBoze0>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Mar 2024 09:50:49 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] firewire: ohci: use pci_irq_vector() to retrieve allocated interrupt line
Date: Sun, 31 Mar 2024 22:50:37 +0900
Message-ID: <20240331135037.191479-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331135037.191479-1-o-takashi@sakamocchi.jp>
References: <20240331135037.191479-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pci_irq_vector() is available to retrieve the allocated interrupt line
instead of the direct access to the member of device structure.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index c14e6efaba36..f3b610f86aac 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3623,7 +3623,7 @@ static int pci_probe(struct pci_dev *dev,
 	struct fw_ohci *ohci;
 	u32 bus_options, max_receive, link_speed, version;
 	u64 guid;
-	int i, flags, err;
+	int i, flags, irq, err;
 	size_t size;
 
 	if (dev->vendor == PCI_VENDOR_ID_PINNACLE_SYSTEMS) {
@@ -3754,12 +3754,17 @@ static int pci_probe(struct pci_dev *dev,
 	err = pci_alloc_irq_vectors(dev, 1, 1, flags);
 	if (err < 0)
 		return err;
+	irq = pci_irq_vector(dev, 0);
+	if (irq < 0) {
+		err = irq;
+		goto fail_msi;
+	}
 
-	err = request_threaded_irq(dev->irq, irq_handler, NULL,
+	err = request_threaded_irq(irq, irq_handler, NULL,
 				   pci_dev_msi_enabled(dev) ? 0 : IRQF_SHARED, ohci_driver_name,
 				   ohci);
 	if (err < 0) {
-		ohci_err(ohci, "failed to allocate interrupt %d\n", dev->irq);
+		ohci_err(ohci, "failed to allocate interrupt %d\n", irq);
 		goto fail_msi;
 	}
 
@@ -3779,7 +3784,7 @@ static int pci_probe(struct pci_dev *dev,
 	return 0;
 
  fail_irq:
-	free_irq(dev->irq, ohci);
+	free_irq(irq, ohci);
  fail_msi:
 	pci_free_irq_vectors(dev);
 
@@ -3789,6 +3794,7 @@ static int pci_probe(struct pci_dev *dev,
 static void pci_remove(struct pci_dev *dev)
 {
 	struct fw_ohci *ohci = pci_get_drvdata(dev);
+	int irq;
 
 	/*
 	 * If the removal is happening from the suspend state, LPS won't be
@@ -3808,7 +3814,9 @@ static void pci_remove(struct pci_dev *dev)
 
 	software_reset(ohci);
 
-	free_irq(dev->irq, ohci);
+	irq = pci_irq_vector(dev, 0);
+	if (irq >= 0)
+		free_irq(irq, ohci);
 	pci_free_irq_vectors(dev);
 
 	dev_notice(&dev->dev, "removing fw-ohci device\n");
-- 
2.43.0


