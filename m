Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D76076F064
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjHCRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHCRMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:12:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C65135B0;
        Thu,  3 Aug 2023 10:12:35 -0700 (PDT)
X-QQ-mid: bizesmtp63t1691082732teddj23p
Received: from i5.. ( [171.221.145.181])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Aug 2023 01:12:03 +0800 (CST)
X-QQ-SSF: 01000000000000B0Z000000A0000000
X-QQ-FEAT: Bt6VvACH2lwPmvZ2wuxvVFxFkkHSVWwlcaMiAMDC0B08fpKKS6wB6QtWXipYN
        8beeUpdbEY9DnoJrjVP3uoPPRobtceinwoceGDBfC84J5V/6uqqjtqb5EGDboke8Y5kEefG
        hFRC+gj4WEE1DVeZGeSsZvhsaROhkLsftu24zdL2sMjnWEnjWg35/OonaWJqq8sGRv8GQnQ
        uFJwTbR0FGouu6FkmpKB81mQJ7koSyXICQ8FT4/qDBL43I5mV6TXE8BSPF/UXXGGqPdZ3xA
        U+R93pxaYdbPtpaii5ETF2KlviuHpKIBd6YxBOahgg+0YUym0CmrSqq+0uIMLXXNBKMvZiv
        /WMVbpIA2OH/f6aPfRisAXDC7KZbw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6091542753805568780
From:   Kaige Ye <ye@kaige.org>
To:     irogers@google.com
Cc:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, ye@kaige.org
Subject: Re: [PATCH] perf stat-display: Check if snprintf()'s fmt argument is NULL
Date:   Fri,  4 Aug 2023 01:11:26 +0800
Message-ID: <5FADEC01265BADB6+20230803171126.134677-1-ye@kaige.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAP-5=fVTra0onRPsVq2guBkGhvuw7yvXNtjFJ5Eom9wrFZtsxA@mail.gmail.com>
References: <CAP-5=fVTra0onRPsVq2guBkGhvuw7yvXNtjFJ5Eom9wrFZtsxA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kaige.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 10:45:47 -0700 Ian Rogers <irogers@google.com> wrote:
> >
> > It is undefined behavior to pass NULL as snprintf()'s fmt argument.
> > Here is an example to trigger the problem:
> >
> >   $ perf stat --metric-only -x, -e instructions -- sleep 1
> >   insn per cycle,
> >   Segmentation fault (core dumped)
> >
> > With this patch:
> >
> >   $ perf stat --metric-only -x, -e instructions -- sleep 1
> >   insn per cycle,
> >   ,
> >
> > Signed-off-by: Kaige Ye <ye@kaige.org>
> > ---
> >  tools/perf/util/stat-display.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 7329b3340..e8936cffd 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -438,7 +438,7 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
> >                 fprintf(out, "%s%s", config->csv_sep, config->csv_sep);
> >                 return;
> >         }
> > -       snprintf(buf, sizeof(buf), fmt, val);
> > +       snprintf(buf, sizeof(buf), fmt ?: "", val);
> 
> Hi,
> 
> I couldn't reproduce this error and the code immediately above here
> does null check fmt:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-display.c?h=perf-tools-next#n437

Hi Ian,

I apologize for my carelessness. You're right, the code above doesn't need any change.
I'll send a new patch to fix it.

> Perhaps this is an older version of the perf tool? You can run "perf
> version" to determine this.

I found this bug with perf version 6.4.4, and I can reproduce the error with perf version 6.5.rc2.g76efcf004289.
The root cause is when I run `perf stat` like this:

  $ perf stat --metric-only -x, -e instructions -- sleep 1

It'll hit this line:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-shadow.c#n318

The error can also be triggered by:
- Replace the `-x,` option with `-j`
- Replace the `-e instructions` option with `-e cycles`

Thanks,
Kaige

> [...]

