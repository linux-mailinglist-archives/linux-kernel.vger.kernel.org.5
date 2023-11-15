Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4037EBD16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjKOG3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjKOG3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:29:40 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C1E8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:29:35 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c4cf0aea06so5359249b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700029775; x=1700634575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ijWgB/n7wQWOhBbaV1md72p8BCrVtoBj2gz5Jm1idO0=;
        b=BrLPsIcbbxEeDIlp/W6DNYnO7aFe9v/lWyJ9wXQfaHy54r50+uLkAZfeeY9P1lAhBn
         S9+G2/jnK2ZaDjho2gMvEYxlniqc2qT9Ty9VMUVgBfSGerEly11jSY/0TU5+MnsNl0yT
         S0256uC4zYisWcT10Z+uz2XW/xpZkSwONPhZCxcqKDwrrMeDa4ujhK5USuhTvmjdtTuH
         D/LeRBeHntStjb63XuvRPQdyLYXJ1soFFSjvD+iNnfVwkviglGfkPQhnHZWIc2wUeECM
         Uhj4VPju1NxAF4lVVrxgpvmHRdjndMyFdGtnBOiHbYJFj4ogEi61KuA7KkWb0gWTo/Qi
         JsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700029775; x=1700634575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijWgB/n7wQWOhBbaV1md72p8BCrVtoBj2gz5Jm1idO0=;
        b=FYBHZe2qwcZM9OalOlEu1TJKf7rdsHS6a+5Hlx98klWIhs7gGaRhfrA+qrZfDsHq1V
         Fokd4ZpCh5tA/YdZsQ5IgKx+pKStvHuwrklNvELzUzD+LoE5vJNN5PulaZsImNbBM8i1
         7vgmoz9QYyJIZBwe6uigvjesWuGbriAzOZOlXjfdVlJLMJUNGsgFcu1AiOSywBoEBHeM
         1ynGjes8ItSH+yqb0+87CM54AdBPaLY86Ugbqolavxoxtg5mCrsIq1yp3ESVuv8yIOy6
         /mJpHD0iL1E1LfE3uQ4QGY4an9LGDs+W1R7H7/N8sghbHX0LeGyCgza360+y81ChbdDG
         t+GA==
X-Gm-Message-State: AOJu0YwvXhCyoXtUdAjqIwmCGMPTRfUt05MrteBUew+p3fmPft8eg+QK
        t1UrsUTXoVN61VQlwGpltnK05w==
X-Google-Smtp-Source: AGHT+IHNQoS9uDAn0ReyTwQP6t3z0RVvRg7vMQN4mCOr0kGFtghMcGt9yzA+q1gHzzOarfaJd1+BRw==
X-Received: by 2002:a05:6a20:244e:b0:15e:d84:1c5e with SMTP id t14-20020a056a20244e00b0015e0d841c5emr15202326pzc.38.1700029775212;
        Tue, 14 Nov 2023 22:29:35 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id oo3-20020a17090b1c8300b0028328057c67sm5810344pjb.45.2023.11.14.22.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 22:29:34 -0800 (PST)
Date:   Wed, 15 Nov 2023 11:59:32 +0530
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
Message-ID: <20231115062932.vz2tyg6wgux5lx6t@vireshk-i7>
References: <20231111014933.1934562-1-davidai@google.com>
 <20231111014933.1934562-3-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111014933.1934562-3-davidai@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-23, 17:49, David Dai wrote:
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy)
> +{
> +	writel_relaxed(policy->cached_target_freq,

Drivers shouldn't be using the cached_target_freq directly. Use the target freq
or index passed from cpufreq core.

> +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->related_cpus);
> +	kfree(policy->freq_table);
> +	policy->freq_table = NULL;

No need of doing this. Also the order of above two calls is wrong anyway.

-- 
viresh
