Return-Path: <linux-kernel+bounces-29456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083BE830E86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8851C24BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A825570;
	Wed, 17 Jan 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C5OLLkav"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E192555E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526492; cv=none; b=nMEqVL62xa+uA5wP6XHwHVAl0sLc7ZMwUI3nrA9rdAuc5/Gc22Bf+uK9u0lJ6xECFQF2CQt8o+b9R4hVkaJOb4TkFRP1kL6u+aOUqIEIr65veVFn6p/RZrYP9iqJkfwSt74YTGRIItNwXv+bAYi4RirYLiEN57uUTkEUY7hPFPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526492; c=relaxed/simple;
	bh=OzPi36uy4OSKSdZ2yKX4LoBRrz9zNHcyo8qrk3ql8N0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=KoCOCSrqMK8d6vJCLxscPfa1FSUlC94vEXvfLEwRlnXAKTqqcSdJvKbm7fhzUBEE3YelV59jdFN/vj4C5wT+v3+J0N12vGytiEhZBv2nOEyc6cBCXLZK74npVLd1QS3xI0MIEJwz3KdR5PUsf97bn6eIhVFS0Ilg564VsmbbSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C5OLLkav; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4b739b49349so2263605e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705526489; x=1706131289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlSlxQK1lCiNiXMfxBZANzuI+vNt+rRyQCAaKT6k4UI=;
        b=C5OLLkavbxUraV8awQPpZoUORp9stEtDtM4uq5VxtXu8KZmXp5JqK++mWcEQuzPDWx
         5HiIEbbCSGBiERwMYiPoI5Aeu2HcM5CTnUyPM3w5bnxrnCHPtPIABQXVidMkXqgzoo/R
         cXqjFsgVjXYN+N1IJhztHaL9NCxC3F4BkwEFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705526489; x=1706131289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlSlxQK1lCiNiXMfxBZANzuI+vNt+rRyQCAaKT6k4UI=;
        b=mtyIRfKkI87XMUTQSlrO1/3WFG0AIYhZzxVRpOS9wDvX/6ncykKKxhIGQBO3ModSQf
         nRMI3u8U7ApJgkNZlaM7kuqoxY8lPNMyxBT/5Fb7O+FIbugnY+QVzDM5ypfq46ACLgsD
         TjXo22kVxFOp/etfVoPEgbSqpyCsFvFskvSFftKF1JjAShT3BC/9yB/Cyw7gVR0jgCrb
         KD5fZoSizag/r2SU3GufDEqJ1+UTGCNyFPA77QWGXDtaEZIoqpyBSWPc7qnRJIbmCvKP
         u1qJYmpddu1cfbo3lpjQY7ApVU9HVH95olrRds8S/1aRXfq1E4/1LKqUDWzfvQMpvJMq
         0YYw==
X-Gm-Message-State: AOJu0YwNvusJ7Rp7Tbka1IUsOZytGbXjpMWWC43aGKl1SG29MsF/hSiZ
	eCWpFDZB6DFm1cJZFns/0qgVWUVEdy2lNX9jlC4lqEk31Vp3
X-Google-Smtp-Source: AGHT+IGrMaQk2+MidTZ8i00EkfSV/JYmUT8IYCGZ3Hrmf5C+mHhV/svTrwF1/H0llVedDRerd435nyBCYHhJzNH6NXE=
X-Received: by 2002:a05:6122:4304:b0:4b7:386:e209 with SMTP id
 cp4-20020a056122430400b004b70386e209mr4879417vkb.14.1705526489419; Wed, 17
 Jan 2024 13:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de> <20231228133949.GG2543524@black.fi.intel.com>
In-Reply-To: <20231228133949.GG2543524@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 17 Jan 2024 16:21:18 -0500
Message-ID: <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for all your comments! I really appreciate all your help
with this. I will address the style feedback once we reach a decision
on how we will fix this bug.
I first will respond to your comments, and then I will list out the
possible solutions to this bug, in a way that takes into account all
of your insights.

On Tue, Dec 26, 2023 at 7:15=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> Can you include a citation (spec name, revision, section) for this
> DMAR requirement?
>
This was my mistake=E2=80=93I misinterpreted what a firmware developer told
me. This is a firmware ACPI requirement from windows, which is not in
the DMAR spec. Windows uses it to identify externally exposed PCIE
root ports.
https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie=
-root-ports#identifying-externally-exposed-pcie-root-ports

