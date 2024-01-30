Return-Path: <linux-kernel+bounces-44867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E507842852
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134211F27196
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436E6DD10;
	Tue, 30 Jan 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="pqhQeG5O"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAEAEAC7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629605; cv=none; b=V/uBU7BLSMp6E+ZuLRoo64mZCYdTz7LoaUj5o9MV81ZGvn3K1i4qCZK6pqzol2ngZGRvqEQTs7jgI5KU9d8cKoEdk6HeCu+JA/GbFcSZSS9AsBrdgnJpVV4vHIn54NXdwnnAEWDtGzRT0rSBn687yygqYiKajjKgzbr4DugnfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629605; c=relaxed/simple;
	bh=5QsR8RljbVYaO7vDJq/bw0y7k/lPHL9DW+2lcSZjycU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkrojP7mhcxJ6XDZfNpNvxmwT5HYQ7ZmucpDwXG35DckTm3KR+9WcgYZHW/r0GphFrlARtBRst1hwyuUbbDIkntWQmPs6VUqiDob9oXcOXSLPrSOXBUsJ+EjwYiDmmk5hfvIuS3Ldvoez4saeNoI9n5/mspspWrDuxu2lwpZL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=pqhQeG5O; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6869e87c8d8so22520746d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706629601; x=1707234401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSHrhHBVRB/N03Yv4tNXKIcG1eMofMSVs9poHGu9roI=;
        b=pqhQeG5OuugVnmwZDfvBQ7xVThGR9mC7MuTpTJfQk5e0MlFxmCV3FV/KXEnf+Foe0P
         uj92oGA5QHAcj52x22VoeMWI5WtXxMvSiz87/vS3n6wq0LJBelKfFkYKqNtXefgJsnKz
         xdj2HKBd/Wnv+MP43680QQNBP46sG/vmrXqR1nu1dR/T5pcA79k/l1jEsopWDCmDzwyw
         Ti0xG9XgUcnr2CrejYcHWEfB8JcshQYpQhDg6uXp/tZo2DegNKR7gkNJFGG+WA/ZOibR
         SHV8dVUagrNG5n7PBcN8J71uXf4fwP4FnEXznrKrv3VJ1RpzOeIQsFyw72XGII2YEF+y
         Fr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706629601; x=1707234401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSHrhHBVRB/N03Yv4tNXKIcG1eMofMSVs9poHGu9roI=;
        b=GQBhv5SxrGVh2gOcfwU4y+Gtww7Ly/2Xnwy+l5bjCVbXcLZi88kJtm469d8rADUxa1
         G0VNit0gQ9DYSC2w+0m6Tw2IX7lOPDcBpHYr5q8Zo7n2ZScu1mgCEWc8+i8jzoyqaXk5
         SRyC9tGovZMClD0SbKVELEJSf7QQoPScEBQvjjlg8TMs0M43xbyYxe/RuW6/20QM4BmU
         OC7eiwryQzwlf61Ue5vQZVW4YtL+/mY83Lyf/LJHqtl6TjBwFmYW8gf/HTAACxOexcLN
         m+olZwaa+kWBpV9/ooAQXyvo7fE9H/Ta9WyRQnSS4rnJN62euHGEijJyBcjUdrL9omwm
         0tFw==
X-Gm-Message-State: AOJu0YzNyTKFZW+czyGPbjtL9uoz5YRUO6Iw0hU/oS356AXYiJ6tr2hm
	WAc6q7Z4BMUVDurQAjNjhdOIuVbnHNdjlZ3mFxLOSbnYqUpJOKlYLNxdzvXHRYk=
X-Google-Smtp-Source: AGHT+IE3fiKrWSe7S6ZuM1WBCgRmbxyZCIZYYdg2jOCfvPFEw9m9XnVh5trG28mBdcgkRiPRIGCptw==
X-Received: by 2002:ad4:5ba9:0:b0:68c:6216:35da with SMTP id 9-20020ad45ba9000000b0068c621635damr1602767qvq.55.1706629601193;
        Tue, 30 Jan 2024 07:46:41 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id pi8-20020a0562144a8800b00681785c95e0sm4595066qvb.46.2024.01.30.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:46:40 -0800 (PST)
Date: Tue, 30 Jan 2024 10:46:32 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] mm: zswap: cleanups
Message-ID: <20240130154632.GB772725@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <ZbiwW5BJhFeGc2Bd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbiwW5BJhFeGc2Bd@google.com>

On Tue, Jan 30, 2024 at 08:16:27AM +0000, Yosry Ahmed wrote:
> Hey Johannes,
> 
> On Mon, Jan 29, 2024 at 08:36:36PM -0500, Johannes Weiner wrote:
> > Cleanups and maintenance items that accumulated while reviewing zswap
> > patches. Based on akpm/mm-unstable + the UAF fix I sent just now.
> 
> Patches 1 to 9 LGTM, thanks for the great cleanups!
> 
> I am less excited about patches 10 to 20 though. Don't get me wrong, I
> am all of logically ordering the code. However, it feels like in this
> case, we will introduce unnecessary layers in the git history in a lot
> of places where I find myself checking the history regularly.
> Personally, I tend to jump around the file using vim search or using a
> cscope extension to find references/definitions, so I don't feel a need
> for such reordering.

I agree that sweeping non-functional changes can be somewhat
painful. However, moves are among the easiest of those because the
code itself doesn't change. git log is not really affected, git blame
<ref-just-before-move> mm/zswap.c works as well. Backports are easy to
adjust and verify - mostly, patch will just warn about line offsets.

What motivated this was figuring out the writeback/swapoff race. I
also use search and multiple buffers in my editor, but keeping track
of the dependencies between shrink_memcg_cb, zswap_writeback_entry and
third places like load and invalidate became quite unwieldy. There is
also the search in the logical direction not finding things, or mostly
unrelated stuff. It's just less error prone to read existing code and
write new code if related layers are grouped together and the order is
logical, despite having those tools.

The problem will also only get worse if there are no natural anchor
points for new code, and the layering isn't clear. The new shrinker
code is a case in point. We missed the opportunity in the memcg
codebase, and I've regretted it for years. It just resulted in more
fragile, less readable and debuggable code. The zswap code has been
stagnant in the last few years, and there are relatively few commits
behind us (git log --pretty=format:"%as %h %s" mm/zswap.c). I figure
now is a good chance, before the more major changes we have planned.

> I am not objecting to it, but I just find it less appealing that the
> rest of the series.

Understood.

