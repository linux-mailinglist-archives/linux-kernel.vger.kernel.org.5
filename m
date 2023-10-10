Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A717C030D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjJJRzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjJJRzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:55:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E547E94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:55:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so71264311fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696960513; x=1697565313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8+Lz5VjZyLQFcPIUwiXiRLWaHkDX/u4z27NHP1/09Y=;
        b=BEkB+iJSg0DKcuJa76L1PK9SUtKZ+56q8YgUOoXv/kChwYw49atO9oFj5jhw39Ghea
         9tDJLQIzMRqs2OEW6xcZj4wy3d5xkYVDI2eZLBA5+LRVuf1vebFLWAPF5P2gL8dwjgKD
         /SBwn0zSflSUONfqF3jfYYR7LDZoHcATW37sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696960513; x=1697565313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8+Lz5VjZyLQFcPIUwiXiRLWaHkDX/u4z27NHP1/09Y=;
        b=dmbzCt6LwN86fzVHa4yGB70q01ggRp4PSe/Q3TQ3yd/JNCVCRXSX3jf4EIazZ5OQ0v
         ikaNIL11L+v/ybtdUz2EtBh2iTsd6oULRZKsQEvb73OATrYUkWk/qZJsW9CWTwDMccj6
         nNkExcOBmTBe+DwngzdPNQR2hGkOmLPhEduFXC2GPyktJ5Hyh4AGgZgWkA2sjWgii1oq
         +076N4Rtj94LImbSLmp8N0qtZR7ZgaPmJ+R2l/3FPtzManAr20ChpG9+W7a+mDFzu+Z2
         CpCQJn+mb8eOI5DLKkXnhAnGFsXN6FlWwsOQ9iLqK1c+YhqvFrY7MA+XUjhKHMXDQnRF
         wMGw==
X-Gm-Message-State: AOJu0YyVa608SmuWL6Z8sgurtctKztTAcRSE2qtiCv/24jFdw2l0PnKK
        dE2OjtUiASYPU3ycZ+2AKJH8w9hlfDrRSqv9dzXGpw==
X-Google-Smtp-Source: AGHT+IH36Z6zQf7WJgiyX00BpD00ZfG+xcbgfTSUuZyCv2ZaTLuRfCvQY/qme+DtZ2tuxnXGoGtuyNnDrLo4eUXJlEQ=
X-Received: by 2002:a2e:9b11:0:b0:2c2:9705:c478 with SMTP id
 u17-20020a2e9b11000000b002c29705c478mr14706221lji.13.1696960511981; Tue, 10
 Oct 2023 10:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <20231006200129.GJ36277@noisy.programming.kicks-ass.net> <20231008163912.GA2338308@google.com>
 <ZSPjIwWxSdKAsKZD@gmail.com>
In-Reply-To: <ZSPjIwWxSdKAsKZD@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 10 Oct 2023 13:55:00 -0400
Message-ID: <CAEXW_YSJTShQoOCdTOHamatV2VFFpK5=GZ40=he5Egz5TRBMkg@mail.gmail.com>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 7:25=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > > > Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates=
 when a CPU goes NOHZ-idle")
> > >
> > > Hurm.. does this really warrant a Fixes tag? Afaict nothing is curren=
tly
> > > broken -- this is a pure optimization question, no?
> >
> > IMHO it is a breakage as it breaks NOHZ -- a lot of times the ILB kicks
> > back the CPU stopping the tick out of idle (effectively breaking NOHZ).
> > The large number of IPIs also wrecks power and it happens only on 6.1 a=
nd
> > after. Having the fixes tag means it will also goto all stable kernels =
>=3D
> > 6.1. Hope that sounds reasonable and thank you for taking a look!
>
> So it's basically a fix of a NOHZ performance regression, introduced by
> 7fd7a9e0caba or so, correct?

Yes.

> As long as the fixes have a good hope of being backported with a low amou=
nt
> of overhead, a Fixes: tag for a ~2 years old performance regression is
> unusual but not unprecedented.
>
> We just need to make sure we don't put too much of a burden on the
> shoulders of -stable maintainers ...

Sure, that sounds good. After we upstream, I am happy to assist in any
stable backporting work related to this as well. In any case, I have
to backport it to ChromeOS kernels which are based on stable. There's
only the 6.1 stable kernel at the moment that is affected.

thanks,

 - Joel
