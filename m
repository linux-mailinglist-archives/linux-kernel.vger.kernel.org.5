Return-Path: <linux-kernel+bounces-56357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0184C92B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B98B1C20DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8FA1804F;
	Wed,  7 Feb 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="alpugtYz"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A517BB4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303967; cv=none; b=AP5Z5zIWBQR2JSlFy6ns4YjPbG2Fw3CQqdvMWO3FdmgjmzJq1YxLigrhyUUX2OVl+g6wP8abkiC8uKdG7ygpNCe1bSlBEmUnD2XnB7AqxbunpWWlTf938IWrZ9g6sndh0joVosLvyDYekyyLA8PQkqCXcuDSyqxmLRuneiIvcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303967; c=relaxed/simple;
	bh=SjX79JlzoG9HgwRP50O7RXEJOgSTsPbHECRNLSXhvhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJb2byWfB2R9sOQQFqrsQjHm7YnfjqgyVDhRbabSy+eankaOX5s61ZvUuVHWwsUzXDObMW5rb7QCPLYdBvEsqq7s9PiQJea4xH9kQx2XZ4Olkibfmv4/nbhtkIt+0hChwKjfh/uEF7kVSQ94FnwFdu3gUfSNZi7Ik3js2WoMdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=alpugtYz; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc36e501e1so312897a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707303963; x=1707908763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+91b1XqNAFALlb1Najn1v2c7o/wK9zms0vvE0c08CY=;
        b=alpugtYzYj+GtL0xFb4gEXIXCMg4r5jhWqsm70CewTrq3Fqiq0vPKEUJLxmitz6OOh
         CjptrzFz6EpRDKC7xE0yYqXlpsWbT9Pp10ukkaBfZeRkcMLpC//5Sdnt4bClKfLqzymJ
         5N8kxDtTfZdYQRB9kJm6fhjjA2IGdeJa8PevxflXQOcjtRcK5PM+DKgkbbyznj+zlcqL
         FmrkiHASYyeO0gNOq3aGD34rliLBMujO1IIVCRJQF3+IG6DwkKYXby7MS1O6f+K4P8h4
         WAiLs3qmGhkkWkzX4v9/5EbYwgsBv9YyWaevEph04jwaXFlvVY21GADpD5D4PJE6eAaN
         yQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303963; x=1707908763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+91b1XqNAFALlb1Najn1v2c7o/wK9zms0vvE0c08CY=;
        b=GUAk3ydPzlASVLMaD7ZF9mw09DkWHA3NxJwLHfutUeG3PpVrzozaQtkNKwaxuKBU8S
         juSop6TiMcUs4LKKEkPnRqvMFkHgqZnR0ygxP/qaKiCeXaXWXxOzF7lOq3pirijfKnUx
         G+ZOE9R6vF1IQdX5pq6bC+nGSh/XqZ85uEOAEPFkGmy9vESslYSfz8RSUgKghjZsDVxt
         ubXufrP2CxUZRl3/7BSKCqT/lQH0CMwMuSCajU49QfK+k3M4EaYNqqYxrynwzqWD9Su/
         t499ds2MDoORbSdCUeyJQ5n3NpoFaYeMe77PicB1wfybuKZngnDZDmY285tRDIRKdmoc
         uoLw==
X-Gm-Message-State: AOJu0Ywe7WUVeiUojW+vGCWTb+ufuc3w8MVEUTPU6ylBuLJZCfi5rnkD
	tg5WyXPrG5KJbN74+Uu04/NYEIg8vPnGSzLnxknYzW7Z7AJusRa5QyGp8UcuDNw=
X-Google-Smtp-Source: AGHT+IET9hW3lKuKYOuuZgQD3VliQnO2AI+JzGh6QwYp3W6pJ2omlYdD1GoU7TBOj3Hgsmo+KI1xyg==
X-Received: by 2002:a05:6358:d390:b0:176:cf18:d0bb with SMTP id mp16-20020a056358d39000b00176cf18d0bbmr3130789rwb.13.1707303963130;
        Wed, 07 Feb 2024 03:06:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWE1jg5D4Q08mRtPkrwIAlKIor83cVkpbALTMa43LCtTq3h09wgMmlQppTtehC5mVHdTfoRjajSqUDFO3l7VysvMOAb8TDy8tnDkgAyUYLl9IQ4+Z2p+ZUykNiBPvN+VXDkR20+BLcfc8S9yno8XmxfH/irG5gL2UpjRGIYkezNbquPLz6I/9AbJWzwlz1GKOoFkKkf2exEBXet2N5+gzaKfYAvlYqF0suoH/R0sQuC65HypSYRp/f+dNvfQD53qsatkmd+XSJ1xOtWFzrIF3WxnW0tZxm98zerq1QnH0lMlstslyZ4FlLEBsqeSybwzlvuZO7yBdBcdl216aSuEwLJMkr0JcTbPYdpNHbyoJQlb2EFa8/7UEc=
Received: from starnight.endlessm-sf.com ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id ff15-20020a056a002f4f00b006e04efcfbc2sm1232068pfb.74.2024.02.07.03.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:06:02 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v3 1/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Wed,  7 Feb 2024 19:02:29 +0800
Message-ID: <20240207110227.575983-3-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remapped PCIe Root Port and NVMe have PCI PM L1 substates capability,
but they are disabled originally.

Here is a failed example on ASUS B1400CEAE:

Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
Substates by following PCI Express Base Specification Revision 6.0, section
5.5.4.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..6aca3f77724c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -751,11 +751,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
-
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
-		return 0;
+		goto out_enable_link_state;
 
 	/*
 	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
@@ -763,7 +761,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	 */
 	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
 	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		return 0;
+		goto out_enable_link_state;
 
 	/*
 	 * Set the default values to the maximum required by the platform to
@@ -775,6 +773,13 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
 	pci_info(pdev, "VMD: Default LTR value set by driver\n");
 
+out_enable_link_state:
+	/*
+	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+	 * PCIe r6.0, sec 5.5.4.
+	 */
+	pci_set_power_state_locked(pdev, PCI_D0);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
 
-- 
2.43.0


