Return-Path: <linux-kernel+bounces-50430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824B8478DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF451C265FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764E1308C0;
	Fri,  2 Feb 2024 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quggqApb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AB15B4DD;
	Fri,  2 Feb 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899345; cv=none; b=jRrMeA9Q5xA89oFAXzHidDqMNUmI89FCve2z3d6VpyFpMfUuYKiRQAM53tkOAfsg0KkWj5PtfCbwcJh0OGJTIsFHjluxRxVgrAtTxzjur+QeURE+OrGRza3H2Tf0SvNAShtT94MQ6gF2QHMilfE/CNDXQsDpUw9uz+2s3gtyo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899345; c=relaxed/simple;
	bh=1b73q4SSa6A/DuyRYEWa3YFb29LuHgm98YU93zzXk0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imhe0IApK1zmioM0dDv5rTvfXzZN3JD2FPRKAdLUhILCdubaEkQTP26e5K7PWea2gCryfFF/bQ14tgS1Vs9l6QD666DeQYGuAOCdcXlYFdJNLsR1Kymsz7jd7RJfE0Nu8fFL2hzIx8lMZJN0vi+fBOlwwhhUvYzt3WNAxMEhRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quggqApb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59891C433F1;
	Fri,  2 Feb 2024 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899345;
	bh=1b73q4SSa6A/DuyRYEWa3YFb29LuHgm98YU93zzXk0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quggqApbjsdPBedbRPy6A/RGHHJ00PC9sEUGPdC9dxWl0FXRKyBWrTPubrLyX9LbJ
	 hW3MyrwBPDukfRDCU1xsZkg/+F+L5pghAyTy72lxnrQNFwlBT/LfgnNn252cwIWANm
	 fc8TBBptwjwa/BXydteqMC+eSxSn4eSfnRYSFMlJdT0togiXwXM2+yFvLyz5bUM+LY
	 dLn3KQ0URcC6vhf73gmDNr7XwLwMzRLjZ+32423UG1fg3z7rUnSWnL/LqOBIXEQ9RS
	 C2LqvwwpqIThAc7ndP5JC8zbnmBnYLTfYIjFz7P7OTK8vNevXEKeOfJqAMX7a2N9xt
	 3F3i0E7lCOmTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conrad Kostecki <conikost@gentoo.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/6] ahci: asm1166: correct count of reported ports
Date: Fri,  2 Feb 2024 13:42:11 -0500
Message-ID: <20240202184215.542162-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184215.542162-1-sashal@kernel.org>
References: <20240202184215.542162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index aa35d1941d1f..5db3dc45bdc4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -618,6 +618,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
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


