Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C23786FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbjHXMxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbjHXMxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:53:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91E1BC5;
        Thu, 24 Aug 2023 05:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F7A66186B;
        Thu, 24 Aug 2023 12:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AACDC433C9;
        Thu, 24 Aug 2023 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692881564;
        bh=m8mTnCQFLBbU5msxA8RyJb+S6cYHpqcaY6LDaPQO678=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nYagsicHZmErqj8eCXNxvs0bBsWBeRg3Ll/kSwJITXFOBcJAhtGfdVKYEzEl9VdPA
         1DPv5pCvqQF7t9QqTw+e+ZXUU3cRPFrZD3vFxQBxxI3F7cQGrJtb9LjLNZk+5XWr3C
         FBYZY8uGP6zkgxHqCyhYEK7WqU8hcSj2oiZiGKH04i5YQWnwTILrei92KXbGtxsoZN
         vTTNX0NCu8NS+Pdfd5jBVkYyty2Nksac8nYeN4ageuiBKFEfycAxSUoVA+6r2LRydC
         vWuXYZztY0vnUqcZTdpd6BCMiYwQIfYta6S63xOz6Xxj0h+9krQH6qeVhRV3+tZ13i
         81uaoq/+SVzIQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-523b066d7ceso8428480a12.2;
        Thu, 24 Aug 2023 05:52:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YypjnTiBkemzyqWtcjdxIl3/lAaCjBQffTmFZScyNCJm5Sbd11w
        P3SX93bEuE5qmolSmQGkO8Ip3pCHZe8ZFUem3V8=
X-Google-Smtp-Source: AGHT+IFnd7HTgPXVzjQmdFKUxDUS6RwqDEPVZwm1vYaBLcFk23zSfhGUWQvpL7gr+1gEAwUr/72a++Xa9f3sc2/6zRA=
X-Received: by 2002:aa7:c508:0:b0:524:547b:59eb with SMTP id
 o8-20020aa7c508000000b00524547b59ebmr11870649edq.15.1692881562847; Thu, 24
 Aug 2023 05:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230822040248.329442-1-chenhuacai@loongson.cn> <87lee0dbmi.ffs@tglx>
In-Reply-To: <87lee0dbmi.ffs@tglx>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 24 Aug 2023 20:52:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6MWOVkgJYa6CedoiQ9YG+Jw_vTLZN-NY5Jrn5Ps5HUAg@mail.gmail.com>
Message-ID: <CAAhV-H6MWOVkgJYa6CedoiQ9YG+Jw_vTLZN-NY5Jrn5Ps5HUAg@mail.gmail.com>
Subject: Re: [PATCH V3] rcu: Update jiffies locally in rcu_cpu_stall_reset()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
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

Hi, Thomas,

On Thu, Aug 24, 2023 at 5:37=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Aug 22 2023 at 12:02, Huacai Chen wrote:
> > + * This function may be called in NMI context, so we cannot use ktime_=
get_ns()
> > + * and ktime_get_coarse_ns(). Instead, we use their inaccurate but saf=
e friends
> > + * ktime_get_mono_fast_ns() and ktime_get_seconds() which will cause r=
cu_state.
> > + * jiffies_stall to be a little large than expected (harmless and safe=
r).
>
> What's inaccurate about ktime_get_mono_fast_ns()? Bogus comments are
> even worse than no comments.
ktime_get_mono_fast_ns() is not as accurate as ktime_get_ns(), I get
this conclusion from:

 * So if the update lowers the slope, readers who are forced to the
 * not yet updated second array are still using the old steeper slope.

>
> >   */
> >  void rcu_cpu_stall_reset(void)
> >  {
> > +     u64 curr, last, delta;
> > +
> > +     curr =3D ktime_get_mono_fast_ns();
> > +     last =3D ktime_get_seconds() * NSEC_PER_SEC;
>
> So this will trigger a warning when someone debugs suspend with KGDB.
Yes, ktime_get_seconds() may cause a warning, I haven't noticed this before=
.

>
> It seems the approach taken here seems to be to throw stuff at the wall
> and see what sticks.
I don't understand what's meaning, but I believe your advice in
another thread is the best solution, so let me try.

Huacai

>
> Thanks,
>
>         tglx
