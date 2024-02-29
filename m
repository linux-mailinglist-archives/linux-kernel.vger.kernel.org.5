Return-Path: <linux-kernel+bounces-86517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C7286C671
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC4F1F22C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513756351B;
	Thu, 29 Feb 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rSkbaSN0"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59A62A06
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201363; cv=none; b=jBW1/HkCVjy9rPwEKJIDkJoyjbiS/+gqCe1+zqbPHG5tSQDL9sMCi+8FhL89BDOuab4XcLXPN76gur9MRdta/rbcjuHspEuMYAAnDFk+UPgtVavJwItAX/d1M/6/cTH9FE4bQHLclTtxRr58bVKU96MkM3KWNvzEDveawm46+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201363; c=relaxed/simple;
	bh=GA3hOk2+V3le+4muvMPKWEzM4CFPwWUnDODB09RfE4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRk2rXr4KK4DDd8oZ5akK/Cz1H84qBadTzYTKkLXGr5gMWmU+cCyFCdKFGY4hax5LF8RpnZeErLWfini/BOlwEVHOYNiF8lkKFUTCYWvn+174zT97ZVmBYxuDY4w+mUD8fpnwgw2o2suNYppObYUpProXhZChcxb40im06iO5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSkbaSN0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso10148a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709201360; x=1709806160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/Go3YqIu09UH/h/HOYTGKZUGAGfZufH1m+hGfleaeo=;
        b=rSkbaSN0te7psnftf8RVCKwTkY/RIDX6i5cjqo/wDTV3qvx8Pmbvd65epK2qKkIjRV
         69Gx5DoTlzMfuDHTe1DwsokSBe2J1BeA0Sev107ppxJnKf2GqMEJvYKiGEvgj3w3/1xp
         0cSqEiCcyJozHyiqrX1k6zzDo4gdzQrp5FnEhetcSXTnAZ7xntuBjADi2MyjCgZTKKrC
         JGBHsdq+iN83J8TInKH/zKF+9VLCGTgNam/fCCTT6H/L8LxttAO9Ii+TAtsWWWxF85s+
         FRKK4yKL80KyOS5OgxUqxIBARzbGBMUOWmc/e/KBFJbu8Qi13FqYphgBy9/vFuRsP1c2
         2xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201360; x=1709806160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/Go3YqIu09UH/h/HOYTGKZUGAGfZufH1m+hGfleaeo=;
        b=ux69MU/bJR7FzQPxl0ha/wfTh+pc4U8w9lMEmEVbqeSLEN7A51mhzUI8JKSBtXZeLs
         mSTfA1Hi7UWXxS3QpITa6hxTAEpOwXBDh09JKJcaDt3y/XrIHm5P77QjLejj4f/ykiC6
         xD5HeVl3xcTLCCbu652Q+0ahCZO6Bg3Fe2rWUgXuH4Wd7MPwxma554MtY3JM81+p7oso
         IziuD+CSO0TPuCwRGI/C3PMvtCdWDPafK9MLwkLyvMa7kOB7V1pV89Qc9JGEm0aOchJb
         20OYXXjtz2fUZPLodaVusYehNhnB2lrrlNSaj2RaTbWc4Gn+o6lF5HjHvjAtqQqk16dq
         j68A==
X-Forwarded-Encrypted: i=1; AJvYcCWR1PTWgKyKIvzgBlkBvPLsc3REw4a2ziPQFeQaJ3Lc7v7NfGwB+4IpnPajmlLEMK3bu4IQNFs3MQqlISWx8MqCWvXpCO6uow5NcjXu
X-Gm-Message-State: AOJu0YzDPRlgLC63KWehMj1WSyop4zJA/K3fvoXcUkRCC9bj4Cy1Rb5Y
	8JqwgAe6U1ISXBInhpqb6mhcBrDgIFgZZ0bLbPwbxOXMJQhHVCVWWb+hMd4X9dpJjCUPA+G5Og3
	RP3/Zt+4fWVeSNNGpQT+WSXlAXHsH5Zv3ePJt
