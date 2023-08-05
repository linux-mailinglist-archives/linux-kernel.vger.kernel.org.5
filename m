Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF477712E7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 00:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjHEWpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 18:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHEWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 18:45:12 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE32727
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 15:45:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so54076401fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691275505; x=1691880305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBvmQjo4/G5q4OEOFo7TpmyhmxzIQuk9NA5YEskEGD0=;
        b=MTHO6PqLhr6m5xYhfArXxt1R/hfRoBr6iqoJl74MZscQGK8OuXF+KizyO/LtoJzDEE
         NLP2M/mcmyqfNfH2GvpbTh+2ec9Hbw2MKaVakLlTMUqNwGK+VrG1JfdUzllN/6atstl6
         Z8as1/wUzVD4pzcsrkd0eQk6FueG25OV4JLek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691275505; x=1691880305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBvmQjo4/G5q4OEOFo7TpmyhmxzIQuk9NA5YEskEGD0=;
        b=dA5rbMbHzniavHwTVsGzmvmIgsYcIFSKXl/9JDhNq0+I1yfPg1cAuaRrqKlS0ecrH0
         VbX3kuyfbmRGl7J4SJ+rq8nct63S99/w9cMTYgX/igCxux4igu670KkPBdCTDJhGdH34
         lDDx7z4l3kVuw3i+PLV6H3Gdq00lWkQTeSbN6AMD0o51106OtEN+r+dMksZ4c+UsP+0+
         9/6pMxFpEl+x8DY7KioW8EjyJSOSRiT0i1m1Ua6Xmdncuh6d+upqOsbutad2lhOee4Yw
         I3e7bujUjMzNpiZ1hTPZxh4Gf2whF1ziNG6VcYEs0kMrRW3qr6WpFzqZ4Jh96aeI60EY
         7W6g==
X-Gm-Message-State: AOJu0YxPi/RUxTtFdbXwrW/XjCpLlr4vd6gaz2TX2vrGPm060kx2yzK2
        hF1XxdIIbXHA9VwR/ks5g1QHugLqRPFF7Flgz7joUw==
X-Google-Smtp-Source: AGHT+IEx2nT/l8NraJQDpLAE6f7yfUXYnFERNnjWiplcPgBsAclfx68kTARV2bPflmzNhis2JJbJzuER3ZECPuK5XN4=
X-Received: by 2002:a2e:780b:0:b0:2b6:fa71:5bae with SMTP id
 t11-20020a2e780b000000b002b6fa715baemr3881000ljc.12.1691275504746; Sat, 05
 Aug 2023 15:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <12d34340-6c94-4bfd-aa16-3c39026070d8@paulmck-laptop> <20230728032232.816584-1-paulmck@kernel.org>
In-Reply-To: <20230728032232.816584-1-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 5 Aug 2023 18:44:53 -0400
Message-ID: <CAEXW_YTwo-mADEU0zJTMHufnVtbw-hiLPUZ3bRhs0xHkUKY=ZA@mail.gmail.com>
Subject: Re: [PATCH rcu 1/2] torture: Add a kthread-creation callback to _torture_create_kthread()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        John Stultz <jstultz@google.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:22=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> This commit adds a kthread-creation callback to the
> _torture_create_kthread() function, which allows callers of a new
> torture_create_kthread_cb() macro to specify a function to be invoked
> after the kthread is created but before it is awakened for the first time=
.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: kernel-team@android.com
> ---
>  include/linux/torture.h | 7 +++++--
>  kernel/torture.c        | 6 +++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/torture.h b/include/linux/torture.h
> index 7038104463e4..bb466eec01e4 100644
> --- a/include/linux/torture.h
> +++ b/include/linux/torture.h
> @@ -108,12 +108,15 @@ bool torture_must_stop(void);
>  bool torture_must_stop_irq(void);
>  void torture_kthread_stopping(char *title);
>  int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, ch=
ar *m,
> -                            char *f, struct task_struct **tp);
> +                            char *f, struct task_struct **tp, void (*cbf=
)(struct task_struct *tp));
>  void _torture_stop_kthread(char *m, struct task_struct **tp);
>
>  #define torture_create_kthread(n, arg, tp) \
>         _torture_create_kthread(n, (arg), #n, "Creating " #n " task", \
> -                               "Failed to create " #n, &(tp))
> +                               "Failed to create " #n, &(tp), NULL)
> +#define torture_create_kthread_cb(n, arg, tp, cbf) \
> +       _torture_create_kthread(n, (arg), #n, "Creating " #n " task", \
> +                               "Failed to create " #n, &(tp), cbf)
>  #define torture_stop_kthread(n, tp) \
>         _torture_stop_kthread("Stopping " #n " task", &(tp))
>
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 8be83fdc6be1..b88a1a86d9da 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -932,7 +932,7 @@ EXPORT_SYMBOL_GPL(torture_kthread_stopping);
>   * it starts, you will need to open-code your own.
>   */
>  int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, ch=
ar *m,
> -                           char *f, struct task_struct **tp)
> +                           char *f, struct task_struct **tp, void (*cbf)=
(struct task_struct *tp))
>  {
>         int ret =3D 0;
>
> @@ -944,6 +944,10 @@ int _torture_create_kthread(int (*fn)(void *arg), vo=
id *arg, char *s, char *m,
>                 *tp =3D NULL;
>                 return ret;
>         }
> +
> +       if (cbf)
> +               cbf(*tp);
> +
>         wake_up_process(*tp);  // Process is sleeping, so ordering provid=
ed.
>         torture_shuffle_task_register(*tp);
>         return ret;
> --
> 2.40.1
>
