Return-Path: <linux-kernel+bounces-56413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A916A84C9DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9BB22DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE311D524;
	Wed,  7 Feb 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ZhF1hbbX"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F01B7E3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306271; cv=none; b=PbB2Yz8MfBmZQkzCUdAyTTeoZPCrZ3RcZ1jhYAtF8a0ddf/UZp/rtX69+JuQ4crMHUFDyTUxYu57fX7W0EaDv+YgFeA6tAkWB6YEiTzAcUp9fNQ1ZroRPVC//s2xXWyrnFQOZFOGOqA+XuN11rk3Z4mruFTRD9yv7udhNCF2osY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306271; c=relaxed/simple;
	bh=1cT8EwzAgV4muwaKG6TVe8enpSpOX5u7s5jXFQu/01I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMsnTVzylGr9w9oJp8r9cmoteA5O1Uf2shXMjp+X61a24zuhFbg++tFb3ZKBRrcaQFZgEdtA53jYxFQEWEVAp+w+Y/XEKzqPZysorvseBVdO+5H4Ge8cHpYSAixVa+478xCFbtSdB8G/ZiQUmGGRTlrVm8hVeJ2z+y1PDIbO4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ZhF1hbbX; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6c0dc50dcso364516276.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707306267; x=1707911067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHQjjIAuLbS5dirxMqHbxELxPNPCwjg4KpsEXJuoJ/0=;
        b=ZhF1hbbX7j7b5b79W1512KtqEa5xb1VwAICuOBaHXaZ7R/S3bTTYf+EmHGn1X+43VI
         9tYI74JxbYsP0xjYGFwUEt4+gGu2JkeQLUttHuzGt7Y+viPbkiWUg/9P2P0fq47yJxPw
         sIBXj3Y+Qh1u1ETck3EhDTzJmZv2QxQ7R6WHWolU4KGQNWQcuH9p+RSlSLR2cU4qQ04c
         T80z4/Tud8nijKlYmiR3Ua+GdkrhKUfZL04/7ck2aP4iWyjmrwv/mrGVmWfMPN4qZs1m
         iTQGTNnviXi/yYTaKdCbXAMn6Xzq3wD2/1QU639c7YRIPYJVYe6/MpuhPKQ0CGzYaPhe
         AV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306267; x=1707911067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHQjjIAuLbS5dirxMqHbxELxPNPCwjg4KpsEXJuoJ/0=;
        b=LoA6aT6AmcTu6l4wTSjcc6jraOuX0r6HxmeNgiP8c5Q7ksGShvIN2vHymB+vtosD+b
         7sMAeIugE8NOZ6gjEdR0EX0l6uIwrNDjivZ4jAyFomkT7tuzj7ZcJ+1EfVKxOSVe+oj7
         3GYvaQY1E3nV9AgGB/WCxftpRLZK/jfWHYcfuvEYEb7l/PD6sS4O02Ey5aKP5KZwH+sp
         lZt7FsPVYQWw7bqGf1HkJh/ddAYgXluDblUqnM+H/VRscTS89jVv9IXWyYLdkdWwe0nC
         n7hE+CdPuO3vHzR8iyQuOEsmU8xBQgwvP6IAxi4R6+CwiNuNhDdnkjn2/1RGS+KTxdjm
         hj3Q==
X-Gm-Message-State: AOJu0Yw4q5TgDvR6cwZuxb7ChGBKKNNfi5pTPTk8fTaAGKW0ROVtbptn
	WWRH60gS41Y0gGOngfshwuPPbxMsCWeqZ+kO+iv+88t6tbU9p/Zw0zType5zwp32SZA6J1aeucm
	gNoZV9N6C//uAMplVdNq7nZZu2VnxbvgIM6GxBEMnhhGoYUshbaSkeQ==
X-Google-Smtp-Source: AGHT+IH3v6VYtO+OTg9Wy0EhHrxKGg2g3IBj2TUN+YMrZmXU54Yu6Nahvd1UX8Fh32Kb8UNMx7ry4ukOpDNF7rDBEbk=
X-Received: by 2002:a5b:991:0:b0:dbd:d617:7f14 with SMTP id
 c17-20020a5b0991000000b00dbdd6177f14mr4298338ybq.10.1707306267205; Wed, 07
 Feb 2024 03:44:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <CAPpJ_eeV45QErAYRADUAHJUsGP0q5DqQJBQsgDdGZL0H0Q1isA@mail.gmail.com>
