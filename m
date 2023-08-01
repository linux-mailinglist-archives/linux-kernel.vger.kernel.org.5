Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC976AFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjHAJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjHAJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:50:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC9C212E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:49:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bed101b70so663583366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690883374; x=1691488174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8Aw/q2325QhvfRmv9aBcluZMD54mucilqUf7AAqeNY=;
        b=6MjFQXPW/mZ+3XWbBfRbNcNoy53tZnxETpLjJSAtIpKe+cSorJsstEpg6WVvdiTiW8
         2+iibuAEVZiriSShY+nTrlnWMKhu1f/fdG6tkwuzKbU1/6QyPGUBNUZa2A9kwdRah/Dg
         MCX75gah/0Rt2Q3c/xyfE4SasPNuDRZ0vWpaHg+5BJiD8Uk85Xw4AK49GN3gt3Pb5Pjl
         ib3mbA5Gz+vlCz6/8FRUj/lOd8snqoFRXSKE2lDgG17YuUq/huNyk8kcpmWwupjkk6aw
         ZC/2Vt28Qnau8yZQKUX8MedyNlM5Gt7F8mfiXBh5S6HeOELAc4zNlnnhvLZN2bl603rw
         54IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690883374; x=1691488174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8Aw/q2325QhvfRmv9aBcluZMD54mucilqUf7AAqeNY=;
        b=QhBRWkGeo2FkpFNulzD6bEEvDoA5msf8Q0LeCrVVW6Z1AG2aephbr46IssTlDPg7H8
         eNFtzZCPSs0XerZJgE3SvRl+RyqsBAPFv9Thvj5WcZfOAiLnLzaBvytCnEleUR1msfQo
         ViSrBgPsWv5688ZTdH1ldH21WBqLwqnXUhPP8L7inaYlkN0e7YJgkwGxs9dMp/o+xQxG
         R1/UWkZvZuuP42tG3Yot5x2Zm+Be6Q8VW6pRKy7x7/e2axDQfd/ghNvWrl4UH2Rsi+25
         8KGdpFEw/WUbDL8iuWOKa+QaH4cPBvwFDEAu7HqBo9T9QKZ6zFYbUY3R/kjfXDwZuJi0
         o9aQ==
X-Gm-Message-State: ABy/qLbrHsyoJHwVqedwsoNrQejV4hP91Gag3m3onRMNC6VE4xZEFVvo
        kdv31x/Y8H2PCx6SpGg4u6pv/w==
X-Google-Smtp-Source: APBJJlGR0qLEiBW7LmZ6eMsyXyJJRH6PCqS7Js03DEAtTFa4qoOwaLAeE+I8AFK1mnaZSUFh4z4FeA==
X-Received: by 2002:a17:907:2716:b0:98d:1f6a:fd47 with SMTP id w22-20020a170907271600b0098d1f6afd47mr2045278ejk.76.1690883374092;
        Tue, 01 Aug 2023 02:49:34 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906410a00b0098951bb4dc3sm7349407ejk.184.2023.08.01.02.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:49:33 -0700 (PDT)
Date:   Tue, 1 Aug 2023 09:49:30 +0000
From:   Quentin Perret <qperret@google.com>
To:     David Dai <davidai@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
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
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <ZMjVKn1MwA2Avm7r@google.com>
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-3-davidai@google.com>
 <ZMjUMk5xXzahXjno@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMjUMk5xXzahXjno@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 Aug 2023 at 09:45:22 (+0000), Quentin Perret wrote:
> Hi David,
> 
> On Monday 31 Jul 2023 at 10:46:09 (-0700), David Dai wrote:
> > +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy)
> > +{
> > +	struct virt_cpufreq_drv_data *data = policy->driver_data;
> > +	/*
> > +	 * Use cached frequency to avoid rounding to freq table entries
> > +	 * and undo 25% frequency boost applied by schedutil.
> > +	 */
> 
> The VMM would be a better place for this scaling I think, the driver
> can't/shouldn't make assumptions about the governor it is running with
> given that this is a guest userspace decision essentially.
> 
> IIRC the fast_switch() path is only used by schedutil, so one could
> probably make a case to scale things there, but it'd be inconsistent
> with the "slow" switch case, and would create a fragile dependency, so
> it's probably not worth pursuing.

Alternatively we could make the schedutil margin configurable via the
cmdline or something along those lines, so we can set it to 0 in the
guest and avoid the issue entirely.

Some partners have been asking for this IIRC , so I suspect there would
be interest from other parties.

Thanks,
Quentin
