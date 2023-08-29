Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D084578CBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjH2SVp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbjH2SVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:21:31 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E0E60;
        Tue, 29 Aug 2023 11:21:04 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5711d5dac14so1120627eaf.0;
        Tue, 29 Aug 2023 11:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693333264; x=1693938064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTo3jfVvlvg1H0vTGTMqTfLkRDIMIdthEAgHEmwpSXM=;
        b=hjOxgcWxFzgT5ml0U8pSTzKmFh5jNZ09ti7Z9TfeztIE8+W+FuSJCVrWP0lq8d2cM3
         n+uC/F00jEpRnkHvXwKdiEpOCG5yljJuO5WKr3YO1wZTtP6qPvuXqVFBaUllqttbVd7L
         urGeCFlT/iyX+wQN3dkGz7wagyq5pjnWv8PZsTaf7zvJ98VCrqz9nfVdsF1tKBowfM+Z
         RMrag6Y5SWHoYV7K0Uver5XCw1TLmhUCxcA7A6A6gQsn5lSK6MJjycl8CJh7cJjA2Zc4
         ukywBc8SWI2UQdT6I6RAJNrv/g5BLScaWjXvzw397VXn1pMkFAzK6lGUFaCu8XU7o8e/
         bwzQ==
X-Gm-Message-State: AOJu0Yz8q99rDaXHnZtbHxMhd5gPISB1XvPo2m59Ue65OJl/lzycuV3Y
        Y0Y6CKPRefxEB8cIf3ivF7Ee0AgnFA9NpfgCKIM=
X-Google-Smtp-Source: AGHT+IFjoV8swkHIl/drxFtMy0VJZUhotJVrxu9o6dCUmDDhJdrefsiA+BF/J8qo/zfiDsryW2RYYMAFObEjxviNzVk=
X-Received: by 2002:a4a:c3cb:0:b0:573:2a32:6567 with SMTP id
 e11-20020a4ac3cb000000b005732a326567mr14914018ooq.0.1693333264116; Tue, 29
 Aug 2023 11:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230829070318.1217668-1-liaochang1@huawei.com> <20230829072024.nxsm6bgu5mx4yxyg@vireshk-i7>
In-Reply-To: <20230829072024.nxsm6bgu5mx4yxyg@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 20:20:53 +0200
Message-ID: <CAJZ5v0jbeYvCV0ZxEPVAk=1Lvbd3wxSrq72jUxBLqvHm1mTStQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Fix the race condition while updating the
 transition_task of policy
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Liao Chang <liaochang1@huawei.com>
Cc:     srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 29, 2023 at 9:20 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-08-23, 07:03, Liao Chang wrote:
> > The field 'transition_task' of policy structure is used to track the
> > task which is performing the frequency transition. Using this field to
> > print a warning once detect a case where the same task is calling
> > _begin() again before completing the preivous frequency transition via
> > the _end().
> >
> > However, there is a potential race condition in _end() and _begin() APIs
> > while updating the field 'transition_task' of policy, the scenario is
> > depicted below:
> >
> >              Task A                            Task B
> >
> >         /* 1st freq transition */
> >         Invoke _begin() {
> >                 ...
> >                 ...
> >         }
> >                                         /* 2nd freq transition */
> >                                         Invoke _begin() {
> >                                                 ... //waiting for A to
> >                                                 ... //clear
> >                                                 ... //transition_ongoing
> >                                                 ... //in _end() for
> >                                                 ... //the 1st transition
> >                                                         |
> >         Change the frequency                            |
> >                                                         |
> >         Invoke _end() {                                 |
> >                 ...                                     |
> >                 ...                                     |
> >                 transition_ongoing = false;             V
> >                                                 transition_ongoing = true;
> >                                                 transition_task = current;
> >                 transition_task = NULL;
> >                 ... //A overwrites the task
> >                 ... //performing the transition
> >                 ... //result in error warning.
> >         }
> >
> > To fix this race condition, the transition_lock of policy structure is
> > now acquired before updating policy structure in _end() API. Which ensure
> > that only one task can update the 'transition_task' field at a time.
> >
> > Link: https://lore.kernel.org/all/b3c61d8a-d52d-3136-fbf0-d1de9f1ba411@huawei.com/
> > Fixes: ca654dc3a93d ("cpufreq: Catch double invocations of cpufreq_freq_transition_begin/end")
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 26fa99d46684..5c09a4936699 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -455,8 +455,10 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
> >                           policy->cur,
> >                           policy->cpuinfo.max_freq);
> >
> > +     spin_lock(&policy->transition_lock);
> >       policy->transition_ongoing = false;
> >       policy->transition_task = NULL;
> > +     spin_unlock(&policy->transition_lock);
> >
> >       wake_up(&policy->transition_wait);
> >  }
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.6-rc material, thanks!
