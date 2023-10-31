Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67547DCA76
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjJaKMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJaKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736B4DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698747089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzDDRWNXtvF0AiHkzgS2GcOo69dWjTdD9mgnyNtPC9Q=;
        b=XedIwXIDonZna4qP1PDBoxGZxb+HAcmf8jXKkeIkGAckVtacU5IoI+x87uJNToIJ/xc84i
        NPveTCzYuD2elsRl0ixcIneqhZAIExjsnMVOGEmxzevY4vS34eYOsh8Tvu6zFnWwOe3CwQ
        EGwZxN9v4dFRPWP3nfTJ3hMYzouNqs0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-llLkH3lFM76WHGdUPFYm0w-1; Tue, 31 Oct 2023 06:11:28 -0400
X-MC-Unique: llLkH3lFM76WHGdUPFYm0w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40839252e81so38882455e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698747086; x=1699351886;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzDDRWNXtvF0AiHkzgS2GcOo69dWjTdD9mgnyNtPC9Q=;
        b=PmkcKDw32U7EWl9ypDR3e4+JK+j9Ew1UBf9QpdujuaJi8IUngzMetKGCDi+MXSY8XG
         ZQ0Tcbh7lXRAbW/9xYOSdUldk7nWlm1uwiI4XHKkX6r1u1qHEtZ2LeJL8bEOtqLMy+s8
         12cXx+31c+vaggydD6K1NWogGFQax7zvefCJ9ufTG7bAP5xNxopzmRBXZGc8lWIjZ/kp
         RsJ6Od6dRKOTACwqOID4C7WJj79y648vLJ7Y6QXEX4HegZvaeGUvX+xoai0bbW/gjL6B
         d3eE7CUBmZjPMG+E8VPQKzGFHyoyjaTUX25rKO9zDO50vxlXyEieGSltWciyiDNnW+kg
         fO6g==
X-Gm-Message-State: AOJu0Yy6HfzmNr73EVP7LIl6jaiAfqrnCCwIEZk0wNVBYzRzhhO2qXJo
        mlSvjzCEdEVk7kwxBQk9CP2JnjqyzjD43nzbmeEZjl//nqQ48SPYLyAv4q3eay58uL0jW+l4jSw
        vI7h1nmTeyeuJ+7m0MPqFGyy/AQj3m8Qa
X-Received: by 2002:a5d:5191:0:b0:32f:9709:df75 with SMTP id k17-20020a5d5191000000b0032f9709df75mr845859wrv.24.1698747086670;
        Tue, 31 Oct 2023 03:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCrFfBWko6jbrSVOEoQNO1U5Ek3OR2diEsBd5CV4xGBcmuAciNM/F+1O/7eI0IwAJOI8X+sw==
X-Received: by 2002:a5d:5191:0:b0:32f:9709:df75 with SMTP id k17-20020a5d5191000000b0032f9709df75mr845843wrv.24.1698747086364;
        Tue, 31 Oct 2023 03:11:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a8-20020adffac8000000b003296b488961sm1127397wrs.31.2023.10.31.03.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 03:11:25 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] drm/ssd130x: Fix possible uninitialized usage of
 crtc_state variable
In-Reply-To: <CAMuHMdVLf=H7QWaUXrN17ABw9eE1MjBdzFEM0AhMNj8_ULSz+Q@mail.gmail.com>
References: <20231020225338.1686974-1-javierm@redhat.com>
 <b048247c-75e9-488e-a4f3-b227a38bca5e@redhat.com>
 <87v8aso1ha.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdVLf=H7QWaUXrN17ABw9eE1MjBdzFEM0AhMNj8_ULSz+Q@mail.gmail.com>
Date:   Tue, 31 Oct 2023 11:11:24 +0100
Message-ID: <87lebjksoj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
> On Fri, Oct 27, 2023 at 11:33=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Jocelyn Falempe <jfalempe@redhat.com> writes:
>> > On 21/10/2023 00:52, Javier Martinez Canillas wrote:
>> >> Avoid a possible uninitialized use of the crtc_state variable in func=
tion
>> >> ssd132x_primary_plane_atomic_check() and avoid the following Smatch w=
arn:
>> >>
>> >>      drivers/gpu/drm/solomon/ssd130x.c:921 ssd132x_primary_plane_atom=
ic_check()
>> >>      error: uninitialized symbol 'crtc_state'.
>> >
>> > That looks trivial, so you can add:
>> >
>> > Acked-by: Jocelyn Falempe <jfalempe@redhat.com>
>> >
>>
>> Pushed to drm-misc (drm-misc-next). Thanks!
>
> Looks like you introduced an unintended
>
>     (cherry picked from commit 9e4db199e66d427c50458f4d72734cc4f0b92948)
>
> ?
>

No, that's intended. It's added by the `dim cherry-pick` command, since I
had to cherry-pick to drm-misc-next-fixes the commit that was already in
the drm-misc-next branch.

You will find that message in many drm commits, i.e:

$ git log --oneline --grep=3D"(cherry picked from commit" drivers/gpu/drm/ =
| wc -l
1708

> Gr{oetje,eeting}s,
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

