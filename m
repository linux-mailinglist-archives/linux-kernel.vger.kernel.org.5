Return-Path: <linux-kernel+bounces-50400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2BB84787F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA6D1C25C36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECD5154C04;
	Fri,  2 Feb 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9SyraTx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA72014D930;
	Fri,  2 Feb 2024 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899275; cv=none; b=GlngSvj83pwjzRAOWgdXbdivmDm2t7LZfxdhrQtj8HR3RZw0M/SkNhD1dwLh8MUq6Pf9F+SvukXC5BNW+zfiOG6jeq7h76fJa479xrYebmQ2SFPGuoqabAyiLhKzYiIapkURLrZq38/NQkI45GJ79L68pgCNZTDysBrqm2QeJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899275; c=relaxed/simple;
	bh=qY2wf8ZS/PzeqxscDBrSKGYywkObzeogAJNumJRou+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyhQBFcRdVxZbGnmfHWf8WNn17hKbgrIFmAmXSxHlQ0jr2WFcRkTTbGJW6Xif9MUHpoFZP344Kd1YjQtwj2KzmMW/aK/NdPUa2SbP93S9dXvK1lKPh2Tm2LTaSoxapCBIkVGcFrarpNrlmXPqu2Cj0AM3J4c8iLyykCtDfWMSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9SyraTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE9EC433F1;
	Fri,  2 Feb 2024 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899275;
	bh=qY2wf8ZS/PzeqxscDBrSKGYywkObzeogAJNumJRou+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9SyraTxIcJx2q1CyLBeayTLZu9wk+mSpLlOaJJ7xcu6+DVqGR/XUTQcSVjGxFPps
	 iPLs9nHdGP3tgaDfQQdMz/PYmRLG0MZANS9sbTw+PKRqjPYkJW/ZklXJnwH/2sdNiB
	 LrajS1+eg7w6Qbp5Dupj5xjsbBXxXVryqTTkPV/eqhYRHX/iFM64aJVUaT90T901GT
	 XfSlgOsjX1KkD36t+E8Ko7dJ1Lt758VRRp/pQU/qczgWiss8ZDJpmIjv4g/wkij5EA
	 vTPMGqZlKXW/rY1p5xbxCeA7x19AEiI21IEZqyO894SYf/W9ra79Caz4RaE+EVh94U
	 JByVVlMiDUfmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conrad Kostecki <conikost@gentoo.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/15] ahci: asm1166: correct count of reported ports
Date: Fri,  2 Feb 2024 13:40:47 -0500
Message-ID: <20240202184057.541411-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
Content-Transfer-Encoding: 8bit

From: Conrad Kostecki <conikost@gentoo.org>

[ Upstream commit 0077a504e1a4468669fd2e011108db49133db56e ]

The ASM1166 SATA host controller always reports wrongly,
that it has 32 ports. But in reality, it only has six ports.

This seems to be a hardware issue, as all tested ASM1166
SATA host controllers reports such high count of ports.

Example output: ahci 0000:09:00.0: AHCI 0001.0301
32 slots 32 ports 6 Gbps 0xffffff3f impl SATA mode.

By adjusting the port_map, the count is limited to six ports.

New output: ahci 0000:09:00.0: AHCI 0001.0301
32 slots 32 ports 6 Gbps 0x3f impl SATA mode.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=211873
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218346
Signed-off-by: Conrad Kostecki <conikost@gentoo.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 805645efb3cc..e22124f42183 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -658,6 +658,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
+		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
+		hpriv->saved_port_map = 0x3f;
+	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->saved_port_map = 1;
-- 
2.43.0


