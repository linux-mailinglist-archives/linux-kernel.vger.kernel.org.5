Return-Path: <linux-kernel+bounces-50413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140498478A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7EC1F22035
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2C150FD7;
	Fri,  2 Feb 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEk9mrGy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6461150FC1;
	Fri,  2 Feb 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899303; cv=none; b=Bz0u6XPJ61ppmAh/mJ8h6CxN2ctDIuTANjBtwf0PS94q73CsKciJSp+E+uKeuWwyUSt5B9ccFbiq2l1s05vji4Rp0a6ZeFXoygEjBR6ENjWiR1FZhQZrtCUvUk1V38Ls3Uw31DvHFWa200IGyP5/cCilPm53ebdBn7C0EhdcI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899303; c=relaxed/simple;
	bh=y9Yg3pe1NwHQpjn7su7ZTso52Sw7EYlIl38Y5ET14t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmENWz+38DN7kPwCcuDoHgmXOk7S055Rx3IvCNyGvn7wpgzhgvZiqwRcpbNT8VYO6AA/h80GRXI5LQyZf0TFyzO+e9qVaFc8V215gI/lk55kN4v/5pMAIIxH72ETJgtzCjWOA9spjNDHZQ7S68TR/MKWh7LMA8rj82nmu/53JQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEk9mrGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51588C433A6;
	Fri,  2 Feb 2024 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899303;
	bh=y9Yg3pe1NwHQpjn7su7ZTso52Sw7EYlIl38Y5ET14t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEk9mrGyUSzCYj6imhs7uM8SQYE6yIkLb/iHIz6uKdUXjRGVrwUvx40rR7vNU7wHl
	 jx1HXvAWDfK7ZuzH6aTT/2WdPDMTAjF22092mPpuoonruL0/wRSRbMjcXR+ZR1GdNZ
	 4uHfYRx5CZDczmEvB8I6uksah0Dp5Vfp6/bVNLXG0hOwul9kyrYtgvKNrYvG6Hg+fY
	 Jj8IGZdYEHYvX3KuMIasBW5qBJ1pHsuFV7OCWqwINNddSAyjpX0pZYX7VIp9e2vptq
	 QVFUXuNhX4iYR/YsQwDQNuaFNduGp0B+5aW/2w8/GWW16bMdbY1DgXXngxRXnVA31R
	 sRv1SJaVlW9Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conrad Kostecki <conikost@gentoo.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/11] ahci: asm1166: correct count of reported ports
Date: Fri,  2 Feb 2024 13:41:21 -0500
Message-ID: <20240202184130.541736-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184130.541736-1-sashal@kernel.org>
References: <20240202184130.541736-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 3147b2e6cd8c..56fcb1dec6af 100644
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
 		hpriv->force_port_map = 1;
-- 
2.43.0


