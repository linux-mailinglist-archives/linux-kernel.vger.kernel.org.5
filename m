Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A578CC52
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbjH2Snu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 14:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjH2SnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:43:19 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2419A;
        Tue, 29 Aug 2023 11:43:16 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1c134602a55so1003417fac.1;
        Tue, 29 Aug 2023 11:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334596; x=1693939396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hrAF9koGhO3AR5bD0rbczrXkKrad5wwFyJYLSucsi4=;
        b=FnlZ+/cfWXOSkkgQ8/TuoBEANQRYv9K/QzQDkRH0BE9NlExfQJdeJor+lmmgO+HtP9
         B7B091if/n2Y7LIfaqFVzXKVnLhQJy3oEABZvKyaT2ZYyGlrS8XWLIbq+pq0vkiaqokd
         jU0Zv0j4NT1aTXh5lyXTu2NQH/9b97K91OmnxlCWFUuxBbRRODEbm4f1pbgCOyKcAK8t
         eSrzs3zksd+qnPG5N98Qz7UcS9k4/mxW2xRtm1/4QiLWaC6PnlkEONEo028Wc7n1EDS7
         PfXjNEASuPXsa4u79fjY+jbtD8lHSbu9rcF9QJES6sTs9f+KE3EKAfpF+c5PX71Hjx3y
         miEw==
X-Gm-Message-State: AOJu0Yw7jOcYLRgzUlB2q36qywbaR88G6XfVkIseeh5ol0cnLMtTfZjs
        FIvftRwCryov46z3dob1HehGrFPc8CKOTWG/ir5+zOep
X-Google-Smtp-Source: AGHT+IFKuc8cMaf60WS7evIZip+73Std+UxfHTWwykEUZKSoNsLwBTLFdcJZnMvlz3cUlmnDBmBBcGCO5KruqdcOGmE=
X-Received: by 2002:a4a:ded9:0:b0:573:55af:777c with SMTP id
 w25-20020a4aded9000000b0057355af777cmr10471583oou.0.1693334595754; Tue, 29
 Aug 2023 11:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230826095743.1138495-1-liaochang1@huawei.com> <20230828070206.dc44mhe4qztg52kc@vireshk-i7>
In-Reply-To: <20230828070206.dc44mhe4qztg52kc@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 20:43:04 +0200
Message-ID: <CAJZ5v0hSNC1f9vBHYF6SP73jxXhW3EM8WdC4ObZhHk1OSx_xQA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: pcc: Fix the potentinal scheduling delays in target_index()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Liao Chang <liaochang1@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 9:02 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-08-23, 09:57, Liao Chang wrote:
> > pcc_cpufreq_target():
> >       cpufreq_freq_transition_begin();
> >       spin_lock(&pcc_lock);
> >       [critical section]
> >       cpufreq_freq_transition_end();
> >       spin_unlock(&pcc_lock);
> >
> > Above code has a performance issue, consider that Task0 executes
> > 'cpufreq_freq_transition_end()' to wake Task1 and preempted imediatedly
> > without releasing 'pcc_lock', then Task1 needs to wait for Task0 to
> > release 'pcc_lock'. In the worst case, this locking order can result in
> > Task1 wasting two scheduling rounds before it can enter the critical
> > section.
> >
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  drivers/cpufreq/pcc-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> > index 73efbcf5513b..9d732a00e2a5 100644
> > --- a/drivers/cpufreq/pcc-cpufreq.c
> > +++ b/drivers/cpufreq/pcc-cpufreq.c
> > @@ -232,8 +232,8 @@ static int pcc_cpufreq_target(struct cpufreq_policy *policy,
> >       status = ioread16(&pcch_hdr->status);
> >       iowrite16(0, &pcch_hdr->status);
> >
> > -     cpufreq_freq_transition_end(policy, &freqs, status != CMD_COMPLETE);
> >       spin_unlock(&pcc_lock);
> > +     cpufreq_freq_transition_end(policy, &freqs, status != CMD_COMPLETE);
> >
> >       if (status != CMD_COMPLETE) {
> >               pr_debug("target: FAILED for cpu %d, with status: 0x%x\n",
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.6-rc material, thanks!
