Return-Path: <linux-kernel+bounces-164837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A098B83CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE3C1C22141
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365F3440C;
	Wed,  1 May 2024 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="lug2jlHw"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D5646
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714524667; cv=none; b=bHPoE7zIbD3LjLzieqPCVhvVpjUXNOTWDjIETWpRYgBuYJgGfjTcWZiLGP5bTyxbMLHeSY64orZU6fsFodwO0tKZY8RzpjavCSOOMIE0FIilVFlhzg5mZFNHg9rKV0lrZ1QH4vjnQx0uo/GMD4HcZqjkGSgju6DhxWFmVoLyTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714524667; c=relaxed/simple;
	bh=3F82S8nexwhqGW6YGWr5YlPxXVIxXYdtx7GHwD0H0Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy1Kmb2FJNtGnU6+l3gpJAZ/nRXRneyEHr3X0+eiAAvK014MTuctSkdEHx3hGUH8ng4xa+0Y33iqQkSfPQh6qe2Lo42O/1jW7Q0dsOqiZDdzv6sDkrZpKLskkTY2R5SzgNz64DsTUlJuetog7RiRoodvQkPxaFBgrH4dazSochw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=lug2jlHw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b5de48126so18025516d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1714524663; x=1715129463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9BD94zdxyDu4bbMrkiiEBVb20niGXuFjMmzvoxFlieQ=;
        b=lug2jlHwBuxetbk347zWSpZL8b9lrj/9Hxh6LwPaC9AaUbeSB7lgqHqoEw+VZN6ku2
         dK6PbToPlQiPr6sH2Wz2r6JxgYjnR7sEf/j8mksuUmT9Po2GxTCuGp+TwlN6cs7RoIXg
         j4sVnZs2y2yjjcyqD6Id+l2MzpNoR8Ndmz8QDgzl4nnxmpaRpF/M5C51SOMXfGHCtHHu
         poVDFMPOxKvLpEnncdhO+lFx1M7mCOQQsU/+rCaWzRiwSi+JnWoHRFgLN/jtTvK2pNVq
         Dvur8SRyegkgeNqvuQ9BOeX9c1aCT6/Qo5WuI9K9Qjm6A1lN9UVsNRCcvHlF7yWcgFXU
         eFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714524663; x=1715129463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BD94zdxyDu4bbMrkiiEBVb20niGXuFjMmzvoxFlieQ=;
        b=j01sRcWEnuFbL0UOUCqnoI9l9nnrI8Fp/eyjmzEaIEoAjIBk8C7w5yX+2c2Wz9LujJ
         QmSi4uxe3nu4VSd80jg4QWvSbUHCY4iRWbuWMlr3alglJh8kJsI2cv6IUXdYIZwgPd0q
         g/z0i2HHNLe0AHN2Fpuuxs4xWCBa0Z4k+g3zdTW+J1PlgogK5lPIO499HQYeKQ1EJBdy
         jSw54a5rsdGTeiGZ7ytPxzCYhSfHVzz2cUggWX3FF0lnOZflUtt0AugQX1IaTvKhQMrP
         m11GrkYcq6fgz4ESaDtKsTAzw5R67Szl6k7srkktuZPbdWmjGbDO/XtTFLQCFKbJUGQN
         rD/g==
X-Forwarded-Encrypted: i=1; AJvYcCUrLmp7sUWhjddSGwHBoYgkoloIGs2vfajT69X6pbRoug10eiD+nWUgWdfotRwgyychPirKSNyKIcprEuXstJUZ/ni/fXyu/f6bwAb6
X-Gm-Message-State: AOJu0YyU6MpW77AE5PqeVLkO1zpXEOZKqJjkXIlPcY/rcFpuOhfcvRQI
	nLbXx1mjdQH9uY/PR+EtQ1woXVwpv+7/B1ny8DPTMQmuWpdw5JRHhEO8wokRepE=
