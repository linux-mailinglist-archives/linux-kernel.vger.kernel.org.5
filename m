Return-Path: <linux-kernel+bounces-48416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 015DC845BAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB17628B563
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9AD6216E;
	Thu,  1 Feb 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="lDXRXzRD"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DB626B0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801678; cv=none; b=o+a5zv7WZbIVPrSTas99b08ShojMBEY2BuxIzsDeHA5/7o4UCt1zjQUCNkwt1nDLSR/hdHr2Hq5w6SejmJiVkMjC+DQ/hD5eIpY1/crl/Q7U/87B/P72QuUrtUh15eAMRBdVYa2dmIlzSQTa7JZC9ggX0MoRaulkXnSkM/JclTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801678; c=relaxed/simple;
	bh=13PcTdhaGFdTv+3l6uEyVq/w0uQbXHOvcDFwClNLKZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfLreZuFaze8GIu8gU/ODgAf0zwgf3ZjK5x1ql5ZWg8yWdmRAS30G1TYKXXr4a55fyPtvrmKeZkghoBGMG2XC/PuOa5JiTsPmhwjK67KV3kUr/fuTJIOkYf/mBwLCTJhmqwlRCV0ENF7LyC04cHLsyLB3VS8MbXoxN6cuWk0NDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=lDXRXzRD; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-783d4b3a00bso73967985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706801675; x=1707406475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zPvZs4K/sfx3gwEPHE0K6OK7OOwWGbcE7kwIuj736Gk=;
        b=lDXRXzRDu4Hdu7j+0XXXm/fY+D/Q9NDZOGdiUVNlhMTZDii16yItoEX7zpLas6unVT
         QQFU6zy8RDuqiiF/xpO72sqIgyA0abeaIW9Ysx/f8DXpuX8jcVFv7JpVk6AucMzeNYjh
         Km2jpznZC+SGUA+NJexeHi1hq4p7RTJlLmQ2ZFxIUAItnI7SXtiZ5xwDflsPfW+RHnb7
         IoNw0yhMaiCMF44q0TZGYe1kFi8hYY8V5AdCITOCGDJGLEALb3PXU7miyoPf+zF7ZriM
         E8NC+yx42Ru6alCZC6fpZZGOElwyRucX0ovliA4nmaU6iM6gfKniz9CwJwu+T5zx7o5R
         DHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801675; x=1707406475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPvZs4K/sfx3gwEPHE0K6OK7OOwWGbcE7kwIuj736Gk=;
        b=bMKxU6Q4ftll9z/lAMW7+dC/26RM+PH14HOT+ulgRpmB118ULNkDMqnJR8crZmNlep
         BS9epvO1rH0kbjpGc9sCQXWiPqOCayfRP2xKEL+xAr3UERON52BBqoUAOYZ1NjhJWcp8
         PGysrSicIjUp+qo6P8gfRFn6H57e7+S/VwtlCsuKJms9Z5ONlwD+9iLeB2AWZsgU9AxV
         Nx2M47ahz2WPm5m1zMBPPmxxJncLKqgM5HK4hJT+BZQnq3tOXjyzWWO1HYliucoiYvOB
         Wbl5fQIf/6lJ2FTsxZ0j9gjH0PnM82ZpdBk4Nn6ZkzVQHagpvL/0lkx16v9eqyY/7s4U
         fD4A==
X-Gm-Message-State: AOJu0Yybyn8xe+H0bkpXhEZzl791Ik1+UEgxJCxWffDC+cgHHg5UDKHk
	DbJgGkcXhTJIY5jwKTvsXd380kEZO+iOdS1CU0TC+9sf57JaykGvo/oEHa32x1w=
