Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036FF7BBA7D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjJFOkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJFOkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:40:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41053CF;
        Fri,  6 Oct 2023 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696603153; x=1697207953; i=efault@gmx.de;
 bh=6ocLe5mCpj5JliJZmmhdjcr12lLq+uiT5TG/FZLfMO4=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Z5k/qWRzGM5sOWULHpHiQjfqVtnhENB+PBzY/c9yx9b3si9bzWJNIdLCXdBuJuTl8xq7vVLwkGK
 RMJ1bt/4Tv4YrUAHfgA5sPy8sq7l7qCeAYKJkIdU3FtlPzrt95zYymCO54FsNap4CCFL5AT2RdLHy
 XBkEHI9ISTqag7yh67FzUJId1wDkMcNKrFz60rg9I73jwnWGz2ucMgLHToqb8m0TUQzEXv+AtdWkE
 jPTC0Xc2ttTxxPcN57vbTpm2r3YLXnnak+Rxh12dcd84Wu7hCSpN8rybJ5ZAUsP2SQZjT0w+omnRA
 ZcJDxKIhLcUMw+ctNKEzzzAXxN4b76ShJvfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.82]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1qxGpi1FWh-008Wwn; Fri, 06
 Oct 2023 16:39:13 +0200
Message-ID: <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "joshdon@google.com" <joshdon@google.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        Pavel Machek <pavel@ucw.cz>, "pjt@google.com" <pjt@google.com>,
        "qperret@google.com" <qperret@google.com>,
        "qyousef@layalina.io" <qyousef@layalina.io>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "timj@gnu.org" <timj@gnu.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "youssefesmat@chromium.org" <youssefesmat@chromium.org>,
        "yu.c.chen@intel.com" <yu.c.chen@intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Date:   Fri, 06 Oct 2023 16:39:09 +0200
In-Reply-To: <20231006140042.GG36277@noisy.programming.kicks-ass.net>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
         <20231005150258.GA36277@noisy.programming.kicks-ass.net>
         <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
         <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
         <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
         <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
         <20231006140042.GG36277@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ca1uBg7Wi+TN1pRX0GlOPnh7bWQolkjBVxxjpAPAi+VGC0DNzS4
 mIgEv+WCHzb6okNBF6pFOohK58WcULpma49+ZYKifEP8UwMDcWOtnX63lmxQ3QEFpKChDiz
 oMJXMgVxu1tfgqRXCV9j0ZEJRBfIe2hL0p7ziY7LNGievsqtELlOYqXf32NBnB2FtRYAPcV
 Ypnyt8x1gHr5ko9TqApkg==
UI-OutboundReport: notjunk:1;M01:P0:lOAnfQNL7L4=;97F/blw5sAmXcOy4IQxvmmsUqt/
 R6ZfCTYXl/Gkc0NqF2dUNEavmBaEAK0C8SwxdjirUnPRySPqU5mKyw1YCrBKMbyBPgHFAqbpu
 Pb1Ti94zdsaX4jEH5e6PD0w1ovst+q5qRAzslSmTyH3S+7NdSwz5NukjOMO3H1d8tTCLUFi+c
 bvEK311b7QNWga0Xqayom8lxCX3pAfTE1AW598IMUYF8h8bfVUqRuaqx+eodiCwOHGk5qH7nL
 c9afeQR/Iav+QH8d/rTYQZaA5Ob1Rg3wmvG1Kn17pS/9vE60q6jzQihv6PYQjFWz0Un6GdlQ6
 VyG8qzRnYYZ4DwmquO+604bdJRF5nbEWP1FNx4T+W7zntEYsna8tP85d0HUxRANRlW+EW2lm0
 c9XipsnCGoZ48p1P09t+UGIha0LZhm8v2QcNH8uRg5zb7PJa+XGgyoauFSto8E68dvfdSYu1b
 EE8dYrn8Zsr3KacFGHAAHQehBvqmsO4ur1MIG49TswI45jmMIBkFJCV2L5TNGvHV37nNHK7/A
 M87BOuKbAWlApOKSl38uRlND/0vCnCMrDTJ2la7AMfRF2mKuMqM8geim4V+uE97AewVXO801X
 QX8w/nk2o1sMppNL/IFM/jAq1EFRoibrplyOBUGPawiIIRSSHHmypclw15ov5WN+Z69LW1kJ3
 LGDYPSjYuuAM67U2tG+qcD+C382EaYZ3csiwWWZQTR3k4V5LQkiN6Ml4mYG71s6Gg08lFRUM1
 bfjFJlYbjQZtEO9amILvDPwSMpCIEOT2KchrJOnvfPJ0EhcgcJ9VrIkHEWUj9rGX4jC9N9FVc
 ylDfjFhIuib3D4FwO2HuTAoS06HT1rBXqJV3VKH0g6zBcCfSbTfyk9spcAHA9nOaUpWN7xvZe
 5n5Oon2SsjyMUISdJYOtAA+NJl0MXpKZ6jJ8YqMjpvIovWarnSdUZzyAZ73QvTchNUb9F8AP3
 06TEKnwDec0LZDDcFNAysLAUDHg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-06 at 16:00 +0200, Peter Zijlstra wrote:
> On Fri, Oct 06, 2023 at 12:31:28PM +0200, Mike Galbraith wrote:
> > On Fri, 2023-10-06 at 10:35 +0200, Marek Szyprowski wrote:
> > >
> > >
> > > Just to note, I've run into this issue on the QEmu's 'arm64/virt'
> > > platform, not on the Samsung specific hardware.=C2=A0
> >
> > It doesn't appear to be arch specific, all I have to do is enable
> > autogroup, raspberry or x86_64 desktop box, the occasional failure
> > tripping over task groups, leaving both best and best_left with
> > identical but not what we're looking for ->min_deadline.
>
> OK, autogroups enabled and booted, /debug/sched/debug shows autogroups
> are indeed in existence.
>
> I've ran hackbench and a kernel build, but no whoopsie yet :-(
>
> I suppose I'll kick some benchmarks and go make a cup 'o tea or
> something.

Hm, just booting gets me a handful, and generic desktop activity
produces a fairly regular supply.  This is virgin 6.6.0.ga9e6eb3-tip.

[  340.473123] EEVDF scheduling fail, picking leftmost
[  340.473132] EEVDF scheduling fail, picking leftmost
[  343.656549] EEVDF scheduling fail, picking leftmost
[  343.656557] EEVDF scheduling fail, picking leftmost
[  343.690463] EEVDF scheduling fail, picking leftmost
[  343.690472] EEVDF scheduling fail, picking leftmost
[  426.224039] EEVDF scheduling fail, picking leftmost
[  426.224080] EEVDF scheduling fail, picking leftmost
[  426.224084] EEVDF scheduling fail, picking leftmost
[  426.363323] EEVDF scheduling fail, picking leftmost
[  426.759244] EEVDF scheduling fail, picking leftmost
[  426.759256] EEVDF scheduling fail, picking leftmost
[  441.872524] EEVDF scheduling fail, picking leftmost
[  441.872556] EEVDF scheduling fail, picking leftmost

