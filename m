Return-Path: <linux-kernel+bounces-23974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53082B4B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EA8B22002
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ABC53E09;
	Thu, 11 Jan 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KiHZ76bu"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A153E06
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd81b09e83so17422971fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704997261; x=1705602061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O5mMV8huNfQ93VjHkDIF8izwnQgK6sYfcTnduqXGytg=;
        b=KiHZ76buxn/97heTGWSgKjYU+jgLC1IdtTYNN1rjW/Ox9ofYj078U35XQSJB6PHO0D
         Gp+ytnZL3FgORQmSMD8F2d+FwtlUi001f5CsbuMz5tkrgO3GETSPmKne/5m2nGxJ8D5O
         1hQVDUqKkj/B0NYBdvyCc/XIh5vCIwNnLW3AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704997261; x=1705602061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5mMV8huNfQ93VjHkDIF8izwnQgK6sYfcTnduqXGytg=;
        b=U17olfVGfe36SJEFZCiXhfjLaCSeX60CCRnwbbrp47mZyux41InvOtl9ilpdq0ix/5
         s2H39rHZFUlJXrPK9jDtl5RuTPKvzsZMrkXre2mNl+GAfFkFZubzA1yN2F7S6AZR8XI3
         VGsIjmxen66Vm4+NDyJBMqkWyRoxoIcSikNZfKuUZx3VS/EF1m/TCz/LEKa5Gw5Lhj7u
         6C3VJUiTdYBoQxlv1SaCtTqmrVEI2uP5uRydwcGihFkcOsESwNQl7QnO7sZuPXquH87z
         QlC8ZmpNUwhu7BqE65YmeyEkOYUKljq6q+gSj1mI5tQurrvrf3HqHc6cl0dHqb4ppCJi
         HmOw==
X-Gm-Message-State: AOJu0YynZDebwbOEpHuIXy9bMmt/Lf2K2MTxgeSsIYrUMfnMJyBsGyDH
	VCzXv8NrvYy8lzMteZh62DDKePSyK7JPBrPRzVxYKuIseqlO
X-Google-Smtp-Source: AGHT+IF/4KF4++0E1sWcD7PFcryGUYNbCwneMjlOaliAsOPqZcqeVC6eO7HpYfXfoR8eA2M0MsduH3rmHZoc+tEou6o=
X-Received: by 2002:a2e:9205:0:b0:2cd:278b:fe5f with SMTP id
 k5-20020a2e9205000000b002cd278bfe5fmr37837ljg.99.1704997261041; Thu, 11 Jan
 2024 10:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113185607.1756-3-james.quinlan@broadcom.com> <20240111172844.GA2184973@bhelgaas>
In-Reply-To: <20240111172844.GA2184973@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 11 Jan 2024 13:20:48 -0500
Message-ID: <CA+-6iNy03Bz1-Wftf4PpuVFF0FS01d2Yo6coG+gHqwwwpRdFMw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Phil Elwell <phil@raspberrypi.com>, 
	bcm-kernel-feedback-list@broadcom.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001cb6a8060eaf9c95"

--0000000000001cb6a8060eaf9c95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 12:28=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Mon, Nov 13, 2023 at 01:56:06PM -0500, Jim Quinlan wrote:
> > The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must =
be
> > deliberately set by the PCIe RC HW into one of three mutually exclusive
> > modes:
> >
> > "safe" -- No CLKREQ# expected or required, refclk is always provided.  =
This
> >     mode should work for all devices but is not be capable of any refcl=
k
> >     power savings.
> >
> > "no-l1ss" -- CLKREQ# is expected to be driven by the downstream device =
for
> >     CPM and ASPM L0s and L1.  Provides Clock Power Management, L0s, and=
 L1,
> >     but cannot provide L1 substate (L1SS) power savings. If the downstr=
eam
> >     device connected to the RC is L1SS capable AND the OS enables L1SS,=
 all
> >     PCIe traffic may abruptly halt, potentially hanging the system.
> >
> > "default" -- Bidirectional CLKREQ# between the RC and downstream device=
.
> >     Provides ASPM L0s, L1, and L1SS, but not compliant to provide Clock
> >     Power Management; specifically, may not be able to meet the T_CLRon=
 max
> >     timing of 400ns as specified in "Dynamic Clock Control", section
> >     3.2.5.2.2 of the PCIe Express Mini CEM 2.1 specification.  This
> >     situation is atypical and should happen only with older devices.
> >
> > Previously, this driver always set the mode to "no-l1ss", as almost all
> > STB/CM boards operate in this mode.  But now there is interest in
> > activating L1SS power savings from STB/CM customers, which requires "as=
pm"
> > mode.
>
> I think this should read "default" mode, not "aspm" mode, since "aspm"
> is not a mode implemented by this patch, right?

Correct.
>
>
> > In addition, a bug was filed for RPi4 CM platform because most
> > devices did not work in "no-l1ss" mode.
>
> I think this refers to bug 217276, mentioned below?

I guess you are saying I should put a footnote marker there.

>
>
> > Note that the mode is specified by the DT property "brcm,clkreq-mode". =
 If
> > this property is omitted, then "default" mode is chosen.
> >
> > Note: Since L1 substates are now possible, a modification was made
> > regarding an internal bus timeout: During long periods of the PCIe RC H=
W
> > being in an L1SS sleep state, there may be a timeout on an internal bus
> > access, even though there may not be any PCIe access involved.  Such a
> > timeout will cause a subsequent CPU abort.
>
> This sounds scary.  If a NIC is put in L1.2, does this mean will we
> see this CPU abort if there's no traffic for a long time?  What is
> needed to avoid the CPU abort?

I don't think this  happens in normal practice as there are a slew of
low-level TLPs
and LTR messages  that are sent on a regular basis.  The only time
this timeout occured
is when  a major customer was doing a hack: IIRC, their endpoint
device has to reboot itself after link-up and driver probe,  so it
goes into L1.2 to execute this to reboot
and while doing so the connection is completely silent.


>
> Rega
> What does this mean for users?  L1SS is designed for long periods of
> the device being idle, so this leaves me feeling that using L1SS is
> unsafe in general.  Hopefully this impression is unwarranted, and all
> we need is some clarification here.


I don't think it will affect most users, if any.

Regards,
Jim Quinlan
Broadcom STB/CM



>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217276
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 96 ++++++++++++++++++++++++---
> >  1 file changed, 86 insertions(+), 10 deletions(-)
> > ...

--0000000000001cb6a8060eaf9c95
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCArH0hk1+ELxOEc/P4sxynXbLJMnh9
/ASrIV8yhJS+rTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDAx
MTExODIxMDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAMSrMQhIINIFgPLjTRCBHwBubYPibZTD+8Htpo7xDOwaaXxvx
RUzz12+7rdnPRq0Q83sH1v6cseFYjVmiZ6bQnvQQp3rLdMTFSgm9aXfh58/y9CXzCFO1++k58Xsz
e6ISxLgzkbK0pjA/5QC/IYci4jV2KoHntETDYW6LMCtX0EOn4FRjOzZt/tTDs08V4IrEe+ZkKm9e
pias4Srrnd7AltNJvBj0KY6Wq3NJZtGalTRcWUzVawHYyUMr3q1/Ube8YMkZInszXSn1yjWcXWnY
1aOQY2aStEwiDKQdJPIGRrEkRib9/Kz/EtdbB2emBg3++HL0qUU+suA8iZ3hSLGgOg==
--0000000000001cb6a8060eaf9c95--

