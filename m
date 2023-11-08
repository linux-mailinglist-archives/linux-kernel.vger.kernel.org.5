Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DD07E607C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjKHWrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKHWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:47:00 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8192129
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 14:46:58 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9ac9573274so291884276.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699483617; x=1700088417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kasTMy/fe+OtJRFIni156cJ9mNbjQLd1RyatLG2PiIA=;
        b=YLXUu8sh2eqKIx9/J1YmqveMK9rQfT2KQgUft4HXgCaAIUCWuClsDQQFTedC8HKpx0
         F/Dz6JKxaeVJR0xwquRaoaiR0o4VqrUBVlpm1uGaXuV58JRZLg1HUeOyPqXiiTn7a/SU
         Edxat2xNnKEZamBLQs+aI/U3gQ99dsM0+wSvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699483617; x=1700088417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kasTMy/fe+OtJRFIni156cJ9mNbjQLd1RyatLG2PiIA=;
        b=uTwHtjHrYCgC+wxaRBApMfVlB6+u55Qr30Mg5YpuNWGiwX8tZiuPURix1dD3ZA1nKB
         47LpkeMq6nTM69P+u/zb8IWD16ljUcU3DE4Owem1sZ8GDPM7ghMpF/sYTNE25uTyO9fM
         vwzjdsGw/xJBQOjKHN7mwL6iaNAKJiGtVXplHDkgf5b7NxjZBJL6ypejSjLq2MC2JbyW
         JFDemBj3vTzM5aGqRNd5QZIs/rj3Y1neAaKGE0S1Zfhpvz8i+gr55PwLlTlmjkTJkhxv
         /aj0LJthOV7kPh+9psg3rO1hpIHFKJ37daIclNFodWQUa/4h22cZFq7UUUmc6tVE/NCy
         EvHg==
X-Gm-Message-State: AOJu0Yz/5njhgzMw8BJUmMOD6egSC5ZfOqcafMxo1qXvNJPrloFU7UEu
        XguruCXGw9FFANyJuEbHnTKrXzyT5gp4+HANi4P4Hw==
X-Google-Smtp-Source: AGHT+IGVVTaz/2RKcL+pjdw6Z2na7+5uwL7VwgfWoZqupvUCQPEBayU3CsDidUd27sBqnoFZUEkcNg==
X-Received: by 2002:a25:cc4f:0:b0:da3:74d8:48bf with SMTP id l76-20020a25cc4f000000b00da374d848bfmr3388973ybf.37.1699483617153;
        Wed, 08 Nov 2023 14:46:57 -0800 (PST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id d4-20020a0ce704000000b0066d04196c39sm1523230qvn.81.2023.11.08.14.46.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 14:46:56 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67131800219so1585536d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 14:46:55 -0800 (PST)
X-Received: by 2002:ad4:5f4e:0:b0:656:3612:7954 with SMTP id
 p14-20020ad45f4e000000b0065636127954mr3631272qvg.1.1699483615502; Wed, 08 Nov
 2023 14:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
 <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu> <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
 <fe672e31315b8f9c44a693c909d464a299e76093.camel@ndufresne.ca>
 <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
 <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com> <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
In-Reply-To: <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 8 Nov 2023 23:46:40 +0100
X-Gmail-Original-Message-ID: <CANiDSCunRRyod3Rg+L9ZsffOZyC7CKbMVTHX3u-n5iuNyZQk0w@mail.gmail.com>
Message-ID: <CANiDSCunRRyod3Rg+L9ZsffOZyC7CKbMVTHX3u-n5iuNyZQk0w@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
To:     nicolas@ndufresne.ca
Cc:     Esker Wong <esker@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Esker Wong <esker@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas

On Wed, 8 Nov 2023 at 21:32, <nicolas@ndufresne.ca> wrote:
>
> The fact that you interpret the time from FRAME_SYNC to DQBUF (well the
> READ IO notification) as the actual latency is yours of course. It
> assumes that the camera on the other end does not introduce other

We want to use this signal to measure how much power is used since we
start receiving the frame until we can use it.
I agree with you that the latency between capture and dqbuf should be
measured using the timestamp. That is not our use case here.

> source of latency (or that these are negligible). You are also going to
> introduce a lot of jitter, since it relies on when the OS decides to
> wake up your process.

We have measured a jitter of around 2.5 msec, which is acceptable for our needs.

>
> I think my opinion resides in if you can accurately *enough* implement
> what the spec says for FRAME_SYNC then do it, otherwise just don't lie.

What the specs says is:
```
Triggered immediately when the reception of a frame has begun
```
In my opinion, that is true for usb devices, we are triggering it as
soon as the transfer has started to the eyes of the driver. We cannot
trigger earlier than that.


> I think for ISO, "after the first chunk" i a small lie, but acceptable.
> But for BULK, the way it was explained is that it will be always very
> close to DQBUF time. and it should not emit FRAME_SYNC for this type of
> UVC device. If it fits other events fine of course, I'm just making a
> judgment on if its fits V4L2_EVENT_FRAME_SYNC or not.

nit: I believe that you have swapped iso and bulk on this description

>
> In term of accuracy, if timestamp was passed with the FRAME_SYNC event,
> it would not matter how fast your process the event anymore and greatly
> improve accuracy.

+1 to that. If we could easily change the uAPI for FRAME_SYNC that
should definitely be implemented.

>
> >
> > Not to mention that the UVC timestamping requires a bit of love.
> >
> > @Laurent Pinchart, @Kieran Bingham  any progress reviewing :P :
> > https://patchwork.linuxtv.org/project/linux-media/list/?series=10083
>
> Thanks for working on this by the way, hope someone will find the time
> to review this. The timestamps should in theory provide a jitter free

It already has a couple of Reviewed-by stamped in.... ;)

> measurement of the delay Esker is trying to measure, and if it wasn't
> of bugs (and crazy complexity) it would in the worst case match the
> transfer time.

Sorry to repeat myself, but just to avoid the confusion: Esker needs
to know how much power is used since we start receiving a frame until
it is available for dqbuf, not de frame latency.

Regards!
>
> Nicolas
>
