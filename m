Return-Path: <linux-kernel+bounces-39469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E6A83D1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B7C1C23069
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E6EBE;
	Fri, 26 Jan 2024 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="FohybPB5"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE4362
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230049; cv=none; b=NieQCrqYg7hqaj0CSKKgMVlm9c5/E65ZzEacdnTXMlcj+fZNGYeYA4YuaoQcgvZtP3bRJ7zgrwkeULvMpWlRpsVmDOmHZ2JoNeT6IaUjYlj3FtMwsFO7Aur959uN7b2wzCIRs/yU+8XvKiCJSg7VQtRuwf1x439yWy3L1bSZPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230049; c=relaxed/simple;
	bh=SGviMvdgb3/1Uvw6JtHD5Jao+VL+YcLXORRKDs6cUnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3txEgF45SbNQnZ8iQgINJY1IT64vckWcFlgQfEPYrZPOXbR1+LawnZ36GOCw/7gYHuAqknxehj4ppsC0LGFHCwPDKDZm54NtHBlaFfEBQjDMx2tE4ADS1e1VaWUJ6ekS0zbtqDWc0VBG2wk6b9sX6Hw7fZoRzuWvZWPE3L94NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=FohybPB5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so80487395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706230046; x=1706834846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEjwaKYVRS0yCuV6oj4h3+sux9ZfnXZ8sxYQfgg8Q8Y=;
        b=FohybPB5URHfNqzWUZo2MRb63ANbf+fHhV5LNrJiEDVJ/ebjzPQ0jMvAeALHgxbNAP
         gh/ZAqmV4qVgoNELQZOq5bqSEH21SVKY9qSSd+2SMB5WMMK3bLyEvvxy9GKPU/xKqo/h
         MMjjGa9jZLkpHOc+Gkz2iOWFQpoFVQoDReImkjLjLuKqHSDHPOsKzCIX/JTJDuLXTDQ7
         KnpCAWCUglRIsaJ8ehpgQtvDZgUJsrp43l6Yjj849gqTAxHV71XIhfUbZzc+Z4X6disf
         METa9LmmEGj2IF/mRbubdnPFh0yfV9368gzVG1jBQsvtb3c1kZZ4Q8JZwjFpX58xwvD7
         ygfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706230046; x=1706834846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEjwaKYVRS0yCuV6oj4h3+sux9ZfnXZ8sxYQfgg8Q8Y=;
        b=eg+xS7B8CQ2/jxzw0DW9tpz3WKRam/czKwsikZK2EWW61AYq7LQb5nYozdNVxpGboR
         TKHPygGQohmw3cGo788d/PVjlglslxtIhRHGAcni21EjtcaSRvts+xlATMy0UxtgS9JG
         SPlO0noIh0jPMDIVwfITMXaZFOVQtv83DbjyxxNOIbuzJqkypZUsVZBrGxw8OJ0vWtve
         njHGj9lIW9DLNm8QuX//n3zR5KiPBau1zGMQiG221KOG6xcTI6kkhoLbTeyhxdk05iie
         S9ueF17KHMHqEWSPMOJr9aaW9pgOIk0mJxvBEr9GYSEPm+nXDjcR9pOXvnmvQZP9laRk
         tN7g==
X-Gm-Message-State: AOJu0YwQLKKA+FUYXu5DVQOJgOO47E+yVy+xFDWjQzCgItQ71AXzIgXJ
	QY0ncGozP4R++opT3tI/Eq+rY/1jrge7c7eg4nBLCNQndL/krLNRJJwVKxWHVos=
X-Google-Smtp-Source: AGHT+IEXjZxnREADIGIe11Lt/UjTEvS70RDiEwR5Iy0q8Pd3ETF3eDUai7IamLWaIEk4QU4BAXGhvw==
X-Received: by 2002:a05:600c:5756:b0:40e:c69d:94f3 with SMTP id jw22-20020a05600c575600b0040ec69d94f3mr328255wmb.185.1706230046000;
        Thu, 25 Jan 2024 16:47:26 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040ed2b76263sm309429wmo.18.2024.01.25.16.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 16:47:25 -0800 (PST)
Date: Fri, 26 Jan 2024 00:47:24 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240126004724.tuh7ahpoysm3hw3x@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
 <20240122180212.67csjrnsbs7vq57i@airbuntu>
 <ece7ce3f-17f3-42a5-90d7-d0410235059d@arm.com>
 <20240124224321.vn4tuwj53wfk6iyk@airbuntu>
 <08334d9d-8a0a-468f-a1db-ce6c19e491f7@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08334d9d-8a0a-468f-a1db-ce6c19e491f7@arm.com>

On 01/25/24 10:35, Dietmar Eggemann wrote:
> On 24/01/2024 22:43, Qais Yousef wrote:
> > On 01/23/24 18:07, Dietmar Eggemann wrote:
> >> On 22/01/2024 19:02, Qais Yousef wrote:
> >>> On 01/22/24 09:59, Dietmar Eggemann wrote:
> >>>> On 05/01/2024 23:20, Qais Yousef wrote:
> >>>>> From: Qais Yousef <qais.yousef@arm.com>
> 
> [...]
> 
> >>>> What happen when we hotplug out all CPUs of one CPU capacity value?
> >>>> IMHO, we don't call asym_cpu_capacity_scan() with !new_topology
> >>>> (partition_sched_domains_locked()).
> >>>
> >>> Right. I missed that. We can add another intersection check against
> >>> cpu_active_mask.
> >>>
> >>> I am assuming the skipping was done by design, not a bug that needs fixing?
> >>> I see for suspend (cpuhp_tasks_frozen) the domains are rebuilt, but not for
> >>> hotplug.
> >>
> >> IMHO, it's by design. We setup asym_cap_list only when new_topology is
> >> set (update_topology_flags_workfn() from init_cpu_capacity_callback() or
> >> topology_init_cpu_capacity_cppc()). I.e. when the (max) CPU capacity can
> >> change.
> >> In all the other !new_topology cases we check `has_asym |= sd->flags &
> >> SD_ASYM_CPUCAPACITY` and set sched_asym_cpucapacity accordingly in
> >> build_sched_domains(). Before we always reset sched_asym_cpucapacity in
> >> detach_destroy_domains().
> >> But now we would have to keep asym_cap_list in sync with the active CPUs
> >> I guess.
> > 
> > Okay, so you suggest we need to update the code to keep it in sync. Let's see
> > first if Vincent is satisfied with this list traversal or we need to go another
> > way :-)
> 
> Yes, if preventing the 'increase of balance_interval' will cure this
> issue as well, then this will be definitely the less invasive fix.
> 
> Can you not easily do a 'perf bench sched messaging -g X -l Y' test on
> you M1 to get some numbers behind this additional list traversal in
> pick_next_task_fair()?

I can do. But I noticed sometimes there're unexplainable variation in numbers
when moving kernels that I am not 100% sure is due to random unrelated changes
in caching behavior or due to something I've done. ie: they get better or worse
in unexpected ways.  I run `perf sched bench pipe`, which is similar enough
I guess? I don't know how to fill these -g and -l numbers sensibly.

I had issues when running perf to collect stats. But maybe I wasn't specifying
the right options. I will try again.

> 
> > I think it is worth having this asym_capacity list available. It seemed several
> > times we needed it and just a little work is required to make it available for
> > potential future users. Even if we don't merge immediately.
> 
> I agree. It would give us this ordered (by max CPU capacity) list of
> CPUs to iterate over.

Okay. I need to figure out how to fix this hotplug issue to keep the list in
sync.


Thanks

--
Qais Yousef

