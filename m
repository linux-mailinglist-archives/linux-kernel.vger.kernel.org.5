Return-Path: <linux-kernel+bounces-97008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88101876460
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C23E28352F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E181401F;
	Fri,  8 Mar 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IE4s4mbv"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584381F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901319; cv=none; b=THDRtm3U2Yya5oSoNYLq+hC4613qpHoHsfOOG5VAa4UaI5ZH/i8Zxr1LEPLZvM9clFVK71DAK9GjpKUb0JzvD0/u9P13pwxLYTorBl4VXUf77hCBbgwyzLnNQlHprfQNHm4gNzSX8bn4+I2SnvVxqH97VlFEgE3rTXlGAhiIOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901319; c=relaxed/simple;
	bh=UCXaes8WzktJgSoggysPl/4dNwbqC06aageHNsCZdQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CScMfFxJ/BS8uod7G8a66qppMQG+SwAHELOsYWn3VNAoLbnUi0rSvbctTmOJiBpljoJU82tpGHhigVWDE/8m59OZfD+8UTbHhlLekwn+lzfYCN0qpcRKeclm8A9sEdEUOV/8CSWnFOZr2oMgxop+04MGbxwiPb4tfgPBGdPOkjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IE4s4mbv; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e50e8dcc72so462927a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709901317; x=1710506117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbSohLBy9a3NU/zF63YnMkWfMfw5GAHH1ppjNeDHZ84=;
        b=IE4s4mbvDtEdNjgFrsSffFgfJn1mygE+GKuS1ozP8EhqK5FxbhYVyYkpYVvLKYZfua
         4KxcSt3YJAu6wl7Dq+r1N1jxBzKqDiC+P0ntjI4eIfzEebvpEZPEgXCGsylaIVzMGJWe
         VEo3WtJSpadDGwaI1GhgesZdrSZRx1aBa2cAd50LlSKz1at/PKd7j2sL/t5nJw1tfEkD
         SiOysSmKvTAlIqInYPDQSLLbf85ev5otKJdQQXVXf0XgW0mZOl+RZCkMpqLgzO+IbARY
         X1JGl+QnfOj+gEpsYTywtou7gXsj2vrJGNcK3t1e81Wgrjyt1bPCrLJ9eO4lpB2MGfur
         Wdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709901317; x=1710506117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbSohLBy9a3NU/zF63YnMkWfMfw5GAHH1ppjNeDHZ84=;
        b=NLZWZkrPrCoGWJFtAkNkPo8guG78/FHyr+KDT4hAP6Act79efsdVKuMg1JQdGiby0J
         3fWPkur3H0x7drEdc3RuBcCEPeS3aM3KK8Qczf9Nj/Dct86k3h7KCGMbLFKqdqH1OaiD
         nZRnZUP9O4/Cqs6SwTGKvXSZnTA4+FSvIXUvv+kEHpx0v1J2hO/N2FGc6MNP6WAqG3Fa
         gcMdw4rq2CWHmFU1k+KQ4xQy+ozryvnzVAKi7EtcGS5fGDgg3dn8qPnmVLVQkfAh05hv
         Oc7f/3LTOBIoSL2EJyekoe8xPLnmSlrfGI5Zmvy1a+RuLkj3kWNmrbs4VzVxZHTmVfzG
         rtYw==
X-Gm-Message-State: AOJu0YyrgLoynBCP6kUDbYuzquviX1IN5EXoXgUNZr5CTRudrUh/mnHq
	17yislIH2xLS6UHvU9Ci0l0Q3N/3VzpOj8NvdC5I2evHNZX1F4BAe0p8TI73FQS+gcSHO6igqzL
	aP3N7kWZRV7ypBZqWbtO44AOg/5z8AOynQN+AOg==
X-Google-Smtp-Source: AGHT+IHS2WHylU3+Rt3tpjBl6wG74qp5v1dDg3cTfhZLfHmGpTN6lUZAvMwBH50X35fyUb0qtZSBuyEJ27e6bnH63wo=
X-Received: by 2002:a05:6870:332b:b0:21e:b6fc:750d with SMTP id
 x43-20020a056870332b00b0021eb6fc750dmr2802000oae.32.1709901316861; Fri, 08
 Mar 2024 04:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307092132.943881-1-jens.wiklander@linaro.org> <ZereCD7kJxP+vzHN@lpieralisi>
In-Reply-To: <ZereCD7kJxP+vzHN@lpieralisi>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 8 Mar 2024 13:35:05 +0100
Message-ID: <CAHUa44Har+TLBXOgz4EqekEu7fKWgFeCuOa0i8UiNLfen4tJiw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_ffa: support running as a guest in a vm
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Sudeep Holla <sudeep.holla@arm.com>, Marc Bonnici <marc.bonnici@arm.com>, 
	Olivier Deprez <Olivier.Deprez@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 10:44=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Thu, Mar 07, 2024 at 10:21:32AM +0100, Jens Wiklander wrote:
> > Add support for running the driver in a guest to a hypervisor. The main
> > difference is that the notification interrupt is retrieved
> > with FFA_FEAT_NOTIFICATION_PENDING_INT and that
> > FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.
>
> I have a couple of questions about these changes, comments below.
>
> > FFA_FEAT_NOTIFICATION_PENDING_INT gives the interrupt the hypervisor ha=
s
> > chosen to notify its guest of pending notifications.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 45 ++++++++++++++++++-------------
> >  1 file changed, 27 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_f=
fa/driver.c
> > index f2556a8e9401..c183c7d39c0f 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -1306,17 +1306,28 @@ static void ffa_sched_recv_irq_work_fn(struct w=
ork_struct *work)
> >       ffa_notification_info_get();
> >  }
> >
> > +static int ffa_get_notif_intid(int *intid)
> > +{
> > +     int ret;
> > +
> > +     ret =3D ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, intid, NU=
LL);
> > +     if (!ret)
> > +             return 0;
> > +     ret =3D ffa_features(FFA_FEAT_NOTIFICATION_PENDING_INT, 0, intid,=
 NULL);
