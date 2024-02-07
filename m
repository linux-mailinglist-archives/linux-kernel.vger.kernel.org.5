Return-Path: <linux-kernel+bounces-56087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D004A84C5C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D02879B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A509200AD;
	Wed,  7 Feb 2024 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/UdfHVE"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430E1F947
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292158; cv=none; b=TQEvElEs2wBAZdUHS8kA8OxZMyjH+A0HzOkwthZeZa864xpyk3NyCRmfk4BpLl1hpWzZNQTZl8pEouWOEPFZlzcTIKPh4Vsv+s8SQ06ETODcFYBMOBtbWTkUsKJ4vsu5AdmXZXIQYwRt0kt/gNlpikayeE7vCrqG18+5lYylLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292158; c=relaxed/simple;
	bh=yGJSWXa0tmgeOdHPNvVXOcFWn0J26BdQTqkblLmPk0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kt9ONzzgbgo7Rhfmps9AGbLAkl24+3anRcNBbyFXMZmKZ5eiyyt+GL8ZHJ46xpw1ymm8/EvZFLguY5TTfSOVDunaq2O/QvN5p4SJEv/ds8T5CoidLJcGynhtBaoXeMPnOA0MAgUboOCDcvpVWp/nOoDWkhNPXWqTu4jtzGTisXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v/UdfHVE; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-46d3c291c4eso11084137.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 23:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707292155; x=1707896955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGJSWXa0tmgeOdHPNvVXOcFWn0J26BdQTqkblLmPk0o=;
        b=v/UdfHVEPTpQgv3m1g1bpYhhdF3gR4jRlsQQiA+bm8Cy2UCjNtC0f89otyEShbkQvA
         GtuOgLAaegih0p1taZD6ZZe/S30Es4pnR5cGoTTckAZn7LexcE16qWqbtPO9jhRAJFtl
         mqTv3M+UvXnAavTHrtIh5bdD8JxRVioPXtBSa8bDbPCZ0uC6k3RRQ+fuaUotikr4Fes+
         oYjTSB1K+MyNNJltwV7PVwc4dtDRlZgkth4SFGUyDDLa5HBKq65LB37JXlkzfeckndPw
         jUWOEvWyx/ICE+nyux2D0ztYnaUI1y+4w3SevPQ67Hoa+Z4xdwpBhRrDmDHh+rCrnoe8
         nbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292155; x=1707896955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGJSWXa0tmgeOdHPNvVXOcFWn0J26BdQTqkblLmPk0o=;
        b=b8LRMtHto4KdBPt7bGLut45/SEwmyk6BiBAHm5SG4cFrXuz60ansW0MlsdvAvDuo+D
         VN9soVApMe2l3hcrgwGsfSyxek36XSNVvalv4wiRW1GGN7h1tOMCKkYMI23yLi6eFTP0
         6EXq3a0pw6CQSPqLlhSGxz1DUinEwqaivweKpbD69TKppQ2ONru+Rmjy4sfRpwQ9TNOv
         lbhoqJoCbFkE96p/gHRbroT3ENbnMTjT86qAW6isMIpRA2z0dmHWhkEdNv7r9TvOjhmI
         yQyAz4OXyeIVfzqKEFze0NC5bpJnMSAWUuyGxehLVC0BOFALFR5mc5hU0SVbRGEL0wrx
         mZMw==
X-Gm-Message-State: AOJu0Yw6NhtQ1TvfhQiaD2meIc9lUWwyL4UCFaLhxgNL5RhaoRBCSSH9
	FD2ws8pTc3xOPZbav4Yo0G+UOVNHxxF2+IRWEEHJkp3yO3o/ng3Tb5qJjaGWkzfC5ziP2ZrpV7V
	Yz0nd0fmEUeY/TnNpUVsjD3A5vqHbxJ+IkdBofg==
X-Google-Smtp-Source: AGHT+IFujJQgoNgF5h3ELvefgatb5AhxnPvBN98IDbK2o1GCBOxSd1pJjVdiP2H13sB+JXTgT+gEPSp7F41Gwcfhwqg=
X-Received: by 2002:a05:6102:290d:b0:46d:37d6:3908 with SMTP id
 cz13-20020a056102290d00b0046d37d63908mr2372082vsb.5.1707292155276; Tue, 06
 Feb 2024 23:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
 <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com>
 <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com> <CAHUa44G+7HMNztQyYAWEhLFJvDBHDxPnqm+FRSVavb0NCyoYzg@mail.gmail.com>
