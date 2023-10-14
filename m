Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1A7C9368
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjJNIJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 04:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 04:09:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A10B7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697270884; x=1697875684; i=efault@gmx.de;
 bh=cKejKnNnw7Yv2UhJa2XOk2CSZhC1OKBfEuZwfonZVjc=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=iYvHkn04TUSskNo3PyjuNUS2Pj9SIrn6GflHvmy/1bQ/XuzVDl+MNYx8oB8cbKqKEXZGvhdxK7o
 Csel5/OKB5cF8+bMsSA2+nksAWsS+JaOAJjifbS3W99LwTX8aDPdu6wTWuSPEWxU+yZVQavxgBV70
 dYS1ETYGXb7R/hTibanRiD8dqz5Imd3kFiFmsmf0X1WaznX73x/bWyM5vii+VI4NxrNd06ecwnEeO
 zDAJD4vMBB7m2JP/k3YzEqyref3tv0inqELVdOz8CwnASzLiBJBwSTnObJGB5wrHe3z++exrv5PL6
 r37Q16nKBT8xQPI6d/3EM1ry9zwZqO93fGUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.116]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzT4-1rCPOq0tpc-00PKsx; Sat, 14
 Oct 2023 10:08:04 +0200
Message-ID: <9f51aa0683d0fc0dc046331691b4f18324548cf4.camel@gmx.de>
Subject: Re: [PATCH 03/15] sched/fair: Add lag based placement
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Benjamin Segall <bsegall@google.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de
Date:   Sat, 14 Oct 2023 10:08:00 +0200
In-Reply-To: <20231013163524.GA5294@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
         <20230531124603.794929315@infradead.org>
         <xm26fs2fhcu7.fsf@bsegall-linux.svl.corp.google.com>
         <20231012223428.GP6307@noisy.programming.kicks-ass.net>
         <20231013163524.GA5294@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+x1j152oyfrpc5KCf+ZYN6zvI2aGCfktYFhyb7pVZhhJmR091Vp
 AgJuV4EeQ+wle7n2NflsNkUMIuhBAx6cQDkMtcLO5Xm/p9BOPOl5dREtXKrNcbPFgxYGxBN
 TN0bODzCoV6+9iemx3zQZrO6QYQUnNSrI8bKw3z5dbQMlJJyXdpIFrfJMP1AOfE3eomsEsm
 AThf/xVWtUZBD/CjCTBug==
UI-OutboundReport: notjunk:1;M01:P0:IUsnprGvpiU=;bRCNaYK/Xwf98Dcc/5x9oVU7rNG
 qrl2wl4aaeq6D8MZMk/uisTfbQ+UMZsU1UuK1bcudk5+oHrSGq753Be6FJAASpPVQbkivaf4E
 TsXkWXEmiktXDmwEYWSIkvEbXoEvpWBcWT4BUnA46ERi6TTwjiXUkLdxX6wTs5S6Sh6nhnqGl
 gYAV1AJgrfWIdGL3bDK4nt8YnbtSztXc26o8uNQHYnDTMdQv+h0R6tl5b3/4GCWN7REdVAVIT
 rKoWmUYaOeHPH2bj4ly7FuFSHYR4aU4pzvZa2G9gU8iD9WCubOLU8jZ4zbO0MQz7+muWx60LB
 UDpIwpeNQaVV9KJSit+Vi14PP2JAeeEiUESTxA5+zjxi9t96BBBpSalYLX/JNgglmiaeVzFDj
 pWjE+0UuT0WkBSGwh3YAhPcJN6U075djrzs8jLlbaK+V6UWmNtLOinYK5yy6Fy0pViUaV0Xb9
 qdyvZV7quVw3Do0U2OfnuI4BPKa3ec1B+AdqUMDO7tpl1URWP8GBCtQPEf+h6+8MdImwmBTM2
 0995SLvc0+9nQruRrYDZbPTXzFEvy9G2nZrEkMTqNIpshb6bZyB1QT5AI9mqJmlKrP1gmcwyH
 Tntyvz/m4AB3da8GaYeOvcvgwKhVWi4sY1CKve9WHtSfEMK2xKAeVQnXXK9mrR20hkYwQ92Ec
 kyMzqlPg2g7/kFM0ZkMwC5AH3foFv3uq7DAf6JO3yZb50ev30AHERMpoEg/ZQgsz3kAVI+UhV
 GuoRpfEKdBs8ZfbbEpmI3gYmgbriQJpEiCvp3fY1/cJznJHzVG6NdxaKHRlgLF797q/FqXcAQ
 +DTKed3fO/TFtkVn5ac6QUEcHBgwZm56PvMcap3hO58paRJUUXPrKWXNsCt4jC+odN6pEtXFR
 LqImkMNQsf0FCQUjEGXio2wVjJClGLp9INSlTWzwb4CWf7dWH9qc8rAagLsvcKAbwo6i0Fktl
 eek/oGcJ+6KqaCZEkFfASzIphBA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-13 at 18:35 +0200, Peter Zijlstra wrote:
> On Fri, Oct 13, 2023 at 12:34:28AM +0200, Peter Zijlstra wrote:
>
> > Right, so I do have this:
> >
> > =C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.gi=
t/commit/?h=3Dsched/eevdf&id=3D344944e06f11da25b49328825ed15fedd63036d3
> >
> > That allows tasks to sleep away the lag -- with all the gnarly bits th=
at
> > sleep time has. And it reliably fixes the above. However, it also
> > depresses a bunch of other stuff. Never a free lunch etc.
> >
> > It is so far the least horrible of the things I've tried.
>
> So the below is one I conceptually like more -- except I hate the code,
> nor does it work as well as the one linked above.
>
> (Mike, this isn't the same one you saw before -- it's been 'improved')

Still improves high frequency switchers vs hogs nicely.

tbench vs massive_intr

6.4.16-stable                  avg
2353.57  2311.77  2399.27  2354.87  1.00

6.4.16-eevdf                   avg
2037.93  2014.57  2026.84  2026.44  .86   1.00  DELAY_DEQUEUE    v1
1893.53  1903.45  1851.57  1882.85  .79    .92  NO_DELAY_DEQUEUE
2193.33  2165.35  2201.82  2186.83  .92   1.07  DELAY_DEQUEUE    v2

It's barely visible in mixed youtube vs compute in i7-4790 box,
squinting required, and completely invisible in dinky rpi4.

A clear win along with no harm to the mundane mix is a good start in my
book.  Here's hoping canned benchmark bots don't grumble.

	-Mike
