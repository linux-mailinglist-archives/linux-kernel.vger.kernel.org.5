Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A694F7C8DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJMTuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:50:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203FCC9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:50:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so1980369f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697226638; x=1697831438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx1cUFmw1hK7yZ7GcQrEKkBst8WaqJrLkeTkGMOaiTk=;
        b=gQKvLK9Bub2yE6JKGw//Q3V6N6Oo4KETAndghxZgQbRa+eGZYg6OciCIwF276a7Rc3
         t9AHRMPXXm416/f4TJPK/qW/jK+Sq+BNPOJENQDSMLvVgr6U6vN0W94a+9fuyTpq08v9
         h880GRfFbG37gOuJSavUU3F04hBhu7qTsPEehkouO+CUGhjyu2FPHfbG1fRwcwozysxj
         Edjmz34++kHlWQkZEwMdDp0zzX7L0uiVr1A9/Fzr2LeTUNVMOM2aWzgNLp02hbPUXnWE
         VYFn90pzzKsfMKQP3ex33E+V7vkPMGZovIWQ+QioU1O/k/kz0wZC0+Ci+SdwjXnLuxU4
         DOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697226638; x=1697831438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx1cUFmw1hK7yZ7GcQrEKkBst8WaqJrLkeTkGMOaiTk=;
        b=KUHK1MuniwhFvIyxFipM+CzCOHlZ1p/oJUXXlif/udxkFw0OfHr6boCn0dm/4R11Gw
         OEUdh+YYBN0i9TuJaHk59+2FsXGeb/iHoDKLevG83ibpzEZCLQXPJV1XOHLkIxMywqXH
         YNkDdVywt96uVuhILR5ET4fvQeQ9C9IW+GbJvGHAXEWuaXsTFx8l+UTGKeMEF9B9TL9L
         frQHGrzhe0AEgdfPGLRFvxZ2WjKPDpa7lpDpMpRAiUviXzXJuKOMqdkWkw81g+/AUK5p
         C0gzusEdT+HS4z25sXiMxwzr2sc7sD7GrRaMTt4zSTRj/KulL6r2PkvlxhL4ZQmkJJMo
         oV0w==
X-Gm-Message-State: AOJu0Yysg46OSqMVPlA8sPx6QUhsTxLfmN59WT0fwv5hdaxfhPHplGFI
        SLlwa3UbR97jPUF9M8CkuXU=
X-Google-Smtp-Source: AGHT+IEDQAlSWc+A/u62V+MvHuimTiaN8lp/uhK9NO20sm2kLcoQiI7ALC/bz4SdK9FhClHxBkqvfQ==
X-Received: by 2002:a05:6000:128b:b0:32d:9d92:481a with SMTP id f11-20020a056000128b00b0032d9d92481amr2005733wrx.39.1697226638285;
        Fri, 13 Oct 2023 12:50:38 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0032d81837433sm8698668wra.30.2023.10.13.12.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:50:37 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     wens@csie.org, airlied@gmail.com, daniel@ffwll.ch,
        samuel@sholland.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] drm/sun4i: dw-hdmi: Split driver registration
Date:   Fri, 13 Oct 2023 21:50:36 +0200
Message-ID: <1773349.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <3cwcfx7fvtr75j6musdqttn6oto4wemsx7lh664gu3run6wxnz@5o5vao4wibm5>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
 <3441738.QJadu78ljV@jernej-laptop>
 <3cwcfx7fvtr75j6musdqttn6oto4wemsx7lh664gu3run6wxnz@5o5vao4wibm5>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 05. oktober 2023 ob 10:43:14 CEST je Maxime Ripard napisa=
l(a):
> On Mon, Sep 25, 2023 at 05:07:45PM +0200, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 25. september 2023 ob 09:47:15 CEST je Maxime Ripard na=
pisal(a):
> > > On Sun, Sep 24, 2023 at 09:26:02PM +0200, Jernej Skrabec wrote:
> > > > There is no reason to register two drivers in same place. Using mac=
ro
> > > > lowers amount of boilerplate code.
> > >=20
> > > There's one actually: you can't have several module_init functions in
> > > the some module, and both files are compiled into the same module.
> >=20
> > Yeah, I figured as much. However, I think code clean up is good enough =
reason
> > to add hidden option in Kconfig and extra entry in Makefile (in v2).
> >=20
> > Do you agree?
>=20
> Yeah, I don't know. Adding more modules makes it more difficult to
> handle (especially autoloading) without a clear argument why.
> Module_init is simple enough as it is currently, maybe we should just
> add a comment to make it clearer?

I'll just drop this patch then. While I think autoloading works pretty good
these days and cleaner code is nice, it can certainly cause some issues whi=
le
packaging.

Best regards,
Jernej



