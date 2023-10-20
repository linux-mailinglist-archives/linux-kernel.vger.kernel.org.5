Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89FF7D1324
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377777AbjJTPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377787AbjJTPur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:50:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C1D60
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:50:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso14083851fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697817043; x=1698421843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7Unt13qEslS+WpNaJrnD/5CwOiBRKQDbQgXxuuTjBI=;
        b=ImrYmy1YDMKRmIN3zC6DTT9kjnPHlkSWAAtTzfLeI+pVF3zCi3qXtJxcydG+7AA2O0
         2whBTX+KZWeAJ6bH8d8MiKrrCuCvTKaQ/i3z+ZWy4Z7t9oVJ17ZQnMmwlC2ry0x7ve7j
         afQDom1NPXTAOXU/JOEiC3lY07joBtoBQBgyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697817043; x=1698421843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7Unt13qEslS+WpNaJrnD/5CwOiBRKQDbQgXxuuTjBI=;
        b=nljgHytBigJyn8nU4yFDqqjJloHrTryHc40nkzoJTxFlQHMnBrxRD1S6kg+BmiTxv9
         dhbOt01Xi6LUiI1JtBCvLfkMXBlIiwM5LYu1QSszkfoot863FzbxxO4PKOjuSVjZb/XQ
         25lb5bs3pJv9bvw7rd3i6iHjw+4rmya54js3L6M8vL63uYcPQWv+mr4ChwZU8h3npsxN
         9MXqf/6Y1gY18/yo6wW+dFwLPEIy9DCnpcItpw9noWJg71sVJxjWsTEiL7wtH6IKZ2Ob
         KCLBj6pgHHghyIQSJknFn3SZknepnNDuFxYzreL843GpWnHgEchknhdptBDavenP4+oW
         WyJQ==
X-Gm-Message-State: AOJu0YzDkep31HfGBTbKYSK44awUdrmbtopop/XlZlTgdETzMw+7Wa84
        4lDuRW1JayPC/NCWORT5rmwl/tsbluFsxwGXPcySuQ==
X-Google-Smtp-Source: AGHT+IEM6LwZfCRsTlSFVPikBNaQG14vdTM6yWo45oC1wORCej6jv0EQrRX2i9OhhA6JM3iZ9P2dTJ/25yW10tqSWu4=
X-Received: by 2002:a2e:bc07:0:b0:2c5:9e2:ed14 with SMTP id
 b7-20020a2ebc07000000b002c509e2ed14mr2601912ljf.39.1697817043155; Fri, 20 Oct
 2023 08:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org> <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
 <ZTKHK2EwgOc8y38v@gmail.com>
In-Reply-To: <ZTKHK2EwgOc8y38v@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 20 Oct 2023 11:50:32 -0400
Message-ID: <CAEXW_YR7bH7gQgqnT6gzFsHE85URch1R78juAn37i3KmkRfvFg@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during newidle balance
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 9:57=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > Even if your figures look interesting, your patch adds regression in
> > the load balance and the fairness.
>
> Indeed - I've removed it from tip:sched/core for the time being.

Sorry we should have marked it as RFC. We still feel there are issues
in the newidle balance code and the fix is in the right direction,
we'll continue discussing with Vincent on the other thread and try to
come up with a proper solution.

Thank you Ingo and Vincent!

 - Joel & Vineeth
