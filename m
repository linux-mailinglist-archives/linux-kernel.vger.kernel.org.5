Return-Path: <linux-kernel+bounces-82370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2236868351
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889F028EC39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE735131E21;
	Mon, 26 Feb 2024 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="lJMdXiM3"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032AD12F388
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984158; cv=none; b=pne6S8QHUtLSJlUvZxtOOQgPRoHYvo0Q9n0TfN5Qo5O9z3CW6MsuwuO4Nk2OsnJyjAZ0R+BFx0ADIkKvDaAfCvayI1AAyjmLvk64jtKYHXktcACar1VYwP6U+/dJ1bvtO9sUfEvGjuiW2N/ohlZVZoXa+/XohnQpfffKWzk4cag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984158; c=relaxed/simple;
	bh=LvqziGEBSPprOdiqXW0BtoohOCzdBYizN85hWV54RjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkdF29eON/p0VDEhYiWSb6lrcEyAPr0ia4KHl1iz7/1mgLVP033pJmVVmYUxZ4DOgQacIjdGpof2kEUhQw5UB3SS61bgK3El1PIxiAgsszrn7+JJtzePlKKEmG7aFWEZBrdLIzrbWiABSw+NBI9Xipv0XNFnZjs84eiV1SY6nhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=lJMdXiM3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso4514880a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1708984155; x=1709588955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvqziGEBSPprOdiqXW0BtoohOCzdBYizN85hWV54RjA=;
        b=lJMdXiM3pFIGXxyJXO09hsjYaQT3Tk8Zeib5LagsRPE1WK48i3G8cAikb07WU/R33n
         uGZFdZQs/z9k+hkFqymGs9m+KqgAThKmV3wHx/NSZCjJq8BbywsZJkvu7HOAWprVWuoc
         6npRdOPKvZYP44gUTPdwjYn69uKBCKbDL1SspX50YCE5Gf5AYGjnORlN3r+4Gnb5/zwA
         quaL4O7i0p7h7xAOUzCjSw3j0yi1KDS3lHCtiYVam/RPwHln7R/vGcG4LzmjpJoc/0ms
         9GCyI4awjaEDyW7x6SrqLGRLkQVVD+u/R+RJwa9pfrMmNoZRcdpsfmfEkub+oxrhuEZb
         FBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708984155; x=1709588955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvqziGEBSPprOdiqXW0BtoohOCzdBYizN85hWV54RjA=;
        b=CO9Pc2uyUEoTzuLS8D+GcVRs+tNuTnU63DwqNGxKw0ghTRsdnTpheM85e5NyIje4tY
         3fheDcExsgj2t0jHCoBUW9+m3y9wWkBo3oCXDxhr83kVCWMs1bWFvy/ojOATz9c0kJP/
         zgkAXSYhvP95vplAS1H4OIIELYWOz70g7EJoXqJ19e9r9qzW8OMNF0BG8F2cq69Wj6Td
         38KMqZPNiU2RPbMMzD2WynwtMf6V3/b22CjjDLHCok2TIvDADnDvmz8wVBCHDyYqu0wq
         boxQZSnr8WE54A3qWoPIvFz9YMyfYeP6xvHLOt2siSDsbBWuf6A9pzneGQb7o76d2pK/
         2aOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1upHtbV0Ts1VJLLGCIVSsKpNgLxr3Vknz4x0rUsfuGN9TvuqCsaAmJV7SQ8YjKE1dfnAZwvUTnGjrQOAH9wd64gj3pK0vjIVLiIQh
X-Gm-Message-State: AOJu0YzmGUj98Odr2gDmTihS5/q4CLBa6lMHOdGqIbKon6EVWC1KhTR5
	ePO3pUFf+A/cekRopONnQA2KcmVnyh76F8IsTQRTyTxkQUMQdQFIT+ZFF53aJrZD3jf07jOlflD
	vPGqYb8Ki5pejYoowkqoD8UPX5+Xghv6CIHLwvg==
X-Google-Smtp-Source: AGHT+IFDhjQUIvtE3gXZFBzP+tu+CRDxsI0/hiztwW0bUlj1DLWQ7Od9BSLqqvs21UZ11Tq9oSJFYh+ttSPmumwWR38=
X-Received: by 2002:aa7:c609:0:b0:565:9e16:60da with SMTP id
 h9-20020aa7c609000000b005659e1660damr4977584edq.30.1708984154965; Mon, 26 Feb
 2024 13:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
 <CAJMQK-it9YMod4rHKnACq4O-iaGieK2SN4x5vQ018CghsA631A@mail.gmail.com>
 <CAD=FV=VfuFrK1cSKA0maMzT5dxzKEzADqrd69fZKXuAGrU2rmA@mail.gmail.com>
 <87sf1u58k0.fsf@intel.com> <CAD=FV=XQdLm3PcjEd_g_dBJ9QO8zAJtj5nrXS9=cjC80+-Jbfg@mail.gmail.com>
 <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org> <CAD=FV=UtakQZ6OEKwERW5gNeAfS88EqkuQAHkrQoN=SicDG1JA@mail.gmail.com>
 <87frxskef7.fsf@minerva.mail-host-address-is-not-set> <CAD=FV=WwfB=u2DVE0ux9cD3OCCccgcWCdJBxW2-9gg4qSFSv+A@mail.gmail.com>
