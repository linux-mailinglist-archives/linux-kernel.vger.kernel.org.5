Return-Path: <linux-kernel+bounces-71070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7185A03F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB88B208FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974E25616;
	Mon, 19 Feb 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="houOTw8u"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD562562C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336387; cv=none; b=J5u31Ie/qXd7D4g25Oe8ifZi1OFphWU47UqP6ow7QVdBHdmkJ8gzcBtQs6ddQaB4Few5Zb9kko7BKHxWr4fqH7uxv6wtBwMCdD1z6zCsKDmmp1mzYozsniTKGg37G5tA+mixzdHH7agwLleajoSSCsUvekn1wdEi2uy4yPrgZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336387; c=relaxed/simple;
	bh=zkfaJddTxfyA5FANSOveBNJ7H7dJsSENwIPF/Oiu9wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9Tblx/cjUD0kFAfTBkrlAv1DbGWjrrNEeP7JLBFF2k9lShNe2TKwruoVu+k711iriEcGy0hRNCXQdXxRXuRSkEShquTsNJCpffPiPswR89CG49HkMlh6fLjBVb76D6Fp0KXUSw4VSf4L344e+j4weYcDTcrEp6u6aMiA0AdCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=houOTw8u; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcdb9d0cdefso770602276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1708336384; x=1708941184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRj8NGZqMx9LUe8iPOkuQ8PoRtqvi0TdpkhVjF7G6cc=;
        b=houOTw8uhK6rtaNvuxRHWGoq4B06mvM6IryF9rOr5jo/I5qLkXI9pIufcAiaIqo/52
         yovFk91EpRnUL6ihx0iLyd9U59HR2z9sbrQMmMsZuc6vpyi62o5aPSfIvTAmcDbCjVOg
         upL+c2OKWFSKMbHmGr/iwhx030QLz6PJFvQp+XL9TMSs/pDUb36Q/YBmgf7E001Z4YV/
         mFsIAZMoB0G0vczKNHq2vOw1KNzN4MKfPDQKRxY0wDc6/NO1Smpm9JiDVFAfOqOd00MG
         4SWUoQhXhyShgyPJuLabo8PE9FH5JzR+9xuOrNDeZYMpnMZy9er2LYvd+rLn3nQuhd0/
         gDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336384; x=1708941184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRj8NGZqMx9LUe8iPOkuQ8PoRtqvi0TdpkhVjF7G6cc=;
        b=V2AEM4dZw+1itlnIZ3HYKVd3nt/SQFNMo/ls9jWhYyDpykI/5P3qbBEBIHm2/H3FzZ
         5HUECMmtJm8PUz/zJ66ngn/TMGBwdLew73bnriY6PxjLYQiUccExMWKbVid0C/GlAzW7
         jRi/SZ9M8vRljaa5ScDNQkKJNW+O6TtbQav6MRaukTfReAf9VrLe7K3Oul7Hhuc3cBmn
         QpyAfn4WHeTTHJlwZWbXWz09hABSzbUmJ43+qXXTqQ8yhf3/G4PvEoow7+f+qqbceX7h
         R+/mh1C9cIMOQr4iyEkq9Mqouf2tNj41uBtKD5OjfUyDPUeV8rmw3Y6SlMJ8kcieztIy
         ultQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Yn/9YbStJX5h2On2llJ2Sujnxw0fMZlHoeVXHYI1dG6JuFwY9qxmY9I7OGhBXH56Eno1Iqzqt/B8moOC1oTRexLSingx9JsxwV/s
X-Gm-Message-State: AOJu0Yzy4F4MYRq6CuLAoiN/HYAFXfaUYq4fj2h0vq1PWnk+dgKE6W96
	8sqgLp2EjLXaKGFvNtZGBikDarKyRVubRWSZJatQNAIVqG+7vtEirkRYCBO7k5b728C0zSgociA
	PHQbaxqkUiNWegD3EreMP1jmvxqwoGZDr8GEUZg==
X-Google-Smtp-Source: AGHT+IH8XfdHIKKoBNErwnHNgHRyZyXFmyJ4lI4k65RSjkRhUZOFWEbob0X/1i+iz3EFjjwLu1P0LM3ZwF/bcpCutTA=
X-Received: by 2002:a05:6902:ca:b0:dcc:58be:1f02 with SMTP id
 i10-20020a05690200ca00b00dcc58be1f02mr4815659ybs.4.1708336384482; Mon, 19 Feb
 2024 01:53:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207200538.GA912749@bhelgaas>
 <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com> <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com>
In-Reply-To: <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com>
From: Daniel Drake <drake@endlessos.org>
Date: Mon, 19 Feb 2024 10:52:28 +0100
Message-ID: <CAD8Lp46_8hVqs2psK4FLRR8EGFssbkWyrQ5OEst0-59OuOpwwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, rafael@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 10:52=E2=80=AFAM Daniel Drake <drake@endlessos.org> =
wrote:
> Just realised my main workstation (Dell XPS) has the same chipset.
>
> The Dell ACPI table has the exact same suspect-buggy function, which
> the affected Asus system calls from PEG0.PXP._OFF:
>
>         Method (DL23, 0, Serialized)
>         {
>             L23E =3D One
>             Sleep (0x10)
>             Local0 =3D Zero
>             While (L23E)
>             {
>                 If ((Local0 > 0x04))
>                 {
>                     Break
>                 }
>
>                 Sleep (0x10)
>                 Local0++
>             }
>
>             SCB0 =3D One
>         }
>
> (the "L23E =3D One" line is the one that writes a value to config offset
> 0xe2, if you comment out this line then everything works)
>
> However, on the Dell XPS system, nothing calls DL23() i.e. it is dead cod=
e.
>
> Comparing side by side:
> Asus root port (PC00.PEG0) has the PXP power resource which gets
> powered down during D3cold transition as it becomes unused. Dell root
> port has no power resources (no _PR0).
> Asus NVM device sitting under that root port (PC00.PEG0.PEGP) has
> no-op _PS3 method, but Dell does not have _PS3. This means that Dell
> doesn't attempt D3cold on NVMe nor the parent root port during suspend
> (both go to D3hot only).

Recap: comparing Asus device (NVMe + parent bridge goes into D3cold in
suspend, and cannot wake up) vs Dell device with same chipset (NVMe
device + parent bridge go into D3hot).

These suspend power states were confirmed by:
    echo -n "file pci-driver.c +p" > /sys/kernel/debug/dynamic_debug/contro=
l

In asking "why does the Dell device not go into D3cold" I got some
details mixed up above. I have now clarified:
The NVMe device does not have any _PSx _PRx methods so
acpi_bus_get_power_flags() does not set the power_manageable flag.
This limits the pci layer to D3hot at best.
The parent bridge has _PS0 and _PS3 methods, so it is
power_manageable. However, it does not have any power resources
(_PR0/_PR3) and hence ACPI_STATE_D3_COLD is not marked as valid.
Checking the ACPI spec, this is indeed the definition of D3cold
support (_PR3 gives the required power resources for running the
device in D3hot state, so if you turn those ones off you get D3cold).

This does not conclusively answer the question of "is D3cold broken on
this PCI bridge for all devices built on this chipset?". But at a
stretch you could regard it as another data point agreeing with that
theory: the Dell product does not attempt D3cold support at the ACPI
level and there may be a good reason for that.

Daniel