In-Reply-To: <CAHUa44G+7HMNztQyYAWEhLFJvDBHDxPnqm+FRSVavb0NCyoYzg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 7 Feb 2024 13:19:03 +0530
Message-ID: <CAFA6WYMNyw5GPji8XMMcPNHSkX5zXubsuVhauWHyGvBBQ3Mefw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Feb 2024 at 12:56, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> H,
>
> On Wed, Feb 7, 2024 at 7:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
> >
> > Hi Ilias, Ulf,
> >
> > On Tue, 6 Feb 2024 at 20:41, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Ulf,
> > >
> > > On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wro=
te:
> > > >
> > > > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro=
org> wrote:
> > > > >
> > > > > A number of storage technologies support a specialised hardware
> > > > > partition designed to be resistant to replay attacks. The underly=
ing
> > > > > HW protocols differ but the operations are common. The RPMB parti=
tion
> > > > > cannot be accessed via standard block layer, but by a set of spec=
ific
> > > > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. S=
uch a
> > > > > partition provides authenticated and replay protected access, hen=
ce
> > > > > suitable as a secure storage.
> > > > >
> > > > > The initial aim of this patch is to provide a simple RPMB Driver =
which
> > > > > can be accessed by the optee driver to facilitate early RPMB acce=
ss to
> > > > > OP-TEE OS (secure OS) during the boot time.
> > > >
> > > > How early do we expect OP-TEE to need RPMB access?
> > >
> > > It depends on the requested services. I am currently aware of 2
> > > services that depend on the RPMB
> > > - FirmwareTPM
> > > - UEFI variables stored there via optee.
> > >
> > > For the FirmwareTPM it depends on when you want to use it. This
> > > typically happens when the initramfs is loaded or systemd requests
> > > access to the TPM. I guess this is late enough to not cause problems?
> >
> > Actually RPMB access is done as early as during fTPM probe, probably
> > to cache NVRAM from RPMB during fTPM init. Also, there is a kernel
> > user being IMA which would require fTPM access too. So we really need
> > to manage dependencies here.
> >
> > >
> > > For the latter, we won't need the supplicant until a write is
> > > requested. This will only happen once the userspace is up and running=
.
> > > The UEFI driver that sits behind OP-TEE has an in-memory cache of the
> > > variables, so all the reads (the kernel invokes get_next_variable
> > > during boot) are working without it.
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > The way things work for mmc today, is that the eMMC card gets
> > > > discovered/probed via a workqueue. The work is punted by the mmc ho=
st
> > > > driver (typically a module-platform-driver), when it has probed
> > > > successfully.
> >
> > It would be nice if RPMB is available as early as possible but for the
> > time being we can try to see if probe deferral suffices for all
> > use-cases.
> >
> > > >
> > > > The point is, it looks like we need some kind of probe deferral
> > > > mechanism too. Whether we want the OP-TEE driver to manage this its=
elf
> > > > or whether we should let rpmb_dev_find_device() deal with it, I don=
't
> > > > know.
> >
> > I wouldn't like to see the OP-TEE driver probe being deferred due to
> > this since there are other kernel drivers like OP-TEE RNG (should be
> > available as early as we can) etc. which don't have any dependency on
> > RPMB.
>
> I agree, the optee driver itself can probe without RPMB.
>
> >
> > How about for the time being we defer fTPM probe until RPMB is availabl=
e?
>
> Sounds a bit like what we do with the
> optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP) call when
> tee-supplicant has opened the supplicant device. It would perhaps work
> with a PTA_CMD_GET_DEVICES_RPMB or such.

That sounds much better, it will be like an OP-TEE driver callback
(optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)) registered with
the RPMB subsystem. But we should check if all the RPMB partitions are
registered before we invoke the callbacks such that OP-TEE will have a
chance to select the right one.

-Sumit

>
> Thanks,
> Jens

