Return-Path: <linux-kernel+bounces-99897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD8878EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9ABB1C20E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B96994B;
	Tue, 12 Mar 2024 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qLyVkKsV"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BD3236
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710225835; cv=none; b=QECaRVrC5SqP7tccuMr6R7bc0gIVLLlL20ijWI5uuka1YpP7y+45Q+3rp0Y2dyrXswk0arhtQfn5bRnLrtzFc41bt0N67TlQbwffFYlBZgyEqOGhg6x421oMrBGQZ6oBs3DPeqCJvRI70qDzsYjdNr178bYjSPa6Tv7+OtMOFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710225835; c=relaxed/simple;
	bh=KVyQA9G2E0onYskpSuHdEyqsu2DglSBt7qITBpu1ins=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pz3cl7wHzaUQh8HRR6nz0+c+JnTh7gaEviChWH1/E9GFFa/kFhSYGgN2s1iDVxGBuE485uD36o6DNX4vFaqIQclJR+QcSdqTmGVnnE1UmxGB3XAW1oFE48X+n8hOJ+tgTiqvcD9m9BcO12hYkzxZ2xdRqIkvoruBc+2HoYLFrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qLyVkKsV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7CD013F1D9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710225830;
	bh=eSsn7G/1gt5lZCGer5tSTvEfw8+OkfHiex4x7n32ric=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=qLyVkKsVPI0gzQzRX9KL8bIKfkI+uGe4xhHmV4lnIv6icP8/58wfEIHyfVrH3c3hp
	 eCxGtDTgUS1so0mAMZ3QjIsIB9OwT8vP6Lilmt5+ewc0nHPlu1U8ZvDE6+/9J1gfMC
	 nmaTmXhPQtf3fbNi2BlbL8ksZ1lzOH19hqRQoDWv7uWgMoZwvS7oixtkZLC9KCHRZq
	 tjIHDP/UtGnjtB2bkWHHcnplQu+yo8CrHWa6JAnvM9mJl76nEJODNFhKWcKpkKCVnq
	 EBUYsJUng1havZPCOhjoW5CQVCkgeC5GiIdFTydxv/bCBrOyud6YXpzJg7Wlod5jwd
	 5xTPMzzbRu42Q==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29be10b5429so1770153a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710225829; x=1710830629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSsn7G/1gt5lZCGer5tSTvEfw8+OkfHiex4x7n32ric=;
        b=t0HGeK+I1ptiSGzah5zPIcjBpQLxVsp19NFHkqi0R9yricZyjV+Xkp3nmlXIX1uhsi
         XX0PFKHr2oBBZ3uRqnHlWBop3ZLZzJiH/bjXQh67czgSOI6gVy2Wo73CiWwISZeFn92c
         CuISzVs9tBIss83VZ8HKAgMmtyD8FfHF9pjAsCNlKwbW+Rok7OTULQ+XK1A8gWqA2Yuy
         M5lyFGXwX76qw1N6Qxp3beZoa40+8ukMc8ud+wiFCxQ3GwVizYp4KMRaYR22XMz7KzIz
         XXe6HbaWfSOG1ltj2H4qksvPWwoFB/z9tdaRQdr5XXNQ3IHN0q/bFdbWs12VJ62CBEfd
         u4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV15W/KK3mspqy1kMAXu9YvU0nzIOlCqlKE1sWZOChqLquIDF26hpxvMTH8Ed8j3deZS7f0CABFvBw3fs8WZTl0lzUQtXcw/rHuPNkA
X-Gm-Message-State: AOJu0YwoNWKrAkAkf0g6i2V3duQ2i8InIJmM8LOrOERJA9Z5crNorJha
	bLlx54ILK6HMvEINmQ+diZmdOhEjHZrMxIJpig8saf2eAmgro0d1GnUODAk9b7Ay5UJrjdako4i
	lfTo6SgCcL38sEgaWeDngRDc2SM1Sa7qyat1Ix5Aw98Pa/oa4UhuY9P8QInfqQneD2PQDK6zZtP
	kosFwDxAqXVtoWqlfceecLhc/KKWRQ1saFw6iwqEutYdxdcydJTVUG
