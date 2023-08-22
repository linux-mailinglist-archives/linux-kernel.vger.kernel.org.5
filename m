Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665CE7839BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjHVGKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjHVGKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:10:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2D186;
        Mon, 21 Aug 2023 23:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692684590; x=1693289390; i=efault@gmx.de;
 bh=2tIsDYryRj0UAmEjOltYAR/Nh7ihW0NC/V1nBUGx1kA=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=GKP2KNZilrQJTwqLjWq3/paltMm5ZhLQjimFRkXpVQo/T2r7VKhMikWOhO7nG0xSttW8Qh+
 kBLWf/z+8zzrPneUCuM3UVd+UTQXC0PmQ9ZGlZrbRVp9EWYrDG6ZPva7SPFRkUwK7nNu5L/H3
 bPqOEa5IdjF8pKtb6esXe81fa6TUzswSSkrqLQXNgjshpWcYLJKTfRIhb+AwhBXM2Zf2Kp909
 2O/Z09+UfSaXXXUJ9SFNY6tHhHy41/hEEL4fgFX0+2IiXK/b2GN2V/Wnc76OXmBtOsGOgbYYc
 LalE86t3zm+XQc7m9erMCJnxDDNpcB6TU5OTwewh9Ym0kqrtLWnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.235]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTRH-1qKDz12F4n-00NQ79; Tue, 22
 Aug 2023 08:09:50 +0200
Message-ID: <0e153dd25900af70f91e4a73f960320e6daf3c6a.camel@gmx.de>
Subject: Re: [tip: sched/core] sched/eevdf: Curb wakeup-preemption
From:   Mike Galbraith <efault@gmx.de>
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Date:   Tue, 22 Aug 2023 08:09:49 +0200
In-Reply-To: <f0859f35-39ec-e5dc-b77a-79162516de31@amd.com>
References: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
         <169228500414.27769.13366308319134164264.tip-bot2@tip-bot2>
         <21f3d376-17d6-8fb6-5f35-507ea931c0d3@amd.com>
         <02f6a15f094adb3c8d9957b031941d6bd10c2e43.camel@gmx.de>
         <f0859f35-39ec-e5dc-b77a-79162516de31@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u3CnOMDnjSy84k/tEVdsCc4+nf0vvYBCRSP6abII0NWoUDEHpx9
 BMHqp/tXG160g8qS+lPbdOrf4gEnXOd+Mo+xpJQBlCHDPV7/eLS5MPnjguOXbyVsavdbsos
 k+MPT2PGip20X8tc6aZLA/DiIm9VwDaQHPZGrLgBD3KmMjRkR5NiLoBBbCMCPTdbvKY4PWd
 4zSVJKciWvXqjUuFx8VFw==
UI-OutboundReport: notjunk:1;M01:P0:mOKMarcG88Y=;iHZioWDAFWTc7bGQQ2B79P4B0HA
 nXH7jRLD7+UnTe0M2FVZELkzHppqJrT/HOUw8V0Y7FvhxgOaOrjWbFN9o7XqCLChNeG9q4IpN
 OaKiKugh5cyERGP+Yh9suxX1Epp1KlNYaNs/Iq5ZjYdvRyPO2DZFZxoTWPnx3FpXI4UGEXbWx
 3brbrQPZcSGKgv+/z+HTAxNQej74kYxovHmbs9PghEEwM7HezxuE36DxZBz5GI+pgHgTvJB6Y
 xLESEBLbWuZq0GWqU7jUZmrPmtJ9E2puJJt5PzAbdsp8L8aRS4HY9eCtwOm41S1zs7u3re+vQ
 Jox0Wi3eAj2O84dd7rini6/v3eFF6IrOoddBd6f8uKFfBBg2/PmKUPq0/IAUXB//YsrgAJ7jW
 93OuUYpHn741wmdhq/phz4HEinQ90k71jIcqXPCTT4DzArh6gmN5uc5LQ9EjJFlrEQ/5z7AZ3
 FXP/bjmc5uVaJC9mIyR/wBmIubZmMU4yN3YfyJJCUvoCgYEtn8MQXwRP7ouK78QUoOTJMshOF
 txTqxLRbEPPT4hIDWzV1sWxzfTJVEazqEQU6N2dpY9Vl8CtrSg+7NaxkjOO3vgAJm83zIcXAh
 +Yvu/xp42FJ1LDLQSoCWk224/b1YHFINQ+1ZAv+5zuDCI+CVVjqoNJn0gIdXvPz98o0W/JQOu
 O9xyxMmzXLZCS/f1zrn8rRkqgUnwfQYiVXxIB0JrlrhNuXgrDNt+LdjVfNLCI8J2afsOLwTOT
 PlwRYTmrUMO+zGkO8E3xUEawnTSAd46KxQ4VymxXFMrqe0YwRM2UKqztRuf/UxENN8BwU1P8i
 jiM/JK2FFOMklPQvzEmIFvTdEe5J1K2o2uRzeYi3ntM4Gl35VSm8bwDaeloyUJvctq8Hw/zSf
 eY4TqCmRYrv0qfeCd+Uq4846fqCLsYXP0daqYT6l4hEaLUflRoh/1iu9owzdilhds+Bnw4JiW
 2s4qV4NryTzPeSRelZNWk6IttxE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-22 at 08:33 +0530, K Prateek Nayak wrote:
> Hello Mike,

Greetings!

> > FWIW, there are more tbench shards lying behind EEVDF than in front.
> >
> > tbench 8 on old i7-4790 box
> > 4.4.302=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4024
> > 6.4.11=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3668
> > 6.4.11-eevdf 3522
> >
>
> I agree, but on servers, tbench has been useful to identify a variety of
> issues [1][2][3] and I believe it is better to pick some shards up than
> leave them lying around for others to step on :)

Absolutely, but in this case it isn't due to various overheads wiggling
about and/or bitrot, everything's identical except the scheduler, and
its overhead essentially is too.

taskset -c 3 pipe-test
6.4.11       1.420033 usecs/loop -- avg 1.420033 1408.4 KHz
6.4.11-eevdf 1.413024 usecs/loop -- avg 1.413024 1415.4 KHz

Methinks these shards are due to tbench simply being one of those
things that happens to like the CFS notion of short term fairness a bit
better than the EEVDF notion, ie are inevitable fallout tied to the
very thing that makes EEVDF service less spiky that CFS, and thus will
be difficult to sweep up.

Too bad I didn't save Peter's test hack to make EEVDF use the same
notion of fair (not a keeper) as I think that would likely prove it.

	-Mike