X-Google-Smtp-Source: AGHT+IGmkFCNrECwXMOsV+GH36MaUwl+gyGfkvlXgDL2aLu6d/LAO2jPBNjH2tAr3rSkoFwqy+Stig==
X-Received: by 2002:a05:6214:242e:b0:69b:17b2:df34 with SMTP id gy14-20020a056214242e00b0069b17b2df34mr1310043qvb.63.1714524663371;
        Tue, 30 Apr 2024 17:51:03 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id q5-20020ad44025000000b006a0cbed1bf9sm2543002qvp.7.2024.04.30.17.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 17:51:02 -0700 (PDT)
Date: Tue, 30 Apr 2024 20:50:58 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] memcg: reduce memory for the lruvec and memcg
 stats
Message-ID: <20240501005058.GA2538005@cmpxchg.org>
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
 <20240430060612.2171650-5-shakeel.butt@linux.dev>
 <CAJD7tkZnXY+Nbip8e6c7WC4qoYC21x=MHop_hT4NqYLKL8Fp6Q@mail.gmail.com>
 <u3okwix7ovvzzfossbmfalwpq23qa3bmv3secg7tpjk7ghyemq@w3ngvr526rc2>
 <CAJD7tkZh-bLHQhaPsU7h1WUmK3xwHVoacVcR=P55i+7d0FzfFw@mail.gmail.com>
 <gmel2s2pysaavfetoqit3zq7grcrsbbfqh7sitg577yip7knwh@bufhf7ymlyd7>
 <CAJD7tkbue8S86YZE3y_1qOF5ee14F9MCuh2iJ0BNBZC8QpL=_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbue8S86YZE3y_1qOF5ee14F9MCuh2iJ0BNBZC8QpL=_Q@mail.gmail.com>

On Tue, Apr 30, 2024 at 04:07:05PM -0700, Yosry Ahmed wrote:
> On Tue, Apr 30, 2024 at 4:00 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Apr 30, 2024 at 10:41:01AM -0700, Yosry Ahmed wrote:
> > > On Tue, Apr 30, 2024 at 10:38 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Tue, Apr 30, 2024 at 01:41:38AM -0700, Yosry Ahmed wrote:
> > > > > On Mon, Apr 29, 2024 at 11:06 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > > > >
> > > > [...]
> > > > > > +
> > > > > > +#define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> > > > > > +#define NR_MEMCG_STATS (NR_MEMCG_NODE_STAT_ITEMS + ARRAY_SIZE(memcg_stat_items))
> > > > > > +static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
> > > > >
> > > > > NR_MEMCG_STATS and MEMCG_NR_STAT are awfully close and have different
> > > > > meanings. I think we should come up with better names (sorry nothing
> > > > > comes to mind) or add a comment to make the difference more obvious.
> > > > >
> > > >
> > > > How about the following comment?
> > >
> > > The comment LGTM. I prefer renaming them though if someone can come up
> > > with better names.
> > >
> >
> > I will be posting v4 and will change the name (still thinking about the
> > name) becasuse:
> >
> > > > > > +static void init_memcg_stats(void)
> > > > > > +{
> > > > > > +       int8_t i, j = 0;
> > > > > > +
> > > > > > +       /* Switch to short once this failure occurs. */
> > > > > > +       BUILD_BUG_ON(NR_MEMCG_STATS >= 127 /* INT8_MAX */);
> >
> > The above should be MEMCG_NR_STAT instead of NR_MEMCG_STATS.
> 
> Yeah it's pretty confusing :)
> 
> How about something explicit like:
> 
> NR_MEMCG_POSSIBLE_STAT_ITEMS / MEMCG_MAX_STAT_ITEM
> NR_MEMCG_ACTUAL_STAT_ITEMS / MEMCG_ACTUAL_NR_STAT

NR is pretty common to mark the end of an enum range. It would be good
to keep that for enum memcg_stat_item.

The other one is about an array, where we usually use "size" or
"len". How about using one of those instead? I think it should be
sufficiently distinguished then:

- MEMORY_STAT_LEN
- MEMCG_VMSTAT_LEN
- MEMCG_VMSTAT_SIZE

