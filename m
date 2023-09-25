Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BE47ADD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjIYREz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYREx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:04:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956EA107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:04:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32172a50356so6516696f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695661484; x=1696266284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kX39Ca8A6vbWsrSc61cEoyakqRV/gh0/WoLN88Nm/E=;
        b=Gz8BQBkdbg5rrf87gVpS5UyOR7X0XOmjWQaNwS14lB5VLYZOzBlyLf8ytI1Cnd4cP5
         n/T2wMo+Ixj04buDMfx/BR8hYRXmW+1NEhqvBeO4h9o1CsVOJ9uStzJoSs+YM7ysQO6p
         l3199YTk56/gx9zQf4wjy+n11MqzIfv4Nov4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695661484; x=1696266284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kX39Ca8A6vbWsrSc61cEoyakqRV/gh0/WoLN88Nm/E=;
        b=eWFGJ3aP8iWeIE4qHYgyX1TRTwWXemCxqsvNDSNjijwq7xxB73jFOAFBeRHI5FEgR+
         TXBqsV+dHAKKeYY+BKRAfsIbIAJGNI+7Y2RITSA7a3Kn1xqSYDK9L/wubuLQarf6Jpvn
         CE075ZCdhYlmNxXXh8FufYGSShIO35ECenhi+++tbjfjOkuCtN459BJkZ349TkV6XS4m
         3tV9yGDbu44+Zqk9e4dVwm4r0y56uxl3eGBEEzrr1x2K6v6xp8Oe22VRIZaiCEYq+hP0
         DK5aQ3OkEsjb5QKQ9nTaYOnftaZEY26b48j+DhuNWB2XqRCDafAGMGIyc0wd3Sm8BgOY
         vKaw==
X-Gm-Message-State: AOJu0YzYrir32ja8Kkogfdf1yR27EEo9gM4Bm5qMjPvRQuJpqzZRw3ob
        N60ryMf9eCxb0SxhCKZpeOmZe+Y1QUqPT7DRXK9Y9UiU
X-Google-Smtp-Source: AGHT+IGwutXOHA0/FjP2JCjFElf3auT6jcUJ4Wj0W2KZv/h6u1C0j22DHhKhF5rssjyJ9aX6/YXJNw==
X-Received: by 2002:a5d:5384:0:b0:31f:ef77:67e8 with SMTP id d4-20020a5d5384000000b0031fef7767e8mr6894970wrv.13.1695661484112;
        Mon, 25 Sep 2023 10:04:44 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b0099cc3c7ace2sm6646491ejb.140.2023.09.25.10.04.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 10:04:43 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so876a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:04:43 -0700 (PDT)
X-Received: by 2002:a50:a699:0:b0:525:573c:6444 with SMTP id
 e25-20020a50a699000000b00525573c6444mr6897edc.1.1695661483259; Mon, 25 Sep
 2023 10:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230921192749.1542462-1-dianders@chromium.org>
 <20230921122641.RFT.v2.7.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid> <BL1PR12MB514407EE7F9B23BC58E40A6CF7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514407EE7F9B23BC58E40A6CF7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Sep 2023 10:04:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK_tWO7Vr2FJiaVX11DwfS7+VhrUoGZa989U7y_vtKOg@mail.gmail.com>
Message-ID: <CAD=FV=UK_tWO7Vr2FJiaVX11DwfS7+VhrUoGZa989U7y_vtKOg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 07/12] drm/amdgpu: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <mripard@kernel.org>,
        "Zhang, Bokun" <Bokun.Zhang@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        "Zhu, James" <James.Zhu@amd.com>,
        "Zhao, Victor" <Victor.Zhao@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "mdaenzer@redhat.com" <mdaenzer@redhat.com>,
        "Zhang, Morris" <Shiwu.Zhang@amd.com>,
        "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 25, 2023 at 8:57=E2=80=AFAM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Douglas Anderson <dianders@chromium.org>
