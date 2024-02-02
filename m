Return-Path: <linux-kernel+bounces-50436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26468478F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55928285EF9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5B015E5A9;
	Fri,  2 Feb 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3sNs6+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACE15DF1D;
	Fri,  2 Feb 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899359; cv=none; b=tILsGjMvMZ95CqE1gkppvMyhtd5739zQ/XwroKlV1/iIcyBkycreS6oBPVosrHDK3+nyvbnk4uR4wspr/P8tautOlQeEny9gTt4xwENvcmfGtl47Tc0a5h96KvpOuJr0thFG7Kas0TqzBepP7cyUgDNvN86Ox20waNuCutMc84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899359; c=relaxed/simple;
	bh=TG38hp9r6X6Rv446nvg3drtlUQpDJO2JSwvII2DOXPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NThHtcRREWF/WnN1LpyyaJWR9DtBt/kZpcdn10a5pGjsctZ+7xZ64nzmLMjTISEMWotv5KzaGREme0yQRf3whlZfFIyklltLXia5/pVT1uLpCWyqVXgK1gc600657XQOltdnB4qH35aLLSlQGqHxP8Vx0cNYPn6H8cIM3NrPWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3sNs6+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130D8C43399;
	Fri,  2 Feb 2024 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899359;
	bh=TG38hp9r6X6Rv446nvg3drtlUQpDJO2JSwvII2DOXPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3sNs6+S1NqmOx1AmLioWn4bbeBL4xxn4KFSGPi59Mg54Ck2A7JrFyU+EDctKujqx
	 S72Z1PEZyNvUM5gWiABebHEhsz8wc2+e8jnB6rlAi804cPKp6hG/5Ytq/jzb7KvZ8T
	 Zmv/MAHKjqvSh+WibitBAmE+9rJLvyTyyVjWiV7nPaTWqJN1n06qE4LqcruxzbsCK1
	 btPid23+1sBCnlIryeX9vaaqjuqFb3HFf4/daD5dFMkhQQQsZXX0C4MAA3FLiJeo1v
	 VDDVQUl1+wN5d7yYjrMvTKxwKEi1DZDvdO5bz1cJITUtaAwnAuHOUQpSShzHOdTKDL
	 JxF2cpxGrlNHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conrad Kostecki <conikost@gentoo.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/5] ahci: asm1166: correct count of reported ports
Date: Fri,  2 Feb 2024 13:42:26 -0500
Message-ID: <20240202184229.542298-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184229.542298-1-sashal@kernel.org>
References: <20240202184229.542298-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index ab3ea47ecce3..abdfd440987b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -634,6 +634,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
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


