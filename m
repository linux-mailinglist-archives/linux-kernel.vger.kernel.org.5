Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48230759C33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGSROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjGSROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:14:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579A319A1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:14:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so11147742e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689786887; x=1692378887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elJrsu6Uef6LQuBYEeLwXbUYorXirAQoAABKR5ida5o=;
        b=fiaiyvFfMRr9Xcr14KrkcwlW5WSFKorUe9O1j3cTg+Ni4nJ2Rwb8XvTzSQsOpqJpyo
         bASm/XVJEga+vfVYU86n+ZR1sZS7RnHGniJdqq5sU1GVbxOKAc2GFcN7PPhA9QJjzWEV
         BlGibLWs5VR+3cOUWr/I+maEKzlhkq9Tt6Hsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786887; x=1692378887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elJrsu6Uef6LQuBYEeLwXbUYorXirAQoAABKR5ida5o=;
        b=KW2MLZbOBGbapL4SXl8cK2j+hxNYxIU4i72TpqHoBwDDdiNO8sPUeRnT0bAKaLPz9B
         B0uQhKR2p3mqGimV7ZwIzpNGkiXY4XE7xNeGxJW8jfnUPQSMDtLR5++x/C577jXsUppn
         NRILqCDc082MAF24TdkAuFnKncagep+cpb9x5ksu4ZhGSOkTnTJhyOe6FtRz/iHTZd3V
         kcBxVlVgSANHWmdWUw5dFpd0X9ot44Wh9ad2IC6HPi1O0fnEVn9lO5+o7ELgAyPwcQFl
         d4/nyTGawdMnaPqF2C7Mz/s/wZs5uCKxKYtyM0TvMWzEWLXkWuKx5UTCBEVLv1bgngDC
         lykQ==
X-Gm-Message-State: ABy/qLYGDsIoNml6l47d53otYhb5kQTwxFXnzxfgiK9E/8HcBDVnpQBw
        z/l/6pU88elPvW5UUZ9OL2En656fjza6ObxyH7Oi
X-Google-Smtp-Source: APBJJlEB1PrXZAM0xFw7GP8k6ndBKsUzY5zeo6WvVrFVnATj7EL2b0cGiZQxPbF0IQ70Uhksr0Wb2hLxqIgfaxCkpiY=
X-Received: by 2002:a2e:8748:0:b0:2b7:33a6:f2c0 with SMTP id
 q8-20020a2e8748000000b002b733a6f2c0mr450107ljj.4.1689786887459; Wed, 19 Jul
 2023 10:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
 <8756384.Zvl9fuB8X0@basile.remlab.net> <CAOnJCU+W9u+HnMfjU_y9W7331Zx07eQs9R1twV0=KsBAeSMSjw@mail.gmail.com>
 <5951331.lOV4Wx5bFT@basile.remlab.net>
In-Reply-To: <5951331.lOV4Wx5bFT@basile.remlab.net>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 19 Jul 2023 10:14:36 -0700
Message-ID: <CAOnJCUKCx0Jh1igZytKAYePhhUBt=x5ANCVx4FRTbLtxGkyowA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] riscv: Allow userspace to directly access perf counters
To:     =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        Mathieu Malaterre <malat@debian.org>,
        Jan Newger <jannewger@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 7:46=E2=80=AFAM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>
> Le keskiviikkona 19. hein=C3=A4kuuta 2023, 1.48.49 EEST Atish Patra a =C3=
=A9crit :
> > > Isn't RDTIM susceptible to interference from power management and CPU
> > > frequency scaling? I suppose that RDCYCLE may behave differently depe=
nding
> > > on PM in *some* designs, but that would still be way better than RDTI=
ME
> > > for the purpose.
> >
> > Yes. But that's what it is probably using for other ISAs ?
>
> At least on AArch64, it is using either Linux perf cycle counter, or if t=
hat
> is disabled at build time, the raw PMU cycle counter - which obviously le=
ads
> to SIGILL on Linux, just like this MR would do with RDCYCLE.
>

Good to know. Thanks for the clarification.

> Again, I do not *personally* have objections to disabling RDCYCLE for
> userspace (somebody else does, but that's neither my nor your problem). I=
 do
> have objections to the wording of some of the commit messages though.
>

Completely agreed. We will update the commit text with more clarification i=
n v5.

> > My point was it should just do whatever it does for other ISA. RISC-V i=
s no
> > special in that regard.
>
> Sure. My point is that RDTIME may be great for, so to say, system-level
> benchmarks. For FFmpeg that could something like how long it takes to
> transcode a video. But it doesn't seem to make much sense for
> microbenchmarking of single threaded tightly optimised loops, as opposed =
to
> RDCYCLE (or a wrapper for RDCYCLE).
>
> --
> R=C3=A9mi Denis-Courmont
> http://www.remlab.net/
>
>
>


--=20
Regards,
Atish
