Return-Path: <linux-kernel+bounces-107913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2918D88036F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34FC284BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259A839AFD;
	Tue, 19 Mar 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+20GPqJ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D0139AD5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869231; cv=none; b=j8Xlfq6Szafzi02svLXF/s4LOmbSu4ZXpP0erp0KtexkcH6HggoIIW6KiChkCJ7JqB/L70RMagD96t660cKhW0/Lsgqnr1kOfx7YiKt8XptLs6hoSrQD5LQadGxRlaedAaASQa8iH3YRFpB/IfiYl5vTZcMNi1x/vSCfNSg4v/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869231; c=relaxed/simple;
	bh=BHyPuwCGdM8QOzVKsIwiYVKlOpsOXE/7vMV2rvxpnCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIGFFl42/2i8nDNC7mYgTAH+V4fzivZCqo2Olyffqq9qiC/6WguW0FvDss9nGl75nmjqZ9VDxnB1NMQ0l40u3ktBWRgqf1MpErGkYoVOfxztTNW+1aW8l1YlC4Tc1yuttvztIcBUlpV2KNDpBOTQPKq8Nnf0FS7cN5IRcH3vPow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+20GPqJ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbd6ea06f5so31743b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710869228; x=1711474028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x0OLis2HEaDYcgS+EngPASHiGFVGElFdRHgyHAw6Lc=;
        b=Q+20GPqJUWUSfpMzcPp1cHSGY4rCMHhONXqQLncC1lF//WPB+HusZFYZKI61X2uKmD
         UUykwjTDI6CB89ifPdM5l/yQrPwvORubUnTq12/IF9Rl6MacNEDyZX9INkX1pUWuh8vL
         ic2IqroNC0QnrxR8AHliAtFIzeAJFLmt8PIQTbzng9y90QoWrboTXO4dCCiRTBTUr3Q8
         yWu7kiqCuro3TaM4oDbM+NDmOYVsKxTN0XFPie6AJp43ooSDuWrfZfrJSakJrNNtOOiU
         +dQ1x05+Mpa7wrT4Yw/Anj3KxZMbCbgh5VxNl7spFDFTjYfLSyjYYRbSh186K7lWhMbJ
         a5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869228; x=1711474028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5x0OLis2HEaDYcgS+EngPASHiGFVGElFdRHgyHAw6Lc=;
        b=nSfpqqaFh/YG6udj8rWCy5dRlQoQXXQRjkgA0/JOl9CsoEsg5479066uLq/rVqbSkX
         DS0gzJuuep0lCevuoVKFM69NXQEx7rZAhUjgz9tjCulCHb2A1OdobqLNQdsqq12gCXhL
         GxPraRu5s/k/gtzIKsoJoOKkSvQmgxNYY4lbqMAv53KfSEGXbgQJ/VP7s0+ZkG7OkmLj
         vAmJF35F6V3Awqn/ScpCCo1Km2evpBJbPH1WbcHu0bntKUpp2UNd5gfCQL+0tBjGKQa0
         YpyTlY10gFdaZn5RES2Ke+AUHLqMaPlgn67qlwUPaxu1+SbBdM3e8DWu+UmgWyKwS0pd
         GUtg==
X-Forwarded-Encrypted: i=1; AJvYcCWUyn+MhfYT5QXwhvo1sy80GTLmuO9S9gjJ7Tgv2zeMfNhqPYl16pj0mxMRSg+OXrXQ1rC7ulOJmqcVyf4Uu4U67HN9rxtJmOadt0Qw
X-Gm-Message-State: AOJu0Yw9htWsn2ZNrRbQrGvGXkRWMHkaVZQ8J2VfeivKfv/nfzdJ4QQm
	K8nqi9X/EA3ygREXsDHadzWXH89e++rLYKVWmf70Gc6O+n/72HrnySIqSRglii9DwEjQXEuVFZU
	JlHr9lOAjEZLrPv8Av58fIN52B3WLA2JeZXd3nQ==
X-Google-Smtp-Source: AGHT+IH+vjRBCJwZWMQcYN3nqasG4Vwt0oDrL9dcErdMyptA7sWYXQPaEC2SbcVIHTOZhBZqaY4n8opwUj3Qx4Za914=
X-Received: by 2002:a05:6808:10c8:b0:3c3:7090:2784 with SMTP id
 s8-20020a05680810c800b003c370902784mr1160387ois.7.1710869228221; Tue, 19 Mar
 2024 10:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307092132.943881-1-jens.wiklander@linaro.org>
 <ZereCD7kJxP+vzHN@lpieralisi> <CAHUa44Har+TLBXOgz4EqekEu7fKWgFeCuOa0i8UiNLfen4tJiw@mail.gmail.com>
 <ZfmfIN_ODYq9MvOq@bogus>
