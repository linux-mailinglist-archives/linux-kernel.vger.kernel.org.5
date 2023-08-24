Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0208078658F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbjHXCsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239366AbjHXCrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43079198;
        Wed, 23 Aug 2023 19:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D628F632E9;
        Thu, 24 Aug 2023 02:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D01EC433C9;
        Thu, 24 Aug 2023 02:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692845265;
        bh=7PBy+Refm2RRnKJWoTExxPu62p0WpFG8uVlZZkXh0xI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SInx7YxBx2W+8zAR+OJPWRrvknl/TERlYQH6atyjZN8Ip2rJjL6ManClVGh/JGPlZ
         FJD0q4ZrcXF9dzRHjQvLrINfIrLg6R2LXhCR/tRzIrX7jvlB0TnDmBiOMVFfEUH3ZF
         BX45B9IIOHVcy1/RznJGW/0QJr7e+Y3lFmlt380LSsRBxqVKXYMZ1CdktrdOqhIK60
         NorsfON4QhicAJ3dfH0k20dsZjgVNjKThmOFAp9KaxyBntBfSmkLcgD39DXhRUKGkU
         BZzApGCmZ6Jfr9dlQ9K4Qf3Y1n/A05+sTTxF3bY5QOTGxXC6ZQgKj79af+41ZRe0MS
         bzAR0QKhyEWxg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so7937998a12.1;
        Wed, 23 Aug 2023 19:47:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YyiE+FAmOCfhM8OTu6kJXT55HU4SzR4FQ18JAFPY2MOR60CvXdF
        g7+ryYZZFL4lQUTxTfjJa7aQFFFYASikd21zSrM=
X-Google-Smtp-Source: AGHT+IGLUmJER6JZOQSpI2I0qEDDzfzobopyBbxWbOGHFMuP7AHCYWCbJytSAiU4IWsDI7i52Oyiq/R7ETxEuMkarNg=
X-Received: by 2002:a05:6402:2051:b0:525:469a:fc49 with SMTP id
 bc17-20020a056402205100b00525469afc49mr10849489edb.17.1692845263397; Wed, 23
 Aug 2023 19:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org> <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
In-Reply-To: <87ttspct76.ffs@tglx>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 24 Aug 2023 10:47:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7o+SK__ySWQRkbB4B-LTBFS-ryosqH_r53ZrZ+W1ZE-A@mail.gmail.com>
Message-ID: <CAAhV-H7o+SK__ySWQRkbB4B-LTBFS-ryosqH_r53ZrZ+W1ZE-A@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
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

On Thu, Aug 24, 2023 at 6:03=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > On Thu, Aug 17, 2023 at 3:27=E2=80=AFAM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> >> > If  do_update_jiffies_64() cannot be used in NMI context,
> >>
> >> Can you not make the jiffies update conditional on whether it is
> >> called within NMI context?
>
> Which solves what? If KGDB has a breakpoint in the jiffies lock held
> region then you still dead lock.
>
> >> I dislike that..
> > Is this acceptable?
> >
> > void rcu_cpu_stall_reset(void)
> > {
> >         unsigned long delta;
> >
> >         delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns=
());
> >
> >         WRITE_ONCE(rcu_state.jiffies_stall,
> >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > }
> >
> > This can update jiffies_stall without updating jiffies (but has the
> > same effect).
>
> Now you traded the potential dead lock on jiffies lock for a potential
> live lock vs. tk_core.seq. Not really an improvement, right?
>
> The only way you can do the above is something like the incomplete and
> uncompiled below. NMI safe and therefore livelock proof time interfaces
> exist for a reason.
>
> Thanks,
>
>         tglx
> ---
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
>   */
>  static ktime_t last_jiffies_update;
>
> +unsigned long tick_estimate_stale_jiffies(void)
> +{
> +       ktime_t delta =3D ktime_get_mono_fast_ns() - READ_ONCE(last_jiffi=
es_update);
> +
> +       return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> +}
> +
>  /*
>   * Must be called with interrupts disabled !
>   */
Thank you for your advice, now the latest proposal is here [1], this
is very similar to your diff, please take a look.

[1] https://lore.kernel.org/rcu/CAAhV-H5mePbbF8Y3t-JfV+PNP8BEcjKtX4UokzL_vD=
zyw+2BRg@mail.gmail.com/T/#t

Huacai
>
>