X-Received: by 2002:a17:90a:578c:b0:29b:fb23:863e with SMTP id g12-20020a17090a578c00b0029bfb23863emr7505031pji.17.1710225829155;
        Mon, 11 Mar 2024 23:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlCJeNbzz2X82r+ek7hjCKxl93swGQbkh/w7gFBWT1A/g/u53goEPjp4l6vceJxSkD1i0Y2G4fdvIGTkRfbo8=
X-Received: by 2002:a17:90a:578c:b0:29b:fb23:863e with SMTP id
 g12-20020a17090a578c00b0029bfb23863emr7505019pji.17.1710225828787; Mon, 11
 Mar 2024 23:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109041218.980674-1-kai.heng.feng@canonical.com>
 <20240109041218.980674-2-kai.heng.feng@canonical.com> <1b8ff82e-ff26-410e-a37e-0d818494bac3@roeck-us.net>
 <ZZ26ea5KV9Xg1MDc@mail.minyard.net> <e090d7f5-208a-4a4d-8162-7202ad6b0183@roeck-us.net>
In-Reply-To: <e090d7f5-208a-4a4d-8162-7202ad6b0183@roeck-us.net>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 12 Mar 2024 14:43:36 +0800
Message-ID: <CAAd53p4AW0WJ9jUnTOVNf8u5gxp0Xq_YYyinbiCRf4enW89KqQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] hwmon: (acpi_power_meter) Ensure IPMI space
 handler is ready on Dell systems
To: Guenter Roeck <linux@roeck-us.net>
Cc: minyard@acm.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Sorry for the belated response.

