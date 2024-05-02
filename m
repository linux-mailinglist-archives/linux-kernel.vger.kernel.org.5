Return-Path: <linux-kernel+bounces-166796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F68B9F90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D94A28C22B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FB416FF5E;
	Thu,  2 May 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0Zx2djf"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37916FF43;
	Thu,  2 May 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671175; cv=none; b=jWD6BQuu/mZPoG9GAERsYQP01oWPrm+xjLQFOd2a/vjI0/VrqQ3E2dOuJhzF966y5OAqPVaIghcbfk3M225h0oAkrvjkgfLAZD25OlpfMRopW9rsHGD2iBtjcWly97+p/3NeI2rrogLNZofOx070iz7k0QAGbE8JUanfLMPk3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671175; c=relaxed/simple;
	bh=hzDPMLK50g1/uZWi+ccEKF7L+IuktgQW6zVbM/w/fwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pREBcx21CJvcs56AKLFJZ5UikxT83I/Ipwyj8Dpivwwvpp9KXUcZ14tiWYHd7N4hcGaIxcXXUEs+p5Sx3OEMozy5T1+efmgX/bHinprsMdEF3IlYVYyPuUszqNb/2ijJLRHwEbZW94sj6lBBdvvvk1PY5bwDjq+t/Um8hcK/5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0Zx2djf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2dd041acff1so97866181fa.1;
        Thu, 02 May 2024 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714671172; x=1715275972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzDPMLK50g1/uZWi+ccEKF7L+IuktgQW6zVbM/w/fwo=;
        b=a0Zx2djfVXQ1Fcy23MGbzYauJ1gDChb0LIvem/m6ogLRn3HEkZ3c+tvssmBltqo0qA
         XJLKr3AMogbNj0OhG22ng0DUns3YEogVVV6hOIfV3TtPV49G1wih8C+mvBrjg/t4Wjxl
         7T48HKngq777iGRznTQD7zcy9xeMDP2tyllhyRJ07DWznes4+QYpa6Es94VJ4uc6Ml3R
         a0Sgyyl70zJT6I2vA6nbyT9m/Ppx1SiRs9TYEg20BN1s4p4TXdWqnKsJ7r/jqphlvcwb
         JfTi2xpweqDARTtQVOYwCcbHXqdaBIYifz6b5fcs2ApZmM0mMX45AV7elC6EUTpAlHSJ
         UgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714671172; x=1715275972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzDPMLK50g1/uZWi+ccEKF7L+IuktgQW6zVbM/w/fwo=;
        b=kv9J02MSdJrnhfJZESiwvQ7tjjdsTkSguCcmExg3Z9D/j62Y7zUSS7jYu+Jm3RhOWz
         jbJFSMC03dNTTEH015HPsNiJ9B7Q5sz8TsW1iak1nIg2eZdNS7WOYcIsiTtjoon4YX/u
         h1kDCRE024qPdtZSg0tc1va7IPKTadT3XAPnDRV8poJ3W4DIYAqm+5m+fF0MPSqW21bo
         +ZbpWKrue9Uj1hsfenCrNZClgcs09G1SpxG51IyBiPLqQyyUrnXY2NiqBwedKwqC6btd
         T/c7IiLSFcOZTolOrw+D1BzMHsIJqTMwA2MuD2JETVwr/kolTtwDH+B0yX4FaTFmacPl
         4pSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyBG2BzXgjsad4hIRzerd3tvjOYDIXye8r9eP2casTpXrf5C36KsHkI7c8zRqaxNJEw4EtaCaSypxxOSqCpAdbYysajMkQlbWvvFQumsMhzSL7W/gSAJpSEcx/JO8z9Tpht/eVz42kr7yjX/DbY6AenE1DjkxzdsSWYGXqh5rlDP8Ep8tI
X-Gm-Message-State: AOJu0YzH9qJbbr8NyNm6SOu5aIdskYWsCmD4kO9rJ6xqmJ81j3MBAu67
	nWjsz82PjdqfzxkUpsqIiORcTIbuXuCDR4K8ITy22AMExDA0rLWx9FdU130dYx/qVAG5sNwjX/+
	u42uyrxis9ytXl2E3ncUSPajg2i0=
