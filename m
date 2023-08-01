Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2976AF6A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjHAJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjHAJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:46:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4B19A8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:45:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso8829879e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690883127; x=1691487927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjzE0pMdAWPzb0ytcueVWoMn3QK/GK8CBwvH9LJxWgk=;
        b=k222fY9P8sD2BkxsXbmTBvfMWrjjvKuo76a0gnS3ewacXTR3lCcEqCO0FkKeoL/3Fy
         nfuy9byD1ZLK+6waJrMUEJcLvF0CJ6HwNk/n7b5qE1ktFCGw6BbVG8Kf9cEEF5IVwL48
         icD8zbt0PR7iGX7F/w+GRFcBoChvQ6tkBfG1tVnjLVvSmCWLI31om1iXvBXT76zxmzbL
         UJwjvHVmxCCLfVPUGgMXNr+BOWcAjGluz9IiXFo+ykNTVWHUY2OkqFwnIfI9YDAroMfA
         ylfxYHvUqhf1x6zbPXeciApsWAI8wPOq4EJ2wcStfZwO2EFhD32vyHfqbnWV9GnxyytE
         QPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690883127; x=1691487927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjzE0pMdAWPzb0ytcueVWoMn3QK/GK8CBwvH9LJxWgk=;
        b=fZkGTiX/BAE+9BqYhKTDircWOOPXcgE0choLezPmakbk5NtciD30xJ/LrQfDZdxlMT
         +iJHIfdmrkNx8jKzERojALYCM6GRE3vlIIzMSNn8Eb3MvvEIk7OcESVn+H7s1BvGXQiY
         tymkWtzx1uOIKXIAvucFG8D9BEbeOI23eU/5MDtBfPNa23oxTL6xdKWXM7nES1oR5+zV
         XY9aJtVFzL6L+FoY1/+2crCIS05UJSHP2OIMvvbMLdtuG1FDOu2Af+xCRAjJonnnuxlR
         Fx3q0HEcFDMZ3/CyV2u4Ie5E+147eTe2lt5TEpPlw7FxT2ZJiNbfIr8bqkATV2tDXeiv
         Purg==
X-Gm-Message-State: ABy/qLZLgCb2CQfLo5WiWgZ4Boz/BOV0d5Ggdu/LIOm48X0bcCw7+lgn
        QpGOqyqa9DFLjYtsTuOsjLg5XA==
X-Google-Smtp-Source: APBJJlFjBOyeZWNZUk3UMzFzo9zb7KYygtaPteVYSbVoNDekf1oBQgNfLV5BFrAcxoqViRRR1BWgGg==
X-Received: by 2002:a05:6512:290:b0:4fe:ee7:a32a with SMTP id j16-20020a056512029000b004fe0ee7a32amr1816148lfp.16.1690883126707;
        Tue, 01 Aug 2023 02:45:26 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id q1-20020a056402040100b005222a38c7b2sm6754243edv.48.2023.08.01.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:45:26 -0700 (PDT)
Date:   Tue, 1 Aug 2023 09:45:22 +0000
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
Message-ID: <ZMjUMk5xXzahXjno@google.com>
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-3-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731174613.4133167-3-davidai@google.com>
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

Hi David,

On Monday 31 Jul 2023 at 10:46:09 (-0700), David Dai wrote:
> +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy)
> +{
> +	struct virt_cpufreq_drv_data *data = policy->driver_data;
> +	/*
> +	 * Use cached frequency to avoid rounding to freq table entries
> +	 * and undo 25% frequency boost applied by schedutil.
> +	 */

The VMM would be a better place for this scaling I think, the driver
can't/shouldn't make assumptions about the governor it is running with
given that this is a guest userspace decision essentially.

IIRC the fast_switch() path is only used by schedutil, so one could
probably make a case to scale things there, but it'd be inconsistent
with the "slow" switch case, and would create a fragile dependency, so
it's probably not worth pursuing.

> +	u32 freq = mult_frac(policy->cached_target_freq, 80, 100);
> +
> +	data->ops->set_freq(policy, freq);
> +	return 0;
> +}

Thanks,
Quentin