On Wed, Jan 10, 2024 at 6:32=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 1/9/24 13:28, Corey Minyard wrote:
> > On Tue, Jan 09, 2024 at 07:23:40AM -0800, Guenter Roeck wrote:
> >> On 1/8/24 20:12, Kai-Heng Feng wrote:
> >>> The following error can be observed at boot:
> >>> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e=
62c5) [IPMI] (20230628/evregion-130)
> >>> [    3.717928] ACPI Error: Region IPMI (ID=3D7) has no handler (20230=
628/exfldio-261)
> >>>
> >>> [    3.717936] No Local Variables are initialized for Method [_GHL]
> >>>
> >>> [    3.717938] No Arguments are initialized for method [_GHL]
> >>>
> >>> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to prev=
ious error (AE_NOT_EXIST) (20230628/psparse-529)
> >>> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to prev=
ious error (AE_NOT_EXIST) (20230628/psparse-529)
> >>> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> >>>
> >>> On Dell systems several methods of acpi_power_meter access variables =
in
> >>> IPMI region [0], so wait until IPMI space handler is installed by
> >>> acpi_ipmi and also wait until SMI is selected to make the space handl=
er
> >>> fully functional.
> >>>
> >>> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linu=
x-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-m=
essages-displayed-in-dmesg?guid=3Dguid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
> >>>
> >>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>> ---
> >>> v4:
> >>>    - No change.
> >>>
> >>> v3:
> >>>    - Use helper.
> >>>    - Use return value to print warning message.
> >>>
> >>> v2:
> >>>    - Use completion instead of request_module().
> >>>
> >>>    drivers/hwmon/acpi_power_meter.c | 6 ++++++
> >>>    1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_po=
wer_meter.c
> >>> index 703666b95bf4..33fb9626633d 100644
> >>> --- a/drivers/hwmon/acpi_power_meter.c
> >>> +++ b/drivers/hwmon/acpi_power_meter.c
> >>> @@ -883,6 +883,12 @@ static int acpi_power_meter_add(struct acpi_devi=
ce *device)
> >>>     strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
> >>>     device->driver_data =3D resource;
> >>> +   if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
> >>> +       acpi_dev_get_first_match_dev("IPI0001", NULL, -1)) {
> >>> +           if (acpi_wait_for_acpi_ipmi())
> >>> +                   dev_warn(&device->dev, "Waiting for ACPI IPMI tim=
eout");
> >>> +   }
> >>> +
> >>
> >> What a hack :-(.
> >>
> >> This needs a comment in the driver explaining the rationale for this c=
hange, and
> >> also a comment explaining why, for example, using late_initcall() does=
 not help.
> >>
> >> If CONFIG_IPMI_SI=3Dn, acpi_wait_for_acpi_ipmi() will return 0, indica=
ting success.
> >> I can only imagine that this will result in a failure since the whole =
point
> >> of this code is to wait until that driver is loaded. Please explain ho=
w and why
> >> the code works with CONFIG_IPMI_SI=3Dn. Similar, if the function retur=
ns an error,
> >> I can not imagine how it would make sense to instantiate the driver. I=
f it does
> >> make sense to continue in this situation, a comment is needed in the c=
ode
> >> describing the rationale.
> >
> > I'm trying to figure out where CONFIG_IPMI_SI comes in here.  It's
> > nowhere in these patches or in drivers/acpi.  ACPI_IPMI depends on
> > IPMI_HANDLER, but that's all I found.  However, ACPI_IPMI can be "m" as
> > you mention and SENSOR_ACPI_POWER is only under the ACPI config, which
> > is a problem.
> >
>
> The patch above is looking for IPI0001, which is instantiated in
>
> drivers/char/ipmi/ipmi_si_platform.c:   { "IPI0001", 0 },
> drivers/char/ipmi/ipmi_ssif.c:  { "IPI0001", 0 },
>
> Are you saying that the above code doesn't depend on it ? In that case,
> why does it need to check for the IPI0001 device in the first place ?

Only Dell hardware has this "implicit" dependency that requires IPMI
opregion to be functional.

>
> That will need another comment/explanation in the code because people
> (or maybe dummies) like me won't understand the non-dependency (i.e.,
> the need to look for IPI0001 but not requiring the associated code).

Sure, will do.

>
> More specifically, unless I really don't understand the acpi code,
> acpi_dev_get_first_match_dev() will return NULL if there is no matching
> device. In that case, the above code won't call acpi_wait_for_acpi_ipmi()=
.
> Fine, but why would this driver have to wait for ipmi if and only if ther=
e
> is a device (and thus a driver) for IPI0001 ?

Because acpi_power_meter's ACPI method access IPMI opregion, which
requires the driver to install the opregion handler and wait for SMI
being selected.

AFAIK there's no mean to discover the "dependency" here, hence the hack...

Kai-Heng

>
> Thanks,
> Guenter
>
> > I do think there are other issues with this patch, though.  The IPMI
> > handler code decouples the user from the driver from a dependency point
> > of view.  It seems to be fairly common to see IPMI_HANDLER and
> > ACPI_IPMI as "y" and IPMI_SI (and IPMI_SSIF, and others) as "m".  That
> > means this code will run but will wait for the IPMI device to appear,
> > which may not be until the module gets loaded, which may be far more
> > than 2 seconds later.
> >
> > I'm not quite sure how to fix this.  Really, the add call for this
> > driver shouldn't be called until the IPMI device is present.  Doesn't
> > ACPI have mechanisms to handle this sort of thing?  If so, the hack may
> > need to be in the handling of that ACPI data (this field is not there
> > but should be), not here, which as Guenter says, is a big hack.
> >
> > -corey
> >
> >>
> >> Third, the new symbol is declared with CONFIG_ACPI, but defined with
> >> CONFIG_IPMI_SI. I can not imagine how this would compile with CONFIG_A=
CPI=3Dy
> >> and CONFIG_IPMI_SI=3D{m,n} and/or CONFIG_ACPI_IPMI=3D{m,n}.
> >>
> >> On top of that, IPMI_SI and ACPI_IPMI are is tristate, as is SENSORS_A=
CPI_POWER.
> >> This means that SENSORS_ACPI_POWER=3Dy combined with CONFIG_IPMI_SI=3D=
{m,n} or
> >> CONFIG_ACPI_IPMI=3D{m,n} will result in a compile failure.
> >>
> >> Please make sure that this code compiles with all possible symbol comb=
inations.
> >>
> >> Thanks,
> >> Guenter
> >>
> >>>     res =3D read_capabilities(resource);
> >>>     if (res)
> >>>             goto exit_free;
> >>
> >>
> >
>