In-Reply-To: <CAD=FV=WwfB=u2DVE0ux9cD3OCCccgcWCdJBxW2-9gg4qSFSv+A@mail.gmail.com>
From: Steev Klimaszewski <steev@kali.org>
Date: Mon, 26 Feb 2024 15:49:03 -0600
Message-ID: <CAKXuJqiXteBsrFF1q-dziaUvFYXXTk98Q2y7ZcDit0VxONsNmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, neil.armstrong@linaro.org, 
	Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org, eizan@chromium.org, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Imre Deak <imre.deak@intel.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 9:30=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Feb 16, 2024 at 12:21=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> >
> > > The kernel tree we landed on was the v5.15 tree, which is currently
> > > serving all Qualcomm sc7180-based Chromebooks, all Mediatek 8173
> > > Chromebooks and all Mediatek 8186 Chromebooks. There are also a pile
> > > of x86 Chromebooks running our v5.15 kernel. This code shouldn't
> > > affect them because (unless I'm mistaken) they don't use the two
> > > affected panel drivers. In any case, I haven't heard any screams from
> > > them either. Given my landing plans of "the week of the 26th", this
> > > still gives another 1.5 weeks for any screams to reach my ears.
> > >
> > > ...or are you looking for non-ChromeOS test reports? I'm not sure how
> > > to encourage those. I suppose sometimes folks at Red Hat end up
> > > stumbling over similar panel problems to those of us in ChromeOS.
> > > Maybe +Javier would be interested in providing a Tested-by?
> > >
> >
> > I do have a SC7180 based HP X2 Chromebook and could test your patch (no=
t
> > today but I could do it early next week), although I haven't followed s=
o
> > if you could please let me know what exactly do you want me to verify.
> >
> > AFAIU the problem is that the fwupd daemon tries to scan DP busses even=
 if
> > the panel is turned off and that's what takes a lot of time (due retrie=
s),
> > and your patch makes the driver to bail out immediately ? If that's the
> > case, I guess that just starting fwupd daemon with an without your patc=
h
> > while the panel is turned off could be a good test ?
>
> Sorry! I wasn't trying to sign you up for extra work. I'm not
> convinced that any extra verification on a Chromebook is all that
> valuable since that's pretty covered by the fact that we've already
> pushed this patch out to real users on Chromebooks. I think Neil was
> hoping for some confirmation that my patch didn't break someone else's
> hardware. I think maybe good enough is if you have some type of
> hardware that uses eDP and that you could verify that my patch does
> break anything about it?
>
> I'm not aware of anyone with extensive DP AUX character device usage.
> I guess I thought of Javier because I remembered him at least also
> using fwupd and some of the fwupd plugins try to talk to DP things
> over the DP AUX character device.
>
> If someone is really in a testing mood and wanted to stress the char
> device, I guess something simple like "hexdump -C /dev/drm_dp_aux*"
> for whatever eDP AUX is associated with eDP would at least do some
> reading. You could stress turning the display on and off while doing
> that with and without my patch. Presumably it will be better (error
> out more quickly) with my patch.
>
> If you wanted to stress the i2c path, you could do something like this
> (the grep assumes you're using ti-sn65dsi86 as your eDP bridge chip,
> but hopefully easy to adjust):
>
> bus=3D$(i2cdetect -l | grep sn65 | sed 's/i2c-\([0-9]*\).*$/\1/')
> i2cdump ${bus} 0x50 i
>
> That should dump your EDID. Again it should error out quickly when the
> panel is off after my patch but should start working again when the
> panel is on.
>
>
> Hmmm, thinking about all the above, I guess there is one case that
> _could_ be broken by my patch. I really hope not, though. If someone
> has a panel that's on an always-on rail or on a shared rail with some
> other device (like the touchscreen) that's keeping the panel power on
> then without my patch it would be possible to do DP AUX transactions
> even when the panel was "off" from Linux's point of view. It would
> have worked mostly due to luck, but now luck will run out and it will
> stop working. I really hope nobody has userspace that is relying on
> this, but I suppose it's always possible that somewhere, someone's
> userspace is. If you are or know of someone who is then please shout.
>
> -Doug

Tested on my Thinkpad X13s, with display on, I get the did when
hexdumping /dev/drm_dp_aux2, with display off I get device/resource
busy.
Tested-by: Steev Klimaszewski <steev@kali.org>

