Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923167EBEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbjKOIpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbjKOIpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:45:34 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245210D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:45:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso10116484a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700037929; x=1700642729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScG462Pjz3S9RYPZZUWzsM/PrLDXDWNPoYbAht/FuJE=;
        b=G9VnH5LDLyLeLQd2Ma151krfGI8KcSgCZkWI4jlCOf/XXsZpQKDQ47N1MXavnSP71u
         TfbjiWruaTCMzWKEdkL9sTbOYnxRd6xFzOcf4nAMY0L+OQmqdgJ1lSnWe+eCKl0mBOQZ
         ISn+XIR6mFaQRLJbY0hLowgDP3JYLR102gqBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700037929; x=1700642729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScG462Pjz3S9RYPZZUWzsM/PrLDXDWNPoYbAht/FuJE=;
        b=LXKkocicDhzoP+AnSBd8ni4gITrnwGMl//dKYmNGHbS8rkrHx3Hxt4p68WIxd4zqKr
         rRa1p51Z8o9CU25KeBqJzTBesbR1s0zLiY2nqx328yMjYGskjWA4mKzXmLQLDDtkoWmv
         HOMG9b5XfYD4IL6hgHGZAdaBNDDn0cQJkHHI6qFjoTopHD5aZk6a4PxqrUIg3YgKAYPY
         p6ZmdB6PjI91QF6Xb+tzHsh4f2zbp/D1k8Yh95wgmlyHhLTMvDw855GkXSrtV5mdAIs7
         +jC9vq0atK/wReGJVK7QDTyb1rLkPnpmlHPM832nCDBYui8p7dIEqhRFp53rAqv0lh9q
         LnyQ==
X-Gm-Message-State: AOJu0YzNPDOErpkt76oeIcYEaxTuBdJ7HRuStZQhuQWeRMx8u0VlLNOk
        nUryYcPhEkCe4gBa8JVzhZK/P2xLX9u1QX4UNLq5BS/B
X-Google-Smtp-Source: AGHT+IGs8i2klzaS7FA7zEObv6zHTjnKeDg1C7NpLDuKmzQ/LFncY3IO5JFVnSUITffKnWDshrEzsQ==
X-Received: by 2002:a05:6402:50cb:b0:53f:a526:779 with SMTP id h11-20020a05640250cb00b0053fa5260779mr10576609edb.12.1700037928691;
        Wed, 15 Nov 2023 00:45:28 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id g24-20020a50d5d8000000b0054037c6676esm6329961edj.69.2023.11.15.00.45.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 00:45:28 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40839652b97so50814535e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:45:27 -0800 (PST)
X-Received: by 2002:a5d:45cb:0:b0:31f:f9a9:a742 with SMTP id
 b11-20020a5d45cb000000b0031ff9a9a742mr7969100wrs.23.1700037927479; Wed, 15
 Nov 2023 00:45:27 -0800 (PST)
MIME-Version: 1.0
References: <1699595289-25773-1-git-send-email-shengjiu.wang@nxp.com>
 <1699595289-25773-11-git-send-email-shengjiu.wang@nxp.com>
 <4cd6b593-2376-4cbc-a7c8-d3eb36a2f7a0@xs4all.nl> <20231113104238.GA13981@pendragon.ideasonboard.com>
 <6a3e7eb9-505c-4cfb-8a86-a8947a2e44d5@xs4all.nl> <20231113110754.GB24338@pendragon.ideasonboard.com>
 <3e898664-cbfc-4892-9765-37b66891643b@xs4all.nl> <ZVIIc-fi32ZxIi-p@valkosipuli.retiisi.eu>
 <20231113114357.GD24338@pendragon.ideasonboard.com> <da6efe14-c00d-4bf4-bf61-dd4ed39c5c60@xs4all.nl>
 <20231113124412.GA18974@pendragon.ideasonboard.com> <b35601f7-8bb2-4317-a8f7-6fbf81572943@xs4all.nl>
