Return-Path: <linux-kernel+bounces-68881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531C1858158
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084102825D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5E146911;
	Fri, 16 Feb 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EN+PO7Ts"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD9146915
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097429; cv=none; b=gzR7B4m/Js9Gt6Gh2ZshdYytJvc6lpo1Nm99XSdpilIJtYIhjTtMyLoT+43zfu/Gi8DR/wx4YfylJzaR7PQTBJViJ+VMcfwqk/IL4pGiu3gceiFiN9xqYDD+8jU3iJn6dZc5WGbCBZmAZty3YF7lvb0YqhYk8+S5v8L14KNwH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097429; c=relaxed/simple;
	bh=zqvzBEiASnSWsOyAXgOzbNtdSKBBKn93ZIiKcXFlZbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzKQuRIom8dgHt25HZx2PK/cLD7hQLlGvzaCD/s9SrDcUGa11vM3pK0Hss95T7rbiRHCzu7209m45rXVXag/LsrbGn2jyahGbmA76YyZoNlZ0feUyZFJzu897/njxELY8wXLjsORCmopypTSEK4te3SxPhtmT00/l3RS3v9qNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EN+PO7Ts; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so298851266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708097423; x=1708702223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqvzBEiASnSWsOyAXgOzbNtdSKBBKn93ZIiKcXFlZbY=;
        b=EN+PO7TsNVn/CawgaaFLeVZUl8HFMMlMOhl91A2SRr8Wdp7p2G4lPPQ0p82HQtEN4U
         RCm/1VBEMmnTS290l/pRv94MngNQ8OTEN6EF3iXm80lPHwRo5UyX2AlV7ZoHhv4rPPzG
         xXGmi2oaSkV8hdJNOWgMdWoz/dXDYmfA6LU6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708097423; x=1708702223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqvzBEiASnSWsOyAXgOzbNtdSKBBKn93ZIiKcXFlZbY=;
        b=lQunlu6WM87MJq1xVvTjvKNJOd06504okjr3hIZ1Lro1+c082+NPUGVfAFuckpbLPI
         szM+c0Rh7orAvBgs4Gd0Ye4iCjmNhxmt2SKDL14bvpR8FSgOqLoz8FMOk4PUlwPNqCSo
         wRCgwjMhJ0JYemGi52FbLPD7dYBoKVhZjBdRgkaAbypgBpCIyjJkWrVyFtZ6FSdomkB+
         sO8U3yFU8nL4Q5MrTS+2s8LHPXUQ/f2C5fsZfk3uWYKM9sg/GmgJoMlRShMiNWtKcadY
         GdAYAxLle2rZQMZQiisTqfvRdpcUqH84zZCv8a1ZqSIXDctdG0RPyeBPPORaKe3lJHa/
         yFsw==
X-Forwarded-Encrypted: i=1; AJvYcCWQD0fXNQM/AY4KDMMNx6sd+Qot/Wyj3l+vth03qmoDc0Ymc/qU1Bqm/rsYvJPyDE3roWflcG/Qz6SU+m6MyORmr7Tr4b3gfaQinBWO
X-Gm-Message-State: AOJu0Yx5yk4dEo473xSzrLmGD/jXOUnWhL4cHyT61oHHasX83Kdd15kq
	2HQYwTgWR52RbJsD8odA9Y1HXFx+o1wP+qvQhGFU16CXqcm5n88/9baxys4Q+NnVbHUmRoWWRpE
	G8x68
X-Google-Smtp-Source: AGHT+IFW+hGHegaZ/zaQjLcCtwCP7QdiROlNhpJRZmKRWfYdeCdpGRyW20OQU0xE46+ccDmusWSuTQ==
X-Received: by 2002:a17:906:aecb:b0:a3d:68aa:5e3 with SMTP id me11-20020a170906aecb00b00a3d68aa05e3mr3279972ejb.77.1708097423576;
        Fri, 16 Feb 2024 07:30:23 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id vb7-20020a170907d04700b00a3d23a4e8fdsm46276ejc.90.2024.02.16.07.30.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 07:30:22 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563dfa4ccdcso10764a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:30:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURGKlNTbnVV4TjHUIAvnkpD2p4xAYS4o2V6DHQO66hyWTAxl+9QYdYEhWR13TqJKT4/SdtnaevOljiOXHu5/w3ROVzT14QZwGeCywk