In-Reply-To: <ZfmfIN_ODYq9MvOq@bogus>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 19 Mar 2024 18:26:57 +0100
Message-ID: <CAHUa44FVmK6im92cKTUshBG936xHAwS6nASfyBa9D2Yb44ansg@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_ffa: support running as a guest in a vm
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Marc Bonnici <marc.bonnici@arm.com>, 
	Olivier Deprez <Olivier.Deprez@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 3:20=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Fri, Mar 08, 2024 at 01:35:05PM +0100, Jens Wiklander wrote:
> > On Fri, Mar 8, 2024 at 10:44=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@k=
ernel.org> wrote:
> > >
> > > On Thu, Mar 07, 2024 at 10:21:32AM +0100, Jens Wiklander wrote:
> > > > Add support for running the driver in a guest to a hypervisor. The =
main
> > > > difference is that the notification interrupt is retrieved
> > > > with FFA_FEAT_NOTIFICATION_PENDING_INT and that
> > > > FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.
> > >
> > > I have a couple of questions about these changes, comments below.
> > >
> > > > FFA_FEAT_NOTIFICATION_PENDING_INT gives the interrupt the hyperviso=
r has
> > > > chosen to notify its guest of pending notifications.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/firmware/arm_ffa/driver.c | 45 ++++++++++++++++++---------=
----
> > > >  1 file changed, 27 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/a=
rm_ffa/driver.c
> > > > index f2556a8e9401..c183c7d39c0f 100644
> > > > --- a/drivers/firmware/arm_ffa/driver.c
> > > > +++ b/drivers/firmware/arm_ffa/driver.c
> > > > @@ -1306,17 +1306,28 @@ static void ffa_sched_recv_irq_work_fn(stru=
ct work_struct *work)
> > > >       ffa_notification_info_get();
> > > >  }
> > > >
> > > > +static int ffa_get_notif_intid(int *intid)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     ret =3D ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, intid=
, NULL);
> > > > +     if (!ret)
> > > > +             return 0;
> > > > +     ret =3D ffa_features(FFA_FEAT_NOTIFICATION_PENDING_INT, 0, in=
tid, NULL);
> > > > +     if (!ret)
> > > > +             return 0;
> > >
> > > I think that both interrupts should be probed in eg a host and the
> > > actions their handlers should take are different.
> > >
>
> +1, I have the same opinion.
>
> > > > +
> > > > +     pr_err("Failed to retrieve one of scheduler Rx or notif pendi=
ng interrupts\n");
> > > > +     return ret;
> > > > +}
> > > > +
> > > >  static int ffa_sched_recv_irq_map(void)
> > > >  {
> > > > -     int ret, irq, sr_intid;
> > > > +     int ret, irq, intid;
> > > >
> > > > -     /* The returned sr_intid is assumed to be SGI donated to NS w=
orld */
> > > > -     ret =3D ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, &sr_i=
ntid, NULL);
> > > > -     if (ret < 0) {
> > > > -             if (ret !=3D -EOPNOTSUPP)
> > > > -                     pr_err("Failed to retrieve scheduler Rx inter=
rupt\n");
> > > > +     ret =3D ffa_get_notif_intid(&intid);
> > > > +     if (ret)
> > > >               return ret;
> > > > -     }
> > > >
> > > >       if (acpi_disabled) {
> > > >               struct of_phandle_args oirq =3D {};
> > > > @@ -1329,12 +1340,12 @@ static int ffa_sched_recv_irq_map(void)
> > > >
> > > >               oirq.np =3D gic;
> > > >               oirq.args_count =3D 1;
> > > > -             oirq.args[0] =3D sr_intid;
> > > > +             oirq.args[0] =3D intid;
> > > >               irq =3D irq_create_of_mapping(&oirq);
> > > >               of_node_put(gic);
> > > >  #ifdef CONFIG_ACPI
> > > >       } else {
> > > > -             irq =3D acpi_register_gsi(NULL, sr_intid, ACPI_EDGE_S=
ENSITIVE,
> > > > +             irq =3D acpi_register_gsi(NULL, intid, ACPI_EDGE_SENS=
ITIVE,
> > > >                                       ACPI_ACTIVE_HIGH);
> > > >  #endif
> > >
> > > This means that for both schedule receiver interrupt and notification
> > > pending interrupt we would end up calling FFA_NOTIFICATION_INFO_GET (=
?),
> > > which is not correct AFAIK, for many reasons.
> > >
> > > If there is a pending notification for a VM, a scheduler receiver
> > > interrupt is triggered in the host. This would end up calling
> > > FFA_NOTIFICATION_INFO_GET(), that is destructive (calling it again in
> > > the notified *guest* - in the interrupt handler triggered by the
> > > hypervisor - would not return the pending notifications for it).
> > >
> > > Therefore, the action for the pending notification interrupt should
> > > be different and should just call FFA_NOTIFICATION_GET.
> > >
> > > Please let me know if that matches your understanding, this
> > > hunk is unclear to me.
>
> As you can expect, the above matches my understanding too.
>
> >
> > This patch was made from the assumption that this FF-A driver is a
> > guest driver, that is, FFA_NOTIFICATION_INFO_GET lands in the
> > Hypervisor at EL2. The FFA_NOTIFICATION_INFO_GET call is needed to
> > know which FFA_NOTIFICATION_GET calls should be dispatched in this VM,
> > to retrieve global notifications and per vCPU notifications.
> >
>
> OK and I assume this aligns with the below excerpts from the spec about
> FFA_NOTIFICATION_INFO_GET:
> "
> This ABI is invoked by a VM at the Non-secure virtual FF-A instance with =
the
> SMC or HVC conduits to request the Hypervisor to return the list of SPs a=
nd
> VMs that have pending notifications. The Hypervisor returns the list of t=
hose
> endpoints whose schedulers are implemented in the calling VM.
> "
>
> But if OPTEE driver in the VM/guest is the scheduler for the OPTEE SP,
> then I would expect the FF-A driver to just register for SRI. It can't be
> NPI as that contradicts with above.
>
> > If the FF-A driver is supposed to be a host driver instead, then I
> > wonder where we should have the guest driver.
> >
>
> At least so far we haven't found a strong reason to have different versio=
ns
> for each.
>
> > For clarification, my setup has Xen as hypervisor at EL2 (doing the
> > host processing), TF-A as SPMD at EL3, and OP-TEE as SPMC at S-EL1.
> > I'm testing this on QEMU. I'm going to post the Xen patches relating
> > to this quite soon.
> >
>
> OK, thanks for the setup info.
>
> > I believe that until now the FF-A driver has worked under the
> > assumption that it's a non-secure physical FF-A instance. With
> > hypervisor at EL2 it becomes a virtual FF-A instance.
> >
>
> Agreed.
>
> > >
> > > >       }
> > > > @@ -1442,17 +1453,15 @@ static void ffa_notifications_setup(void)
> > > >       int ret, irq;
> > > >
> > > >       ret =3D ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL,=
 NULL);
> > > > -     if (ret) {
> > > > -             pr_info("Notifications not supported, continuing with=
 it ..\n");
> > > > -             return;
> > > > -     }
> > > > +     if (!ret) {
> > > >
> > > > -     ret =3D ffa_notification_bitmap_create();
> > > > -     if (ret) {
> > > > -             pr_info("Notification bitmap create error %d\n", ret)=
;
> > > > -             return;
> > > > +             ret =3D ffa_notification_bitmap_create();
> > > > +             if (ret) {
> > > > +                     pr_err("notification_bitmap_create error %d\n=
", ret);
> > > > +                     return;
> > > > +             }
> > > > +             drv_info->bitmap_created =3D true;
> > > >       }
> > > > -     drv_info->bitmap_created =3D true;
> > >
> > > This boils down to saying that FFA_NOTIFICATION_BITMAP_CREATE is not
> > > implemented for a VM (because the hypervisor should take care of issu=
ing
> > > that call before the VM is created), so if the feature is not present
> > > that does not mean that notifications aren't supported.
> > >
> > > It is just about removing a spurious log.
> > >
> > > Is that correct ?
> >
> > No, this is about not aborting notification setup just because we have
> > a hypervisor that handles the FFA_NOTIFICATION_BITMAP_CREATE call.
>
> Understood.
>
> > With this patch, if ffa_get_notif_intid() fails, then we don't have
> > support for notifications.
> >
>
> But I still don't understand the mixup of SRI and NPI in your usecase
> model. It should be just SRI. NPI handler must just use NOTIFICATION_GET
> and not INFO_GET as Lorenzo has explained above.

Sorry for my confusion, I get your point now. I'll make a v2 where I
add an NPI handler and keep the SRI handler as you described.

Thanks,
Jens


>
> --
> Regards,
> Sudeep

