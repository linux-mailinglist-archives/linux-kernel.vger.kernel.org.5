Return-Path: <linux-kernel+bounces-50423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309568478CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E652946A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0AB1565FA;
	Fri,  2 Feb 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vydo2dEc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3791565E2;
	Fri,  2 Feb 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899328; cv=none; b=JUvv2QqYeAjBBsOn/h+4jOaLzPi4P48LNvIK6RWcLbnoIFnKY0PEEUlZONmec2UTGTj9NRFmt1Y6AnYVH/gSNHUkKHisne3tu5GQN1sn2AWS0OnGMg2HU90rXIgPX2Uqbu1QHljgE5oJ+bkuDZNNR6psq0ntUDg3VhfddxjJSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899328; c=relaxed/simple;
	bh=4I4eJ90jm/XcRcaR8RvjI7Za/j/p4ZljUrBO+xD3Ooo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbAoF4F+UHL4Gr4J0pZZzkC+F9wYbEMHVfif6YLV4Tq0r7LeQzWAr8/Be/cce8pJYMg4DDiq4eUU5oxBSBsGwZzaMOzm4Cy2ZqpuAABUbma1DE6rDmhhnwYCWFgG1CMGYWYb5kTAfEFZFZRD1yPYSm96dnuR5HbEdd3CSTU6vno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vydo2dEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6126DC433B1;
	Fri,  2 Feb 2024 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899327;
	bh=4I4eJ90jm/XcRcaR8RvjI7Za/j/p4ZljUrBO+xD3Ooo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vydo2dEcawtxFWiZkUPjni/kf5W/Cnjnz36H8t/i9GLUuRvaxHQPCIr5AChBDPLKF
	 fca7E5/Na0j9xxG+vFOu79lNCTLhsul1LDKCRO9VyLmCTlywsvK8JFEC/ek8BVlx2g
	 12T5Ifaq47NJ4PZeNV4EYqDVPVTTcqBEdsrVLL4cNa8fVJRCpiGd6qzJ4WJ/ry7iqK
	 v6nL4Yf5lMKx7ipytIRSvU3zWIVKWm7ldQB+dpSoOEvnuYDkujCqJuU9HUn+U31FkD
	 sIcDdJEp2p25POF445WqrvTjpRf0tHk2zpY4A2sZdRzTcnNa6xWY2gXA62D1IDX6mf
	 Qq0z51qNUyzPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conrad Kostecki <conikost@gentoo.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 6/8] ahci: asm1166: correct count of reported ports
Date: Fri,  2 Feb 2024 13:41:50 -0500
Message-ID: <20240202184156.541981-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184156.541981-1-sashal@kernel.org>
References: <20240202184156.541981-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 4297a8d69dbf..8bfada4843d8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -654,6 +654,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
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
 		hpriv->force_port_map = 1;
-- 
2.43.0


