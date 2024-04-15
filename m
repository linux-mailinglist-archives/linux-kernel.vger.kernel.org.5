Return-Path: <linux-kernel+bounces-145975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0445E8A5DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCC71F21E09
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36444157A61;
	Mon, 15 Apr 2024 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ey4fZt+M"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD545944
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713220453; cv=none; b=usbUX82pmVEPQrYEc3kbdmN9NN3AftLLTm5zlTRIusyGvRIVGmSjZ/X04tY6CZpn8pM/41FgdTTn6/mbwZr4/e9COCEWJDiu928ndZxk2Y8OomzQ6FF3ofqmhlQWP3GLdu6HCc2oMUDFswZseoCJ89TGHqQYcxX7VCCAAgvIWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713220453; c=relaxed/simple;
	bh=7acQjHE0FRAyHEHJVTS5Zrtc4ySTWdRrmVh7RnffPDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEl5mG8a9KCAYqblnPsSP4jU1ptZXj6xRu6FA5Yg3MxmhTRW+O6tgl3Qq5icwqeI+ODfVFHg/SrQRUlg9Qu/cRPG+eKH6ufCOxRgd4QKIQxOilqM3Y9+09xl6T8dTLzTJjOmJCuuVolqG2qUhGHQKOun87bkUY5+ulDAqFSXGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ey4fZt+M; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7e3555015a8so859099241.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713220451; x=1713825251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=67AIpHDTzJHchwF056bG2a4yzdGbydIfluO3yoiihTI=;
        b=Ey4fZt+M7JKFa6z6Qd9AfmoTUBBk88hfBQvsJp/u6jmMprcqrm9xoU+MdI++KxNxBn
         VnZclu1L1uBq4JKCwF6pkh3NWQIcx2yvIwLA3ba9jAnKp+2CxgnIdZk+SVXbgkBSldK/
         swth6RpVjVhiJ0chKL52BWT86c4ofy10whPjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713220451; x=1713825251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67AIpHDTzJHchwF056bG2a4yzdGbydIfluO3yoiihTI=;
        b=kek5HC/dNLq5Zki539eFfriM02m9ncFNt8uIksK/UC3Y1dpNIQ5IPCKptqpPvLNXtG
         l0aX+evcb0P8favtiIHmNDgghUuTv1JZxYSsqjU4054YGS1x00aREKBVM3yhdoTifhQI
         e+H50LVEAUcqU2L1CWuq8bdyNe/DpVhCxhalMOG16QBgoIcXJfAbn0qDI2SGHi+sTA3n
         wwLjm1Ddrd3qOqUjVVdcmm2AK1jWfG0SN1DTEmvpAz6reK+C3T5096KuZYd4YxOHMnSc
         NTWukh9ZBAnw7aTksQItRrTuajbgN3cFRKdWK/gu3AhRhNOVMuzi/Y4RrVX/uMzEG5hE
         OSaw==
X-Forwarded-Encrypted: i=1; AJvYcCWVcIlUPzqvx3AODSHZszCT663RxFk1m9KAH1xhjbK8eJIeS1mc+Lu0IeVaJcuI+qMnkJCCt/czxJoUF0Z6om9fUQ4HOOJtD6w850V7
X-Gm-Message-State: AOJu0YwjD7EEiK59l6oRxOB7kHorlWkN1H806A7+esCLcC0Ijlw92EwV
	SgL9TqMFitvjFE2KqC7uxh3GSb0FVtOkCkwzDdyKjWJyaqTpdoc718CrkD2y/afqaU9W/XQq92f
	5f9tP7PJ0nBOXIOSeofT4JBZPP07dB81mCHiC
X-Google-Smtp-Source: AGHT+IE9wMrayCQ//dB3BHrVi3zj6zncCfJH35JYbhYekkl7tuDKaZ6sfL0DUpsQ6gPR7Y83low3zp4CddX8xeGHGe0=
X-Received: by 2002:a05:6102:3c89:b0:47b:8c4b:1054 with SMTP id
 c9-20020a0561023c8900b0047b8c4b1054mr3085718vsv.3.1713220450916; Mon, 15 Apr
 2024 15:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228132517.GA12586@wunner.de> <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com> <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com> <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com> <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com> <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
In-Reply-To: <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Mon, 15 Apr 2024 18:34:00 -0400
Message-ID: <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

