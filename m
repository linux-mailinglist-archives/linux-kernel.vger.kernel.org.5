Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971D47534C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjGNIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjGNIJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1313590
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689322029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+9ZBEjT3mFJea6YptXe/CBaBHfnJsPQnoZEZ+DpvPs=;
        b=Ow669B2RPwtRufEkrH+DIruk5erl4LMYHiBtPulUTaG5zZkwEt6wXdCsK8C4NFnbkLQYjL
        B6+USE3Tk3rbdoB947kU0DZMoZrJ1RMSnKnd4PDB3E2FdF+IPwhpQFnvWcgEGxwin0jVfy
        quR4ufyxG2cvFKvcjB0bf+hpPz3rr+Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-0ua4jPjLNkONWG-yHejRjg-1; Fri, 14 Jul 2023 03:53:40 -0400
X-MC-Unique: 0ua4jPjLNkONWG-yHejRjg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-315926005c9so985550f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321219; x=1691913219;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+9ZBEjT3mFJea6YptXe/CBaBHfnJsPQnoZEZ+DpvPs=;
        b=SAMfsjYW2GJV0ZK2OPlS9o+5ZrP7cjduNgKxCQM77GZLKQASKHN3bzRjYcAWDLetIx
         /FAgxxeMxJ+bQ81M4UIRzsunfCkPnQvHgxYkzIlXw+2RCynCLFh8MuX5dWRemaJ6DXGk
         de3b7iUBctrIb72oiME/iIaLiPIBEdcP0Y2z2rGaCIKtGZ94/dk9JTUc8ri1AnLFI373
         m40u46vAY88QQMLuQpMwxOi6NayBP4rNx051fv3m9J3lg0NxY1k4vc+jrL2bGSXSu+0C
         TRJXwjCOjtTe+6xHEpWd9SAgdgl4rBqXgkys71P4Yc15z4u9V3GDdCW4uKcYDKRFDtd8
         CG8w==
X-Gm-Message-State: ABy/qLYdt4IqPQmag2vIokEtiUF9B9PReVBRZ/qSpKDxJlWx+3LFzcVP
        wAjvC1l92Rr/TDpQYC2LPfD7pWfbXlQrkdTCyM+GZ0acePLQMlSeSTreGUeHBMzSobnnT5RR12O
        yFLhibYv5JqtfRDfzUWtPvMJh
X-Received: by 2002:a5d:4bcc:0:b0:314:11ab:11a0 with SMTP id l12-20020a5d4bcc000000b0031411ab11a0mr3311915wrt.34.1689321219589;
        Fri, 14 Jul 2023 00:53:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFADpuHUbZdK5ADJswylCCcQ4pxYAN8eI2QEsyDhW7qoWJSX8qkK3H+kEbsI7p7RxibRp7P/Q==
X-Received: by 2002:a5d:4bcc:0:b0:314:11ab:11a0 with SMTP id l12-20020a5d4bcc000000b0031411ab11a0mr3311905wrt.34.1689321219190;
        Fri, 14 Jul 2023 00:53:39 -0700 (PDT)
Received: from localhost ([90.167.94.6])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d560d000000b0031590317c26sm10103869wrv.61.2023.07.14.00.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:53:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Fix an oops when attempting to update a
 disabled plane
In-Reply-To: <CAMuHMdXbboXGYVezzw3_TEu8U6WR=q2x2NjD-aqeF91-DXOD3Q@mail.gmail.com>
References: <20230713163213.1028952-1-javierm@redhat.com>
 <CAMuHMdXbboXGYVezzw3_TEu8U6WR=q2x2NjD-aqeF91-DXOD3Q@mail.gmail.com>
Date:   Fri, 14 Jul 2023 09:53:38 +0200
Message-ID: <87ttu7szct.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Javier,
>
> On Thu, Jul 13, 2023 at 6:32=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert reports that the following NULL pointer dereference happens for him
>> after commit 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each
>> plane update"):
>>
>>     [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
>>     ssd130x-i2c 0-003c: [drm] surface width(128), height(32), bpp(1)
>>     and format(R1   little-endian (0x20203152))
>>     Unable to handle kernel NULL pointer dereference at virtual address =
00000000
>>     Oops [#1]
>>     CPU: 0 PID: 1 Comm: swapper Not tainted
>>     6.5.0-rc1-orangecrab-02219-g0a529a1e4bf4 #565
>>     epc : ssd130x_update_rect.isra.0+0x13c/0x340
>>      ra : ssd130x_update_rect.isra.0+0x2bc/0x340
>>     ...
>>     status: 00000120 badaddr: 00000000 cause: 0000000f
>>     [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
>>     [<c0304200>] ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
>>     [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
>>     [<c02f9314>] drm_atomic_helper_commit_tail+0x5c/0xb4
>>     [<c02f94fc>] commit_tail+0x190/0x1b8
>>     [<c02f99fc>] drm_atomic_helper_commit+0x194/0x1c0
>>     [<c02c5d00>] drm_atomic_commit+0xa4/0xe4
>>     [<c02cce40>] drm_client_modeset_commit_atomic+0x244/0x278
>>     [<c02ccef0>] drm_client_modeset_commit_locked+0x7c/0x1bc
>>     [<c02cd064>] drm_client_modeset_commit+0x34/0x64
>>     [<c0301a78>] __drm_fb_helper_restore_fbdev_mode_unlocked+0xc4/0xe8
>>     [<c0303424>] drm_fb_helper_set_par+0x38/0x58
>>     [<c027c410>] fbcon_init+0x294/0x534
>>     ...
>>
>> The problem is that fbcon calls fbcon_init() which triggers a DRM modeset
>> and this leads to drm_atomic_helper_commit_planes() attempting to commit
>> the atomic state for all planes, even the ones whose CRTC is not enabled.
>>
>> Since the primary plane buffer is allocated in the encoder .atomic_enable
>> callback, this happens after that initial modeset commit and leads to the
>> mentioned NULL pointer dereference.
>>
>> Fix this by not using the default drm_atomic_helper_commit_tail() helper,
>> but instead the drm_atomic_helper_commit_tail_rpm() function that doesn't
>> attempt to commit the atomic state for planes related to inactive CRTCs.
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>

Thanks for reporting the issue in the first place and for the testing!

>> --- a/drivers/gpu/drm/solomon/ssd130x.c
>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>> @@ -795,6 +795,10 @@ static const struct drm_mode_config_funcs ssd130x_m=
ode_config_funcs =3D {
>>         .atomic_commit =3D drm_atomic_helper_commit,
>>  };
>>
>> +static const struct drm_mode_config_helper_funcs ssd130x_mode_config_he=
lpers =3D {
>> +       .atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm,
>
> The docs say this is intended for drivers that support runtime_pm or
> need the CRTC to be enabled to perform a commit.  Might be worthwhile
> to add basic Runtime PM, so the I2C controller can go to sleep when
> the display is not used.
>

Indeed, I thought the same. But I believe we can do that as a follow-up pat=
ch.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

