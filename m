Return-Path: <linux-kernel+bounces-73505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A659885C397
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01146B21C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A80778661;
	Tue, 20 Feb 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pb3cT5AP"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339886BB3C;
	Tue, 20 Feb 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453624; cv=none; b=XomIHZgwSiFs/P4bWDHGJ2qkd6HKCV1/eoYhb3dDFydRsjoUmP25cZx3RmPptxePKr4nkWEXz6Ct2BcFWcBQ4uwpINzbbs1WY5id3vtnWUCJZx860qKpYrKBklXjTle/3iq+OaS1FwwSUyhOj0FCQF5PTcqEhnSq/TqIqflkxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453624; c=relaxed/simple;
	bh=cO4ujRper6/Km3zY4aCT4SkVOMMMSTDm9agYKouiuA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Egl5Jh5fDEcK2iB5UTSu0BT/jDCOdRY8iUf/qlzz/kkavxySli7nDxSmoAJD7hKU3oiF2kVMm5y+5qwjH9fXj7Y2lqlFn1b02tS832bVoFnp/Geg+02cInxf+/Blb2a2GrDj2ciCncLTlxw2Lsdgl6ncW28HdeWoKz5yek4OyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pb3cT5AP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB6F71C0002;
	Tue, 20 Feb 2024 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708453619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kB0cvcURRPKKf25KZPEQvVjQACHIFe4QsdVW+tao6hM=;
	b=pb3cT5APvCDwUMCs6rkAssdwUJSu1o3vDArTlIdrEpWEqbUiYhk6JFvdA46gc2Uhn3f0dX
	NEAKKOipxEDnMILY8SbAoeVA2W+kE9aN8AbHUvK/Axmisa4ays3YGF9zS0qlpqFhqHtpZM
	5yRckL7eH9585zQTvHBOJzvHEGPa+ia+xLlpN53bLb+J9P2DHEdtM2juT1ScfM2wSNricV
	DJ+3kYQGfCLY6X6Q8dAbna6ppg1gSS7M+yTfccJwQ1HkBQIppKos+BzECIvh1qOYUPbCtg
	C0j9Kj8ZFoFism6isEbsaH5NLAAkgOwOWvoqYCI8d4COzKkTjgcSkT6zLLskMw==
Date: Tue, 20 Feb 2024 19:26:57 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
 <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip
 device is removed
Message-ID: <20240220192657.3dd9480c@bootlin.com>
In-Reply-To: <20240220142959.GA244726@rigel>
References: <20240220111019.133697-1-herve.codina@bootlin.com>
	<20240220111019.133697-3-herve.codina@bootlin.com>
	<20240220142959.GA244726@rigel>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Kent,

On Tue, 20 Feb 2024 22:29:59 +0800
Kent Gibson <warthog618@gmail.com> wrote:

