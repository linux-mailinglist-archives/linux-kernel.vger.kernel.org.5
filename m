Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EAC77F3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349840AbjHQJ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbjHQJ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505D2D7B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692266334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8LhOrW0WUa6CT60pjE8C+ol39HJMr426zMLoqg+/dY=;
        b=B+dqzvpmYeyHTkBI6yVuGmqWO/MNu6z4ZPF78vvVdSA/oIbnkIPxE+KtUpf7S4vECQLSFE
        t7sllDYJpJ8AdfgtnsqhFe7MSSlW3V8sLhg8/lqxNBD4/X1cmJPPFEnYmSezRseGSLAT3C
        rJyhbsz9h/4Oxsi/j9bpdGons+vD6rc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-XM0uLRC8MZmxh9fjRGkuxw-1; Thu, 17 Aug 2023 05:58:52 -0400
X-MC-Unique: XM0uLRC8MZmxh9fjRGkuxw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9d5bc6161so13732291fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692266331; x=1692871131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8LhOrW0WUa6CT60pjE8C+ol39HJMr426zMLoqg+/dY=;
        b=AwDIUucrzujGV2QThkHDllihGrOTVx19CUQYQC16PnYKOdf93PC32i2iL30b9ssK5C
         EDuPmi0QXkeTwTpRPLA4FAlQkK3McSnSad7N84vCGE5+iOcFkiujs6rxonR/+m95bsg/
         nPKJ6IXZiYTD/9UZf4vvhwQPOtla1uRZIOKmQgzeNuuRP+fTshLRYGuOVwwUHjbuOKZP
         NHwWVSYTjJebWpPgZ8VkAUcKJpTWoi/9bKW/RqN7dh6o04c3tjjFYb/8XduUWPB7OEvF
         +hbPwJwTe0wl3InpWbmZYfmZ3Tme943Q799MlfDJxghLBCGKsuYQVjOt8PC9ZhfDUDnv
         /I/A==
X-Gm-Message-State: AOJu0YymDPpIpnJn3k6BSAqK4hwZcYyNWPhfCTnk2FIONi9AvqiIWGhm
        uXjtnYyvZh0I/y+bY1YpaORW7X/R/3hAGDC5TG6STyEY/TeO1LyAo/OrKeQUF6gmzfNpVNv61jI
        oGiHW7I4siwAgMk05kw8BTbQnfpBdnVu1mGH8jKO9
X-Received: by 2002:a2e:bba2:0:b0:2b6:7c3a:6adc with SMTP id y34-20020a2ebba2000000b002b67c3a6adcmr2639033lje.5.1692266331505;
        Thu, 17 Aug 2023 02:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+OkqFqWypjUgZ0iljxcxYcRVfxwr2dkieuQVR8uoM+9sEf+VyJeMAJQEHmz2GuI9BiYnREEMjsnHLf9Gnm74=
X-Received: by 2002:a2e:bba2:0:b0:2b6:7c3a:6adc with SMTP id
 y34-20020a2ebba2000000b002b67c3a6adcmr2639023lje.5.1692266331198; Thu, 17 Aug
 2023 02:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230814144933.3956959-1-kherbst@redhat.com> <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
 <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
 <20230816145338.GIZNzi8o3d9x9bcPzX@fat_crate.local> <CACO55ttasKLxBTmZjN-XBOuJFC7rng2PbLgxCT8WT6ukOZNGzQ@mail.gmail.com>
 <20230816151252.GKZNzndDNySuWC+Vwz@fat_crate.local> <CACO55tunC5mEu3Tw64rKLqNM6MN6d=N90kYQKYwXWNMB=ahDaw@mail.gmail.com>
 <20230816221353.GXZN1KIXloRn8cGt5E@fat_crate.local> <CACO55ts7430tAUDC+0qY0EZ5ReO=2Rjwj1SzHaBLodmyBgrUrw@mail.gmail.com>
 <20230817081032.GAZN3V+NQ1blzQC2sU@fat_crate.local>
In-Reply-To: <20230817081032.GAZN3V+NQ1blzQC2sU@fat_crate.local>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 17 Aug 2023 11:58:40 +0200
Message-ID: <CACO55tv-dKnDzUYYFW+d2pNoAhEoEniUT=QAmD4-c_xKQw0cfw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp: fix use-after-free in error handling of nouveau_connector_create
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:10=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Thu, Aug 17, 2023 at 01:18:12AM +0200, Karol Herbst wrote:
> > do you have one of these? https://en.wikipedia.org/wiki/DMS-59
>
> Ah, DMS =3D=3D Dual Monitor Solution :-)
>
> Yap, that's exactly what the GPU has. And the Y-cable is 2xDVI. It is
> a Dell workstation and it came this way, meaning I haven't done any
> changes there.
>
> Thx.

right.. seems like on my GPU with such a connector I'm not seeing any
issues... let me dig further into the vbios and see if I can figure
something out there.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

