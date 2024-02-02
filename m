Return-Path: <linux-kernel+bounces-50360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB08847826
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E412AB2D1E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3496E839FB;
	Fri,  2 Feb 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ8C3llk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5483A16;
	Fri,  2 Feb 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899190; cv=none; b=rlIV583gq8h8yieeRJEvkILivXVNSMDKWr6A+Up2G3C7lzepgqVXsZgyCxPR76xp8WDsekNWGbmVnjBu4vOEdVOcGT4PCoCxsb7lQRefurdY2Iz/B4eXCrshPpUZVsJbS6fcKN6L703tWKV3DFfUN0EHeiTyndwdFDHghqMHJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899190; c=relaxed/simple;
	bh=aHEh0AU8JAtEFx452FRZPB+lXST7+uMQNY898W0q+08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKRF0nK3XmhjMnmkt8sXiquV2aPOiZvKhTQNR6LdvmK6BfARjWlXtTibwSAhscQbJRdgoB2UUW/53K7gCuCkRL0I7BpS9aKFFBf1gzhtqMzguTTeHhqe/uPUGQuAzSpNkp0C1zLe9s40dVDNMaZO9mYtm8/JBAWBz0n95e+kfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ8C3llk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF45FC433C7;
	Fri,  2 Feb 2024 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899189;
	bh=aHEh0AU8JAtEFx452FRZPB+lXST7+uMQNY898W0q+08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJ8C3llklf/dacGXwQfqpBTzANedTQpPD/Bp3VyZLucIiECwpXiTCOtuo5D2aONZe
	 p9hW5DgAtJ3UKv1Vx8umJRQ16mSO7lw+ZT+Y5lEfN1S8I78S67vDIutJ/W8WD0JSxW
	 dXe6BZd7ZX5LbH6U2ZqgH2e5nvL/05o1nMLNclyEErTe7xUEuMGJBuejXfAuhKm4+f
	 NfgFmGWgpnc7QN781eMksGpAMFPR3aEnbSynaPilDd/0tltz4bQ7F2VhG5xvJ0AMNO
	 OCDSSsV+orzNXa5uWrM+5FrOxxLmi9pFFIe4d90CDwb0T9D5ReFYLQCZOW4yLFwnTg
	 R+LAR5GO2/Qkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conrad Kostecki <conikost@gentoo.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 15/23] ahci: asm1166: correct count of reported ports
Date: Fri,  2 Feb 2024 13:39:11 -0500
Message-ID: <20240202183926.540467-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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
index 3a5f3255f51b..762c5d8b7c1a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -663,6 +663,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
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


