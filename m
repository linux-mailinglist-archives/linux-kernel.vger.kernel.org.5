Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7E762B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjGZG0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjGZGZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:25:58 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A0C1982
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:25:54 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63cff46ddb8so2917746d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690352753; x=1690957553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fIXZYAd4S4dWNQQy99R1f7KDCW04tYVv72JP0Q85d0Q=;
        b=mN0neb/4TNp31RpJzrR/eC6sZwsKTQXnWLV4BznWFAR5GVJwH2xgpNRv9QZWJ5bPJZ
         3nscHf1W64LmZeheNsRi3fk3ac6IlPBDe7T9Qgtle0bFJh/MJ5fwgw990MT0qPNKNCSO
         4ewZymj0rFjoyu7L2PgTVpLBMW4eUsXC5uxCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690352753; x=1690957553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIXZYAd4S4dWNQQy99R1f7KDCW04tYVv72JP0Q85d0Q=;
        b=JnHbU5uJujnCr4xG/+TWQO1Irwwtz9xqvCedqvn504U80tXYMbGY9B5Cb8dlhK4w5a
         HBojrSkIanrG1noE1mkLXXhA/e8Ag86idqU1FFxPNnVfHus/KO2BKp0MBe3JwuRvRRO3
         NSdMhK8hCfco0Rf9uGhnDHEk9DpXAzx+ahk5xn26wcBzLNUTtc6oJka0iP0Aw2uk6tgF
         VjikVL1f/dAdG510OpyJSQjw6/uw9wnqqx2vLu6QodfBCdKXDQzglaLJORkEc2OBgLfY
         3uhKG+7KYugJB3xqVPmrT4F55FwHdY2tOISKrrvPZnWQrQM6BLT3EOYBpbPMTJsiezUR
         m3Aw==
X-Gm-Message-State: ABy/qLaAdKgTReyCg3ppQC6udqdG6f3RjZ7brURd1h5JAzLMnFSu7hoP
        aQGFXWp2kuqFGBFIA+z1SgHajmJ9gLLcRcQfmbCv5A==
X-Google-Smtp-Source: APBJJlF4Ef7/wO5yj/RazzIvLDurn/WZ/oTttGLx4YVrG56Ofmoi73DD47kYDGhJFMssJOs8nNx4ww==
X-Received: by 2002:a0c:dd8d:0:b0:62d:ed66:7ad1 with SMTP id v13-20020a0cdd8d000000b0062ded667ad1mr1801041qvk.28.1690352753281;
        Tue, 25 Jul 2023 23:25:53 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id o8-20020a0ccb08000000b00636291d04adsm1952993qvk.47.2023.07.25.23.25.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 23:25:19 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-63cff46ddb8so2915686d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:25:04 -0700 (PDT)
X-Received: by 2002:a05:6214:124e:b0:623:8494:9945 with SMTP id
 r14-20020a056214124e00b0062384949945mr5700539qvv.26.1690352702309; Tue, 25
 Jul 2023 23:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230717-uvc-oob-v2-1-c7745a8d5847@chromium.org> <20230725213451.GU31069@pendragon.ideasonboard.com>
In-Reply-To: <20230725213451.GU31069@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Jul 2023 08:24:50 +0200
X-Gmail-Original-Message-ID: <CANiDSCttkqows7PZS823Jpk-CqK9Gz2rujF_R4SPDi=wcPJ2LA@mail.gmail.com>
Message-ID: <CANiDSCttkqows7PZS823Jpk-CqK9Gz2rujF_R4SPDi=wcPJ2LA@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Fix OOB read
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@kernel.org, Zubin Mithra <zsm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

Thanks for the review!

On Tue, 25 Jul 2023 at 23:34, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Thu, Jul 20, 2023 at 05:46:54PM +0000, Ricardo Ribalda wrote:
> > If the index provided by the user is bigger than the mask size, we might do an
> > out of bound read.
> >
> > CC: stable@kernel.org
> > Fixes: 40140eda661e ("media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU")
> > Reported-by: Zubin Mithra <zsm@chromium.org>
>
> checkpatch now requests a Reported-by tag to be immediately followed by
> a Closes tag that contains the URL to the report. Could you please
> provide that ?
>
I saw that, but the URL is kind of private:

Closes: http://issuetracker.google.com/issues/289975230

> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Avoid reading index >= 31
> > ---
> > Changes in v2:
> > - Use BITS_PER_TYPE instead of 32 (thanks Sergey).
> > - Add Reported-by tag.
> > - Link to v1: https://lore.kernel.org/r/20230717-uvc-oob-v1-1-f5b9b4aba3b4@chromium.org
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 5e9d3da862dd..e59a463c2761 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1402,6 +1402,9 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
> >       query_menu->id = id;
> >       query_menu->index = index;
> >
> > +     if (index >= BITS_PER_TYPE(mapping->menu_mask))
> > +             return -EINVAL;
> > +
>
> I'd move this a few lines up, before setting query_menu.
>

SGTM, I just wanted to clear all the fields to mimic the other error
paths of the function.

> With those minor changes,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> There's no need for a v3, I can handle the changes locally, but I need
> the URL for the Closes tag.
>
> >       ret = mutex_lock_interruptible(&chain->ctrl_mutex);
> >       if (ret < 0)
> >               return -ERESTARTSYS;
> >
> > ---
> > base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
> > change-id: 20230717-uvc-oob-4b0148a00417
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
