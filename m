Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01476EB41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjHCNyk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHCNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:54:39 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A76194;
        Thu,  3 Aug 2023 06:54:38 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-563393b63dbso131050eaf.1;
        Thu, 03 Aug 2023 06:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070877; x=1691675677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0uojx/PSR6NRVoOOYI8BdNOR0rI5Yxlweh79ZGfbrQ=;
        b=VrrbwkXRlRvx392sqNtvnHi6Z99scB0cwphZyk89G7mhPd1eb1XjNGrwZDcIZ2ykE0
         6d562gIaGS8O0g27LcS/N4OQx09zUXgoc/n8LwuFT5QQaqVBE+geR1xOW9cMNIvU4sqT
         g+2kQfM9/7Xj6BPbvBD0ZTNBzvn7QRHcyDDZ2ehO76KXwJrNdS+Q7cXmhj+sNE54Lr7Z
         zjU4cpPVecLofPYE9ss3P4wViyglxb2Pt9dzOj7691CdKTStT1JSLQXtzN/NWIXVwhsH
         nuAc26Qx1EPjn1p8mLDMQDMTBSNmrBUq3cPy5Cst2CKIFCpekfd4s5tBC5LvaF+T4RvO
         piKw==
X-Gm-Message-State: ABy/qLbCkZBD6ddA/7dX1ZNsxAkliQGCQ5dVwkS8yq5p4A43MhG/ZWCS
        zruKSHQTUXe6H+v1GtLfzKVzfhMhzAkX/lSDq2FCNFx2
X-Google-Smtp-Source: APBJJlH8QBBe/1Zdnnp+6mBnDgrxY4JAWToHxCeYgNP2HjzSXTvNuZDm1UME8fCXLSDUW4KweY+wy3+ORvw1x9SlCMA=
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id
 d5-20020a4aa585000000b0056c484a923dmr12865389oom.1.1691070877330; Thu, 03 Aug
 2023 06:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <4511619.LvFx2qVVIh@kreacher> <ZMupCqOA+v6QGdWN@e126311.manchester.arm.com>
In-Reply-To: <ZMupCqOA+v6QGdWN@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Aug 2023 15:54:26 +0200
Message-ID: <CAJZ5v0haMtqmsfo4JLVgfagtK=60nqfRm2=C1X-8WjhxMO5uiw@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v1 0/2] cpuidle: teo: Do not check timers
 unconditionally every time
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kajetan,

