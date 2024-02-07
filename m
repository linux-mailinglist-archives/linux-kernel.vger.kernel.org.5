Return-Path: <linux-kernel+bounces-56367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09C084C94C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4850A284567
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD418EB3;
	Wed,  7 Feb 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="UYLBu0of"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF91805E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304436; cv=none; b=fe45Sg9avCpvPNKhAdN/Lm2QGTi28AfBuV5kUOAs28Nw1nPIJ9II9X1Z+fuQs4MXwaZRarKpVuSITEVJyKNSEopr80Xbx0MfRj1kdeWyUAnFeEw8i304u5WSRUSEN6/5xeiLUt2CF4p7dlGNtLCoEzgol9ROKZ3xuDVqa+gUuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304436; c=relaxed/simple;
	bh=tro8ragEiatxrzVyhM2KBl3dAfGGbhXMHer3p8yIa1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xgz4rsEq9662Q2o05rZD7cJX2TRYcIA/AyaQYoYagjdqcndeSEhQ6RJWCx4YNEUPwUXck/pV9K1wRb0RiS3QwaFkoH8XfIVhktZ0/pPJw526FoSTRPdfo0OuHEVnHxnw89yDzxgMAEGZafzm2NsZdd2/fPs4DD8x/BvfQOIKs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=UYLBu0of; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d51ba18e1bso4879245ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707304433; x=1707909233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bOqg2l6/pVQQK6oz5sCjnvNtEXfm6tGtms7+YNZ0l8=;
        b=UYLBu0ofnkihM/tICzvmGXejcLPPm2D+MmmQw8XrahA6J8ewk8GhVppWDgdwfClJW8
         olYMwNuS7M6w7ZJki2Id4ISlUXtz7xXX/J2/D2seZWZphrFsJPeWcxDU8KrRERJASrZk
         qH1gyxpuAl8OXCbGn/We/UNvjew2botuDgLgEvdFe06pbWprMdqbzbzC6+eF3F67y1R5
         sKEMBBUAnMmQ1Ra+Q9iQim5PDU9xSEiQhTMCmqHEcPKVahxeY/HkBrzidWH3GnrlnNuG
         Kpxkc/77bPH1WFjmvjJv2I3E3g57FyjwlKwgOa87NQv35EWt2YEEJDCTRoTku/ImOh1V
         eeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304433; x=1707909233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bOqg2l6/pVQQK6oz5sCjnvNtEXfm6tGtms7+YNZ0l8=;
        b=ZBYsikgzEzZoBpEnPE4fUFISsiFp6oad56IZY3KPUh/cdZDALRXsRDNvQu6tWQuHNP
         3zTj6Cwdnzn74AwkrtscFGWnA+OPZHTQ4sl4dIljI0EFWDRlN96B45CSXAbRNT7A0DGE
         0gYj1DefH8sIx6YR9BbLlr3V0bYbgKVQ6uHkwfDJ+zqoeh9vKhNlkVHzrbdyqLeUr/8o
         qXts0eRgD2nM1pEiDcRAGpSl6+Ur7C3w/9f9hvQHnVl0oit0gdI3AkLhJdeHi0DpPVdI
         NJqWQoDJuCKT7GFfaEu6fUk7OafrNeVnmT6ScZAH2lT8P7Vo/Yekz8K2JDOQ3l4B6q5k
         QhKA==
X-Gm-Message-State: AOJu0Ywx2UjMEz89EDDXhUkHtP+mJc1frg0HQY9yARUKf/7kpIcFg3e7
	BO94sSENFAYN+SENIgeN3W1nqjkye1vOI9gumHzCVmJV8tmGsitIU2R9wNLsa5tnvMLKruKNUu1
	CRek=
X-Google-Smtp-Source: AGHT+IEMM33I1mRf3qbVJCVIjvQWYDJtRxsXJDDEil45HxeXjK8i5H0rpNmzDJEgjoSgP1/Q05BGvg==
X-Received: by 2002:a17:903:1108:b0:1d9:6c3:e24f with SMTP id n8-20020a170903110800b001d906c3e24fmr5075235plh.38.1707304433286;
        Wed, 07 Feb 2024 03:13:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg/yi/uJnxEcXcmd+ClMWaL8fo5FJp0E7pxLW4vkdPZBq2tQuH3k264ISX7sYs/6PkEusBcLp0t8vxUU1nEdwp6+GcqrFv2vXIkJxrTB0JJcPoty+/55pKqExpwVbHzkGNCCg58NY/f/RUoZkCSr26jNWoAL+rGGxWBlA0WC4WnH0DaRpuZ0qfTjDsi7dpnN0MLDSSdzC91W1zuXT+KeUNea3scWS60so7bDtfaDhLjy5x872vL7GDVkg0i0YF80Va8OlQATzjAoqy76EzUDm0965k0HbemZgpZsZ7nIJaQcWYP5Wwv/THKdoKcCvm/uK/QMjiiIcVXYZG42O4O0KTui/0hYj9Or4+XymP7PtrCROpQIBNDjY=
Received: from starnight.endlessm-sf.com ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id jv12-20020a170903058c00b001d9602f3dbesm1176957plb.24.2024.02.07.03.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:13:52 -0800 (PST)
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
Date: Wed,  7 Feb 2024 19:08:43 +0800
Message-ID: <20240207110842.576091-2-jhp@endlessos.org>
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
v2:
- Power on the VMD remapped devices with pci_set_power_state_locked()
- Prepare the PCIe LTR parameters before enable L1 Substates
- Add note into the comments of both pci_enable_link_state() and
  pci_enable_link_state_locked() for kernel-doc.
- The original patch set can be split as individual patches.

v3:
- Re-send for the missed version information.
- Split drivers/pci/pcie/aspm.c modification into following patches.
- Fix the comment for enasuring the PCI devices in D0.

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


