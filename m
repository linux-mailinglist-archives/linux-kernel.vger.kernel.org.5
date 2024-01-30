Return-Path: <linux-kernel+bounces-45108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E9842BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850CF1C223B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7600015AADA;
	Tue, 30 Jan 2024 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="KPiqro+W"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC64215AAC6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639489; cv=none; b=KySKqn+EzI9QicpRjhRSEIaKLCX1vycXg7PNj+nyDtX+BAdrVOBgeJwttDc8iA5etza5JAB2xHJuZCflv+J2ZwM9ffMA8bwj3q3lHopuoQhT2mGV6BVDqs9G5GGOLXFLtyCDEW9pMATyyjgzsWMHeLZP173MCMFMbmrj61ZCKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639489; c=relaxed/simple;
	bh=M/3mcyS/R5YfUYzMjS5FWZp3gs7RfsHrYV0noCUNd14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=co4NmKUOcM1IKaWCWBFRyxniEsXpP3p4rXU2zaPS1FGNzsva34EdkZT+NGm1U+4NNUy/nDfYFKbdf0kVZq9/gDg8a6k/JNL9WsDKQPF+Z4dML6/Egx2z13knDvypHTlwbT1DNhSdm7bzTZ4X9sFO5NzM8UTuzyocNGyT3XlfBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=KPiqro+W; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc26698a5bfso1259444276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706639486; x=1707244286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPoJ+lkdtf6SxlpJxbUgnjG2tKoABsEhn7jfQlZts2E=;
        b=KPiqro+WzkMiFRTSTEwS4WgPNBYL8WfSlMMMmrdhc0deD/+32DWzl1Ezqowr7za1Tk
         CDYPjuslJZdCpp366pi0TwYMFd4reyNbEQXocUkcrFbWoDE4xJjiqg3qNEC9aUg3IK2K
         CPGKsXzqI5pWz9HZQDztpaKoEm7PEEszGJXHnIHw3iNsP47IIOGevtC6GMHNwCgEBub+
         vHnHI3D/CfrfrESSj6Uxd8Je1KKJvNHHE7bV19gqOL8nH1AMVCVewbx9lvyaY9kOsbWk
         HWgJk4vKGEp/Q3In44/mrFy83j8piamw4gdm3VYJYXCfPtIfrIQBI0ySsvKLgjX7C3ot
         CVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639486; x=1707244286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPoJ+lkdtf6SxlpJxbUgnjG2tKoABsEhn7jfQlZts2E=;
        b=NUGo4sO8YQaD2jQGP8mqtehNEFKMWEcRyzL2m1qvVg093InGNA8Sx1+rOE8ZaXapDh
         867MmYfONjJUfnkNADAB9yyXIXZcCTu97uI+7qFZmZIARJ0dopbq2dGsNcj7nQbwJLoN
         bN3/nwQDyGM5Q765J307eBbj+N6WzhjtruSaunEI6HbM9q4bZB7tKbKgb1dF7yJvhMJn
         63kMjGZ8t6iKaCJ0fpNv1X2VRRiRaXjO4gErWtg4XrPBAOzcz349NiI2pVe1flA4Y43Y
         kACkIaREopNAfcLXmQIRvLrAcdLoOOVmxxuKxVlKWH8RqjE2lOEUnk5dB7PMcVgh8JV6
         BFFg==
X-Forwarded-Encrypted: i=0; AJvYcCV+7xS8VeicXr1H+N4ksJSfoqdkhkenlGdKNMjMgmEU/5Wam8pI78ZSgpkombNAc/JUxwfnJt4pzWgRgfWZkNk8EIWG+DjlfFyl9C+O
X-Gm-Message-State: AOJu0YyeW4iCMmGTVci/Mbm/TvkbJFNqxox86Ybb/6abEECr144tZk//
	OeAG7aFFuASQ4biifWcxx738T3CX3WcGiLTmR76W7VQ6bdLKCKOLjpmaujNSD9g=
X-Google-Smtp-Source: AGHT+IGJcrsHfepFGSKOQ+k9TTGgzKp3KAahBgGcbX766Kr+souwzLGcZHuEWohgzjIvbBSec2Z98Q==
X-Received: by 2002:a25:4191:0:b0:dc6:42cd:6554 with SMTP id o139-20020a254191000000b00dc642cd6554mr128378yba.0.1706639486584;
        Tue, 30 Jan 2024 10:31:26 -0800 (PST)
Received: from limbo.local ([2001:1308:266d:cd00:9e57:ca38:1eb0:4db5])
        by smtp.gmail.com with ESMTPSA id 63-20020a251342000000b00dc24ed83a6csm3091202ybt.62.2024.01.30.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:31:26 -0800 (PST)
From: Daniel Drake <drake@endlessos.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	david.e.box@linux.intel.com
Subject: [PATCH] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
Date: Tue, 30 Jan 2024 14:31:24 -0400
Message-ID: <20240130183124.19985-1-drake@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Asus B1400 with production shipped firmware version 304 and VMD
disabled cannot resume from suspend: the NVMe device becomes unresponsive
and inaccessible.

This is because the NVMe device and parent PCI bridge get put into D3cold
during suspend, and this PCI bridge cannot be recovered from D3cold mode:

  echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/unbind
  echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/unbind
  setpci -s 00:06.0 CAP_PM+4.b=03 # D3hot
  acpidbg -b "execute \_SB.PC00.PEG0.PXP._OFF"
  acpidbg -b "execute \_SB.PC00.PEG0.PXP._ON"
  setpci -s 00:06.0 CAP_PM+4.b=0 # D0
  echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/bind
  echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/bind
  # NVMe probe fails here with -ENODEV

This appears to be an untested D3cold transition by the vendor; Intel
socwatch shows that Windows leaves the NVMe device and parent bridge in D0
during suspend, even though this firmware version has StorageD3Enable=1.

Experimenting with the DSDT, the _OFF method calls DL23() which sets a L23E
bit at offset 0xe2 into the PCI configuration space for this root port.
This is the specific write that the _ON routine is unable to recover from.
This register is not documented in the public chipset datasheet.

Disallow D3cold on the PCI bridge to enable successful suspend/resume.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
Signed-off-by: Daniel Drake <drake@endlessos.org>
---
 arch/x86/pci/fixup.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

There's an existing quirk for this product that selects S3 instead of
s2idle because of this failure. However, after extensive testing,
we've found that S3 cannot reliably wake up from suspend (firmware issue).
We need to get s2idle working again; I'll revert the original quirk
once we have solved this D3cold issue.

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index f347c20247d30..c486d86bb678b 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -907,6 +907,32 @@ static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
 
+/*
+ * Disable D3cold on Asus B1400 PCIe bridge at 00:06.0.
+ *
+ * On this platform with VMD off, the NVMe's parent PCI bridge cannot
+ * successfully power back on from D3cold, resulting in unresponsive NVMe on
+ * resume. This appears to be an untested transition by the vendor: Windows
+ * leaves the NVMe and parent bridge in D0 during suspend, even though
+ * StorageD3Enable=1 is set on the production shipped firmware version 304.
+ */
+static const struct dmi_system_id asus_nvme_broken_d3cold_table[] = {
+	{
+		.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
+		},
+	},
+	{}
+};
+
+static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
+{
+	if (dmi_check_system(asus_nvme_broken_d3cold_table) > 0)
+		pci_d3cold_disable(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
-- 
2.39.2


