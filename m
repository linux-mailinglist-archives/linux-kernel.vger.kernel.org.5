Return-Path: <linux-kernel+bounces-68228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C6857798
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F13D1F215B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE41DDEB;
	Fri, 16 Feb 2024 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffjFZC/8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3097F1B81A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071683; cv=none; b=Q9mh+ANaAjfouHj3K6ez3814MlLLNsqqIwgd4WGdjvdynBqQbG3R8obz/0AejACRX5ONdnECnLAobFSYriq0gbl+8juGmxIT1aF9QYTh39F1JAQLXGvoFNpEEvZKxyScZvozovufO1dWHTDWQiImaF3CLJDOaDvExm2hFkTqofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071683; c=relaxed/simple;
	bh=HsCdI41uNLdj9vWH20xULzyDarTlzF8V7YTORvhNJQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I0BEbEN4bZeohX4jGfaVrgH2vvuYdv4Uag+2FWRPB+I6mtzBnBQkUSTzzELeatiD+bIYIWLtJ5H4brnLzf6Q6tNKptMlGd0XI+zpNfs/P9Uis1VawKiOfPxTHSwqbr52IAC/xOsLQm6zfB4jjmkqZ+/XqLDgpF7fORL1bqL/FR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffjFZC/8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708071681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsCdI41uNLdj9vWH20xULzyDarTlzF8V7YTORvhNJQ0=;
	b=ffjFZC/8eXg/IT3tHbexJsqbOxeRoc+iP5J7rqs8IewJ3sA7iDxdYxPRQB1Y288GexD5H6
	AdH+bMwdzFkY7l4eto9A3hDaA3d3PuhYcRwfJrB4xErNbCUsjXG6bbiHwhLcYjBFki2cdA
	feN8lzUCx+vvaud+Pqs288BLT62Zycg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-IoSh8ShXPBGmSdqDMlP1Aw-1; Fri, 16 Feb 2024 03:21:19 -0500
X-MC-Unique: IoSh8ShXPBGmSdqDMlP1Aw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d19ac07c5so249410f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071678; x=1708676478;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsCdI41uNLdj9vWH20xULzyDarTlzF8V7YTORvhNJQ0=;
        b=YFNE5IGkooSBz/qt4LoH8vLBIhk6vST8xtpFcTxxt0G+SNgdEdjW32OnlY0mxqwSG6
         qk7q5EjZClOTlw6Yrxpq6zv9GBqfCLnuqKBbwyJOE4c6R01HRlPn6IeTAhRQpG6qW4I9
         jSlVtt3XRiADcv3x1NGPC7ZGtCEFJLfl7k17C0cWLv24Urz7eUlHfzfIrbsRkfbuBUWw
         VghAm3D44a+aBrlxNCrTc6UPlicu0hCwSrTr2acJnxLQ/RHyJrsjU1rDuAb7NE9s/QTp
         HDSmR+dlEY+j1oL3B7Cfu6vmusNg6o/Aq4nGfkFFZsFVt2lR3gVqaO9bzXRm6Aeue/H5
         4ssQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Qi0piifRUpfyomGY7cCbyVjagD0iCpoJiaXMUZyso5I1KgD8gAzmxxIzCaJv7DjyUh5yL3rk1FiMIbh8AVrfDhn6zL620hrjtSaH
X-Gm-Message-State: AOJu0Yw5itscppbHtetJ9wHQ33xTPnHLqjzT6XoyAztQQ7NpqIjPIOl9
	KY1XJLYD6clbFEDuhXRQGe1nXZXYsQljCEQCMge5zMsSifmxZp863n1JZkJ5aBekF8Db3zd41XA
	ZiXDMl7mBrsKYAg2WqEf6xg+Y7JYcTHY/rBzW0BwxvMsM3HQHZ4YWUiM27VjQPQ==
X-Received: by 2002:a5d:6109:0:b0:33d:228f:f4ab with SMTP id v9-20020a5d6109000000b0033d228ff4abmr105150wrt.15.1708071678170;
        Fri, 16 Feb 2024 00:21:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFhNSykPbcaVP9rvuI+Pxyv/DedRPTjhi4bZfskagZIPLeSAgm7zKS8dwtr+tsW9UaRRKMAg==
X-Received: by 2002:a5d:6109:0:b0:33d:228f:f4ab with SMTP id v9-20020a5d6109000000b0033d228ff4abmr105131wrt.15.1708071677787;
        Fri, 16 Feb 2024 00:21:17 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d6347000000b0033d14455c99sm1468403wrw.101.2024.02.16.00.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:21:17 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Doug Anderson <dianders@chromium.org>, neil.armstrong@linaro.org
