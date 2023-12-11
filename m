Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA380BEB2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 02:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjLKBPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKBPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:15:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ABEE3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:15:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so37684695e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702257311; x=1702862111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVYCyVS3+ff43Qu6NzjIwTDiljR88wG6SCIsO7lLWds=;
        b=hUDwjp8kWW21rshJ2xD5xVe1/v2MPrdMkSORUL5685RPBIDOdhsxQEBTgDphBI2WYe
         SrafVbt/3Jh1c/wZZTlozayYEBnCg7F0nKklHjAEO97ZTDXa6fO+vf4ORVqnO1USBhxl
         1Lx82BN+lJ0cYktMWp+EKyWHhVVjDFz9LYlqcvKodiv1AdSrfUVUVdg7DeXtMZ36I3Tv
         1QKztmHsmTsu7GKiA5/B53C85W1kJly3uaZc/tvdYSpMzJn/U2qVuZBSdtXyWGLR//QF
         8uEVFfsHnEalP1E9KxbNNCbTIYeLhGA0JYCkLcmZgZkQyvUPmwyS8HKS5UzKny+oE51F
         lwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702257311; x=1702862111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVYCyVS3+ff43Qu6NzjIwTDiljR88wG6SCIsO7lLWds=;
        b=oKnJWo4gojSmSzC8fgDJ+HFeIX4XToZg2C1hqHKo2+UpDvfbpGDOL5QVqEfPIp0tHk
         B3AyKMGxD+cePBHQM9MnieFrQWNNvXZ2l0/bTS80Qg16Q703jmcjBAlHbaUrcir5GN5g
         8fav9S57y0yLvETuSOZ6ZMBqR7RaTeYVwOapFFrzJ4CEoTjtn8T6xivFYQHa6VgDFhiT
         /2HCA7+y14Z1s3azXcx89eQ32ScnsJR3Gi2zssBLCZrLzhReVITu18KN3Ovs4hLZet4z
         Np97MXqNfcdLshcUiaEHdSnwTQ5sXm1weayFbQOSRKX/O/pybTXQRWFJT0RkMCNfvpf/
         ilFQ==
X-Gm-Message-State: AOJu0YwZg0/TcYXt6U89BvlBpbh1SdaKARaBunouP8XDbqgklo2xqbgc
        +2B0BNdY6B51d6u7f3zkYZo3fPEktCZmcctOmMM=
X-Google-Smtp-Source: AGHT+IHs/2WGc7kkqOKYqUw7U3gIBEFHtRUjCsAT6m4TrVG9iYyfq51zDosI6ulGoJtA7worvysu+A==
X-Received: by 2002:a05:600c:2294:b0:40c:2328:fcd with SMTP id 20-20020a05600c229400b0040c23280fcdmr1585213wmf.135.1702257310691;
        Sun, 10 Dec 2023 17:15:10 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm4316862wmb.15.2023.12.10.17.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 17:15:10 -0800 (PST)
Date:   Mon, 11 Dec 2023 00:08:09 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 2/4] sched/uclamp: Remove rq max aggregation
Message-ID: <20231211000809.qostlrd5bka6cvak@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-3-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231208015242.385103-3-qyousef@layalina.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/23 01:52, Qais Yousef wrote:

> +/* Request freq update on context switch if necessary */
> +static inline void uclamp_context_switch(struct rq *rq)
>  {
> -	return static_branch_likely(&sched_uclamp_used);
> +	unsigned long uclamp_min;
> +	unsigned long uclamp_max;
> +	unsigned long util;
> +
> +	/* Only RT and FAIR tasks are aware of uclamp */
> +	if (!rt_policy(current->policy) && !fair_policy(current->policy))
> +		return;

We have a dependency on min_granularity_ns (or base_slice_ns) here that
I forgot to add before posting.

If our base_slice_ns is smaller than dvfs_update_delay, then tasks won't run
long enough for the hardware to apply their performance hints before they get
context switched out.

Beside the new proposed sched_runtime being able to request a smaller slice; in
practice default base_slice_ns is okay-ish.

> +
> +	uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> +	uclamp_max = uclamp_eff_value(current, UCLAMP_MAX);
> +	util = rq->cfs.avg.util_avg;
> +
> +	if (uclamp_min > util || uclamp_max < util)
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_PERF_HINTS);
>  }
