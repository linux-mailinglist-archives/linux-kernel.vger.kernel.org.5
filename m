Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ECE7F3EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjKVHfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVHfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:35:44 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F19F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:35:41 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5cbcfdeaff3so13595127b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700638540; x=1701243340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lUZAaiUOw0C5H3gndMumbia7PfIimHYq+ovFLumPTQE=;
        b=J4DQUqkmvE2pyXpQGK8Ogfc8mgDa3bLToXGsYi9Q8bX9+kUuYIGwdb7jMywLduwhe7
         El87pya8Wh8jcLvJpzyu+BDW5tbxmPjjyetQc6a4TPcJvdwwYs5trtRPesg0Z+jrR3pA
         k3fHKtI7bzj77NxUvJQCUdwSQuCGP/EY7MB8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700638540; x=1701243340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUZAaiUOw0C5H3gndMumbia7PfIimHYq+ovFLumPTQE=;
        b=AieBvjvHTsvuuHS0PVwlbFLHGWqY7NulCI7fER+Okbti3lWKnDlNox1S//VhH2wrhr
         3tqrOUBunxtJWoY01SnxaUeYTWtRVVx+NXcp/Ssqv8LuDx/ksdHe1jI+Z44RHQRTrDuG
         nYjVLy4K98iYpd6bPi9Wxaf519WSFqmLBJWmkMWpWuvG0nPO592IS20UkhqfHSVbusRm
         WTAMjy4AZ6wYXgi/p5oeac0phm/NzhPxuDaHUPkSkqybT0r/3M+rifVKBFbmHbyN4l8z
         pc+dbdADQEsMZb2bljWC2vwHHSnuUv6TvsXalCR4OnxUTzlDemlwLNcDhzQibgh4U8/b
         MKwQ==
X-Gm-Message-State: AOJu0YzVuICx9A5qWmIyF9mgztRPtEOsZb/AGBrSmhT8xmHfvtA7ZNaI
        N83UMoSc5ZB1XRWAUd49aI2SQl6G+ZB0zrQZmgZLVQ==
X-Google-Smtp-Source: AGHT+IGdIEBGzfBq+aNTlJBojJGY5OQ0ot2MYrxA/vh6ZFym86KBri051qCPZy3UtboWBjSAzlqYPQ==
X-Received: by 2002:a81:a503:0:b0:5cb:246a:736f with SMTP id u3-20020a81a503000000b005cb246a736fmr1285231ywg.38.1700638539696;
        Tue, 21 Nov 2023 23:35:39 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id u145-20020a817997000000b005c858847fcbsm3405181ywc.35.2023.11.21.23.35.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 23:35:39 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5cc66213a34so3615827b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:35:39 -0800 (PST)
X-Received: by 2002:a81:65d4:0:b0:59a:d42c:5d50 with SMTP id
 z203-20020a8165d4000000b0059ad42c5d50mr1265775ywb.52.1700638538563; Tue, 21
 Nov 2023 23:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-1-d8a5eae2312b@chromium.org> <20231122072108.GA1465745@google.com>
In-Reply-To: <20231122072108.GA1465745@google.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 08:35:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCunwy4wYL3-J5KNp4cG4mGsq8FtoyJ6hOr3VK+9+L2LgA@mail.gmail.com>
Message-ID: <CANiDSCunwy4wYL3-J5KNp4cG4mGsq8FtoyJ6hOr3VK+9+L2LgA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] media: uvcvideo: Always use uvc_status_stop()
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey

On Wed, 22 Nov 2023 at 08:21, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/11/21 19:53), Ricardo Ribalda wrote:
> > uvc_status_stop() handles properly the race conditions with the
> > asynchronous worker.
> > Let's use uvc_status_stop() for all the code paths that require stopping
> > it.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c   | 4 ----
> >  drivers/media/usb/uvc/uvc_status.c | 2 +-
> >  2 files changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index e59a463c2761..8e22a07e3e7b 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -2765,10 +2765,6 @@ void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> >       struct uvc_entity *entity;
> >       unsigned int i;
> >
> > -     /* Can be uninitialized if we are aborting on probe error. */
> > -     if (dev->async_ctrl.work.func)
> > -             cancel_work_sync(&dev->async_ctrl.work);
> > -
> >       /* Free controls and control mappings for all entities. */
> >       list_for_each_entry(entity, &dev->entities, list) {
> >               for (i = 0; i < entity->ncontrols; ++i) {
> > diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> > index a78a88c710e2..0208612a9f12 100644
> > --- a/drivers/media/usb/uvc/uvc_status.c
> > +++ b/drivers/media/usb/uvc/uvc_status.c
> > @@ -292,7 +292,7 @@ int uvc_status_init(struct uvc_device *dev)
> >
> >  void uvc_status_unregister(struct uvc_device *dev)
> >  {
> > -     usb_kill_urb(dev->int_urb);
> > +     uvc_status_stop(dev);
>
> Sort of feels like this needs dev->lock somewhere here. Should we move 3/3
> to the head of the series?
>
> The question is, can this be called in parallel with uvc_v4l2_release(),
> for instance?

I can be called in parallel with uvc_v4l2_release(), but
uvc_status_stop() is thread-safe and does not take any locks after:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=619d9b710cf06f7a00a17120ca92333684ac45a8

So this "should" be good. key-word here is should :P


>
> >       uvc_input_unregister(dev);
> >  }



-- 
Ricardo Ribalda
