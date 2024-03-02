Return-Path: <linux-kernel+bounces-89567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2B86F222
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504EB1C20BE3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0AE3FE4C;
	Sat,  2 Mar 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QP5IPPsf"
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7F81DA22
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709408957; cv=none; b=YXSCUBwO12KSjDNzg7sjKyIa8NY38f4Cqu0dzGEX7JEMiNP31Vpgeb+N9rfNBqT7yDVy/ChyBPsj8OcvTPkYUqZ49dBEoypIbCMxS2iDy/QLVdlh6YcGDBMBXkVSQaJsOo8G/J+9FwqUUHzfKBLcWdljOrfoyc+5L2ft09Kbo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709408957; c=relaxed/simple;
	bh=1/O971Kz3Ca9+qto3OAZZaXFJ/wZxNO4FP4SmyF+X/4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0HRN4q8SPBYfHUN8Bv/TCbxirn+9CT9XeSvhsM0aDQl3azgbPkJk4+yOq0oOiLdbsT57nWYi75QM2mHBqGCZz2WlkqTKhD5x0ReQKeAbzm01T6ahTOSQOtiaQjsYqmfXuDkyTkof3pKCvevm+RbWQKmaynKdLJCbkYo2JbuLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QP5IPPsf; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1709408947; x=1709668147;
	bh=C9KfCpmllxHwslBiHqyM/X8deidYhgDbYoo5M9+/3IM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QP5IPPsf0yfcMdg1Gn7C5/oUGM2rM5Qqs/vaKB2W66slwjzr1BeoaExauLuguwU1T
	 WKpQjLMYVsYA05wRzlcm/7knAwgRm5ofJmC6m0bjOXpwUbwH7xoPbo0LeKrRg4FqZp
	 mjQ9bwjcFLi2ml/ICVn0fEiD1cf74VL0Bd0XTdHk11ISvUk7cOEbGw+aWpk9Pa0RBe
	 phmuoqzO3RXBTK+mx+5Ekb5PFDADebanOZ2CCMc03lkjv5QMgXXCLs27oGa6ynHvlQ
	 mYrBwEN2uiDt9wovSn91HIo1ISFwo6LJKvZVBSL0VMiThQ/3Drz6EO1W2ZCj1F7PSt
	 m+w8f6/PDFfZw==
Date: Sat, 02 Mar 2024 19:48:53 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
From: Edmund Raile <edmund.raile@proton.me>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] firewire: ohci: prevent leak of left-over IRQ on unbind
Message-ID: <wrcvrmxqfy2zfpbcgoy4txqmzcoyptzvctzymztlp55gasu2fg@tyudozxoyvzo>
In-Reply-To: <20240301044024.GA37429@workstation.local>
References: <20240229101236.8074-1-edmund.raile@proton.me> <20240229144723.13047-2-edmund.raile@proton.me> <20240301044024.GA37429@workstation.local>
Feedback-ID: 45198251:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> In my opinion, the devres mechanism releases the allocated memory when
> releasing the data of associated device structure.
> device_release_driver_internal()
> ->__device_release_driver()
>   ->device_unbind_cleanup()
>     (drivers/base/devres.c)
>     ->devres_release_all(dev);
>       ->release_nodes()
>         (kernel/irq/devres.c)
>       ->free_irq()

Looking at __device_release_driver() in drivers/base/dd.c,
device_remove() gets called, leading to dev->bus->remove(dev),
which likely calls our good old friend from the call trace:
pci_device_remove().

> > Call Trace:
> >  ? remove_proc_entry+0x19c/0x1c0
> >  ? __warn+0x81/0x130
> >  ? remove_proc_entry+0x19c/0x1c0
> >  ? report_bug+0x171/0x1a0
> >  ? console_unlock+0x78/0x120
> >  ? handle_bug+0x3c/0x80
> >  ? exc_invalid_op+0x17/0x70
> >  ? asm_exc_invalid_op+0x1a/0x20
> >  ? remove_proc_entry+0x19c/0x1c0
> >  unregister_irq_proc+0xf4/0x120
> >  free_desc+0x3d/0xe0
> >  ? kfree+0x29f/0x2f0
> >  irq_free_descs+0x47/0x70
> >  msi_domain_free_locked.part.0+0x19d/0x1d0
> >  msi_domain_free_irqs_all_locked+0x81/0xc0
> >  pci_free_msi_irqs+0x12/0x40
> >  pci_disable_msi+0x4c/0x60
> >  pci_remove+0x9d/0xc0 [firewire_ohci
> >      01b483699bebf9cb07a3d69df0aa2bee71db1b26]
> >  pci_device_remove+0x37/0xa0
> >  device_release_driver_internal+0x19f/0x200
> >  unbind_store+0xa1/0xb0

Then in ohci.c's pci_remove(), we kill the MSIs, which leads to
the removal of the IRQ, etc.
Back in __device_release_driver(), after device_remove(),
device_unbind_cleanup() is called, leading to free_irq(), but too late.

I think the order of these calls may be our issue but I doubt it
has been done like this without good reason.
That code is 8 years old, someone would have noticed if it had an error.

I could be entirely wrong but the function description in
/kernel/irq/devres.c tells me that function is meant to be used:

> Except for the extra @dev argument, this function takes the
> same arguments and performs the same function as free_irq().
> This function instead of free_irq() should be used to manually
> free IRQs allocated with devm_request_irq().

And while devm_request_irq() has no function description of its own, its
sister devm_request_threaded_irq() mentions this:

> IRQs requested with this function will be
> automatically freed on driver detach.
>
> If an IRQ allocated with this function needs to be freed
> separately, devm_free_irq() must be used.

Should we pull in the maintainers of dd.c for their opinion?

Thank you very much for all the very hard work you do Sakamoto-Sensei!