X-Google-Smtp-Source: AGHT+IGi/XmGKqr5Cs1gVK8YipQ2XHKTRdRpKkoeUGmO9YOgPFP2kvzWajFfZcZoTktkg1gfV2ePmA==
X-Received: by 2002:a05:620a:26a2:b0:783:5b21:5746 with SMTP id c34-20020a05620a26a200b007835b215746mr3935847qkp.43.1706801674936;
        Thu, 01 Feb 2024 07:34:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWJY1BAiTTEZMvicUpiSL9Kon6fKRwF3bWl6PwAZJC7iyhfRfrydfsJ5C+fXJA32s9ApqaBsBBEUHSHo+Kkzhp5r3fZeOOpdfU4yoeNqMjLSkqBvLpTGA+NCh7wpjyeS0dIhEriuuIqIg0XlRtefRk/FxGDcMT+LJ3nk9UrZ8+YDxTCeYS4HCV65LhB3VeDXyQLjxCuN43UvgZ4s3C07VVvH27WkDy02wbD4TIB90t8t01GhyO8NFCmWhrz8g1bfvvRi2zXbx0l7ONCw4n9pMZkgp2Su7ETPyA8mZxI6hVrywGoAd7GwZD5BdclWZjquE3kE1d8XMDVDzKuORnJ7nLiTwE3KbgWgr0+5ojToooEIB5Xb08GaDDWTwmCQqXczCpIp3eKjOUeaIOtORQcfOu8Fg==
Received: from localhost (2603-7000-0c01-2716-97cf-7b55-44af-acd6.res6.spectrum.com. [2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id vy15-20020a05620a490f00b00784048d795asm2918077qkn.108.2024.02.01.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:34:34 -0800 (PST)
Date: Thu, 1 Feb 2024 10:34:28 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
Message-ID: <20240201153428.GA307226@cmpxchg.org>
References: <20240131162442.3487473-1-tjmercier@google.com>
 <q3m42iuxahsjrskuio3ajz2edrisiw56cwy2etx2jyht5l7jzq@ttbsrvgu4mvl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q3m42iuxahsjrskuio3ajz2edrisiw56cwy2etx2jyht5l7jzq@ttbsrvgu4mvl>

On Thu, Feb 01, 2024 at 02:57:22PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Wed, Jan 31, 2024 at 04:24:41PM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
> >  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > -					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> > +					max((nr_to_reclaim - nr_reclaimed) / 4,
> > +					    (nr_to_reclaim - nr_reclaimed) % 4),
> 
> The 1/4 factor looks like magic.

It's just cutting the work into quarters to balance throughput with
goal accuracy. It's no more or less magic than DEF_PRIORITY being 12,
or SWAP_CLUSTER_MAX being 32.

> Commit 0388536ac291 says:
> | In theory, the amount of reclaimed would be in [request, 2 * request).

Looking at the code, I'm not quite sure if this can be read this
literally. Efly might be able to elaborate, but we do a full loop of
all nodes and cgroups in the tree before checking nr_to_reclaimed, and
rely on priority level for granularity. So request size and complexity
of the cgroup tree play a role. I don't know where the exact factor
two would come from.

IMO it's more accurate to phrase it like this:

Reclaim tries to balance nr_to_reclaim fidelity with fairness across
nodes and cgroups over which the pages are spread. As such, the bigger
the request, the bigger the absolute overreclaim error. Historic
in-kernel users of reclaim have used fixed, small request batches to
approach an appropriate reclaim rate over time. When we reclaim a user
request of arbitrary size, use decaying batches to manage error while
maintaining reasonable throughput.

> Doesn't this suggest 1/2 as a better option? (I didn't pursue the
> theory.)

That was TJ's first suggestion as well, but as per above I suggested
quartering as a safer option.

> Also IMO importantly, when nr_to_reclaim - nr_reclaimed is less than 8,
> the formula gives arbitrary (unrelated to delta's magnitude) values.

try_to_free_mem_cgroup_pages() rounds up to SWAP_CLUSTER_MAX. So the
error margin is much higher at the smaller end of requests anyway.
But practically speaking, users care much less if you reclaim 32 pages
when 16 were requested than if you reclaim 2G when 1G was requested.

