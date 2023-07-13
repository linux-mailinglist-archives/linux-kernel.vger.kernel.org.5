Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6575232D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjGMNQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjGMNQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA201BC9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689254150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+W653bQgYnkrDlOyPaGyC+VUCI2YgiP6l1CnjaSmytU=;
        b=Fdjwc3v2+cWNyYfFTzmUPg1Eyter38stwduUTZec0rQ+XIoMb7ljtJSxBg5jIU3mZoZmBG
        cDJQ+AkHICupzRPdJtfQ2v+ONAyxMCt2vcF5YF39dpIPvmG1SFORgUg5LqC8W1Z+xtCYb2
        al3F5z87+HylQ8AigDeiPrE5aelHka8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-v5TEijVlMMOSrSsO4zuCqA-1; Thu, 13 Jul 2023 09:15:49 -0400
X-MC-Unique: v5TEijVlMMOSrSsO4zuCqA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-314326f6e23so453945f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689254148; x=1691846148;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W653bQgYnkrDlOyPaGyC+VUCI2YgiP6l1CnjaSmytU=;
        b=BNOGI/r9Czj4pBw8d9SRTcBtqgcOzmPH2bD87IUGgWYqDp3gJ8p+jQ41HG647vFd7m
         YpwCxycTFzkdO2biilHiAkiSk6w57TtHdcOcG4u/jRBtS9iQ1sNua5PaNiYrcN2tkV5T
         8v++rL0zO6NNgzDTcta41pE7Wl3QrVSWVYNE4HdlAwhmy0Ix6h9/5qOxwitzhqsCzvbS
         KW1lw92EEdFSExdOEuQHGVoEEXFgXLsynQrXhfyI/0Va+cR2urFZef0ZPAPw5Op06kU5
         htqNRjLZL0kYJXqjos/87P2MaV1kYcYv6+11d4/hsewlxgS0HSKgKHHkQ5TTlT++faVv
         50rQ==
X-Gm-Message-State: ABy/qLZhV1hJMT2rAzI7iirNCIAuJmh38OkTIX9I1f4lJu25d6w7kAM2
        FGUsCm4R/aeYlFajM7HyUlgZ29ehSBwr31pDPVNSIOH/nVpEoRZcaXHQMVVw9wC+s1KdPZZ5mjC
        8W2tkDH2JvHx/uXvpayzTj/dF
X-Received: by 2002:a5d:6603:0:b0:313:ee2e:dae1 with SMTP id n3-20020a5d6603000000b00313ee2edae1mr1377229wru.18.1689254147837;
        Thu, 13 Jul 2023 06:15:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGcwH17n+61+faw0EOmRZrjFZUmAq9pqWras4eL7iwT2iWWC+qh/xr6DBkUXMGcDHuJWJH95Q==
X-Received: by 2002:a5d:6603:0:b0:313:ee2e:dae1 with SMTP id n3-20020a5d6603000000b00313ee2edae1mr1377213wru.18.1689254147547;
        Thu, 13 Jul 2023 06:15:47 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k4-20020a056000004400b00314326c91e2sm8002635wrx.28.2023.07.13.06.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 06:15:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/5] drm/ssd130x: Don't allocate buffers on each
 plane update
In-Reply-To: <CAMuHMdVXhi52KfpCmnum+9t74UWP+AOLE95xQU6VV6Nz=VHk1Q@mail.gmail.com>
References: <20230609170941.1150941-1-javierm@redhat.com>
 <20230609170941.1150941-5-javierm@redhat.com>
 <CAMuHMdVXhi52KfpCmnum+9t74UWP+AOLE95xQU6VV6Nz=VHk1Q@mail.gmail.com>
Date:   Thu, 13 Jul 2023 15:15:46 +0200
Message-ID: <87fs5sgdfh.fsf@minerva.mail-host-address-is-not-set>
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
> On Fri, Jun 9, 2023 at 7:09=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The resolutions for these panels are fixed and defined in the Device Tre=
e,
>> so there's no point to allocate the buffers on each plane update and that
>> can just be done once.
>>
>> Let's do the allocation and free on the encoder enable and disable helpe=
rs
>> since that's where others initialization and teardown operations are don=
e.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>
>> (no changes since v1)
>
> Thanks for your patch, which is now commit 49d7d581ceaf4cf8
> ("drm/ssd130x: Don't allocate buffers on each plane update") in
> drm-misc/for-linux-next.
>
>> --- a/drivers/gpu/drm/solomon/ssd130x.c
>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>> @@ -701,14 +709,22 @@ static void ssd130x_encoder_helper_atomic_enable(s=
truct drm_encoder *encoder,
>>                 return;
>>
>>         ret =3D ssd130x_init(ssd130x);
>> -       if (ret) {
>> -               ssd130x_power_off(ssd130x);
>> -               return;
>> -       }
>> +       if (ret)
>> +               goto power_off;
>> +
>> +       ret =3D ssd130x_buf_alloc(ssd130x);
>
> This appears to be too late, causing a NULL pointer dereference:
>

Thanks for reporting this issue.

> [   59.302761] [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
> [   59.304231] [<c0304200>]
> ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
> [   59.305716] [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
>

I wonder how this could be too late. I thought that the encoder
.atomic_enable callback would be called before any plane .atomic_update.

> Bailing out from ssd130x_update_rect() when data_array is still NULL
> fixes that.
>

Maybe we can add that with a drm_WARN() ? I still want to understand how
a plane update can happen before an encoder enable.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

