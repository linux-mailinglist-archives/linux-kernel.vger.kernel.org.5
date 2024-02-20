Return-Path: <linux-kernel+bounces-73108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFC585BDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98B928457E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72FE6EB6D;
	Tue, 20 Feb 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="yRUccnPe"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216946D1B8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437042; cv=none; b=JKQcyK/3qjXiSWwZbFU6uWWKQHo7dq5PPMFpIBUC+rrFtRrEevoQeM71BHee2G5Lj0cTp1pze2TRAgorFDuLf6BAVwHe0309XYVPByIWkBEpqcCJ8OMKXf3sY29p+MB8j9RKkv4vonXcfU9+C6H9SlwZ4d5+26XOzIBZ7sWk9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437042; c=relaxed/simple;
	bh=Jrx11QzEIynH7Lc7JLpWcoYA3bkny4IBJMQqUSnWar8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBxIFlvsrIbgWCR6G/iUCOZCrsPga1GN6XQJTj9EXX1qyFZRdhqW6mWAi1WKjtBz+BLUqiRqC4I9HlcD6TF8nOlHiIkE0DpxbY1nC7NM8oXfU1qDUPrLFkjASuSU3henJsCyK0DuKH8xjVE01GqsePfHaeJoO9L0qbivV5bF+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=yRUccnPe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d146737e6so3384010f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708437039; x=1709041839; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ilid/e5sP7UghfGnEg/Cgg4pyAzEewQR8WBetW5rMY=;
        b=yRUccnPeog/jnLc+M9IUavyWKAlW5ZuP1b1WyaBWS2BZVO15pXWViLDSXEdyV1nbQ8
         fkouReYc27gGGg7d6KTcAEumdAQveEoZhxP6sYGYElXR8+zoArEQzD0CndSueqLxmYKB
         REmVvv/bSI/V5D7TUl+myZu3WZ0VI3S1B5vqvUsEkHwj3k4NEVsz9y9eYjSKqIo6Ukp6
         pl8oJ13tiqyBbx6BkZymob6AbY723o3guVUZ8bQ/x5d1hb0xJHBGuvUR+uydtZ/7BQ1v
         Qw49zxuFL27pu84rkzvSI5Ie/tz1+tgNi7j/cRzHr2BdRo2mosoj3O8Eao/xV8NHQ0Sp
         YaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708437039; x=1709041839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ilid/e5sP7UghfGnEg/Cgg4pyAzEewQR8WBetW5rMY=;
        b=FTtd+r4H1YZM2071vfIIbjnLbq6NlV8x6nDLcNJ76W/UJYxSR89VIQHzVFJ3bDHUDM
         7RtDkLesgHNge06aXrNB04gFFui1woTRiSpdDSRMe5w5xMC1FMTReqLRTSlRJnfZET79
         brGN9cFBMT/XsXZQk65JmSzyDyWx1tsEEyd69tLwgEQpwuTXc61mugCja8sxu2iE1EJi
         AdCOoVAAsrEp9CA2mJcqzU4PdQKtEnOKOH8kwVm2TxEhX3MVsHVKQp5F+IMeRbtQrTzW
         rxfOn4yR0pBp/JpunhKN+WdyBDPomVvmBwOS5cl/6bPK7Cb3YmHtjIb8VguA63Jtz8Dn
         N/Og==
X-Forwarded-Encrypted: i=1; AJvYcCU8AuaL/XsVfP//fr1R0R78EsXCSnqVSOTnWJvsBOI9EpN6tqEBIs6u103hbXrdEe4/hpIdVHL8ZYm3l3mFbtkNb4PbbYxaj5FkdwhA
X-Gm-Message-State: AOJu0YxiqjBRpWAEFysJmVZPSfxrumNEjdY/l2AjpfuZRlHTbPp1iOgD
	gBzDm3KMpcnR+EypEu7RswJ70tpktGoEWltAh28WK7pQYBcGagmYDCN2BDkgg60=
X-Google-Smtp-Source: AGHT+IHhQGWV31zH86wvYhgr4JRITrjVnPUeUY8jjkgyFLLfbaTZNDF5uD++rL2UUzCCSKch0Zc3ZQ==
X-Received: by 2002:adf:fdd1:0:b0:33d:2dd4:7f5b with SMTP id i17-20020adffdd1000000b0033d2dd47f5bmr6529768wrs.45.1708437039043;
        Tue, 20 Feb 2024 05:50:39 -0800 (PST)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id bn7-20020a056000060700b0033d3ff1cb67sm8199683wrb.66.2024.02.20.05.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:50:38 -0800 (PST)