> > Sent: Thursday, September 21, 2023 3:27 PM
> > To: dri-devel@lists.freedesktop.org; Maxime Ripard <mripard@kernel.org>
> > Cc: Douglas Anderson <dianders@chromium.org>; Zhang, Bokun
> > <Bokun.Zhang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> > Zhu, James <James.Zhu@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>;
> > Pan, Xinhui <Xinhui.Pan@amd.com>; airlied@gmail.com; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; Koenig,
> > Christian <Christian.Koenig@amd.com>; daniel@ffwll.ch; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; jim.cromie@gmail.com; Ma, Le
> > <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; linux-
> > kernel@vger.kernel.org; maarten.lankhorst@linux.intel.com; Limonciello,
> > Mario <Mario.Limonciello@amd.com>; mdaenzer@redhat.com; Zhang,
> > Morris <Shiwu.Zhang@amd.com>; SHANMUGAM, SRINIVASAN
> > <SRINIVASAN.SHANMUGAM@amd.com>; tzimmermann@suse.de
> > Subject: [RFT PATCH v2 07/12] drm/amdgpu: Call
> > drm_atomic_helper_shutdown() at shutdown time
> >
> > Based on grepping through the source code this driver appears to be mis=
sing a
> > call to drm_atomic_helper_shutdown() at system shutdown time. Among
> > other things, this means that if a panel is in use that it won't be cle=
anly
> > powered off at system shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case o=
f OS
> > shutdown/restart comes straight out of the kernel doc "driver instance
> > overview" in drm_drv.c.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This commit is only compile-time tested.
> >
> > ...and further, I'd say that this patch is more of a plea for help than=
 a patch I
> > think is actually right. I'm _fairly_ certain that drm/amdgpu needs thi=
s call at
> > shutdown time but the logic is a bit hard for me to follow. I'd appreci=
ate if
> > anyone who actually knows what this should look like could illuminate m=
e, or
> > perhaps even just post a patch themselves!
> >
> > (no changes since v1)
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 ++
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 8f2255b3a38a..cfcff0b37466 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1104,6 +1104,7 @@ static inline struct amdgpu_device
> > *amdgpu_ttm_adev(struct ttm_device *bdev)  int amdgpu_device_init(struc=
t
> > amdgpu_device *adev,
> >                      uint32_t flags);
> >  void amdgpu_device_fini_hw(struct amdgpu_device *adev);
> > +void amdgpu_device_shutdown_hw(struct amdgpu_device *adev);
> >  void amdgpu_device_fini_sw(struct amdgpu_device *adev);
> >
> >  int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev); diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index a2cdde0ca0a7..fa5925c2092d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4247,6 +4247,16 @@ void amdgpu_device_fini_hw(struct
> > amdgpu_device *adev)
> >
> >  }
> >
> > +void amdgpu_device_shutdown_hw(struct amdgpu_device *adev) {
>
> This needs a better name since its only for displays.  Also maybe move it=
 into amdgpu_display.c since it's really about turning off the displays.  T=
hat said is this really even needed?  The driver already calls its suspend =
functionality to turn off all of the hardware and put it into a quiescent s=
tate before shutdown.  Basically shares the same code we use for suspend.

As per my comment above, for this driver, my patch was a "plea for
help". I have no idea if it's really needed or if suspend handles it.

My main concerns are:

a) If it's possible that someone out there is using this DRM driver
with a "drm_panel" then we need to make sure the panel gets disabled /
unprepared properly at shutdown time. The goal is to remove the
special logic in some panel drivers that disables the panel at
shutdown time. The guidance I got from Maxime is that we should be
relying on the DRM driver to disable panels at shutdown time and not
have extra per-panel code for it.

b) It is documented that DRM driers call drm_atomic_helper_shutdown()
at shutdown time. Even if things are working today, it's always
possible that something will change later and break for drivers that
aren't doing this.


If you're confident that everything is great for the "amdgpu" driver
then I'm happy to drop this patch and not consider it a blocker for
the eventual removal of the code in the individual panels drivers.

If, after reading this, you conclude that some sort of patch is
needed, I'd love it if you could test/post a patch yourself and then
I'll drop this patch from my series.


-Doug