Hey!
Asking for some help on implementation.
So I implemented most of this, and successfully tested the quirk on 6
different devices with various types of discrete fixed JHL Thunderbolt
chips.

However I want to add an additional check. A device wouldn't need this
quirk if it already has Thunderbolt functionality built in within its
Root Port.

I tried to use "is_thunderbolt" as an identifier for that type of
device--- but when I tested on a device with a thunderbolt root port,
"is_thunderbolt" was false for all the Thunderbolt PCI components
listed below.

~ # lspci -nn | grep Thunderbolt
00:07.0 PCI bridge [0604]: Intel Corporation Tiger Lake-LP Thunderbolt
4 PCI Express Root Port #1 [8086:9a25] (rev 01)
00:07.2 PCI bridge [0604]: Intel Corporation Tiger Lake-LP Thunderbolt
4 PCI Express Root Port #2 [8086:9a27] (rev 01)
00:0d.0 USB controller [0c03]: Intel Corporation Tiger Lake-LP
Thunderbolt 4 USB Controller [8086:9a13] (rev 01)
00:0d.2 USB controller [0c03]: Intel Corporation Tiger Lake-LP
Thunderbolt 4 NHI #0 [8086:9a1b] (rev 01)
00:0d.3 USB controller [0c03]: Intel Corporation Tiger Lake-LP
Thunderbolt 4 NHI #1 [8086:9a1d] (rev 01)

The device I tested was the Lenovo carbon X1 Gen 9. When
set_pcie_thunderbolt is run, the devices listed above return false on
the pci_find_next_ext_capability check.

I have spent some time trying to see if there are any ACPI values or
any alternative indicators to reliably know if a root port has
thunderbolt capabilities. I do see that ADBG is often set to TBT but
that looks like a debugging tool in ACPI.

I also looked through lspci -vvv and compared the output with a device
that has no Thunderbolt built into its CPU, which gave me nothing.

I also tried looking through values in /sys/bus and searching through
the kernel, looking through logs etc. The only option I see now is
figuring out how to get the string value returned by the lspci and
parsing it, but I'm not 100% sure if all Thunderbolt CPUs would have
Root ports specifically labeled as "Thunderbolt Root Port". I'm also
not sure if that value is supposed to be used in that way.

I was hoping that someone may have a suggestion here.


Just for reference, this is the fix I have so far. I don't want to
submit it as a new patch, until I resolve the above question.

+static bool get_pci_exp_upstream_port(struct pci_dev *dev,
+                                   struct pci_dev **upstream_port)
+{
+       struct pci_dev *parent = dev;
+
+       // If the dev is an upstream port, return itself
+       if (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
+               *upstream_port = dev;
+               return true;
+       }
+
+       // Iterate through the dev's parents to find its upstream port
+       while ((parent = pci_upstream_bridge(parent))) {
+               if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
+                       *upstream_port = parent;
+                       return true;
+               }
+       }
+       return false;
+}
+
+static void relabel_internal_thunderbolt_chip(struct pci_dev *dev)
+{
+       struct pci_dev *upstream_port;
+       struct pci_dev *upstream_ports_parent;
+
+       // Get the upstream port closest to the dev
+       if (!(get_pci_exp_upstream_port(dev, &upstream_port)))
+               return;
+
+       // Next, we confirm if the upstream port is directly behind a PCIe root
+       // port.
+       if (!(upstream_ports_parent == pci_upstream_bridge(upstream_port)))
+               return;
+       if (!(pci_pcie_type(upstream_ports_parent) == PCI_EXP_TYPE_ROOT_PORT))
+               return; // quirk does not apply
+
+       // If a device's root port already has thunderbolt capabilities, then
+       // it shouldn't be using this quirk.
+       // TODO: THIS CHECK DOES NOT WORK
+       // I ALSO TRIED USING pci_is_thunderbolt_attached WHICH DIDN'T
WORK EITHER
+       if (!(upstream_ports_parent->is_thunderbolt))
+               return; // thunderbolt functionality is built into root port
+
+       // Apply quirk
+       dev_set_removable(&dev->dev, DEVICE_FIXED);
+
+       // External facing bridges must be marked as such so that devices
+       // below them can correctly be labeled as REMOVABLE
+       if ((pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
+            && (dev->devfn == 0x08 | dev->devfn == 0x20))
+               dev->external_facing = true;
+}