Date: Tue, 20 Feb 2024 13:50:37 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian.Loehle@arm.com
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240220135037.qriyapwrznz2wdni@airbuntu>
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <20240205074514.kiolurpounokalum@vireshk-i7>
 <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
 <ca000b2d-b552-43cb-8807-0a5f1450c6a2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca000b2d-b552-43cb-8807-0a5f1450c6a2@arm.com>

On 02/14/24 10:19, Pierre Gondois wrote:
> Hello,
> 
> On 2/12/24 16:53, Rafael J. Wysocki wrote:
> > On Mon, Feb 5, 2024 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > 
> > > On 05-02-24, 02:25, Qais Yousef wrote:
> > > > 10ms is too high for today's hardware, even low end ones. This default
> > > > end up being used a lot on Arm machines at least. Pine64, mac mini and
> > > > pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
> > > > it's too high for all of them.
> > > > 
> > > > Change the default to 2ms which should be 'pessimistic' enough for worst
> > > > case scenario, but not too high for platforms with fast DVFS hardware.
> > > > 
> > > > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > > > ---
> > > >   drivers/cpufreq/cpufreq.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 44db4f59c4cc..8207f7294cb6 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> > > >                 * for platforms where transition_latency is in milliseconds, it
> > > >                 * ends up giving unrealistic values.
> > > >                 *
> > > > -              * Cap the default transition delay to 10 ms, which seems to be
> > > > +              * Cap the default transition delay to 2 ms, which seems to be
> > > >                 * a reasonable amount of time after which we should reevaluate
> > > >                 * the frequency.
> > > >                 */
> > > > -             return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
> > > > +             return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
> > > 
> > > Please add spaces around '*'.
> > > 
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > I've adjusted the whitespace as suggested above and applied the patch
> > as 5.9 material.
> > 
> > Thanks!
> > 
> 
> To add some numbers, on a Juno-r2, with latency measured between the frequency
> request on the kernel side and the SCP actually making the frequency update.
> 
> The SCP is the firmware responsible of making the frequency updates. It receives
> the kernel requests and coordinate them/make the actual changes. The SCP also has
> a mechanism called 'fast channel' (FC) where the kernel writes the requested
> frequency to a memory area shared with the SCP. Every 4ms, the SCP polls/reads
> these memory area and make the required modifications.
> 
> Latency values (in ms)
> Workload:
> Idle system, during ~30s
> +---------------------------------------+
> |       |   Without FC  |      With FC  |
> +-------+---------------+---------------+
> | count |       1663    |        1102   |
> | mean  |          2.92 |          2.10 |
> | std   |          1.90 |          1.58 |
> | min   |          0.21 |          0.00 |
> | 25%   |          1.64 |          0.91 |
> | 50%   |          2.57 |          1.68 |
> | 75%   |          3.66 |          2.97 |
> | max   |         14.37 |         13.50 |
> +-------+---------------+---------------+
> 
> Latency values (in ms)
> Workload:
> One 1% task per CPU, period = 32ms. This allows to wake up the CPU
> every 32ms and send more requests/give more work to the SCP. Indeed
> the SCP is also responsible of idle state transitions.
> Test duration ~=30s.
> +---------------------------------------+
> |       |   Without FC  |      With FC  |
> +-------+---------------+---------------+
> | count |       1629    |       1446    |
> | mean  |          3.23 |          2.31 |
> | std   |          2.40 |          1.73 |
> | min   |          0.05 |          0.02 |
> | 25%   |          1.91 |          0.98 |
> | 50%   |          2.65 |          2.00 |
> | 75%   |          3.65 |          3.23 |
> | max   |         20.56 |         16.73 |
> +-------+---------------+---------------+
> 
> ---
> 
> The latency increases when fast channels are not used and when there is an actual
> workload. On average it is always > 2ms. Juno's release date seems to be 2014,
> so the platform is quite old, but it should also have benefited from regular
> firmware updates.

Thanks for sharing the numbers

> 
> Regards,
> Pierre

