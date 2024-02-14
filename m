Return-Path: <linux-kernel+bounces-66101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2498556E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92161F27A70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2CA13DB90;
	Wed, 14 Feb 2024 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hHvEYglg"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95A1DA27
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952087; cv=none; b=ZQubTX7NRkHZVdRMh3t6Vx5IRKOFADpWea3gvL9ewQrEieJBlORD9ACtRMN6S8Qhm/HUQW7P2IbUhgcu1QgJ9SUt7ATF5d0GvDCh0CXquC5PegwxeT1Moyb1l3o9LilZrKJ8H/6s1T+5YISEp45G1JpIu7rrchPT309EH5PMdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952087; c=relaxed/simple;
	bh=po6FB+Baujb9bEueLyWoU1S6jvmJIc+PouEW/zdHIJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJJzpXEICZtOv/o7p2yjnZo5mrUxoysh+/SjWuY7OmQzNHQ3ibHADNPCLXV94/+oyDZ3MDf2qt4S2GVIf7fVXwPGgaFsBLgu88GsCH7ScQAJ3vdjuNIbQo65v2ACqldI5l30bUY8y8ZUIFvMiw51ND+Vmx8ge5Y7XSLGN1ZTELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hHvEYglg; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21433afcc53so167765fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707952084; x=1708556884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po6FB+Baujb9bEueLyWoU1S6jvmJIc+PouEW/zdHIJk=;
        b=hHvEYglgxu13A/TsZvjQdycNhNecJ+0foraJwwN/Xh+0iYJ9xnmFhNklHWBoV2bVWh
         eIoFNGkanYRAExL7xs75uj3Rj4068Tzh54hOdlOqwgDseK8rNZeKeWfVkUYV7Na1YUrD
         qBYKZwBufHrqbL9pfQOvfj4vitg/F0pCE5X1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952084; x=1708556884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=po6FB+Baujb9bEueLyWoU1S6jvmJIc+PouEW/zdHIJk=;
        b=de9oc7WF7GACo8cU7ljo08hlD7qJjo8yJjjp2nkkL75ujkeT7Ct87dlbwjyfnMWX4x
         IJmzMt1+Wtq+zO16o7vFSzAQaHiubft48O+iZQPxlN2UnWX1kzmwpV4J7/+w+mrkYa5R
         rPqO8Hr1bWqLES4nsmFenwkol4QeFd9oJNsrtpQkh320oAz9lXK2OUEPllmHkfx8hxvF
         fClS8uAKDEiMOmbQG7xt87G3BTfqwuZKgCZfEId0stX5USPKRsPuiLKE+p9crmY4nsS3
         AqMjcl61IBbR4a0ph434rYMnrwyj+MplH0DbGCUPUd+AgFebEa6+/Xiq0G7Z5WkYJ5q6
         43MA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ23IaVXhkWtG+QCX4UB7JYprBBKp1Pabj0pAsfgehbjzqSsSWndhZKnJHyWd73z/9rVpkQZkbJ/ECLrRY0mAucGrW8cSAVaM6r9T3
X-Gm-Message-State: AOJu0YyWzC6QeLrBbLlzg3PI/KJrmzf5rSXlnG0sfnogd1WBdVE8+IGv
	ydQlaM0oQsc4Wzdt9aTwcO3mIT7EF2V6wu6jG4SCtlCd3xl32AHTEYepaPBPUJHUfD4UwgnfUUS
	/tyc8
X-Google-Smtp-Source: AGHT+IE7wiOgyC81cjehzDRoS50qpjg4bYLrTVtAREQ19ckZuow4IAlJw6mMVKUJNGWlEmEohdEGWg==
X-Received: by 2002:a05:6870:7012:b0:218:cdb9:24e9 with SMTP id u18-20020a056870701200b00218cdb924e9mr3877116oae.48.1707952083773;
        Wed, 14 Feb 2024 15:08:03 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id f14-20020ac86ece000000b0042c64992b92sm11886qtv.57.2024.02.14.15.08.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 15:08:02 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42c70247923so36191cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:08:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBIfisNtbUDi4Nnnm414nrd5hOdGr2qqgO32U4tXpxa2+4siRyFulqg3RhmaV0rGjtrcQSJ/+e3T5B3YXWKPHqjHEiwoBwvAcfYl/c
X-Received: by 2002:ac8:6207:0:b0:42d:c8b2:8dca with SMTP id
 ks7-20020ac86207000000b0042dc8b28dcamr118141qtb.4.1707952082055; Wed, 14 Feb
 2024 15:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
 <CAJMQK-it9YMod4rHKnACq4O-iaGieK2SN4x5vQ018CghsA631A@mail.gmail.com>
In-Reply-To: <CAJMQK-it9YMod4rHKnACq4O-iaGieK2SN4x5vQ018CghsA631A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 14 Feb 2024 15:07:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VfuFrK1cSKA0maMzT5dxzKEzADqrd69fZKXuAGrU2rmA@mail.gmail.com>
Message-ID: <CAD=FV=VfuFrK1cSKA0maMzT5dxzKEzADqrd69fZKXuAGrU2rmA@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: Hsin-Yi Wang <hsinyi@chromium.org>, Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, eizan@chromium.org, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Imre Deak <imre.deak@intel.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 13, 2024 at 10:25=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org>=
 wrote:
>
> On Wed, Feb 14, 2024 at 2:23=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > If an eDP panel is not powered on then any attempts to talk to it over
> > the DP AUX channel will timeout. Unfortunately these attempts may be
> > quite slow. Userspace can initiate these attempts either via a
> > /dev/drm_dp_auxN device or via the created i2c device.
> >
> > Making the DP AUX drivers timeout faster is a difficult proposition.
> > In theory we could just poll the panel's HPD line in the AUX transfer
> > function and immediately return an error there. However, this is
> > easier said than done. For one thing, there's no hard requirement to
> > hook the HPD line up for eDP panels and it's OK to just delay a fixed
> > amount. For another thing, the HPD line may not be fast to probe. On
> > parade-ps8640 we need to wait for the bridge chip's firmware to boot
> > before we can get the HPD line and this is a slow process.
> >
> > The fact that the transfers are taking so long to timeout is causing
> > real problems. The open source fwupd daemon sometimes scans DP busses
> > looking for devices whose firmware need updating. If it happens to
> > scan while a panel is turned off this scan can take a long time. The
> > fwupd daemon could try to be smarter and only scan when eDP panels are
> > turned on, but we can also improve the behavior in the kernel.
> >
> > Let's let eDP panels drivers specify that a panel is turned off and
> > then modify the common AUX transfer code not to attempt a transfer in
> > this case.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

Thanks for the review!

Given that this touches core DRM code and that I never got
confirmation that Jani's concerns were addressed with my previous
response, I'm still going to wait a little while before applying. I'm
on vacation for most of next week, but if there are no further replies
between now and then I'll plan to apply this to "drm-misc-next" the
week of Feb 26th. If someone else wants to apply this before I do then
I certainly won't object. Jani: if you feel this needs more discussion
or otherwise object to this patch landing then please yell. Likewise
if anyone else in the community wants to throw in their opinion, feel
free.

-Doug

