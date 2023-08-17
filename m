Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF577F400
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349878AbjHQKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349229AbjHQKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0062D69
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692266461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxvFWtLfZHUU3yR6UuCUCdkToTTydlxIuObM2X2y+A0=;
        b=I74Jt8dgG2kPZwinPquctPlMt+MgCT1FuBH/yMRWbtY+Fyf55++fzz+o7NjpGREdlYfZg9
        JRNltwyI3PyNOJH9JOfJcDfYDkE2teCD5MpfUldEQpwwdQt/5ILKkKufwDoaPiRZROKtwP
        J6NPezDCNKh+hdPvMlyO+9N9dH3+siw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Hm23HrKIN1-QmHtNCwMXmw-1; Thu, 17 Aug 2023 06:01:00 -0400
X-MC-Unique: Hm23HrKIN1-QmHtNCwMXmw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9d5bc6161so13735491fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692266459; x=1692871259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxvFWtLfZHUU3yR6UuCUCdkToTTydlxIuObM2X2y+A0=;
        b=ieT8muahVPQDbne8CyzRVHRG5mCpt84uzyEdf4cpaF3Irm3zcgzzU9epL7wVmQOE3p
         2U1WA0Tq8rUWJB6oQZXSq+KPWuQJC7OYZizer0CNLoAowfxFzzykYcKqXd3amXNaZRKO
         dmCBCeVV9zG/C9tYe2vdbo2I3cmRB27h2hMrUnTl4run2TgMnT0zUk13b8ZiJFGM6/DZ
         8JpypCl5GS6FRR7ZYa8ALibAB664J/i9IebWCVMjC+IuzlkQFr0uwV20jZfq+/84XtU3
         wGbNfsmxQ6kCr1g8jYUCnMdBZ5lBhVnR/GGzQt/pxEOy6lgCxYDpMZu+kxyp/kNaqEsw
         gUng==
X-Gm-Message-State: AOJu0Ywe1vfgCAvoLbUcH7Q1UcNU8IShoLgWMSG3cMOC1tRtmLrGsNKX
        iTPwoICRoJO27fx+3xRUS/3tVMw3KFGNHx39niDbbN1E8GXIBbqY9z0cwFQ15lvqpJIqo0aZMc9
        98hKCY7IQJvN00mmDG6OjtRrPRHBJxUg9VKDbTBgB
X-Received: by 2002:a2e:9043:0:b0:2b9:e10b:a511 with SMTP id n3-20020a2e9043000000b002b9e10ba511mr3029744ljg.0.1692266458793;
        Thu, 17 Aug 2023 03:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX6/54OJqwhp3VR3zAVcKja7LAQ8KhRaL+hfdqOgYduGmKxKWNx/Sz3QfKQ1PMt/yuW5leDc5yD5ItStaUNh0=
X-Received: by 2002:a2e:9043:0:b0:2b9:e10b:a511 with SMTP id
 n3-20020a2e9043000000b002b9e10ba511mr3029732ljg.0.1692266458510; Thu, 17 Aug
 2023 03:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230814144933.3956959-1-kherbst@redhat.com> <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
 <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
 <20230816145338.GIZNzi8o3d9x9bcPzX@fat_crate.local> <CACO55ttasKLxBTmZjN-XBOuJFC7rng2PbLgxCT8WT6ukOZNGzQ@mail.gmail.com>
 <20230816151252.GKZNzndDNySuWC+Vwz@fat_crate.local> <CACO55tunC5mEu3Tw64rKLqNM6MN6d=N90kYQKYwXWNMB=ahDaw@mail.gmail.com>
 <20230816221353.GXZN1KIXloRn8cGt5E@fat_crate.local> <CACO55ts7430tAUDC+0qY0EZ5ReO=2Rjwj1SzHaBLodmyBgrUrw@mail.gmail.com>
 <20230817081032.GAZN3V+NQ1blzQC2sU@fat_crate.local> <CACO55tv-dKnDzUYYFW+d2pNoAhEoEniUT=QAmD4-c_xKQw0cfw@mail.gmail.com>
In-Reply-To: <CACO55tv-dKnDzUYYFW+d2pNoAhEoEniUT=QAmD4-c_xKQw0cfw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 17 Aug 2023 12:00:47 +0200
Message-ID: <CACO55tuWTYngfw+MZnan+U4eYyE+SvOWgxzffaCMNGQgriq3ig@mail.gmail.com>
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

On Thu, Aug 17, 2023 at 11:58=E2=80=AFAM Karol Herbst <kherbst@redhat.com> =
wrote:
>
> On Thu, Aug 17, 2023 at 10:10=E2=80=AFAM Borislav Petkov <bp@alien8.de> w=
rote:
> >
> > On Thu, Aug 17, 2023 at 01:18:12AM +0200, Karol Herbst wrote:
> > > do you have one of these? https://en.wikipedia.org/wiki/DMS-59
> >
> > Ah, DMS =3D=3D Dual Monitor Solution :-)
> >
> > Yap, that's exactly what the GPU has. And the Y-cable is 2xDVI. It is
> > a Dell workstation and it came this way, meaning I haven't done any
> > changes there.
> >
> > Thx.
>
> right.. seems like on my GPU with such a connector I'm not seeing any
> issues... let me dig further into the vbios and see if I can figure
> something out there.
>

btw, what would help is to know where `nvkm_uconn_uevent` actually
fails, or rather, are you running into this "/* TODO: support DP IRQ
on ANX9805 and remove this hack. */" condition?

> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
> >

