Return-Path: <linux-kernel+bounces-46374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81B843EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A611C2A9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5778672;
	Wed, 31 Jan 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="K9+h5sgb"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCAC69E08
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701227; cv=none; b=ikNYC67CXf7w+jZZ4h3/4ad4t+NpFaMn6RLncY1d14ZlJSCts1uTVKkV9FB/WVH6pZz6J6omtqzvBvEFxC7PgaNK0MgXk8YC1At6tjuQi+5sEpNOONt+DG9KiBy9G2TjJ6A0Ct02jvv6iM0BC9w4quqjV2lss5kY1Q6x/HqVr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701227; c=relaxed/simple;
	bh=gxRETUAO4ejfNPS9THFytRMFDZ4PEG1BBW8DTBF2OTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4rci41jrLJF1/1XJpNJ5o+K8wNk1Cuk0lOocRjHsFQmYfqUlAy1VWjqJ0qb/rE3MuwPMdeXYkzoW71r2h9RoZ3PBjvsMLz/nonK6w9p/h3rD8J1jqWzgq7/0JUZpxjL2zISLEenKQXgGM5MBwiz/XdScTReGjQom109rfPA2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=K9+h5sgb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a9f4935a6so6090231cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706701223; x=1707306023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Lzo33rYp/jHRN4zYc2SlNCqEW0zo3N4pWtMW5AZL7A=;
        b=K9+h5sgbxMFnHFkiVV4RtCf7AvCbz5yrqQolL+7Wx6bpvXJ1SiAapQJjWTcCaId6qW
         10/uDpM3WtO+Z0rWZInNEegS1WYeeGjtUfsicc1Zx8OavmVDkRo2MPYUGVju4BTOz1iD
         lxFnXlwTJM97RyPNXghDgzjS54GIchFYhm+ufSHSJYIc8W1IzIlyOHsegnOM+WtuPr8c
         CR7+8YIkQsIjp0BXT3rPbvcSpNiSWzB6XX0H14CbeTYWajAOvIpp23JxVxNzzjC4Nyn8
         ClbWnh9KOpmrnLukMHJl3eyTJ+KFDNW/+gkdWNRFy7UFzIvs6Pgk2P30HtlUZARx7viX
         s9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706701223; x=1707306023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Lzo33rYp/jHRN4zYc2SlNCqEW0zo3N4pWtMW5AZL7A=;
        b=Zfoe+I2tKEmQYXrEQCQDh9pmjXsy5InuOyjhz9BJTQh6oGFQOKUpJotj0H6ML4JeBY
         YwTuWJ3/UPPb4JmsknYnpddOK6XzQpPaGtfOn7V+SV410Oj2BWpkkXCqPxb+9aodZpPX
         Rk7qUrxljCROvsMImyTaGkLLBlfzunKoVcDoVAWsEeUEbicUsslwjGfmkZgD8IsexDB/
         EVNrpPn3hKMC30oUP4nipDkg8kU/bfVTR72A09nI1mWgNpWvhhm3vxDF1D0Lvg45D/j/
         TbXidD3nxedFOI5avpoFzhDBeJ0UuPuTOJ639FUSLv7FWjxJaLd4xKWXH4cGWnO0kMqj
         6e9Q==
X-Gm-Message-State: AOJu0YwAReaB+Z7wWtkr8eLjUHNPzl+gOv1SwynLu0Uu94GNUJnVoo0g
	tNhiDEFJJi67A/g57MpXlx7ItU0IxCo4/YqRnVNhx+bJFzu/NInX2N1ZFK2VEWk=
X-Google-Smtp-Source: AGHT+IHZHuDj0X9ZmM0ZA8QLxbNoD8yboDYYy0lIuwhvDcAy3bHX1G78dwqYdFflFTcQ9gLdUIou6A==
X-Received: by 2002:a05:622a:1389:b0:42a:8a3e:4e86 with SMTP id o9-20020a05622a138900b0042a8a3e4e86mr4411430qtk.21.1706701222931;
        Wed, 31 Jan 2024 03:40:22 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id y19-20020a05622a005300b004181e5a724csm4800977qtw.88.2024.01.31.03.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 03:40:22 -0800 (PST)
Date: Wed, 31 Jan 2024 06:40:17 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/20] mm: zswap: function ordering: public lru api
Message-ID: <20240131114017.GB1227330@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-15-hannes@cmpxchg.org>
 <CAKEwX=NMbVcGO4WPi7hyFPQFFec1OveGzS0AJDN+SctNNvOxAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=NMbVcGO4WPi7hyFPQFFec1OveGzS0AJDN+SctNNvOxAw@mail.gmail.com>

On Tue, Jan 30, 2024 at 03:47:25PM -0800, Nhat Pham wrote:
> On Mon, Jan 29, 2024 at 5:42 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > The zswap entry section sits awkwardly in the middle of LRU-related
> > functions. Group the external LRU API functions first.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/zswap.c | 37 +++++++++++++++++++------------------
> >  1 file changed, 19 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index e650fc587116..511bfafc1456 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -746,6 +746,10 @@ static int zswap_enabled_param_set(const char *val,
> >         return ret;
> >  }
> >
> > +/*********************************
> > +* lru functions
> > +**********************************/
> > +
> 
> nit: looks like there are 2 "lru functions" headers after this patch?
> You remove the "lruvec functions" header, then add another "lru
> functions" header it seems. The next patch removes one of them, so end
> result is fine I guess - just seems a bit odd.

Yeah that's an artifact of trying to make git produce readable
diffs. Since the lru functions are right next to the entry functions,
I went through several attempts where it wouldn't generate clean moves
but instead would interleave entry and lru functions line by line to
overwrite one with the other in place. I think the above helped in
making it not do that, although I'm not positive it would still be
required in the final form of this patch. It was kind of brute force.

> That asides:
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks!

