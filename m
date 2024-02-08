Return-Path: <linux-kernel+bounces-57626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C4384DB90
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F1E1C248A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF1692E6;
	Thu,  8 Feb 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ZIdG1OOD"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E267A00
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381495; cv=none; b=iPzOSMNUG3jxA9KSlCymGRhDnUs19XeTdh+/KP0r8OtZg5N1fLO4+64fuB0+4YloUYHhJFlRhDTfzZi237FcXoWZZVcJtV7ap9RV+u3pwgLqhZzG7LIUKzc2HcoYVuWWh9tburgiVztRwyacz8GbPiGL+4eTxTkavSGvokHHV8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381495; c=relaxed/simple;
	bh=lF1qmuDwtNui8X0ZFYNVt/ucazJB6+zf68wnH6w0jUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyQzJnjO4q3PkWGJ6pxWiCl0Nsqe79vN6CCvBG3OEUCDI2cneIzBJnujBNlH4CIR8WXZWfx2E0e2YqedXYr87LlUzouaiBOUNkeiLhKtnzbHI19OmfLneY09onOG/iJoUab7L+wsw0UQR2DjrLJI+DatM2Z92cX+e+Vage8bYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ZIdG1OOD; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc34d761e2aso338168276.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 00:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707381493; x=1707986293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJjgK/86oIYgDKE/vpWS6pEJ65u/gCjBzOy2n9k26uo=;
        b=ZIdG1OODqGuJaJXs8H41EmQ0bNAavyQGcaIO+8Qw0ubArxDacqPV2K9ahfrmZM35m4
         O/tRdNIj/GHDwrRkzGrbi24C5qIau/sIxruXhf/mXZbsAOJKBlW7n0F1qr3/cE8L/wfn
         cg+WN0PKcmG3qXzOXr+q6ok6ax6azW04qVBG8pINMcELfSA3Z+z0cADJ/htA87f9cB38
         ZsQFFKmwk91yyATi4Py53ZWsBcrlE4YyRFPnA6zluRsAYXnHfwE9Q2mxRj2BKUCu1KuR
         s0m40emk0w8GW3tuEH+zTmDEpYupavmdN1hf2rgfQI78vMH4gZFeaRlcpcv6JDERp9uS
         ze6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707381493; x=1707986293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJjgK/86oIYgDKE/vpWS6pEJ65u/gCjBzOy2n9k26uo=;
        b=oLnS6HEUdliDBfPlvtyhMGZ11xeR0SrxTGoHkP4X3SxPYgB0OO5te8Y6+5UKX+arva
         1BQMSKGLmxRT1F4kUmROdwz0OjwQavQ08maDtPjL6Id+CU+fTo9QMMBwtaUTAzGqw+6i
         tWt7MkapxFs/DaN15rcCG0Lfyj2euFJlFb7TTgeroYM4ks9nXhSKOkW1Zesf5qnp/aee
         p9H+UPlwemBq16dz+zbBMmESO+ynWJSWFL6A8sGR+mBxM8rNX0Zpw+1vUjpYnw5avcjY
         IGwHGaoizSX57+hX0DDvqFmyqVUMJMuVKSGxjiGMdvbVuN2pupqoEWBW/9GliDMUkX+7
         sMGg==
X-Forwarded-Encrypted: i=1; AJvYcCUwLangAZM2+QVJYvzjk/YploRIrbn+a+l0smz5YiOvI+Un/wTPYQ1c8R/DLGxzPIVQkdtUYDyJ5bN6EA2B/ZMRTtc/i7vvqZvfeuM2
X-Gm-Message-State: AOJu0YxxoIKHQjE2dEoOK3kRK1MWQbaDwZLRG1YSKuV3XXxCNAk0hPTC
	0tnxdNr2lhRfEAJ5cFz9yneS1F0z8LAbGgLVf2fhTa5a8tIcsdIDfBr3o+wKsEBtMZmJ4z4qx2F
	rlbga+RyM/V0mSJpFTPnSumXLxRa0ZIooWDY1eQ==
X-Google-Smtp-Source: AGHT+IGMvfAD5Dwy5xHDpbIKVVXYXtthlZowYoNKU2j4hr05mPhNntdO2N44+cfCiLv/dgkt+wBOwO1Wtk1t6IMtHLg=
X-Received: by 2002:a25:8002:0:b0:dbc:b927:c5f9 with SMTP id
 m2-20020a258002000000b00dbcb927c5f9mr7087610ybk.6.1707381492892; Thu, 08 Feb
 2024 00:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207200538.GA912749@bhelgaas>
In-Reply-To: <20240207200538.GA912749@bhelgaas>
From: Daniel Drake <drake@endlessos.org>
Date: Thu, 8 Feb 2024 09:37:36 +0100
Message-ID: <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, rafael@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:05=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
> Can you run "sudo lspci -vvxxxx -s00:06.0" before putting the Root
> Port in D3hot, and then again after putting it back in D0 (when NVMe
> is inaccessible), and attach both outputs to the bugzilla?

Done: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742#c21

> Given that D3cold is just "main power off," and obviously the Root
> Port *can* transition from D3cold to D0 (at initial platform power-up
> if nothing else), this seems kind of strange and makes me think we may
> not completely understand the root cause, e.g., maybe some config
> didn't get restored.
>
> But the fact that Windows doesn't use D3cold in this case suggests
> that either (1) Windows has a similar quirk to work around this, or
> (2) Windows decides whether to use D3cold differently than Linux does.
>
> I have no data, but (1) seems sort of unlikely.  In case it turns out
> to be (2) and we figure out how to fix it that way someday, can you
> add the output of "sudo lspci -vvxxxx" of the system to the bugzilla?

https://bugzilla.kernel.org/show_bug.cgi?id=3D215742#c27

Some other interesting observations from Windows, observed via socwatch & V=
Tune:

On affected BIOS versions:
CPU does not go into the lowest power state PC10 during suspend - it
only reaches PC8.
SLP_S0# signal is not asserted (which follows from it not reaching PC10).
NVMe device in D0 and the HDD LED briefly blinks every 1-2 seconds
(can't recall if it a regular or irregular blink)

On latest BIOS version:
PC10 reached and SLP_S0# asserted during suspend, but only for about
25% of the suspend time
NVMe device in D0 and the HDD LED briefly blinks every 1-2 seconds
(can't recall if it a regular or irregular blink)

The LED blinking leaves me wondering if there is something "using" the
disk during suspend in Windows, so that's why it doesn't try to power
it down even on the original version with StorageD3Enable=3D1. This HDD
LED blinking during suspend does not happen on Linux, not even when
NVMe device is left in D0 over suspend with the regular nvme_suspend()
path putting the NVMe device into lower power mode at the NVMe
protocol level.

> What would be the downside of skipping the DMI table and calling
> pci_d3cold_disable() always?  If this truly is a Root Port defect, it
> should affect all platforms with this device, and what's the benefit
> of relying on BIOS to use StorageD3Enable to avoid the defect?

I had more assumed that it was a platform-specific DSDT bug, in that
PEG0.PXP._OFF is doing something that PEG0.PXP._ON is unable to
recover from, and that other platforms might handle the suspend/resume
of this root port more correctly. Not sure if it is reasonable to
assume that all other platforms on the same chipset have the same bug
(if that's what this is).

Daniel

