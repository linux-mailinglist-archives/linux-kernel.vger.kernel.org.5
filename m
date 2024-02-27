Return-Path: <linux-kernel+bounces-83295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E686917C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A9E28FF45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD713B28A;
	Tue, 27 Feb 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="S5fE3bH+"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00351EB25
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039685; cv=none; b=P0nJ7yPiMdzO2YTqaDOHoeVVb9YQCvFi2q+uF0nxG+Unm7rsg5yZFrLdxQ8ujZ1foBGTiHCFE/JjFdDFhIcNsSbF95F8vagu0xEgzgdOiNn8YxcrDH2YAXhrwm3sewTU4qGqeG0WDjnmf/DY6QIGBy/49bGFREqh4Y1UXucWr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039685; c=relaxed/simple;
	bh=rx8PCE5o6dFMSFR8vi+L7kexPHd420uWKw7zhq26y8s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Svk6F6GlUxFBCsRvOTtqFpck7VXNO7qgN3Kdh6h0NK5FaTY0+zC3o6SCA64AD712+3zDfbBSHfG2lNEY7tXuzH8+oSHiGQ2W9U1+kX50sywNh5oUQgl205aBJ5BqfXRt6hGqtU5MWWFPOqe+viDwjn6C8XbeOX6vpDxPkBEEaio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=S5fE3bH+; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=zndwy7274ndljkwkfrt7ypvhmq.protonmail; t=1709039667; x=1709298867;
	bh=ZrJU4qMFbvDi4ufPStPJLjmeabfKg0P/vMjlkrx7MbI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=S5fE3bH+wdw2Dmpb8pSzPkeRDwJKlQqvoxzNGJVm5vMlgEjNnzy82BG5ydEem2Au3
	 eMaciU8io8jQmN2q81+g1i9hP8NPodDaY2JAe2GsjomLnTerwN5Kj27BLRIOoWooO2
	 2WSLxmm2l5pm3zxQRqlKvqbzIEK5GF3HlkerWh33RQJPWv8IRMQmEHVhVvEAxIf2sY
	 OQ/YkcpQTHvEAWyYbM1G3nC2FkDCpXNe5aCIo5Q3fv5t6HkuSmL6hZsJi69Mu6sG4n
	 FQKE3vjDU7ywCH2ak1YTH69L27DMdpFpucSjm8KcYMi8s0FP0HN+dxcf+zANImDNG8
	 Tz5KlKlfKdV7Q==
Date: Tue, 27 Feb 2024 13:14:18 +0000
To: helgaas@kernel.org
From: Edmund Raile <edmund.raile@proton.me>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Edmund Raile <edmund.raile@proton.me>
Subject: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240227131401.17913-1-edmund.raile@proton.me>
In-Reply-To: <20240226102354.86757-1-edmund.raile@proton.me>
References: <20240226102354.86757-1-edmund.raile@proton.me>
Feedback-ID: 45198251:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Using LSI / Agere FW643 with vfio-pci will exhaust all
pci_reset_fn_methods, the bus reset at the end causes a broken link
only recoverable by removing power
(power-off / suspend + rescan).
Prevent this bus reset.
With this change, the device can be assigned to VMs with VFIO.
Note that it will not be reset, resulting in leaking state between VMs
and host.

Signed-off-by: Edmund Raile <edmund.raile@proton.me>

---

I sincerely thank you for your patience and explaining
the background of pci resets which I lacked.
The commit message and comment now describe it correctly.
The comment on leaking states was added.

Usefulness:

The LSI FW643 PCIe->FireWire 800 interface may be EOL but it is
the only one that does not use a PCIe->PCI bridge.
It is reliable and enables FireWire audio interfaces to be used
on modern machines.

Virtualization allows for flexible access to professional audio
software.

It has been used in at least the following Apple machines:
MacBookPro10,1
MacBookPro9,2
MacBookPro6,2
MacBookPro5,1
Macmini6,1
Macmini3,1
iMac12,2
iMac9,1
iMac8,1

Implementation:

PCI_VENDOR_ID_ATT was reused as they are identical.

 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d797df6e5f3e..e0e4ad9e6d50 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3765,6 +3765,19 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x00=
3e, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset)=
;
=20
+/*
+ * Using LSI / Agere FW643 with vfio-pci will exhaust all
+ * pci_reset_fn_methods, the bus reset at the end causes a broken link
+ * only recoverable by removing power
+ * (power-off / suspend + rescan).
+ * Prevent this bus reset.
+ * With this change, the device can be assigned to VMs with VFIO.
+ * Note that it will not be reset, resulting in leaking state between VMs
+ * and host.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5900, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
+
 /*
  * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIES=
S
  * automatically disables LTSSM when Secondary Bus Reset is received and
--=20
2.43.0