X-Google-Smtp-Source: AGHT+IFF642nCQbTBoX56+mFk3mvRUhXsAjPZu5dVafLuy3/6t2/2YpxNodcFEBkeqfLuRKrtfsp/7ctQg12LrVXQa4=
X-Received: by 2002:a2e:7d07:0:b0:2de:809c:c67b with SMTP id
 y7-20020a2e7d07000000b002de809cc67bmr234714ljc.24.1714671171615; Thu, 02 May
 2024 10:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com> <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com> <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
 <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>
 <ZjCYu2pc8376rjXk@hovoldconsulting.com> <9eebd77b-c070-4260-a979-9b97f14eb5b1@quicinc.com>
 <ZjDtDRCHT3z-3nHh@hovoldconsulting.com> <a09ab4e3-699b-4eb7-bc64-44c9de6db78d@quicinc.com>
 <ZjNm3OnJ1fdHctaZ@hovoldconsulting.com> <1feddcbc-205d-4c9b-bde2-7a2daace71a9@quicinc.com>
In-Reply-To: <1feddcbc-205d-4c9b-bde2-7a2daace71a9@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 May 2024 13:32:38 -0400
Message-ID: <CABBYNZK7MVRoOcFq8Ea8-ZqZq_fE=46WE+5_XMoj2KPnz_ePBw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Doug Anderson <dianders@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Janaki,

On Thu, May 2, 2024 at 1:03=E2=80=AFPM Janaki Ramaiah Thota
<quic_janathot@quicinc.com> wrote:
>
> Hi Johan,
>
> On 5/2/2024 3:41 PM, Johan Hovold wrote:
> > On Thu, May 02, 2024 at 12:35:19PM +0530, Janaki Ramaiah Thota wrote:
> >> On 4/30/2024 6:37 PM, Johan Hovold wrote:
> >
> >>> But here we disagree. A non-unique address is not a valid one as it w=
ill
> >>> cause collisions if you have more than one such controller.
> >>>
> >>> I understand that this may be convenient/good enough for developers i=
n
> >>> some cases, but this can hurt end users that do not realise why thing=
s
> >>> break.
> >>>
> >>> And a developer can always configure an address manually or patch the
> >>> driver as needed for internal use.
> >>>
> >>> Are there any other reasons that makes you want to keep the option to
> >>> configure the device address through NVM files? I'm assuming you're n=
ot
> >>> relying on patching NVM files to provision device-specific addresses
> >>> after installation on target?
> >
> >> We prefer unique address to be flashed on OTP (persistent) memory of
> >> BT-Chip, which is supported by almost all QC BT-chips.
> >
> > Yes, that is certainly the best option for everyone.
> >
> >> If someone is not able to do that/ does not prefer that, they still
> >> have an option to flash unique address in firmware binary (NVM)file.
> >> This does not require setting BD address from user space.
> >>
> >> Also until a developer flashes OTP/ keep unique BD-Address in NVM,
> >> he should be able to run most of the use cases from Device, that's
> >> why we want to make it as configured.
> >
> > Ok, but a developer can still do this since they can patch the driver t=
o
> > disable the check temporarily or, alternatively, just update the
> > devicetree with a valid unique address.
> >
> >> In our opinion this provides best Out of box experience.
> >
>
> If a developer has to patch a code/update device-tree, that is not
> a "out of box" experience. By "out of box" we meant, things should
> work without much changes required.
>
> > You can also look into improving support in user space (e.g. bluez) for
> > providing a valid unique address in a simple text-based configuration
> > file.
> >
>
> We don't think putting a must-have dependency in user space is the
> right thing to do, especially when we own a code in kernel space.
>
> > That would be useful for all Linux users and not require having access
> > to Qualcomm specific tools to update the NVM configuration file (which
> > could also be in a read-only file system, e.g. on Android).
> >
>
> Having a non-unique valid address allows a developer to handle all
> scenarios where he/she is dealing with DUT + commercial device and
> in such case, default BD-Address from nvm file should also be okay.
> Only when 2/more similar devices are in the mix, they need unique
> address. In that case we are providing end developers with a NVM
> utility(part of Qcom build Not open source tool)to change this
> default BD-Address.

And we don't agree with doing that, that is why the controller shall
be marked as unconfigured when a non-unique address is used and if you
insist in doing that I will probably have to escalate that you guys
are intentionally using addresses that can clash over the air.

If the firmware is intended for developer, it shall be kept private,
public firmware shall never use duplicate addresses, ever, and don't
come back with arguments like that only when 2/more similar devices
are in the mix but that would just stress even more the point that you
are breaking stuff _on purpose_, which is pretty bad by itself, and
then suggesting to use a non-open-source tool to fix the address is
making things worse because end users can be affected by this, that
really fills like you don't care if your hardware works on regular
Linux distros and in that case I will probably move it to
driver/staging.

> > Johan
>
> -Janaki Ram



--=20
Luiz Augusto von Dentz

