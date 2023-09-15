Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE377A24E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjIORfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjIORfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95D293598
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694799174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3iRbWt1YTt0h4sdUmK03Vi+q52/EZN5SzHkBsDxopwQ=;
        b=biVaaXNg3dY2s0Fcp5PeLWFiePscsdY4wZvaY8ZdVbFCiAVGMGLJD6DahQWdVZPrO4hdGx
        qTrT/Ob4KujIjGtYVijVWmctXzux/E94bVN2f5D45+LTFT+AvSPf0It8KDlp25YW9Dc6Zd
        bYBZJgC4dJi4R76+8mctdM3AzZUw30c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-mHrvW0HoPWCC-7YGg1CGoQ-1; Fri, 15 Sep 2023 13:32:52 -0400
X-MC-Unique: mHrvW0HoPWCC-7YGg1CGoQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76de9c09746so323402885a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799172; x=1695403972;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iRbWt1YTt0h4sdUmK03Vi+q52/EZN5SzHkBsDxopwQ=;
        b=lSviokKHEJWgUzux3u0q7D3QsVqW2h/v6NC4XUT4dmb017OJkMbuQiN2aohpsEDjLd
         XYG42QgLzcpvS/oU3mPH/dwHHK1fqrGGc+aiDuz2enKF1Q5r3NPJZregso2QlQxMSHlL
         uVr1VmPyUoKKrFdWTsMfx7yJw9iO3pnVd6uzkQxXEfnnB32iWMhbQDd3Fw6yq7ReDN+T
         1P7eNaNTBmHto/iemWkrVALL6CCVWOBVyNLWMsqKJ6yxRcuX0B0VRbz9/Hw+Px5ZTMxO
         rUYID/4p+z1SjrNcyGEZRYJc3EU4q7694kf0oFR7yohq2pRercO3IQaaS5brbPe2CYgQ
         o0tg==
X-Gm-Message-State: AOJu0YwriRf2KTCUq7MpSIFufi9+e6fdkH9h1qvSmYJz+E0oXxVBm0G8
        d47nk7GqgyWTtbYxuG+qmj69QGe5dbiIyTJF9ocJgMK5w1KjsMAk1m5khiIj+3BvCF4jpCebaV9
        oAinRZaVQpiFsmL/01fD6VHJ1
X-Received: by 2002:a05:620a:450b:b0:76c:a9fb:6d07 with SMTP id t11-20020a05620a450b00b0076ca9fb6d07mr2820431qkp.2.1694799171852;
        Fri, 15 Sep 2023 10:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETBX46w8bl1e85ceIF07jVSYpOO67r7UYVTVMH7Dqpa2+cz1AIiLu9iLVGSZRmJCWMnZIaqw==
X-Received: by 2002:a05:620a:450b:b0:76c:a9fb:6d07 with SMTP id t11-20020a05620a450b00b0076ca9fb6d07mr2820408qkp.2.1694799171623;
        Fri, 15 Sep 2023 10:32:51 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id pa9-20020a05620a830900b00767d572d651sm1364433qkn.87.2023.09.15.10.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:32:51 -0700 (PDT)
Message-ID: <43da274f22acaae8b917f51f6e62376928163e8f.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/pm: refactor deprecated strncpy
From:   Lyude Paul <lyude@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Fri, 15 Sep 2023 13:32:50 -0400
In-Reply-To: <202309142158.59A6C62F@keescook>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
         <202309142158.59A6C62F@keescook>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice catch!

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push in just a moment

On Thu, 2023-09-14 at 21:59 -0700, Kees Cook wrote:
> On Thu, Sep 14, 2023 at 10:17:08PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >=20
> > We should prefer more robust and less ambiguous string interfaces.
> >=20
> > A suitable replacement is `strscpy` [2] due to the fact that it guarant=
ees
> > NUL-termination on the destination buffer without unnecessarily NUL-pad=
ding.
> >=20
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>=20
> The "- 1" use in the original code is strong evidence for this being a
> sane conversion. :)
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

