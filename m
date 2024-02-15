Return-Path: <linux-kernel+bounces-67374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD7856ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D05AB223D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A839F136672;
	Thu, 15 Feb 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XOawKM+K"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52236136642
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016950; cv=none; b=lF7zLgLHirP+NSSJiayQIblM7mkbX4l76YOhP+rvWNY2y5CK1hhOUoSxvSzhJ2tIUISZJbfq5Ew2+hXGJkf5eX3ayUbhSLevsp0cRSjamoHIjIQYrDtzVSTrD0dWVzzN8G3tI84hYHQklYFBcQq8U2vvtY582mMxCIiS+FqJmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016950; c=relaxed/simple;
	bh=s1/ASlNWdXM10uIzZ2ikbKUIZYgIKrRa/y3zX+Zh6qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNx3R7DwaSuHeDQdj8ief5qwWjeBS5viIYgpVhpH4d6YPVXVsFce0Qvmx90O6WLVDgcOzCFn7e8qqWrQmsy0emzjjBDCGI2iW75fdw2re7U8ITXRYNDUEyjDK/+9SV1DbvQkuxcntr3cscawOeV3WLVSIMPbykq3hA84LaNke+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XOawKM+K; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3c1a6c10bbso140340866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708016945; x=1708621745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1/ASlNWdXM10uIzZ2ikbKUIZYgIKrRa/y3zX+Zh6qk=;
        b=XOawKM+KcVbFYiVjAJymvVi7Bqu3b5/mXgMKKW6LvQcJvLKey5Zws4ZMiOcCzCQhS5
         vXtYIj8jXoxraY4dyohsjQn9+55HdOStAtbuAmNRQjJEi2iOUTAZF0daEzMu8SwR5n73
         bnWmoHDa+EcbTrz7yMXUOIh/LPtlZ1DAsVflo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708016945; x=1708621745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1/ASlNWdXM10uIzZ2ikbKUIZYgIKrRa/y3zX+Zh6qk=;
        b=TXzoEO8y91ZFCi+b+Lbt3M6imig9+Eo6H6ZGPXy4JwaZg54qfI5Vcxg7XnPJ3dDitG
         ASeE/izDNqbws7OXKDxknPcC/8xFAGIOYgPhdh5ATH2EL+E3ehp6Y2l5Bscud7lGUdrf
         Y7b9M6vayNJ4wCgfXFVrmwxdXANgcl28+jBBMKu8LUS4X0QuWT3g2pLzGb9Ektj7moka
         UdIDOP+pH3KHeXB4jfx6r6a6+ZyrCTx0MQe3y9+Ld6fd/qNTAk2RdX85P09/2TEd3uAJ
         2b5dcF9t3ZK4X6HW2yTlioxx3WWLVmcmZamcTZpedfXLIXGi81Llm/g8bc5WNZ9Wkefq
         UuSg==
X-Forwarded-Encrypted: i=1; AJvYcCXRzFgMI93xrOmsx1SZsLtD25QFzncHuiOy49Ui1W1XVO0ZtvBVu8qQbKZRtDKPZNNgoAQGK3WmCbV/Acw5xFnjeSzqNKrT2VaGLcsA
X-Gm-Message-State: AOJu0YyArkFubfqtmUPy8MI8dse7DAStJkfBwLgEbS8HhMDcll+J2p+0
	hgfVy378TZo7T/UG6WMxPrmR7d1ZpadxSpYuzojQxlEuqJIZceltPZDVCH5/hAa27H+D38tV4x3
	4zuTT
X-Google-Smtp-Source: AGHT+IE6rJD+Q3CVHnlZeIFTeK0vyen55fPjqizFhLujSKfeBMmXPlJwGmEXVK94W3/+IeLYM0v5iQ==
X-Received: by 2002:a17:906:4c58:b0:a3c:e9fb:fc38 with SMTP id d24-20020a1709064c5800b00a3ce9fbfc38mr2053660ejw.12.1708016945474;
        Thu, 15 Feb 2024 09:09:05 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id ty8-20020a170907c70800b00a3d1b3c5f1esm751139ejc.77.2024.02.15.09.09.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:09:05 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso77955e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:09:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW71DWvVAkUI6WCMVwxMQdPJXNoSn/VTGkpXo6eGjwddxrhhMr5NHUsziWJLEqeZZla6CQjKT9CsYeqhv/QRw9lzEc54PXDHYrHpUv0
X-Received: by 2002:a05:600c:3d9b:b0:412:255a:f7dc with SMTP id
 bi27-20020a05600c3d9b00b00412255af7dcmr20552wmb.5.1708016943776; Thu, 15 Feb
 2024 09:09:03 -0800 (PST)
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
 <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org>