In-Reply-To: <b35601f7-8bb2-4317-a8f7-6fbf81572943@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 15 Nov 2023 17:45:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CjnvDh1t9N+xbnQD4HuJoYwA0gtKUQPCy-6EF=Oy-rGA@mail.gmail.com>
Message-ID: <CAAFQd5CjnvDh1t9N+xbnQD4HuJoYwA0gtKUQPCy-6EF=Oy-rGA@mail.gmail.com>
Subject: Re: [PATCH v9 10/15] media: uapi: Add V4L2_CTRL_TYPE_FIXED_POINT
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 5:09=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> Hi Laurent,
>
> On 13/11/2023 13:44, Laurent Pinchart wrote:
> > Hi Hans,
> >
> > On Mon, Nov 13, 2023 at 01:05:12PM +0100, Hans Verkuil wrote:
> >> On 13/11/2023 12:43, Laurent Pinchart wrote:
> >>> On Mon, Nov 13, 2023 at 11:28:51AM +0000, Sakari Ailus wrote:
> >>>> On Mon, Nov 13, 2023 at 12:24:14PM +0100, Hans Verkuil wrote:
> >>>>> On 13/11/2023 12:07, Laurent Pinchart wrote:
> >>>>>> On Mon, Nov 13, 2023 at 11:56:49AM +0100, Hans Verkuil wrote:
> >>>>>>> On 13/11/2023 11:42, Laurent Pinchart wrote:
> >>>>>>>> On Mon, Nov 13, 2023 at 11:29:09AM +0100, Hans Verkuil wrote:
> >>>>>>>>> On 10/11/2023 06:48, Shengjiu Wang wrote:
> >>>>>>>>>> Fixed point controls are used by the user to configure
> >>>>>>>>>> a fixed point value in 64bits, which Q31.32 format.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >>>>>>>>>
> >>>>>>>>> This patch adds a new control type. This is something that also=
 needs to be
> >>>>>>>>> tested by v4l2-compliance, and for that we need to add support =
for this to
> >>>>>>>>> one of the media test-drivers. The best place for that is the v=
ivid driver,
> >>>>>>>>> since that has already a bunch of test controls for other contr=
ol types.
> >>>>>>>>>
> >>>>>>>>> See e.g. VIVID_CID_INTEGER64 in vivid-ctrls.c.
> >>>>>>>>>
> >>>>>>>>> Can you add a patch adding a fixed point test control to vivid?
> >>>>>>>>
> >>>>>>>> I don't think V4L2_CTRL_TYPE_FIXED_POINT is a good idea. This se=
ems to
> >>>>>>>> relate more to units than control types. We have lots of fixed-p=
oint
> >>>>>>>> values in controls already, using the 32-bit and 64-bit integer =
control
> >>>>>>>> types. They use various locations for the decimal point, dependi=
ng on
> >>>>>>>> the control. If we want to make this more explicit to users, we =
should
> >>>>>>>> work on adding unit support to the V4L2 controls.
> >>>>>>>
> >>>>>>> "Fixed Point" is not a unit, it's a type. 'Db', 'Hz' etc. are uni=
ts.
> >>>>>>
> >>>>>> It's not a unit, but I think it's related to units. My point is th=
at,
> >>>>>> without units support, I don't see why we need a formal definition=
 of
> >>>>>> fixed-point types, and why this series couldn't just use
> >>>>>> VIVID_CID_INTEGER64. Drivers already interpret VIVID_CID_INTEGER64
> >>>>>> values as they see fit.
> >>>>>
> >>>>> They do? That's new to me. A quick grep for V4L2_CTRL_TYPE_INTEGER6=
4
> >>>>> (I assume you meant that rather than VIVID_CID_INTEGER64) shows tha=
t it
> >>>
> >>> Yes, I meant V4L2_CTRL_TYPE_INTEGER64. Too hasty copy & paste :-)
> >>>
> >>>>> is always interpreted as a 64 bit integer and nothing else. As it s=
hould.
> >>>
> >>> The most common case for control handling in drivers is taking the
> >>> integer value and converting it to a register value, using
> >>> device-specific encoding of the register value. It can be a fixed-poi=
nt
> >>> format or something else, depending on the device. My point is that
> >>> drivers routinely convert a "plain" integer to something else, and th=
at
> >>> has never been considered as a cause of concern. I don't see why it
> >>> would be different in this series.
> >>>
> >>>>> And while we do not have support for units (other than the document=
ation),
> >>>>> we do have type support in the form of V4L2_CTRL_TYPE_*.
> >>>>>
> >>>>>>> A quick "git grep -i "fixed point" Documentation/userspace-api/me=
dia/'
> >>>>>>> only shows a single driver specific control (dw100.rst).
> >>>>>>>
> >>>>>>> I'm not aware of other controls in mainline that use fixed point.
> >>>>>>
> >>>>>> The analog gain control for sensors for instance.
> >>>>>
> >>>>> Not really. The documentation is super vague:
> >>>>>
> >>>>> V4L2_CID_ANALOGUE_GAIN (integer)
> >>>>>
> >>>>>   Analogue gain is gain affecting all colour components in the pixe=
l matrix. The
> >>>>>   gain operation is performed in the analogue domain before A/D con=
version.
> >>>>>
> >>>>> And the integer is just a range. Internally it might map to some fi=
xed
> >>>>> point value, but userspace won't see that, it's hidden in the drive=
r AFAICT.
> >>>
> >>> It's hidden so well that libcamera has a database of the sensor it
> >>> supports, with formulas to map a real gain value to the
> >>> V4L2_CID_ANALOGUE_GAIN control. The encoding of the integer value doe=
s
> >>> matter, and the kernel doesn't expose it. We may or may not consider
> >>> that as a shortcoming of the V4L2 control API, but in any case it's t=
he
> >>> situation we have today.
> >>>
> >>>> I wonder if Laurent meant digital gain.
> >>>
> >>> No, I meant analog. It applies to digital gain too though.
> >>>
> >>>> Those are often Q numbers. The practice there has been that the defa=
ult
> >>>> value yields gain of 1.
> >>>>
> >>>> There are probably many other examples in controls where something b=
eing
> >>>> controlled isn't actually an integer while integer controls are stil=
l being
> >>>> used for the purpose.
> >>>
> >>> A good summary of my opinion :-)
> >>
> >> And that works fine as long as userspace doesn't need to know what the=
 value