> But I don't see where the defect is here.  And I doubt that this is
> really a unique situation.  So it's likely that this will happen on
> other systems, and we don't want to have to add quirks every time
> another one shows up.
..
> don't have the new interface.  But we at least need a plan that
> doesn't require quirks indefinitely.
..
On Thu, Dec 28, 2023 at 8:41=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> This is not scalable at all. You would need to include lots of systems
> here. And there should be no issue at all anyways.
My team tests hundreds of different devices, and this is the only one
which exhibited this issue that we=E2=80=99ve seen so far.
No other devices we=E2=80=99ve seen so far have a discrete internal
Thunderbolt controller which is treated as a removable device.
Therefore, we don=E2=80=99t expect that a large number of devices will need
this quirk.

> There is really nothing "unique" here. It's exactly as specified by
> this:
>
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pc=
ie-root-ports#identifying-externally-exposed-pcie-root-ports
>
> and being used in many many system already out there and those have been
> working just fine.
I don=E2=80=99t know how many computers have a discrete Thunderbolt chip th=
at
is separate from their CPU, but this doesn=E2=80=99t seem to be a common
occurrence.
These devices were made during a narrow window of time when CPUs
didn=E2=80=99t have Thunderbolt features yet, so a separate JHL6540 chip ha=
d
to be added so that Lenovo could include Thunderbolt on X1 Carbon Gen
7/8.

As you said, these devices do indeed work fine in cases where you
don=E2=80=99t care if a PCI Thunderbolt device is internal or external, whi=
ch
is most cases.
Problems happen only whenever someone adds a security policy, or some
other feature that cares about the distinction between a fixed or
removable PCI device.

> This has been working just fine so far and as far as I can tell there is
> no such "policy" in place in the mainline kernel.
Correct, there is no such policy in the mainline kernel as of now. The
bug is that the linux kernel=E2=80=99s =E2=80=9Cremovable=E2=80=9D property=
 is inaccurate for
this device.

> Can you elaborate what the issue is and which mainline kernel you are
> using to reproduce this?
Thanks for this question! On a Lenovo Thinkpad Gen 7/Gen 8 computer
with the linux kernel installed, when you look at the properties of
the JHL6540 Thunderbolt controller, you see that it is incorrectly
labeled as removable. I have replicated this bug on the b85ea95d0864
Linux 6.7-rc1 kernel.

Before my patch, you see that the JHL6540 controller is inaccurately
labeled =E2=80=9Cremovable=E2=80=9D:
$ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
{removable} -e {device} -e {vendor} -e looking
  looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
    ATTR{device}=3D=3D"0x15d3"
    ATTR{removable}=3D=3D"removable"
    ATTR{vendor}=3D=3D"0x8086"
  looking at parent device '/devices/pci0000:00/0000:00:1d.4':
    ATTRS{device}=3D=3D"0x02b4"
    ATTRS{vendor}=3D=3D"0x8086"
  looking at parent device '/devices/pci0000:00':

After applying the patch in this ticket, we see the JHL6540 controller
is now labeled as =E2=80=9Cfixed=E2=80=9D:
$ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
{removable} -e {device} -e {vendor} -e looking
  looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
    ATTR{device}=3D=3D"0x15d3"
    ATTR{removable}=3D=3D"fixed"
    ATTR{vendor}=3D=3D"0x8086"
  looking at parent device '/devices/pci0000:00/0000:00:1d.4':
    ATTRS{device}=3D=3D"0x02b4"
    ATTRS{vendor}=3D=3D"0x8086"
  looking at parent device '/devices/pci0000:00':

OK so here is the part where I share what I=E2=80=99ve developed as a resul=
t
of your comments:

The two options I see to resolve this are as follows:
1) Either we fix this by adding a new firmware interface as Bjorn
Helgaas brought up.
2) Alternatively we may address this through a cleaned-up version of this p=
atch

If the solution is to add a firmware interface, how would I go about
that process? Could you put me in touch with someone with that
know-how?
Would we have a temporary software quirk in place while the firmware
spec is being updated?
I am deferring to your expertise and knowledge in solving this bug.
Thank you for all your help.

