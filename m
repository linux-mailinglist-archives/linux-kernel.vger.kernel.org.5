Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCF765D01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjG0UNL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jul 2023 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjG0UNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:13:10 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADECBE47;
        Thu, 27 Jul 2023 13:13:08 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56475c1b930so176181eaf.0;
        Thu, 27 Jul 2023 13:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488788; x=1691093588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5Z31Dq5VWK2apYQ/bvG19BYq0hISSJX9VnwC0J6vTg=;
        b=BQkYGyaX0c0jsh/oaidhkkGbXEVjca9dtOXnTqqV64piuemI2+z9X6SGLxi50vQ5nv
         6cXqgUzr1if6W8dchD/aNQYCkYHbL0ODQoUGNlI9TPuw6PtfClYQRuWYrIbqtS6Q95Fw
         TvsIwYg2lbpCe0/o28DXhfz5EhTFYXfcHChYh+3gxjUt+/qKN1w+a+OlGGsbL8IHtd2z
         kXzh1WUfwiVx4xly91PVqpdKp/mRHSqygQyVdPP7mGQVMlnM4OpAIpAwIH9hhUPvOsTr
         R+ijs6KK5Wmz7RqkZ9ZEdZrTKoj8//fRYjZYVu3C+0KER69QjpQiVA45Nl33rYjl+3Wo
         GIVA==
X-Gm-Message-State: ABy/qLbNXiLOpKZfAE/M52Z24J9tfl/7Oeu+0DN6TsVb7tOy/JNe1W6D
        PfZW0dgZspKzyfamlXT2WUIUlkFWsFaVBos1E9d3XTkc
X-Google-Smtp-Source: APBJJlE+5WCDAGDphOpgTpC96fI64euD/U8QM5jbQYMAU92UDLulFFTCuVFyQdLuchdl+KeAwtSLRP6nesgHW23upDM=
X-Received: by 2002:a4a:db86:0:b0:560:b01a:653d with SMTP id
 s6-20020a4adb86000000b00560b01a653dmr565021oou.0.1690488787631; Thu, 27 Jul
 2023 13:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <4506480.LvFx2qVVIh@kreacher>
In-Reply-To: <4506480.LvFx2qVVIh@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jul 2023 22:12:56 +0200
Message-ID: <CAJZ5v0hnRm7Nnup3HPWedEchzLD_9w8OPkhQ0vjpR3uAL3HUoQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: teo: Update idle duration estimate when
 choosing shallower state
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
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

On Thu, Jul 27, 2023 at 10:05 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The TEO governor takes CPU utilization into account by refining idle state
> selection when the utilization is above a certain threshold.  The idle state
> selection is then refined by choosing an idle state shallower than the
> previously selected one.
>
> However, when this is done, the idle duration estimate needs to be updated
> so as to prevent the scheduler tick from being stopped while the candidate
> idle state is shallow, which may lead to excessive energy usage if the CPU
> is not interrupted quickly enough going forward.  Moreover, in case the
> scheduler tick has been stopped already and the new idle duration estimate
> is too small, the replacement candidate state cannot be used.
>
> Modify the relevant code to take the above observations into account.
>
> Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> @Peter: This doesn't attempt to fix the tick stopping problem, it just makes
> the current behavior consistent.
>
> @Anna-Maria: This is likely to basically prevent the tick from being stopped
> at all if the CPU utilization is above a certain threshold.  I'm wondering if
> your results will be affected by it and in what way.
>
> ---
>  drivers/cpuidle/governors/teo.c |   33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/cpuidle/governors/teo.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> +++ linux-pm/drivers/cpuidle/governors/teo.c
> @@ -397,13 +397,22 @@ static int teo_select(struct cpuidle_dri
>          * the shallowest non-polling state and exit.
>          */
>         if (drv->state_count < 3 && cpu_data->utilized) {
> -               for (i = 0; i < drv->state_count; ++i) {
> -                       if (!dev->states_usage[i].disable &&
> -                           !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
> -                               idx = i;
> +               /*
> +                * If state 0 is enabled and it is not a polling one, select it
> +                * right away and update the idle duration estimate accordingly,
> +                * unless the scheduler tick has been stopped.
> +                */
> +               if (!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
> +                       s64 span_ns = teo_middle_of_bin(0, drv);
> +
> +                       if (teo_time_ok(span_ns)) {
> +                               duration_ns = span_ns;
>                                 goto end;
>                         }
>                 }
> +               /* Assume that state 1 is not a polling one and select it. */

Well, I should also check if it is not disabled.  Will send a v2 tomorrow.

> +               idx = 1;
> +               goto end;
>         }
>
>         /*
> @@ -539,10 +548,20 @@ static int teo_select(struct cpuidle_dri
>
>         /*
>          * If the CPU is being utilized over the threshold, choose a shallower
> -        * non-polling state to improve latency
> +        * non-polling state to improve latency, unless the scheduler tick has
> +        * been stopped already and the shallower state's target residency is
> +        * not sufficiently large.
>          */
> -       if (cpu_data->utilized)
> -               idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> +       if (cpu_data->utilized) {
> +               s64 span_ns;
> +
> +               i = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> +               span_ns = teo_middle_of_bin(i, drv);
> +               if (teo_time_ok(span_ns)) {
> +                       idx = i;
> +                       duration_ns = span_ns;
> +               }
> +       }
>
>  end:
>         /*
>
>
>
