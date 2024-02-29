Return-Path: <linux-kernel+bounces-86865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F886CBE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10B21F21E58
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9C13774E;
	Thu, 29 Feb 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UfYoVems"
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962A41A80
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218099; cv=none; b=dXjC10M5S8XjlTo0YaTv+mGIpeadRdqj0Jw08oZK7cX+q4opK0ilGcUWLlCIbO0hotLmRTW0kn7knVT3EpxrZuWJztfQ1pNspy9SgaMP/cRfKBSPDBqTocHY/+8Ta8SuTidNJeZzFA6gk0kRZnCIfj94iKe51sXmrW2tM9Y+7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218099; c=relaxed/simple;
	bh=WGL9qM33Nk7fRGwrV2mf7JvJ3jNhdkTxb/e39Lrf8ZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+3oD74aVz/4sK9k/D94zC9xGhl8E6/J0PrQRFgJd75qTlHFe/QXl+A1VMudGMmUM9ih7ATlJcd57SBhyk0rMfPnNz3Jek3x/HSm5SNWJnUUasFiUeR+IVzn+5GZSH9Fqo5/vcFFqfwSJ7t2Qmu7Z0lFCv2kUEeGw+pg/MWChZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UfYoVems; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1709218090; x=1709477290;
	bh=oSUfZi1cGfdeB2IvoV8ev5peOvcG5sVLj13qHsWtvCc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UfYoVemsMrQXXTx6rDIs2sKrXk0meAWKVEgf/yHRQx7M1rDUxGzvpEqxfNE2Y74XE
	 t1TiBTeQl3lF75ZupVeL9itL2H2iEebx1xVAQiDcbaCzdGvHy8ZL2nRS2BSGOSAQwg
	 Eq4Yt0EWBcXzdh0fDzMj4fiBZbRz3tn+V26n/v8cb4Vw3fK8oC6XHqDd3TY1M4V+0P
	 FmTlx3Kn4I8gJhPIqv0kftgY8YKYPDkPsbem+/HOIwDlw0Hwg1rs7p2Jit4YJ/OckL
	 sEkVM19++zYWIL7lG9LC5G+gNutZklt4F/23hsa5cX6rrqjRbcHQ/OKhdiWi+dG4hi
	 IxQpaaVxQFJ0w==
Date: Thu, 29 Feb 2024 14:47:59 +0000
To: o-takashi@sakamocchi.jp
From: Edmund Raile <edmund.raile@proton.me>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Edmund Raile <edmund.raile@proton.me>
Subject: [PATCH v2] firewire: ohci: prevent leak of left-over IRQ on unbind
Message-ID: <20240229144723.13047-2-edmund.raile@proton.me>
In-Reply-To: <20240229101236.8074-1-edmund.raile@proton.me>
References: <20240229101236.8074-1-edmund.raile@proton.me>
Feedback-ID: 45198251:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Commit 5a95f1ded28691e6 ("firewire: ohci: use devres for requested IRQ")
also removed the call to free_irq() in pci_remove(), leading to a
leftover irq of devm_request_irq() at pci_disable_msi() in pci_remove()
when unbinding the driver from the device

remove_proc_entry: removing non-empty directory 'irq/136', leaking at
least 'firewire_ohci'
Call Trace:
 ? remove_proc_entry+0x19c/0x1c0
 ? __warn+0x81/0x130
 ? remove_proc_entry+0x19c/0x1c0
 ? report_bug+0x171/0x1a0
 ? console_unlock+0x78/0x120
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? remove_proc_entry+0x19c/0x1c0
 unregister_irq_proc+0xf4/0x120
 free_desc+0x3d/0xe0
 ? kfree+0x29f/0x2f0
 irq_free_descs+0x47/0x70
 msi_domain_free_locked.part.0+0x19d/0x1d0
 msi_domain_free_irqs_all_locked+0x81/0xc0
 pci_free_msi_irqs+0x12/0x40
 pci_disable_msi+0x4c/0x60
 pci_remove+0x9d/0xc0 [firewire_ohci
     01b483699bebf9cb07a3d69df0aa2bee71db1b26]
 pci_device_remove+0x37/0xa0
 device_release_driver_internal+0x19f/0x200
 unbind_store+0xa1/0xb0

remove irq with devm_free_irq() before pci_disable_msi()
also remove it in fail_msi: of pci_probe() as this would lead to
an identical leak

Fixes: 5a95f1ded28691e6 ("firewire: ohci: use devres for requested IRQ")

Signed-off-by: Edmund Raile <edmund.raile@proton.me>

---

Using FW643 with vfio-pci required unbinding from firewire_ohci,
doing so currently produces a memory leak due to a leftover irq
which this patch removes.

The irq can be observed while the driver is loaded and bound:
find /proc/irq -type d -name "firewire_ohci"

Is it a good idea to submit a patch to devm_request_irq() in
include/linux/interrupt.h to add the function comment
/*
 * counterpart: devm_free_irq()
 */
so LSPs show that hint?

v2 change: corrected patch title

 drivers/firewire/ohci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 9db9290c3269..7bc71f4be64a 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3773,6 +3773,7 @@ static int pci_probe(struct pci_dev *dev,
 =09return 0;
=20
  fail_msi:
+=09devm_free_irq(&dev->dev, dev->irq, ohci);
 =09pci_disable_msi(dev);
=20
 =09return err;
@@ -3800,6 +3801,7 @@ static void pci_remove(struct pci_dev *dev)
=20
 =09software_reset(ohci);
=20
+=09devm_free_irq(&dev->dev, dev->irq, ohci);
 =09pci_disable_msi(dev);
=20
 =09dev_notice(&dev->dev, "removing fw-ohci device\n");
--=20
2.43.0



