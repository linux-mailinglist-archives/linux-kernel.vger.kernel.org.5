Return-Path: <linux-kernel+bounces-147554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B28A762C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817CC1F23797
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA55BACB;
	Tue, 16 Apr 2024 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZZ/JlCMe"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB61E864
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302109; cv=none; b=rOFci8WOmAlO97T2xfIJKkX8HTgN29mSTa2sWYGZEjBwkiu4DSCbylPyF+xliO3BUw5U6bFxTDbu8VMvCkAl9GSroPp4SUhT27GzBl5GPwp5ptcF/jSbOQjeyp3SIQWPGxkEeVUmJITGymDdYPf2s6Zj1XX2kRGrKkyHDIEIvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302109; c=relaxed/simple;
	bh=PjGLsefc9/tCgj7AApKQXcWQr179c0n4nR8NEB1dlyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhsIAeg+igyet3DGPGeLVqmGmaBgnqls9qZocPowT2ftRwv1kw9QB8qWpIReTou2FiEDWlau77arikPnsWFpGM97/v3YnpaQ5vgq8r0dAxEfPi+g0KUjKe3kaKSfxH+whmhvdi4Ps8qwXFJEAKMWwrbEVPotxQr51WMlwcv3FJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZZ/JlCMe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e65b29f703so23294895ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713302107; x=1713906907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pTzXQk5cYMYr3uWvC+W6FdkM1s551/ydGHaU1dE8ImE=;
        b=ZZ/JlCMeiqH/9W/WxQMdFT6WE7uexc2+m+Opj9KK+8IY3STgarhOcL2di4BJ4jLH6j
         V04+KdJDJSAfg0EJ7mKr2iLQcUUDtzr8BMXVt9nt3vZc/Im9GJOv3K+ln4hlEPUyTmxw
         EhwWJC/GRrsqi21wRLpEmlcaLA8hu1xINa0aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713302107; x=1713906907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTzXQk5cYMYr3uWvC+W6FdkM1s551/ydGHaU1dE8ImE=;
        b=hYmBZFQYvxlaPFGyiU1QEhJnHgtEqT7YlyeXl5E9mdqftN0teZqC+bnhWN8HwqsG0P
         KRXLZNcr5NTPYKbBuhNjVl9nxUZkVYxbQ5PidxsXFzvi+4hPQ2D/aFp/KbCBxhYyJhNt
         F7yK6xf/y2GIVDSrbRNv9Hlodp9nV+vuImI6bbPo8+0RK5598mbxugjPKDoyHneoNlFZ
         HJcZM2wDUfhsAWxrAV+/eOqoNOWUMTViYYCqeCgc1S/1ZbL7yCc+4pwZ2cQ5nD95A8iz
         pS5p+VjCeXPmsPYqyDIw1Oa8X75UnshWtxpN7IHUxHIF3KO0IFVdUWtLIkNPT4uViwKT
         8wjg==
X-Forwarded-Encrypted: i=1; AJvYcCVoKlEpf7x1I6jNbVK7iSYfl6N/V+X/ILUuE7ARa3WDAi2HPxnfGFRqhGS9Rn8tGObtRhyk28XGwMbsEvUxzpPT2crhOJYh6NXbY4jL
X-Gm-Message-State: AOJu0YwItLSWPB7nFTkJ25/W0MubeynC9vJjK2GseiGGjKIJ1muRM7me
	ojZlj5HO9QGOchX6IW9/AbkwrIBWEQwVE3yaSh+NUcXlMJ36wTBvp6Jd37BzxQ==
X-Google-Smtp-Source: AGHT+IFCsq9S5/cbVp0lnxA0tUMH8WRTnjuRRJ5Uu0Baa9l7gBLBXdaH4bb/p9nHjctMeNCzXwE66Q==
X-Received: by 2002:a17:902:ee4d:b0:1e4:ccf6:209f with SMTP id 13-20020a170902ee4d00b001e4ccf6209fmr11655360plo.28.1713302106842;
        Tue, 16 Apr 2024 14:15:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001e49428f313sm10239724plb.261.2024.04.16.14.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 14:15:05 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:15:04 -0700
From: Kees Cook <keescook@chromium.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
Message-ID: <202404161413.8B4810C5@keescook>
References: <20220302043451.2441320-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302043451.2441320-1-willy@infradead.org>

*thread necromancy*

On Wed, Mar 02, 2022 at 04:34:32AM +0000, Matthew Wilcox (Oracle) wrote:
> I thought I'd choose one of the more core parts of the kernel to
> demonstrate the value of -Wshadow.  It found two places where there are
> shadowed variables that are at least confusing.  For all I know they're
> buggy and my resolution of these warnings is wrong.
> 
> The first 12 patches just untangle the unclean uses of __ret in wait.h
> & friends.  Then 4 patches to fix problems in headers that are noticed
> by kernel/sched.  Two patches fix the two places in kernel/sched/
> with shadowed variables and the final patch adds -Wshadow=local to
> the Makefile.
> 
> I'm quite certain this patch series isn't going in as-is.  But maybe
> it'll inspire some patches that can go in.

I was looking at -Wshadow=local again, and remembered this series. It
sounded like things were close, but a tweak was needed. What would be
next to get this working?

Thanks!

-Kees

-- 
Kees Cook