On Thu, Aug 3, 2023 at 3:18 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi Rafael,
>
> On Tue, Aug 01, 2023 at 09:35:15PM +0200, Rafael J. Wysocki wrote:
> > Hi Folks,
> >
> > This is on top of the fixes series posted previously:
> >
> > https://lore.kernel.org/linux-pm/4515817.LvFx2qVVIh@kreacher/
> >
> > (I'll put it all into one git branch tomorrow).
> >
> > I started to play with the idea described here
> >
> > https://lore.kernel.org/linux-pm/CAJZ5v0hQh2Pg_uXxj8KBRw3oLS1WdsU+rUafBAAq7dRdbRwYSA@mail.gmail.com/
> >
> > and this is the result.
> >
> > Note that this is completely experimental, even though it doesn't kill any of
> > the test boxes I've run it on.
> >
> > Patch [1/2] moves the tick_nohz_get_sleep_length() call in teo_select() after
> > a preliminary idle state selection based on statistics and patch [2/2] adds
> > checks to avoid it completely if the idle state selected so far is shallow
> > enough.
> >
> > I would appreciate checking if this actually makes any difference.
> >
> > Thanks!
>
> As mentioned in the other thread I did some testing with these two
> patches on top as well, here are the results:
>
> 1. Geekbench 6
>
> +---------------------------+---------------+-----------------+-------------------+
> |          metric           |      teo      |     teo_tick    |    teo_tick_rfc   |
> +---------------------------+---------------+-----------------+-------------------+
> |      multicore_score      | 3320.9 (0.0%) | 3303.3 (-0.53%) |  3293.6 (-0.82%)  |
> |           score           | 1415.7 (0.0%) | 1417.7 (0.14%)  |  1423.4 (0.54%)   |
> |      CPU_total_power      | 2421.3 (0.0%) | 2429.3 (0.33%)  |  2442.2 (0.86%)   |
> |  latency (AsyncTask #1)   | 49.41μ (0.0%) | 51.07μ (3.36%)  |   50.1μ (1.4%)    |
> | latency (labs.geekbench6) | 65.63μ (0.0%) | 77.47μ (18.03%) | 55.82μ (-14.95%)  |
> | latency (surfaceflinger)  | 39.46μ (0.0%) | 36.94μ (-6.39%) |  35.79μ (-9.28%)  |
> +---------------------------+---------------+-----------------+-------------------+
>
> Ie the big picture is all right, the latency either improves with these
> patches or the spike in the previous patchset was an anomaly, either way
> seems fine. Not sure where the change in the score is coming from but
> for the record the line plots of the 3 iterations for both the tick
> variants look the same while they're slightly distinct from the pure 'teo'
> variant. It's still a below 1% gap so not the end of the world if
> there's benefits elsewhere.
>
> +-------------------+---------+------------+--------+
> |      kernel       | cluster | idle_state |  time  |
> +-------------------+---------+------------+--------+
> |        teo        | little  |    0.0     | 146.75 |
> |      teo_tick     | little  |    0.0     |  63.5  |
> |     teo_tick_rfc  | little  |    0.0     | 62.48  |
> |        teo        | little  |    1.0     | 53.75  |
> |      teo_tick     | little  |    1.0     | 146.78 |
> |     teo_tick_rfc  | little  |    1.0     | 147.14 |
> +-------------------+---------+------------+--------+
>
> The idle numbers look pretty much the same as the previous variant which
> confirms that the change for the little cluster residency is caused by
> the previous changes but also that these two patches don't affect it.
>
> 2. JetNews
>
> +-----------------+---------------+----------------+-------------------+
> |     metric      |      teo      |    teo_tick    |    teo_tick_rfc   |
> +-----------------+---------------+----------------+-------------------+
> |       fps       |  86.2 (0.0%)  |  86.4 (0.16%)  |   86.0 (-0.28%)   |
> |    janks_pc     |  0.8 (0.0%)   |  0.8 (-0.66%)  |   0.8 (-1.37%)    |
> | CPU_total_power | 185.2 (0.0%)  | 178.2 (-3.76%) |   182.2 (-1.6%)   |
> +-----------------+---------------+----------------+-------------------+
>
> Pretty much no change here, the power is still better than in base teo.
>
> +-------------------+---------+------------+-------+
> |      kernel       | cluster | idle_state | time  |
> +-------------------+---------+------------+-------+
> |        teo        |   mid   |    -1.0    | 21.63 |
> |     teo_tick      |   mid   |    -1.0    | 21.57 |
> |    teo_tick_rfc   |   mid   |    -1.0    | 17.66 |
> |        teo        |   big   |    -1.0    | 8.81  |
> |     teo_tick      |   big   |    -1.0    | 8.55  |
> |    teo_tick_rfc   |   big   |    -1.0    | 12.04 |
> +-------------------+---------+------------+-------+
>
> This part slightly stands out so could be worth noting. For some reason
> the trace registers a few seconds less running time (-1 means 'not
> idle') on the mid cores but a few seconds more on the big cores. This
> wasn't the case for the 'teo_tick' variant before so looks like it's
> caused by these two patches. Doesn't seem to be an issue though, just
> interesting.
>
> TLDR:
> Does not blow up, looks okay :)

Thank you for the feedback, much appreciated!

I'll likely send a new version of this series later today including
one more patch and I will set up a git branch with it later.

Thanks!