X-Google-Smtp-Source: AGHT+IGqgX6DpEN74CADxukO7H9XFj6A5L3gDfzgaZwl7aLZqmrIaLPyqEGhwFwYnJ0bEzVfW3daN07CbHbZHFQiHXk=
X-Received: by 2002:aa7:dcc5:0:b0:563:f48a:aa03 with SMTP id
 w5-20020aa7dcc5000000b00563f48aaa03mr103397edu.2.1709201360039; Thu, 29 Feb
 2024 02:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com>
 <CAJZ5v0gM=0rU6a1A6Bh2Ed=4=1AtQ3p5aDJVCOioA6qxGv1jtQ@mail.gmail.com>
 <CAOuDEK1NdFSZgy8_ebO_zSxbU-gLJHsCzjd6JSr2cckQAFgaTg@mail.gmail.com> <CAJZ5v0g0WgYWyOfMaq8PhOkCmBFuDRb3XbCxPpcbpJuJza0+cA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g0WgYWyOfMaq8PhOkCmBFuDRb3XbCxPpcbpJuJza0+cA@mail.gmail.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 29 Feb 2024 18:09:00 +0800
Message-ID: <CAOuDEK04r+1j-R7EmMEu91OGwmjY8AaViyQgVK4uShouTLZFiw@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rdunlap@infradead.org, james@equiv.tech, 
	broonie@kernel.org, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:28=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Feb 26, 2024 at 10:45=E2=80=AFAM Guan-Yu Lin <guanyulin@google.co=
m> wrote:
> >
> > On Sat, Feb 24, 2024 at 1:44=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Fri, Feb 23, 2024 at 3:38=E2=80=AFPM Guan-Yu Lin <guanyulin@google=
com> wrote:
> > > >
> > > > In systems with a main processor and a co-processor, asynchronous
> > > > controller management can lead to conflicts.  One example is the ma=
in
> > > > processor attempting to suspend a device while the co-processor is
> > > > actively using it. To address this, we introduce a new sysfs entry
> > > > called "conditional_skip". This entry allows the system to selectiv=
ely
> > > > skip certain device power management state transitions. To use this
> > > > feature, set the value in "conditional_skip" to indicate the type o=
f
> > > > state transition you want to avoid.  Please review /Documentation/A=
BI/
> > > > testing/sysfs-devices-power for more detailed information.
> > > >
> > > > Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> > >
> > > Please explain how this is intended to work.  That is, what exactly
> > > you expect to happen when the new attribute is set.
> >
> > The sysfs entry 'conditional_skip' for a device indicates which power
> > transitions (e.g. PM_EVENT_SUSPEND) are omitted within the system
> > power management flow. During the processing of an identified power
> > transition, the device's power.entry will not be added to the
> > dpm_prepared_list, preventing the device from undergoing that
> > transition. As 'conditional_skip' is modifiable at runtime, a device's
> > participation in system power management can be dynamically enabled or
> > disabled.
>
> So this idea is completely misguided AFAICS.
>
> First off, why would a device be skipped in system-wide suspend and
> not in hibernation?  Or the other way around?  Or why would it be
> skipped in one phase of hibernation and not in the other?
>

The motto is to set less constraints and let users configure them
properly by themselves. But, we could redesign it to better match with
existing conventions/regulations.

> Second, but not less important, why is skipping a device in
> system-wide transitions a good idea at all?  What about dependencies
> between that device and the other devices in the system?
>

If a device is also used by another operating system kernel, then
Linux kernel shouldn't always do the system power transition on that
device to avoid affecting another operating system kernel.

Since device dependencies can be highly system-specific, maybe we
should let users handle it as users are the only ones who understand
their system's unique configuration.

> Generally speaking, system-wide PM is designed to cover the entire
> system and there are good reasons for that.  If you don't want it to
> cover the entire system, you cannot use it at all.

We discovered a use case that the existing system-wide PM may not
fully support: devices shared by multiple operating system kernels. I
think supporting this case would be beneficial to the system-wide PM,
as it would increase its compatibility.

