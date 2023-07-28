Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E62766FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbjG1Oms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbjG1Omq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:42:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ABE1AD;
        Fri, 28 Jul 2023 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1690555313; x=1691160113; i=georgmueller@gmx.net;
 bh=M/WETmw5YIFP0LfRJ5a0hlrmqjLYh88H3TYqQUuDLdg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=irSBPPfsD9YZWAOoLipis84tV4HY5LroJoPAytKtykYfw9PxsUvriC+YKqWh6yTuAizMhy7
 pRAvDM7vGICrT/FKpnz7bp+NhefqKYSasC2tqDJBXp2v4Za009ZmyP5L5byKVpWexWU4y7MI7
 Lf+nO7EAXI1jNkYySLM8WTz/bU4PTME5Afai9Vr6Bz7H+DFywHvaOB1/TVpz8g1rBtrfMcl4o
 iYciGffDtIZlV+e180y/dcklMQJrgUGoK+Z+Ow5U554VvFzj37No6kWTYIwL2SMAHicCJtXFl
 w10YdaTU+VDyfIxpwHR5I3ildC6jXqYkpd7eMluRWpT+xZhG6Ncg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.54.0.101] ([79.246.95.128]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1pweU51ln6-00g23i; Fri, 28
 Jul 2023 16:41:53 +0200
Message-ID: <adcb2f0e-9db1-dd5a-91dd-6f5567357174@gmx.net>
Date:   Fri, 28 Jul 2023 16:41:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] perf probe: add test for regression introduced by
 switch to die_get_decl_file
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        regressions@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230628082337.1857302-1-georgmueller@gmx.net>
 <20230628082337.1857302-2-georgmueller@gmx.net>
 <CAP-5=fUP6UuLgRty3t2=fQsQi3k4hDMz415vWdp1x88QMvZ8ug@mail.gmail.com>
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
In-Reply-To: <CAP-5=fUP6UuLgRty3t2=fQsQi3k4hDMz415vWdp1x88QMvZ8ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sDrqkfLvyKv87wPdI67Pfq8Dl0IoJ7GwNZNYrQTBseNuxPM0HT1
 qaKXhyQgK8x53dir8/keVvV22/H9RvuV71zhL1tJG6CDG1X4iCBQxMORJKb8tItAU7iI9IX
 heIB3x11p57i727oXCjTtGgruGT5oIT7tJukV+4omfX7u6h1x+dBmFZoC8eTsDC2H4XXl8f
 RCUgGladaVclQG/JHOtbg==
UI-OutboundReport: notjunk:1;M01:P0:jMofSfNp27s=;ALDfp4otrWiPAi0bWjifjlNZHxp
 FBbnIv+agpXiztrLKqyKpIQny49hWZ/AfZHlEqm0cFNlKQAMXWdBWzSA7arZy6yw9shgjbwiz
 Sk6IirbVwFZpg51EOEGApCAw3zaWP9d5fY5zwJYfCsSFmuTXBkqS3lnYOTuT3U6Npt75H3B9l
 C22ALRlC3RLbO9rCMTPJCLrhvlBbXVErl6FdsGuFgH/2SiKD12cODw0HENT7fkWwmBrrMA27x
 rswn5qfdcr84cbvauFzegSqfNKAioIqCDCtWA7KKYWCLfNR5bfUdin0EHapSO0LGSWgoGIFxE
 029AZGpjK4D9RM3ncmPDJ8m31dhvEEyIE++JhRtW6+cqq9Lg6q8cG0tDOeOzPCLZ3KV+b3FcO
 iQi2aUm6aiwE5m0zKFGktutYM66VooTrUJJaocfB26IN/bQ5EahN2wYciKqX+aiwWYTMnWMGn
 fYJJSq534xJNFez2X1DaNMQ1TtamRDDxmoETXUmd+TozWRAMisn6/2tP+MyzFLPAe66A5wPnp
 JSmcyaGgF1t+S/utiBz6QbZRwH/uaEviIFZnnI67CyfdFdmCk3QB5FTiRMCXkdcoJrEvwwtOu
 O+p2TjUOwg1ZLQXgwaGMegIqtrmBKA75q6CHA45ykdIr4TOzyozuBVBWsoylWgfQzL3srPqaW
 SXHIZY6xOjQtVvhjWhc8PSv+7jQKJQTV2zvazKzX8OJVhjx39NXkkifPO4A9dMkehmSz0vrSK
 QzVBPEyaVyvhol5UQbKEsX/u3lv7SgYopDVxeYyI4q+GP5iQM/meAl3z6hZuNmHaEmVkne577
 xc90UBXi5Cjdm2CbuPPWPHMLOrmY66XtBgdpOw9BX/oIH52isqOtnW0KTzTU0HwwwlclTtHJM
 5qtxKPThslkhRUT8pYdHygR3tCS7eM+O5xtuzNXeRtVp8ik8RQJfZaIuvf+eHl/gQV7Lqi5PS
 m83DSw==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 27.07.23 um 19:45 schrieb Ian Rogers:
> On Wed, Jun 28, 2023 at 1:25=E2=80=AFAM Georg M=C3=BCller <georgmueller@=
gmx.net> wrote:
>
> Thanks for the test Georg! By directly relying on gcc this test fails
> for me in some constrained environments, like containers. I think
> there should be a skip if gcc isn't present. A different option is to
> just build the test code into the perf binary itself as a test
> workload:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git=
/tree/tools/perf/tests/workloads?h=3Dperf-tools-next
>
> Wdyt? Thanks,
> Ian
>

I prepare a commit which checks for gcc and skips the test in this case.

I think building thi test code into the perf binary itself is not an optio=
n
here, since the test relies on a special setup of using -flto for one of t=
he
compilation units.

There is also a cleanup issue if anything fails. This will be included in
the patch as well.

Best regards,
Georg