In-Reply-To: <CAPpJ_eeV45QErAYRADUAHJUsGP0q5DqQJBQsgDdGZL0H0Q1isA@mail.gmail.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 19:43:51 +0800
Message-ID: <CAPpJ_eeAOjdERye=Br6r0LgzEGf_OnpD+osTGHahjTQ6PdioWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Daniel Drake <drake@endlessos.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, rafael@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Daniel Drake <drake@endlessos.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:44=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > The Asus B1400 with original shipped firmware versions and VMD disabled
> > cannot resume from suspend: the NVMe device becomes unresponsive and
> > inaccessible.
> >
> > This is because the NVMe device and parent PCI bridge get put into D3co=
ld
> > during suspend, and this PCI bridge cannot be recovered from D3cold mod=
e:
> >
> >   echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/unbind
> >   echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/unbind
> >   setpci -s 00:06.0 CAP_PM+4.b=3D03 # D3hot
> >   acpidbg -b "execute \_SB.PC00.PEG0.PXP._OFF"
> >   acpidbg -b "execute \_SB.PC00.PEG0.PXP._ON"
> >   setpci -s 00:06.0 CAP_PM+4.b=3D0 # D0
> >   echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/bind
> >   echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/bind
> >   # NVMe probe fails here with -ENODEV
> >
> > This appears to be an untested D3cold transition by the vendor; Intel
> > socwatch shows that Windows leaves the NVMe device and parent bridge in=
 D0
> > during suspend, even though these firmware versions have StorageD3Enabl=
e=3D1.
> >
> > Experimenting with the DSDT, the _OFF method calls DL23() which sets a =
L23E
> > bit at offset 0xe2 into the PCI configuration space for this root port.
> > This is the specific write that the _ON routine is unable to recover fr=
om.
> > This register is not documented in the public chipset datasheet.
> >
> > Disallow D3cold on the PCI bridge to enable successful suspend/resume.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742
> > Signed-off-by: Daniel Drake <drake@endlessos.org>
>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

Change to Acked-by: Jian-Hong Pan <jhp@endlessos.org>

> > ---
> >  arch/x86/pci/fixup.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > v2:
> > Match only specific BIOS versions where this quirk is required.
> > Add subsequent patch to this series to revert the original S3 workaroun=
d
> > now that s2idle is usable again.
> >
> > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > index f347c20247d30..6b0b341178e4f 100644
> > --- a/arch/x86/pci/fixup.c
> > +++ b/arch/x86/pci/fixup.c
> > @@ -907,6 +907,51 @@ static void chromeos_fixup_apl_pci_l1ss_capability=
(struct pci_dev *dev)
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl=
_pci_l1ss_capability);
> >  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_a=
pl_pci_l1ss_capability);
> >
> > +/*
> > + * Disable D3cold on Asus B1400 PCIe bridge at 00:06.0.
> > + *
> > + * On this platform with VMD off, the NVMe's parent PCI bridge cannot
> > + * successfully power back on from D3cold, resulting in unresponsive N=
VMe on
> > + * resume. This appears to be an untested transition by the vendor: Wi=
ndows
> > + * leaves the NVMe and parent bridge in D0 during suspend.
> > + * This is only needed on BIOS versions before 308; the newer versions=
 flip
> > + * StorageD3Enable from 1 to 0.
> > + */
> > +static const struct dmi_system_id asus_nvme_broken_d3cold_table[] =3D =
{
> > +       {
> > +               .matches =3D {
> > +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMP=
UTER INC."),
> > +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.=
304"),
> > +               },
> > +       },
> > +       {
> > +               .matches =3D {
> > +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMP=
UTER INC."),
> > +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.=
305"),
> > +               },
> > +       },
> > +       {
> > +               .matches =3D {
> > +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMP=
UTER INC."),
> > +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.=
306"),
> > +               },
> > +       },
> > +       {
> > +               .matches =3D {
> > +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMP=
UTER INC."),
> > +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.=
307"),
> > +               },
> > +       },
> > +       {}
> > +};
> > +
> > +static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
> > +{
> > +       if (dmi_check_system(asus_nvme_broken_d3cold_table) > 0)
> > +               pci_d3cold_disable(pdev);
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme=
_d3cold);
> > +
> >  #ifdef CONFIG_SUSPEND
> >  /*
> >   * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3c=
old, but
> > --
> > 2.43.0
> >

