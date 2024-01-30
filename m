Return-Path: <linux-kernel+bounces-44879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46DD84286E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423BCB2A60A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE2A86AC9;
	Tue, 30 Jan 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MAh/c/Rd"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FED85C62
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629927; cv=none; b=ZbcyCh34FKgfjUAwyoVmHy/FWPsqeIzanWTxjaeRfVJ7QmVPTd3YvjlJHwYyQb8uPoLAdyYCJ+UJeq2/FfqVaQKfYtR900UP0OoW2dYL/86SFZtBY4CG8PAP/uw+VzLl3tzBTwMUERhvn7jgyeLuHCmzXBvQn1piuBLQHmEyttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629927; c=relaxed/simple;
	bh=a9DSV1a3buSEtz/hZjXRiaE3i7K2xq3bipMj9zTNHjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0Kd75o50kaqIpFrjh9qFC7axqC7OkBersh047h6eiR1o+UpcgLGOU6zz9iec+oO229NCfzl2DUBu8ZSFYwSTSsF1Uje96MBiD8u2UPzKAT/P+yPgXcdGAbIwS2FLBY+x9hzjqCnfR8DXne6kmhyzcnXRIVhFD6pXoApNiyDRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MAh/c/Rd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a9f0f1d40so17083981cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706629923; x=1707234723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDKgQ8EjVSjsSkLiWJDakoC4bVJBW8jYaW7ZEBGiuZg=;
        b=MAh/c/Rd90uHb86b0J58RGJaJu2qGEqMGLbvOI6U+sfvaWCbbfGLi6ATazHD9OaMVZ
         eGQtu6kLi8c2ah4qvVkg925Nzt9XMSLJbk5qaro09EV7wqkRTodYUQs+mWlYczMwH51I
         J2DJ9VqNkpvfeg13ljxva29XvhGYjn2hJjFvrrq8EKlYimNu/1PFX+6fOmRqHlPwWzEW
         pwBFAHGLMtM3DotDvxFvIMbnZ/xvWMxaV9QiwkBrn4yH/81+029gmVc0/e0ia2mG4JKa
         Jm5YS9qFKUdwrFHzmR2GD/Uhx/mSAiXJaFxk24wSaEj/Iz3TuTvUeqv6WcbYYLHbZCvO
         aM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706629923; x=1707234723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDKgQ8EjVSjsSkLiWJDakoC4bVJBW8jYaW7ZEBGiuZg=;
        b=xDQJX7C+FnrHgX3JDB5LFDSr5otQRdnP0OChJLjdxDtalzFBw51hdIjSkpwR9uoZo1
         mT8OBfX1UxW2kCXUT9Qx6u8pDxVEknrw6Zk2X9jyEJNoov0kzHN0m3ISnxS3bncLsrjR
         Srlm8tXvIm6X0oi2M9/bkTUq+4ySXlHzu5IREi5fUcHFhFRL7IEl4QGK7Zo+pnsB2WHs
         jcli/U5lzdyfnathOHgtMF0WcLIDw2u+2wrQjLAuaZXnFTo96zt660wMd4Wmkv1Wkn00
         C9i5Rz+T8fb01B3UrLaFR+RULBOAH+d7Lj3CayFdqnxXQwp7eu2e6hKQPzEdN2l6S102
         qbNg==
X-Gm-Message-State: AOJu0Yw4UPHF3YsklgOiEbglA0UvG+tQPpwWiYytqo2yh6llujbkFocz
	SA7GX/U2tr00I9GdI9q8kGki+zPZIvkroQQD1vXRfMEAL5mBeGVaIs+V0SRrKlp/0uGTkgZm4Yh
	j
X-Google-Smtp-Source: AGHT+IHyXour5Y7pAwTZhV2ka4GDvuqw5YyY5jKAxx7XXZvnlw2JMJfhgFeiluhaq73ynDtXvaZtnA==
X-Received: by 2002:ac8:5dcd:0:b0:42a:b176:1fde with SMTP id e13-20020ac85dcd000000b0042ab1761fdemr2821771qtx.73.1706629923104;
        Tue, 30 Jan 2024 07:52:03 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id bp43-20020a05622a1bab00b0042a0d455bdfsm4181160qtb.64.2024.01.30.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:52:02 -0800 (PST)
Date: Tue, 30 Jan 2024 10:52:01 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] mm: zswap: cleanups
Message-ID: <20240130155201.GC772725@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <ZbiwW5BJhFeGc2Bd@google.com>
 <20240130122131.GA9406@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130122131.GA9406@google.com>

On Tue, Jan 30, 2024 at 09:21:31PM +0900, Sergey Senozhatsky wrote:
> On (24/01/30 08:16), Yosry Ahmed wrote:
> > Hey Johannes,
> > 
> > On Mon, Jan 29, 2024 at 08:36:36PM -0500, Johannes Weiner wrote:
> > > Cleanups and maintenance items that accumulated while reviewing zswap
> > > patches. Based on akpm/mm-unstable + the UAF fix I sent just now.
> > 
> > Patches 1 to 9 LGTM, thanks for the great cleanups!
> > 
> > I am less excited about patches 10 to 20 though. Don't get me wrong, I
> > am all of logically ordering the code. However, it feels like in this
> > case, we will introduce unnecessary layers in the git history in a lot
> 
> This also can complicate cherry-picking of patches to stable, prod, .etc

I'm sensitive to that argument, because we run our own kernel at Meta
as well.

But moves are pretty easy. The code doesn't actually change, just the
line offsets. So patch will mostly work with offset warnings. And if
not, it's easy to fix up and verify. Refactoring and API restructuring
(folios e.g.) make it much harder when it comes to this.

