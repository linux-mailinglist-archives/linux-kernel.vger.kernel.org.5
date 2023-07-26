Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE5763EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjGZSve convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 14:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGZSvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:51:32 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F7C270B;
        Wed, 26 Jul 2023 11:51:31 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1bb3df62b34so34894fac.0;
        Wed, 26 Jul 2023 11:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397491; x=1691002291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRGsH1Jfr6RATHY+BbPInolEKd5y3/mX+qRWdn1CGUY=;
        b=FWorQ3k0gTLDgZU5HCJ6IP+DjHbd4tu7o1TpbdXgQB52EYsvwKMnR2PhJlF/ewVljV
         RkjWtALROnlwiSBDhj16utPY35dlacmY8lhcT90KvYRJMxPbg9IVthh8VhZnYyt/Quv4
         yEHZqMUzglDH65jffZaVFvDI/VFHQ29QAm0ceX9Ipa+zrhQ5A4oM8Bu6Ar3ceMvFe9Pu
         JhQr81+WS+GD7RuGIWLFu4U/9ZGb7tClMtiQMNxwHDprqaPZo0TbXtVyNl/LQoi72tGl
         5ClLDRNaH+52R1IQKuirGw0Y+0v+eIfEwnoSWJ7uouF3dXcRkEEFdqKxvTWc0P6uUD+M
         wkpQ==
X-Gm-Message-State: ABy/qLaYOeumLQt72Gn5rEZxoXSbWX0KD7ek/8XidF8fMuS46JZ8PDEI
        Go5GwbUrK43uL7vAE3UmuBgDkJMGOLr2mwV7Xn0=
X-Google-Smtp-Source: APBJJlFVCfzLFBWJ9nKz6/tyw2MPzkkpGTF3nE0WwxgFcOp8SstqNkXH4ER+l035s5VdMt4zisZ9NDaLmuRaMGBsFqE=
X-Received: by 2002:a05:6870:1693:b0:1bb:81a1:f44e with SMTP id
 j19-20020a056870169300b001bb81a1f44emr3091322oae.3.1690397491100; Wed, 26 Jul
 2023 11:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230723-thermal-fix-of-memory-corruption-v1-1-ed4fa16d199d@kernel.org>
 <f559a614-93d5-121a-8ff3-0da77bc85f44@linaro.org> <ZL054LHAZv8VmIk3@finisterre.sirena.org.uk>
 <CAJZ5v0jJ+YM=7LUEKB_b5GUsGopLTT0eyPmomYV0OcGQp2gvig@mail.gmail.com> <a72ca5e0-556a-4d16-9c5e-2b342bb074c1@sirena.org.uk>
In-Reply-To: <a72ca5e0-556a-4d16-9c5e-2b342bb074c1@sirena.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jul 2023 20:51:20 +0200
Message-ID: <CAJZ5v0jybAspzV2sWduERaMhBWPSYN_USiUcO_=eRUBB6vB6GQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: Fix double free of params during unregistration
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jul 26, 2023 at 08:42:39PM +0200, Rafael J. Wysocki wrote:
> > On Sun, Jul 23, 2023 at 4:32 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > There was a message on the thread saying the patches have been applied
> > > for v6.5 but I can't see them in either mainline or -next.
>
> > They should be there in linux-next (as of today).
>
> Yes, they're there now.  They weren't at time of writing the above (on
> Sunday).
>
> > Surely, they are present in my linux-next branch.
>
> Are they queued as fixes?

They are.

>  It'd be really good to get these into v6.5,
> they're rendering the Allwinner platforms I have unusable.

I'm going to send a pull request with them tomorrow or on Friday.