In-Reply-To: <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 15 Feb 2024 09:08:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UtakQZ6OEKwERW5gNeAfS88EqkuQAHkrQoN=SicDG1JA@mail.gmail.com>
Message-ID: <CAD=FV=UtakQZ6OEKwERW5gNeAfS88EqkuQAHkrQoN=SicDG1JA@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: neil.armstrong@linaro.org, Javier Martinez Canillas <javierm@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org, eizan@chromium.org, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Imre Deak <imre.deak@intel.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 15, 2024 at 8:53=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Hi Doug,
>
> On 15/02/2024 16:08, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Feb 15, 2024 at 2:24=E2=80=AFAM Jani Nikula <jani.nikula@intel.=
com> wrote:
> >>
> >> On Wed, 14 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
> >>> Hi,
> >>>
> >>> On Tue, Feb 13, 2024 at 10:25=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromiu=
m.org> wrote:
> >>>>
> >>>> On Wed, Feb 14, 2024 at 2:23=E2=80=AFPM Douglas Anderson <dianders@c=
hromium.org> wrote:
> >>>>>
> >>>>> If an eDP panel is not powered on then any attempts to talk to it o=
ver
> >>>>> the DP AUX channel will timeout. Unfortunately these attempts may b=
e
> >>>>> quite slow. Userspace can initiate these attempts either via a
> >>>>> /dev/drm_dp_auxN device or via the created i2c device.
> >>>>>
> >>>>> Making the DP AUX drivers timeout faster is a difficult proposition=
.
> >>>>> In theory we could just poll the panel's HPD line in the AUX transf=
er
> >>>>> function and immediately return an error there. However, this is
> >>>>> easier said than done. For one thing, there's no hard requirement t=
o
> >>>>> hook the HPD line up for eDP panels and it's OK to just delay a fix=
ed
> >>>>> amount. For another thing, the HPD line may not be fast to probe. O=
n
> >>>>> parade-ps8640 we need to wait for the bridge chip's firmware to boo=
t
> >>>>> before we can get the HPD line and this is a slow process.
> >>>>>
> >>>>> The fact that the transfers are taking so long to timeout is causin=
g
> >>>>> real problems. The open source fwupd daemon sometimes scans DP buss=
es
> >>>>> looking for devices whose firmware need updating. If it happens to
> >>>>> scan while a panel is turned off this scan can take a long time. Th=
e
> >>>>> fwupd daemon could try to be smarter and only scan when eDP panels =
are
> >>>>> turned on, but we can also improve the behavior in the kernel.
> >>>>>
> >>>>> Let's let eDP panels drivers specify that a panel is turned off and
> >>>>> then modify the common AUX transfer code not to attempt a transfer =
in
> >>>>> this case.
> >>>>>
> >>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>>>> ---
> >>>>
> >>>> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >>>
> >>> Thanks for the review!
> >>>
> >>> Given that this touches core DRM code and that I never got
> >>> confirmation that Jani's concerns were addressed with my previous
> >>> response, I'm still going to wait a little while before applying. I'm
> >>> on vacation for most of next week, but if there are no further replie=
s
> >>> between now and then I'll plan to apply this to "drm-misc-next" the
> >>> week of Feb 26th. If someone else wants to apply this before I do the=
n
> >>> I certainly won't object. Jani: if you feel this needs more discussio=
n
> >>> or otherwise object to this patch landing then please yell. Likewise
> >>> if anyone else in the community wants to throw in their opinion, feel
> >>> free.
> >>
> >> Sorry for dropping the ball after my initial response. I simply have n=
ot
> >> had the time to look into this.
> >>
> >> It would be great to get, say, drm-misc maintainer ack on this before
> >> merging. It's not fair for me to stall this any longer, I'll trust the=
ir
> >> judgement.
> >>
> >> Reasonable?
> >
> > I'd be more than happy for one of the drm-misc maintainers to Ack.
> > I'll move Maxime, Thomas, and Maarten to the "To:" line to see if that
> > helps get through their filters.
>
> I'll like some test reports to be sure it doesn't break anything,
> then I'll be happy to give my ack !

Sounds good. I know Eizan (CCed, but also a ChromeOS person) was going
to poke at it a bit and seemed willing to provide a Tested-by. I'll
let him chime in.

..but perhaps some better evidence that it's not breaking hardware is
that we actually landed this into one (but not all) ChromeOS kernel
trees [1] and it's rolled out to at least "beta" channel without
anyone screaming. Normally we like things to land upstream before
picking, but in this case we needed to land another patch to gather
in-field data [2] that would have made the problem even worse.

The kernel tree we landed on was the v5.15 tree, which is currently
serving all Qualcomm sc7180-based Chromebooks, all Mediatek 8173
Chromebooks and all Mediatek 8186 Chromebooks. There are also a pile
of x86 Chromebooks running our v5.15 kernel. This code shouldn't
affect them because (unless I'm mistaken) they don't use the two
affected panel drivers. In any case, I haven't heard any screams from
them either. Given my landing plans of "the week of the 26th", this
still gives another 1.5 weeks for any screams to reach my ears.

..or are you looking for non-ChromeOS test reports? I'm not sure how
to encourage those. I suppose sometimes folks at Red Hat end up
stumbling over similar panel problems to those of us in ChromeOS.
Maybe +Javier would be interested in providing a Tested-by?

[1] https://crrev.com/c/5277322
[2] https://crrev.com/c/5277736