> > +     if (!ret)
> > +             return 0;
>
> I think that both interrupts should be probed in eg a host and the
> actions their handlers should take are different.
>
> > +
> > +     pr_err("Failed to retrieve one of scheduler Rx or notif pending i=
nterrupts\n");
> > +     return ret;
> > +}
> > +
> >  static int ffa_sched_recv_irq_map(void)
> >  {
> > -     int ret, irq, sr_intid;
> > +     int ret, irq, intid;
> >
> > -     /* The returned sr_intid is assumed to be SGI donated to NS world=
 */
> > -     ret =3D ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, &sr_intid=
, NULL);
> > -     if (ret < 0) {
> > -             if (ret !=3D -EOPNOTSUPP)
> > -                     pr_err("Failed to retrieve scheduler Rx interrupt=
\n");
> > +     ret =3D ffa_get_notif_intid(&intid);
> > +     if (ret)
> >               return ret;
> > -     }
> >
> >       if (acpi_disabled) {
> >               struct of_phandle_args oirq =3D {};
> > @@ -1329,12 +1340,12 @@ static int ffa_sched_recv_irq_map(void)
> >
> >               oirq.np =3D gic;
> >               oirq.args_count =3D 1;
> > -             oirq.args[0] =3D sr_intid;
> > +             oirq.args[0] =3D intid;
> >               irq =3D irq_create_of_mapping(&oirq);
> >               of_node_put(gic);
> >  #ifdef CONFIG_ACPI
> >       } else {
> > -             irq =3D acpi_register_gsi(NULL, sr_intid, ACPI_EDGE_SENSI=
TIVE,
> > +             irq =3D acpi_register_gsi(NULL, intid, ACPI_EDGE_SENSITIV=
E,
> >                                       ACPI_ACTIVE_HIGH);
> >  #endif
>
> This means that for both schedule receiver interrupt and notification
> pending interrupt we would end up calling FFA_NOTIFICATION_INFO_GET (?),
> which is not correct AFAIK, for many reasons.
>
> If there is a pending notification for a VM, a scheduler receiver
> interrupt is triggered in the host. This would end up calling
> FFA_NOTIFICATION_INFO_GET(), that is destructive (calling it again in
> the notified *guest* - in the interrupt handler triggered by the
> hypervisor - would not return the pending notifications for it).
>
> Therefore, the action for the pending notification interrupt should
> be different and should just call FFA_NOTIFICATION_GET.
>
> Please let me know if that matches your understanding, this
> hunk is unclear to me.

This patch was made from the assumption that this FF-A driver is a
guest driver, that is, FFA_NOTIFICATION_INFO_GET lands in the
Hypervisor at EL2. The FFA_NOTIFICATION_INFO_GET call is needed to
know which FFA_NOTIFICATION_GET calls should be dispatched in this VM,
to retrieve global notifications and per vCPU notifications.

If the FF-A driver is supposed to be a host driver instead, then I
wonder where we should have the guest driver.

For clarification, my setup has Xen as hypervisor at EL2 (doing the
host processing), TF-A as SPMD at EL3, and OP-TEE as SPMC at S-EL1.
I'm testing this on QEMU. I'm going to post the Xen patches relating
to this quite soon.

I believe that until now the FF-A driver has worked under the
assumption that it's a non-secure physical FF-A instance. With
hypervisor at EL2 it becomes a virtual FF-A instance.

>
> >       }
> > @@ -1442,17 +1453,15 @@ static void ffa_notifications_setup(void)
> >       int ret, irq;
> >
> >       ret =3D ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NUL=
L);
> > -     if (ret) {
> > -             pr_info("Notifications not supported, continuing with it =
.\n");
> > -             return;
> > -     }
> > +     if (!ret) {
> >
> > -     ret =3D ffa_notification_bitmap_create();
> > -     if (ret) {
> > -             pr_info("Notification bitmap create error %d\n", ret);
> > -             return;
> > +             ret =3D ffa_notification_bitmap_create();
> > +             if (ret) {
> > +                     pr_err("notification_bitmap_create error %d\n", r=
et);
> > +                     return;
> > +             }
> > +             drv_info->bitmap_created =3D true;
> >       }
> > -     drv_info->bitmap_created =3D true;
>
> This boils down to saying that FFA_NOTIFICATION_BITMAP_CREATE is not
> implemented for a VM (because the hypervisor should take care of issuing
> that call before the VM is created), so if the feature is not present
> that does not mean that notifications aren't supported.
>
> It is just about removing a spurious log.
>
> Is that correct ?

No, this is about not aborting notification setup just because we have
a hypervisor that handles the FFA_NOTIFICATION_BITMAP_CREATE call.
With this patch, if ffa_get_notif_intid() fails, then we don't have
support for notifications.

Cheers,
Jens

>
> Thanks,
> Lorenzo
>
> >
> >       irq =3D ffa_sched_recv_irq_map();
> >       if (irq <=3D 0) {
> > --
> > 2.34.1
> >