> >> actually means.
> >>
> >> That's not the case here. The control is really a fractional Hz value:
> >>
> >> +``V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET (fixed point)``
> >> +    Sets the offset from the audio source sample rate, unit is Hz.
> >> +    The offset compensates for any clock drift. The actual source aud=
io sample
> >> +    rate is the ideal source audio sample rate from
> >> +    ``V4L2_CID_M2M_AUDIO_SOURCE_RATE`` plus this fixed point offset.
> >
> > I don't see why this would require a new type, you can use
> > V4L2_CTRL_TYPE_INTEGER64, and document the control as containing
> > fixed-point values in Q31.32 format.
>
> Why would you want to do this? I can store a double in a long long int,
> and just document that the variable is really a double, but why would you=
?
>
> The cost of adding a FIXED_POINT type is minimal, and having this type
> makes it easy to work with fixed point controls (think about proper repor=
ting
> and setting of the value in v4l2-ctl and user applications in general tha=
t
> deal with controls).

I can see one potential drawback of adding a new type - userspace
would have to be made aware of it, although arguably with brand new
controls, userspace would have to be aware of them anyway. Not sure if
we have some kind of userspace that can handle any controls purely
based on their type - if yes, they would not be able to handle the new
controls.

>
> If this would add a thousand lines of complex code, then this would be a
> consideration, but this is just a few lines.
>
> Just to give an example, if you use 'v4l2-ctl -l' to list a int64 control
> and it reports the value 13958643712, would you be able to see that that =
is
> really 3.25 in fixed point format? With the right type it would be printe=
d
> like that. Much easier to work work.
>
> Regards,
>
>         Hans
>
> >
> >>>> Instead of this patch, I'd prefer to have a way to express the meani=
ng of
> >>>> the control value, be it a Q number or something else, and do that
> >>>> independently of the type of the control.
> >>
> >> Huh? How is that different from the type of the control? You have inte=
gers
> >> (one type) and fixed point (another type).
> >>
> >> Or do you want a more general V4L2_CTRL_TYPE_ that specifies the N.M v=
alues
> >> explicitly?
> >>
> >> I think the main reason why we use integer controls for gain is that w=
e
> >> never had a fixed point control type and you could get away with that =
in
> >> user space for that particular use-case.
> >>
> >> Based on the V4L2_CID_NOTIFY_GAINS documentation the gain value can ty=
pically
> >> be calculated as (value / default_value),
> >
> > Typically, but not always. Some sensor have an exponential gain model,
> > and some have weird gain representation, such as 1/x. That's getting ou=
t
> > of scope though.
> >
> >> but that won't work for a rate offset
> >> control as above, or for e.g. CSC matrices for color converters.
> >>
> >>> Agreed.
> >>>
> >>>>> In the case of this particular series the control type is really a =
fixed point
> >>>>> value with a documented unit (Hz). It really is not something you w=
ant to
> >>>>> use type INTEGER64 for.
> >>>>>
> >>>>>>> Note that V4L2_CTRL_TYPE_FIXED_POINT is a Q31.32 format. By setti=
ng
> >>>>>>> min/max/step you can easily map that to just about any QN.M forma=
t where
> >>>>>>> N <=3D 31 and M <=3D 32.
> >>>>>>>
> >>>>>>> In the case of dw100 it is a bit different in that it is quite sp=
ecialized
> >>>>>>> and it had to fit in 16 bits.
> >
>
