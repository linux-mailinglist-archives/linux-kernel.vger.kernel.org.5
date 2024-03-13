Return-Path: <linux-kernel+bounces-101138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CB487A2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AF4283734
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019E13ADD;
	Wed, 13 Mar 2024 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ogCyEsPs"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221116429
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710311102; cv=none; b=BNII8yRVEGidiayCVPM4jw653OekY7iTGpLLQQgxtRyphr1NvVfFPm4wy9xfUXgnj6yFfid8iKveRV8jTOzLHuEC28JeQMAohaJWrClEY991tWoYMpGUAtQasWfZRj7QTgoOCemUMvsrKu6DrXC0FBuIdRnGlcX/+t0mwT2V2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710311102; c=relaxed/simple;
	bh=xtoB8rbdXQhWfkrNIS7WejeYtUS9NaKHQgxM7D9UiXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm0EdAfXWWqe7DxnI7WZ22r2p1YIKTGEKluSqLa8c2aUhQYGH4yoNMaXBz5naHjbRN+c628BQbUi2KSDKCcpc3yUwBeEyKPoN5RRAIrDpvizFQ2vpuJLIq09CFGbzGNFCGe3stwJmUb0Fq1UGZ0ATURFLVa8Ngk5jtiCA2PnJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ogCyEsPs; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1D3F23F266
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710311091;
	bh=gyS4CxXuiixQE46i3lf6LipxCQAyfgB5ILNmTVboYOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ogCyEsPs9WyKKNKHKP5dHCTt4pz6T5zCLhKtT3KnVt1DNQXpwPjupeFQOcGv8V7pd
	 gMxXE0ZcHYNz9uRhNIYi2fZ60N3z71/Z4hXpESIqz0N3Y45nuSAOYq/B3mYADaMQpC
	 owoTtHD+uaUZa+dzRj4mBRZTLiXhdXjuGrfzkevkvsw60Aq4tkO1eKqTLWsoYDKGHq
	 2bCIoTR0WzKanPKBNQGNS3kDcKH9LFjTuF9Jy+tJw2Ps12UbC2tgWx3yoBnxAHqXqC
	 UhD8ZV5gEnrW5cZMjCXRYhLLEAYFKWd9ZjKv6xiGqtyyNFUcXCN0CTnFgKuXAEkOQm
	 vVRlKhSJy5akQ==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so4368908a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710311090; x=1710915890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyS4CxXuiixQE46i3lf6LipxCQAyfgB5ILNmTVboYOM=;
        b=KveBs22HCzBZKR6Ht2gu9bFvdFbNh1QE6qmBtBWnaqTzeyYY02pKT+ydg+DISFuFUc
         ZCFrVaxbSWYwmsn5FbMGfIpRtGa0QkHw3a3oMl4JumDAhTx8sZdExinCzkdoKSjNQprS
         s3caMZ6c8W1rWXDgNz3z7sv5yJyDg3X1QVBFBXuRgYQ3gfYZJqhacqwnCdCXVLezePNs
         0ll0DrNIRyku0yUkQssBuVF4kbO/QiGRofD1OWwa08uh70UYBqp8g6ZJ608G1uywUPyx
         iy94sjp2E2tfkgHtfO3n8dQyiWfeuX2OVXwAv8MyTPwDLNiy6uksl3oOvssAdBHt6wRb
         MYLw==
X-Forwarded-Encrypted: i=1; AJvYcCWWKBBjmwIJ6LTQFkJOmA5ozCTPcWS22sIY6yxEGSyUWU+ENOl3iiPBXpjwX1V5nkbzjjlqh+bsb8sNMalO9WR/XoYhxuaUAX2PqpdK
X-Gm-Message-State: AOJu0Yzrv/aTwUuljpPGDKc5UcdLn5ckgkDA/GM/JdPqvglhn//Fx31n
	UglVlTcSGiALQafjiO0mWhyQnp3bTKyitnRvvhve6ZDhSKQp7Chk/8GIML9V7S0/Kq8zJblQMoU
	21XbY1iFx7q4R9DmgovR/uo7r+iaQrqQPYOBC7bcxdC0jp5X22DWmcs+0Op3J7MqQv6z++dJBXy
	YFSH+aVBXjaNwo5dGtDiJDGiF1W6OJlZ5kngIfhbAfPuLEcCZrDx1o
X-Received: by 2002:a05:6a20:9382:b0:1a1:3ecb:52fe with SMTP id x2-20020a056a20938200b001a13ecb52femr9690569pzh.0.1710311089256;
        Tue, 12 Mar 2024 23:24:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5zKpCLcd0GZpY9zwgTSGqwbNwfuarrJWlUhevzTtyHWPLaXO9KU2nDe5BMELpRKfc/a3Oov4lQ83sKz8Vq7s=