> On Tue, Feb 20, 2024 at 12:10:18PM +0100, Herve Codina wrote:
> > When gpio chip device is removed while some related gpio are used by the
> > user-space, the following warning can appear:
> >   remove_proc_entry: removing non-empty directory 'irq/233', leaking at least 'gpiomon'
> >   WARNING: CPU: 2 PID: 72 at fs/proc/generic.c:717 remove_proc_entry+0x190/0x19c
> >   ...
> >   Call trace:
> >     remove_proc_entry+0x190/0x19c
> >     unregister_irq_proc+0xd0/0x104
> >     free_desc+0x4c/0xc4
> >     irq_free_descs+0x6c/0x90
> >     irq_dispose_mapping+0x104/0x14c
> >     gpiochip_irqchip_remove+0xcc/0x1a4
> >     gpiochip_remove+0x48/0x100
> >   ...
> >
> > Indeed, the gpio cdev uses an IRQ but this IRQ is not released when the
> > gpio chip device is removed.
> >
> > Release IRQs used in the device removal notifier functions.
> > Also move one of these function definition in order to avoid a forward
> > declaration (move after the edge_detector_stop() definition).
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 33 ++++++++++++++++++++++-----------
> >  1 file changed, 22 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index 2a88736629ef..aec4a4c8490a 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -688,17 +688,6 @@ static void line_set_debounce_period(struct line *line,
> >  	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
> >  	 GPIO_V2_LINE_EDGE_FLAGS)
> >
> > -static int linereq_unregistered_notify(struct notifier_block *nb,
> > -				       unsigned long action, void *data)
> > -{
> > -	struct linereq *lr = container_of(nb, struct linereq,
> > -					  device_unregistered_nb);
> > -
> > -	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
> > -
> > -	return NOTIFY_OK;
> > -}
> > -
> >  static void linereq_put_event(struct linereq *lr,
> >  			      struct gpio_v2_line_event *le)
> >  {
> > @@ -1189,6 +1178,23 @@ static int edge_detector_update(struct line *line,
> >  	return edge_detector_setup(line, lc, line_idx, edflags);
> >  }
> >
> > +static int linereq_unregistered_notify(struct notifier_block *nb,
> > +				       unsigned long action, void *data)
> > +{
> > +	struct linereq *lr = container_of(nb, struct linereq,
> > +					  device_unregistered_nb);
> > +	int i;
> > +
> > +	for (i = 0; i < lr->num_lines; i++) {
> > +		if (lr->lines[i].desc)
> > +			edge_detector_stop(&lr->lines[i]);
> > +	}
> > +  
> 
> Firstly, the re-ordering in the previous patch creates a race,
> as the NULLing of the gdev->chip serves to numb the cdev ioctls, so
> there is now a window between the notifier being called and that numbing,
> during which userspace may call linereq_set_config() and re-request
> the irq.

Well in my previous patch, if gdev->chip need to NULL before the call to 
gcdev_unregister(), this can be done.
I did modification that leads to the following sequence:
--- 8< ---
	...
        gcdev_unregister(gdev);

        gpiochip_free_hogs(gc);
        /* Numb the device, cancelling all outstanding operations */
        gdev->chip = NULL;
        gpiochip_irqchip_remove(gc);
        acpi_gpiochip_remove(gc);
        of_gpiochip_remove(gc);
        gpiochip_remove_pin_ranges(gc);
	...
--- 8< ---

I can call gcdev_unregister() right after gdev->chip = NULL.
The needed things is to have free_irq() (from the gcdev_unregister()) called
before calling gpiochip_irqchip_remove().

And so, why not:
--- 8< ---
	...
        gpiochip_free_hogs(gc);
        /* Numb the device, cancelling all outstanding operations */
        gdev->chip = NULL;
	gcdev_unregister(gdev);
        gpiochip_irqchip_remove(gc);
        acpi_gpiochip_remove(gc);
        of_gpiochip_remove(gc);
        gpiochip_remove_pin_ranges(gc);
	...
--- 8< ---

> 
> There is also a race here with linereq_set_config().  That can be prevented
> by holding the lr->config_mutex - assuming the notifier is not being called
> from atomic context.

I missed that one and indeed, I probably can take the mutex. With the mutex
holded, no more race condition with linereq_set_config() and so the IRQ cannot
be re-requested.

> 
> You also have a race with the line being freed that could pull the
> lr out from under you, so a use after free problem.

I probably missed something but I don't see this use after free.
Can you give me some details/pointers ?


> I'd rather live with the warning :(.
> Fixing that requires rethinking the lifecycle management for the
> linereq/lineevent.

Well, currently the warning is a big one with a dump_stack included.
It will be interesting to have it fixed.

The need to fix it is to have free_irq() called before
gpiochip_irqchip_remove();

Is there really no way to have this correct sequence without rethinking all
the lifecycle management ?

Also, after the warning related to the IRQ, the following one is present:
--- 8< ---
[ 9593.527961] gpio gpiochip9: REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED
[ 9593.535602] ------------[ cut here ]------------
[ 9593.540244] WARNING: CPU: 0 PID: 309 at drivers/gpio/gpiolib.c:2352 gpiod_free.part.0+0x20/0x48
..
[ 9593.725016] Call trace:
[ 9593.727468]  gpiod_free.part.0+0x20/0x48
[ 9593.731404]  gpiod_free+0x14/0x24
[ 9593.734728]  lineevent_free+0x40/0x74
[ 9593.738402]  lineevent_release+0x14/0x24
[ 9593.742335]  __fput+0x70/0x2bc
[ 9593.745403]  __fput_sync+0x50/0x5c
[ 9593.748817]  __arm64_sys_close+0x38/0x7c
[ 9593.752751]  invoke_syscall+0x48/0x114
..
[ 9593.815299] ---[ end trace 0000000000000000 ]---
[ 9593.820616] hotplug-manager dock-hotplug-manager: remove overlay 0 (ovcs id 1)
gpiomon: error waiting for events: No such device
# 
--- 8< ---

Best regards,
Hervé