X-Received: by 2002:a50:cd8c:0:b0:562:70d:758 with SMTP id p12-20020a50cd8c000000b00562070d0758mr205798edi.2.1708097421181;
 Fri, 16 Feb 2024 07:30:21 -0800 (PST)
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
 <87frxskef7.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87frxskef7.fsf@minerva.mail-host-address-is-not-set>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 16 Feb 2024 07:30:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WwfB=u2DVE0ux9cD3OCCccgcWCdJBxW2-9gg4qSFSv+A@mail.gmail.com>
Message-ID: <CAD=FV=WwfB=u2DVE0ux9cD3OCCccgcWCdJBxW2-9gg4qSFSv+A@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: neil.armstrong@linaro.org, Jani Nikula <jani.nikula@intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	dri-devel@lists.freedesktop.org, eizan@chromium.org, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Imre Deak <imre.deak@intel.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 16, 2024 at 12:21=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> > The kernel tree we landed on was the v5.15 tree, which is currently
> > serving all Qualcomm sc7180-based Chromebooks, all Mediatek 8173
> > Chromebooks and all Mediatek 8186 Chromebooks. There are also a pile
> > of x86 Chromebooks running our v5.15 kernel. This code shouldn't
> > affect them because (unless I'm mistaken) they don't use the two
> > affected panel drivers. In any case, I haven't heard any screams from
> > them either. Given my landing plans of "the week of the 26th", this
> > still gives another 1.5 weeks for any screams to reach my ears.
> >
> > ...or are you looking for non-ChromeOS test reports? I'm not sure how
> > to encourage those. I suppose sometimes folks at Red Hat end up
> > stumbling over similar panel problems to those of us in ChromeOS.
> > Maybe +Javier would be interested in providing a Tested-by?
> >
>
> I do have a SC7180 based HP X2 Chromebook and could test your patch (not
> today but I could do it early next week), although I haven't followed so
> if you could please let me know what exactly do you want me to verify.
>
> AFAIU the problem is that the fwupd daemon tries to scan DP busses even i=
f
> the panel is turned off and that's what takes a lot of time (due retries)=
,
> and your patch makes the driver to bail out immediately ? If that's the
> case, I guess that just starting fwupd daemon with an without your patch
> while the panel is turned off could be a good test ?

Sorry! I wasn't trying to sign you up for extra work. I'm not
convinced that any extra verification on a Chromebook is all that
valuable since that's pretty covered by the fact that we've already
pushed this patch out to real users on Chromebooks. I think Neil was
hoping for some confirmation that my patch didn't break someone else's
hardware. I think maybe good enough is if you have some type of
hardware that uses eDP and that you could verify that my patch does
break anything about it?

I'm not aware of anyone with extensive DP AUX character device usage.
I guess I thought of Javier because I remembered him at least also
using fwupd and some of the fwupd plugins try to talk to DP things
over the DP AUX character device.

If someone is really in a testing mood and wanted to stress the char
device, I guess something simple like "hexdump -C /dev/drm_dp_aux*"
for whatever eDP AUX is associated with eDP would at least do some
reading. You could stress turning the display on and off while doing
that with and without my patch. Presumably it will be better (error
out more quickly) with my patch.

If you wanted to stress the i2c path, you could do something like this
(the grep assumes you're using ti-sn65dsi86 as your eDP bridge chip,
but hopefully easy to adjust):

bus=3D$(i2cdetect -l | grep sn65 | sed 's/i2c-\([0-9]*\).*$/\1/')
i2cdump ${bus} 0x50 i

That should dump your EDID. Again it should error out quickly when the
panel is off after my patch but should start working again when the
panel is on.


Hmmm, thinking about all the above, I guess there is one case that
_could_ be broken by my patch. I really hope not, though. If someone
has a panel that's on an always-on rail or on a shared rail with some
other device (like the touchscreen) that's keeping the panel power on
then without my patch it would be possible to do DP AUX transactions
even when the panel was "off" from Linux's point of view. It would
have worked mostly due to luck, but now luck will run out and it will
stop working. I really hope nobody has userspace that is relying on
this, but I suppose it's always possible that somewhere, someone's
userspace is. If you are or know of someone who is then please shout.

-Doug

