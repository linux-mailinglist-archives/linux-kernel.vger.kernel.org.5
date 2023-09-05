Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2521792A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbjIEQiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354791AbjIEOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:24:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E274189
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:24:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso3495579a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693923852; x=1694528652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVp7mkHXr+2wOrv7T4nMYTKfiU2Rr3GKiul2WMppLoU=;
        b=ZlRWyXnuO+BrDfbMBq01Cwa5R9LQRjuAt4zmH6Il52gYCLtQO5i/En92+4LDoylMAd
         QdBtsJjb+YgSTAj5+In7MVl7cmMM3tmCW86u3w7ruXGaW3HaEq7KtbKNXZZzH6bKxKYf
         ftsZ6zjnkUnKAy/em/joUaitSJBp8gXMGic+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693923852; x=1694528652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVp7mkHXr+2wOrv7T4nMYTKfiU2Rr3GKiul2WMppLoU=;
        b=D7KGinlZRYqU5+m5Uy79WBvhX5SGaYtEv7SJSWzMGhA/h+BqCpvpwOw9dWHoLE0BmV
         TAPfLTu1obWDvt8jC3tVnrmCHooxEwNi02m5rpsayYQA8ZQnSFwfmXb6a5CqpCaJzNeZ
         T9KiPLTudINblxgDQHDnf+1Hyii/JKgDh16aiKVztoTu8iF+2wb2jSisRfIknR66zax2
         kP/gkHm/EOdmCVYR7AVhmztPOqbgTrgLnYqKXwmwTnc/UuJUjZN8iv55814HyL4jZmyi
         1CMgMX3zdFU7fHiEc+69q+hxaKGc2ttP27/Tz57VFyEky0xWabVyfbYiztZN+JPh9UgH
         EG/Q==
X-Gm-Message-State: AOJu0YyiLpunJv/chIPeh04nSYb+ZDtPZTCI/O2MXtjgbEiXTtYjkhSQ
        1+mBbHTJ1j2+lRrfod6PALY/htLvxXLT0eDUMysF5A==
X-Google-Smtp-Source: AGHT+IFX8rb821OgcFc8qIcK62JuBl4SmmQIijoBDyGywsfrPN6CIkneUdX5ggtEweb0xyJ06tUReQ==
X-Received: by 2002:aa7:d790:0:b0:52b:daff:f702 with SMTP id s16-20020aa7d790000000b0052bdafff702mr10127953edq.16.1693923852287;
        Tue, 05 Sep 2023 07:24:12 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id v18-20020a056402349200b0052e1783ab25sm3182690edc.70.2023.09.05.07.24.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 07:24:11 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso179425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 07:24:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3d0c:b0:3f7:3e85:36a with SMTP id
 bh12-20020a05600c3d0c00b003f73e85036amr264789wmb.7.1693923851202; Tue, 05 Sep
 2023 07:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.1.I3d5598bd73a59b5ded71430736c93f67dc5dea61@changeid> <ZPSsBhbekKY7VyDg@shell.armlinux.org.uk>
In-Reply-To: <ZPSsBhbekKY7VyDg@shell.armlinux.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Sep 2023 07:23:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WT4Hf1XVA641WtNFg4WRYFKarU1WOkLPEbr0eiVQuZPg@mail.gmail.com>
Message-ID: <CAD=FV=WT4Hf1XVA641WtNFg4WRYFKarU1WOkLPEbr0eiVQuZPg@mail.gmail.com>
Subject: Re: [RFT PATCH 01/15] drm/armada: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 3, 2023 at 8:53=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Sep 01, 2023 at 04:41:12PM -0700, Douglas Anderson wrote:
> > Based on grepping through the source code this driver appears to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > time. Among other things, this means that if a panel is in use that it
> > won't be cleanly powered off at system shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart comes straight out of the kernel doc "driver
> > instance overview" in drm_drv.c.
> >
> > This driver was fairly easy to update. The drm_device is stored in the
> > drvdata so we just have to make sure the drvdata is NULL whenever the
> > device is not bound.
>
> ... and there I think you have a misunderstanding of the driver model.
> Please have a look at device_unbind_cleanup() which will be called if
> probe fails, or when the device is removed (in other words, when it is
> not bound to a driver.)

...and there I think you didn't read this patch closely enough and
perhaps that you have a misunderstanding of the component model.
Please have a look at the difference between armada_drm_unbind() and
armada_drm_remove() and also check which of those two functions is
being modified by my patch. Were this patch adding a call to
"dev_set_drvdata(dev, NULL)" in armada_drm_remove() then your NAK
would be justified. However, I am not aware of anything in the
component unbind path nor in the failure case of component bind that
would NULL the drvdata.

Kindly look at the patch a second time with this in mind.

-Doug