X-Received: by 2002:a05:6a20:9382:b0:1a1:3ecb:52fe with SMTP id
 x2-20020a056a20938200b001a13ecb52femr9690551pzh.0.1710311088814; Tue, 12 Mar
 2024 23:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109041218.980674-1-kai.heng.feng@canonical.com>
 <20240109041218.980674-2-kai.heng.feng@canonical.com> <1b8ff82e-ff26-410e-a37e-0d818494bac3@roeck-us.net>
 <ZZ26ea5KV9Xg1MDc@mail.minyard.net> <e090d7f5-208a-4a4d-8162-7202ad6b0183@roeck-us.net>
 <ZZ3cSygeCTAr35nz@mail.minyard.net>
In-Reply-To: <ZZ3cSygeCTAr35nz@mail.minyard.net>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 13 Mar 2024 14:24:37 +0800
Message-ID: <CAAd53p71sS+eV1OmPgSDrAcqu8-FJZX-9sd=3a6ZNAvaZV9jbQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] hwmon: (acpi_power_meter) Ensure IPMI space
 handler is ready on Dell systems
To: minyard@acm.org
Cc: Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Corey,

On Wed, Jan 10, 2024 at 7:52=E2=80=AFAM Corey Minyard <minyard@acm.org> wro=
te:
>
> On Tue, Jan 09, 2024 at 02:32:41PM -0800, Guenter Roeck wrote:
> > On 1/9/24 13:28, Corey Minyard wrote:
> > > On Tue, Jan 09, 2024 at 07:23:40AM -0800, Guenter Roeck wrote:
> > > > On 1/8/24 20:12, Kai-Heng Feng wrote:
> > > > > The following error can be observed at boot:
> > > > > [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000=
ab9e62c5) [IPMI] (20230628/evregion-130)
> > > > > [    3.717928] ACPI Error: Region IPMI (ID=3D7) has no handler (2=
0230628/exfldio-261)
> > > > >
> > > > > [    3.717936] No Local Variables are initialized for Method [_GH=
L]
> > > > >
> > > > > [    3.717938] No Arguments are initialized for method [_GHL]
> > > > >
> > > > > [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to =
previous error (AE_NOT_EXIST) (20230628/psparse-529)
> > > > > [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to =
previous error (AE_NOT_EXIST) (20230628/psparse-529)
> > > > > [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_E=
XIST
> > > > >
> > > > > On Dell systems several methods of acpi_power_meter access variab=
les in
> > > > > IPMI region [0], so wait until IPMI space handler is installed by
> > > > > acpi_ipmi and also wait until SMI is selected to make the space h=
andler
> > > > > fully functional.
> > > > >
> > > > > [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-=
linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-err=
or-messages-displayed-in-dmesg?guid=3Dguid-0d5ae482-1977-42cf-b417-3ed5c3f5=
ee62
> > > > >
> > > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > ---
> > > > > v4:
> > > > >    - No change.
> > > > >
> > > > > v3:
> > > > >    - Use helper.
> > > > >    - Use return value to print warning message.
> > > > >
> > > > > v2:
> > > > >    - Use completion instead of request_module().
> > > > >
> > > > >    drivers/hwmon/acpi_power_meter.c | 6 ++++++
> > > > >    1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acp=
i_power_meter.c
> > > > > index 703666b95bf4..33fb9626633d 100644
> > > > > --- a/drivers/hwmon/acpi_power_meter.c
> > > > > +++ b/drivers/hwmon/acpi_power_meter.c
> > > > > @@ -883,6 +883,12 @@ static int acpi_power_meter_add(struct acpi_=
device *device)
> > > > >         strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS)=
;
> > > > >         device->driver_data =3D resource;
> > > > > +       if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
> > > > > +           acpi_dev_get_first_match_dev("IPI0001", NULL, -1)) {
> > > > > +               if (acpi_wait_for_acpi_ipmi())
> > > > > +                       dev_warn(&device->dev, "Waiting for ACPI =
IPMI timeout");
> > > > > +       }
> > > > > +
> > > >
> > > > What a hack :-(.
> > > >
> > > > This needs a comment in the driver explaining the rationale for thi=
s change, and
> > > > also a comment explaining why, for example, using late_initcall() d=
oes not help.
> > > >
> > > > If CONFIG_IPMI_SI=3Dn, acpi_wait_for_acpi_ipmi() will return 0, ind=
icating success.
> > > > I can only imagine that this will result in a failure since the who=
le point
> > > > of this code is to wait until that driver is loaded. Please explain=
 how and why
> > > > the code works with CONFIG_IPMI_SI=3Dn. Similar, if the function re=
turns an error,
> > > > I can not imagine how it would make sense to instantiate the driver=
 If it does
> > > > make sense to continue in this situation, a comment is needed in th=
e code
> > > > describing the rationale.
> > >
> > > I'm trying to figure out where CONFIG_IPMI_SI comes in here.  It's
> > > nowhere in these patches or in drivers/acpi.  ACPI_IPMI depends on
> > > IPMI_HANDLER, but that's all I found.  However, ACPI_IPMI can be "m" =
as
> > > you mention and SENSOR_ACPI_POWER is only under the ACPI config, whic=
h
> > > is a problem.
> > >
> >
> > The patch above is looking for IPI0001, which is instantiated in
> >
> > drivers/char/ipmi/ipmi_si_platform.c:   { "IPI0001", 0 },
> > drivers/char/ipmi/ipmi_ssif.c:  { "IPI0001", 0 },
> >
> > Are you saying that the above code doesn't depend on it ? In that case,
> > why does it need to check for the IPI0001 device in the first place ?
> >
> > That will need another comment/explanation in the code because people
> > (or maybe dummies) like me won't understand the non-dependency (i.e.,
> > the need to look for IPI0001 but not requiring the associated code).
> >
> > More specifically, unless I really don't understand the acpi code,
> > acpi_dev_get_first_match_dev() will return NULL if there is no matching
> > device. In that case, the above code won't call acpi_wait_for_acpi_ipmi=
().
> > Fine, but why would this driver have to wait for ipmi if and only if th=
ere
> > is a device (and thus a driver) for IPI0001 ?
>
> Honestly, I don't really understand the acpi code that well, either.
> What I think it's saying is that if IPI0001 is present in the ACPI
> tables (there is an acpi_device present), then wait for the driver to
> get loaded.  It could be IPMI_SI or IPMI_SSIF, but there's no direct
> connection between this code and the low-level IPMI driver.  I don't
> think it forces the driver to load, at least not from what I can tell.

The dependency isn't discoverable at software level. It's all in the BIOS' =
ASL

>
> And another bug.  From the description of acpi_dev_get_first_match_dev():
> The caller is responsible for invoking acpi_dev_put() on the returned dev=
ice.

Sure. I'll fix it in next revision.

>
> As you said, this is a big hack.  There must be a better way.

Unfortunately I really can't find a better alternative if the
dependency isn't declared anywhere.

Kai-Heng

>
> -corey
>
> >
> > Thanks,
> > Guenter
> >
> > > I do think there are other issues with this patch, though.  The IPMI
> > > handler code decouples the user from the driver from a dependency poi=
nt
> > > of view.  It seems to be fairly common to see IPMI_HANDLER and
> > > ACPI_IPMI as "y" and IPMI_SI (and IPMI_SSIF, and others) as "m".  Tha=
t
> > > means this code will run but will wait for the IPMI device to appear,
> > > which may not be until the module gets loaded, which may be far more
> > > than 2 seconds later.
> > >
> > > I'm not quite sure how to fix this.  Really, the add call for this
> > > driver shouldn't be called until the IPMI device is present.  Doesn't
> > > ACPI have mechanisms to handle this sort of thing?  If so, the hack m=
ay
> > > need to be in the handling of that ACPI data (this field is not there
> > > but should be), not here, which as Guenter says, is a big hack.
> > >
> > > -corey
> > >
> > > >
> > > > Third, the new symbol is declared with CONFIG_ACPI, but defined wit=
h
> > > > CONFIG_IPMI_SI. I can not imagine how this would compile with CONFI=
G_ACPI=3Dy
> > > > and CONFIG_IPMI_SI=3D{m,n} and/or CONFIG_ACPI_IPMI=3D{m,n}.
> > > >
> > > > On top of that, IPMI_SI and ACPI_IPMI are is tristate, as is SENSOR=
S_ACPI_POWER.
> > > > This means that SENSORS_ACPI_POWER=3Dy combined with CONFIG_IPMI_SI=
=3D{m,n} or
> > > > CONFIG_ACPI_IPMI=3D{m,n} will result in a compile failure.
> > > >
> > > > Please make sure that this code compiles with all possible symbol c=
ombinations.
> > > >
> > > > Thanks,
> > > > Guenter
> > > >
> > > > >         res =3D read_capabilities(resource);
> > > > >         if (res)
> > > > >                 goto exit_free;
> > > >
> > > >
> > >
> >
> >

