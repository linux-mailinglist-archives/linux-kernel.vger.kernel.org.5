Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED66769FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGaRv2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGaRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:51:26 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DCADC;
        Mon, 31 Jul 2023 10:51:25 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6b9da57da6bso545885a34.0;
        Mon, 31 Jul 2023 10:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690825884; x=1691430684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+JkNS7y6iFOYB1q8wNZKe6z0SLxh9/YAsuQt8DVUlU=;
        b=W4teAq+sJXzofOL2vvcyV2wEx/noc+AZfji6PJ9k3CpUkkRIIHcOd5rGpda2ccN+Je
         b8h5s91og1BYq1jUdDbzcQoaH1HvXpqXrG1gHZwtWKUB770mWhsOtwVrpHvBpE7q/5AK
         Vjid8tgoP0Io0YMcL/tY6za9xFfwOIXiVTsC+0Wv9JrhJJs+bH6e5d1ZFR0VSjuJ6Eec
         GWpHljsxsu6A2lOA5hkIRBpfI4UE5ZlRHBtifZhFCZuaFIlsJI7EBc4Aljsn5adUblab
         aDLzQP/cb5hsr3nye/mXEbv1w7Pfsf2Mo8aHrSJSn3TF9mMltpjSBFVYLTSKGuEzQYKT
         blQw==
X-Gm-Message-State: ABy/qLal9vkbfcIpH8ak0BnyfUEVx9zg24tjC7t2uKVuKqMx/5jBcopF
        maPPEQgnLxTiAVslzwFXPZT+RDDINwdu8dDXBJA=
X-Google-Smtp-Source: APBJJlHPE8yzXNkDF8Fe+crD1Fgd+0FV2ylqSdty85TQsHTVp9mS34JQ3hj55nLyT1+WPWG9azUhWjRJBs+Rxq13AZk=
X-Received: by 2002:a05:6870:1697:b0:1be:ec3c:1ef with SMTP id
 j23-20020a056870169700b001beec3c01efmr2918523oae.0.1690825884678; Mon, 31 Jul
 2023 10:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <8b6b73a7-aff4-21e-5c55-294fcf67934e@linutronix.de>
In-Reply-To: <8b6b73a7-aff4-21e-5c55-294fcf67934e@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Jul 2023 19:51:13 +0200
Message-ID: <CAJZ5v0jJxHj65r2HXBTd3wfbZtsg=_StzwO1kA5STDnaPe_dWA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] cpuidle,teo: Improve TEO tick decisions
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
        tglx@linutronix.de, frederic@kernel.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 1:47 PM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Hi,
>
> On Fri, 28 Jul 2023, Peter Zijlstra wrote:
>
> > Hi,
> >
> > Wanted to send this yesterday, but my home server died and took everything
> > down :/
> >
> > These patches are lightly tested but appear to behave as expected.
> >
> >
>
> As I was asked to see if the patches of Raphael improve the behavior, I
> rerun the tests with Raphaels v2 as well as with Peters RFC patchset. Here
> are the results (compared to upstream):

Thanks for the numbers!

>                         upstream                raphael v2              peter RFC
>
> Idle Total              2533    100.00%         1183    100.00%         5563    100.00%
> x >= 4ms                1458    57.56%          1151    97.30%          3385    60.85%
> 4ms> x >= 2ms           91      3.59%           12      1.01%           133     2.39%
> 2ms > x >= 1ms          56      2.21%           3       0.25%           80      1.44%
> 1ms > x >= 500us        64      2.53%           1       0.08%           98      1.76%
> 500us > x >= 250us      73      2.88%           0       0.00%           113     2.03%
> 250us > x >=100us       76      3.00%           2       0.17%           106     1.91%
> 100us > x >= 50us       33      1.30%           4       0.34%           75      1.35%
> 50us > x >= 25us        39      1.54%           4       0.34%           152     2.73%
> 25us > x >= 10us        199     7.86%           4       0.34%           404     7.26%
> 10us > x > 5us          156     6.16%           0       0.00%           477     8.57%
> 5us > x                 288     11.37%          2       0.17%           540     9.71%
>
> tick_nohz_next_event()
> count                   8839790                 6142079                 36623
>
> Raphaels Approach still does the tick_nohz_get_sleep_length() execution
> unconditional. It executes ~5000 times more tick_nohz_next_event() as the
> tick is stopped. This relation improved massively in Peters approach
> (factor is ~7).

So I'm drawing slightly different conclusions from the above.

First, because there are different numbers of idle cycles in each
case, I think it only makes sense to look at the percentages.

So in both the "upstream" and "Peter RFC" cases there is a significant
percentage of times when the tick was stopped and the measure idle
duration was below 25 us (25.39% and 25.54%, respectively), whereas in
the "Rafael v2" case that is only 0.51% of times (not even 1%).  This
means a huge improvement to me, because all of these cases mean that
the governor incorrectly told the idle loop to stop the tick (it must
have selected a shallow state and so it should have not stopped the
tick in those cases).  To me, this clearly means fixing a real bug in
the governor.

Now, I said in the changelog of my v1 that the goal was not to reduce
the number of tick_nohz_get_sleep_length() invocations, so I'm not
sure why it is regarded as a comparison criteria.