Cc: Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
 dri-devel@lists.freedesktop.org, eizan@chromium.org, Ankit Nautiyal
 <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, David
 Airlie <airlied@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Imre
 Deak <imre.deak@intel.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, Sam
 Ravnborg <sam@ravnborg.org>, Stanislav Lisovskiy
 <stanislav.lisovskiy@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
In-Reply-To: <CAD=FV=UtakQZ6OEKwERW5gNeAfS88EqkuQAHkrQoN=SicDG1JA@mail.gmail.com>
References: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
 <CAJMQK-it9YMod4rHKnACq4O-iaGieK2SN4x5vQ018CghsA631A@mail.gmail.com>
 <CAD=FV=VfuFrK1cSKA0maMzT5dxzKEzADqrd69fZKXuAGrU2rmA@mail.gmail.com>
 <87sf1u58k0.fsf@intel.com>
 <CAD=FV=XQdLm3PcjEd_g_dBJ9QO8zAJtj5nrXS9=cjC80+-Jbfg@mail.gmail.com>
 <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org>
 <CAD=FV=UtakQZ6OEKwERW5gNeAfS88EqkuQAHkrQoN=SicDG1JA@mail.gmail.com>
Date: Fri, 16 Feb 2024 09:21:16 +0100
Message-ID: <87frxskef7.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Doug Anderson <dianders@chromium.org> writes:

Hello Doug,

> Hi,
>
> On Thu, Feb 15, 2024 at 8:53=E2=80=AFAM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> Hi Doug,
>>
>> On 15/02/2024 16:08, Doug Anderson wrote:
>> > Hi,
>> >
>> > On Thu, Feb 15, 2024 at 2:24=E2=80=AFAM Jani Nikula <jani.nikula@intel=
com> wrote:
>> >>
>> >> On Wed, 14 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
>> >>> Hi,
>> >>>
>> >>> On Tue, Feb 13, 2024 at 10:25=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromi=
um.org> wrote:
>> >>>>
>> >>>> On Wed, Feb 14, 2024 at 2:23=E2=80=AFPM Douglas Anderson <dianders@=
chromium.org> wrote:
>> >>>>>
>> >>>>> If an eDP panel is not powered on then any attempts to talk to it =
over
>> >>>>> the DP AUX channel will timeout. Unfortunately these attempts may =
be
>> >>>>> quite slow. Userspace can initiate these attempts either via a
>> >>>>> /dev/drm_dp_auxN device or via the created i2c device.
>> >>>>>
>> >>>>> Making the DP AUX drivers timeout faster is a difficult propositio=
n.
>> >>>>> In theory we could just poll the panel's HPD line in the AUX trans=
fer
>> >>>>> function and immediately return an error there. However, this is
>> >>>>> easier said than done. For one thing, there's no hard requirement =
to
>> >>>>> hook the HPD line up for eDP panels and it's OK to just delay a fi=
xed
>> >>>>> amount. For another thing, the HPD line may not be fast to probe. =
On
>> >>>>> parade-ps8640 we need to wait for the bridge chip's firmware to bo=
ot
>> >>>>> before we can get the HPD line and this is a slow process.
>> >>>>>

[...]

>
> The kernel tree we landed on was the v5.15 tree, which is currently
> serving all Qualcomm sc7180-based Chromebooks, all Mediatek 8173
> Chromebooks and all Mediatek 8186 Chromebooks. There are also a pile
> of x86 Chromebooks running our v5.15 kernel. This code shouldn't
> affect them because (unless I'm mistaken) they don't use the two
> affected panel drivers. In any case, I haven't heard any screams from
> them either. Given my landing plans of "the week of the 26th", this
> still gives another 1.5 weeks for any screams to reach my ears.
>
> ...or are you looking for non-ChromeOS test reports? I'm not sure how
> to encourage those. I suppose sometimes folks at Red Hat end up
> stumbling over similar panel problems to those of us in ChromeOS.
> Maybe +Javier would be interested in providing a Tested-by?
>

I do have a SC7180 based HP X2 Chromebook and could test your patch (not
today but I could do it early next week), although I haven't followed so
if you could please let me know what exactly do you want me to verify.

AFAIU the problem is that the fwupd daemon tries to scan DP busses even if
the panel is turned off and that's what takes a lot of time (due retries),
and your patch makes the driver to bail out immediately ? If that's the
case, I guess that just starting fwupd daemon with an without your patch
while the panel is turned off could be a good test ?

> [1] https://crrev.com/c/5277322
> [2] https://crrev.com/c/5277736
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


