Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A71809FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573506AbjLHJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbjLHJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:51:48 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB11FD7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:51:11 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58e256505f7so851178eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 01:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702029071; x=1702633871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6L21h7YTzNvrxPdnkHfqtungBWb9rqotOm7akioWdJE=;
        b=kqfpZ4ok6qdf9ukhOUygjkCeUyFj/G/WP1Mv9nFTkUAqwdRhi56g/dflJhljw/pPbC
         aReJ5eBSblSqiPbEnoOXnNuBdYb6kbRPDUAkabxJd2hn7Pcg46i0vcBUBOfWQygL7qPS
         96Kn5ZnIyuDRx7OSmH2ceQM/dxGI3nOXyd7skS5RrCLpOq732jeZ3aX/CyeFGZCJ5yTf
         0cY7u907A2eYNfcBw8IK4xXi1DXUHxzWovBkr7oXEuAOJ1z9mD2oJxZsYm43vdGOAg6i
         iFPeAACzVU5yXPHtKviYNolj0VzBjLgK1bpwukHajYpGSW+w2AgFNr/faBP+PO6zNDsy
         qvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702029071; x=1702633871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6L21h7YTzNvrxPdnkHfqtungBWb9rqotOm7akioWdJE=;
        b=g6XXnImDl5wFbEhMV98gcnnW5vfIJ4cNKba5H+8Fz6jl+Nqo3gXJhgi3OOdX6pFzC0
         MSPfHORX8CFC9jwYT0gdBmaKpm5jH+EDVuNfWz7Wv9vYa8rOyLWIz+Td+c9MHqAPtkRI
         MUWOJYQ+xXisU5pH1KOJl+bMLOpSK6beWYk+DadjuesF3E+yoL5t1M2vN1qf/rCzfUIF
         1I3V5MiTL6vPrtO5s5XSbUMWUaiO+nQ06KAFz6dRHVme6aEdjYP58LY594LxDRVQTa1m
         JevTZ2X0mS9Da93SCzH3sx+0ShpgOkvi3lj0OL+aMvECAv0GoJFGZryGnWRfTMscpnHH
         1mHA==
X-Gm-Message-State: AOJu0Ywwo3n80QPMAIXANnsr/F0NHHSdshOTW1c9bEdg1KHxJe6wLHOJ
        vIBmbmO74S+r5EG3wB5t/2I8RQ==
X-Google-Smtp-Source: AGHT+IG3yrBJKShrn9bFMJhh1fczhfYyM+n5aSw+UE1/5hPNj+hMXwBAbyt34COA/L/kuAqdCT5VXw==
X-Received: by 2002:a05:6359:6609:b0:170:1cd9:b2a2 with SMTP id sm9-20020a056359660900b001701cd9b2a2mr3472117rwb.37.1702029071139;
        Fri, 08 Dec 2023 01:51:11 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001d08e08003esm1273016plx.174.2023.12.08.01.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:51:10 -0800 (PST)
Date:   Fri, 8 Dec 2023 15:21:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Dai <davidai@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <20231208095108.mg5bz7yjvla6syk2@vireshk-i7>
References: <20231111014933.1934562-1-davidai@google.com>
 <20231111014933.1934562-3-davidai@google.com>
 <20231115062932.vz2tyg6wgux5lx6t@vireshk-i7>
 <CABN1KCKfCWB6fVAuMSN9AdJOe-zueNMPFUdDnKLcq-uetz2ZFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABN1KCKfCWB6fVAuMSN9AdJOe-zueNMPFUdDnKLcq-uetz2ZFQ@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-12-23, 10:18, David Dai wrote:
> Hi Viresh,
> 
> Apologies for the late reply,
> 
> On Wed, Nov 15, 2023 at 3:29 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 10-11-23, 17:49, David Dai wrote:
> > > diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> > > +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy)
> > > +{
> > > +     writel_relaxed(policy->cached_target_freq,
> >
> > Drivers shouldn't be using the cached_target_freq directly. Use the target freq
> > or index passed from cpufreq core.
> 
> We were trying to avoid rounding to frequency table entries to provide
> more accurate frequency requests. However, we didn't find any
> significant power or performance regressions using the frequencies
> from the table, so I'll send another patch series using your
> suggestion.
> 
> >
> > > +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > > +{
> > > +     topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->related_cpus);
> > > +     kfree(policy->freq_table);

This becomes a dangling pointer for a very short amount of time. There may or
may not be a actual race here and so I said the ordering must be just the
opposite anyway.

> > > +     policy->freq_table = NULL;

And I thought this isn't required too since the core is going the free the
policy structure right after returning from here. But maybe it is not a
guarantee that the core provides (the code can change in future) and so be
better to unset it anyway.

> > No need of doing this. Also the order of above two calls is wrong anyway.
> 
> Can you clarify this point a bit more? Are you suggesting to just
> remove setting policy->freq_table to NULL and swap the ordering
> freeing the freq_table vs clearing the topology source? I can
> alternatively use dev_pm_opp_free_cpufreq_table to mirror the init.

That would be better actually, to let a single piece of code manage this :)

-- 
viresh
