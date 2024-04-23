Return-Path: <linux-kernel+bounces-155852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6591B8AF802
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1287528B608
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8F142E70;
	Tue, 23 Apr 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JHynQWbu"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282D53361
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904225; cv=none; b=GfTV97BfRIbxnFFioE32EbRPEzH1/zp3lCjjKSAEBrBNZX2Y8R5rMIYd4J9d2XXBaLus55SktvQ09op/RjbBt+5Zcy5CA5ZZPozaOTJsapTdAaWDkwzqi0zt1NhIsb3be72eAs20YNOsh7tQPtoDxFS5WQo7A8zCkGtSrUy8Yq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904225; c=relaxed/simple;
	bh=CVIaYdYrEQr9OMr4jPSvITFD5x9uRmh+lgV2uZibvH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRyWmdFrxL5eg6o97OYHUg4zt6/LIQCR0E5BHwUKIiL3SdgR73odnyBmMUqY0LlrlTGClRGmBCTiBuOW7g98BekokkBmBtMpYqyfEGS8RpE16rTev+Fo29Z3j9hZxyfl66Mlz7Si6tRJgESY/T5Ty82wWMq2vLM7Ix7jrSKFx1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JHynQWbu; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c75139645aso2266946b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1713904221; x=1714509021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Torx1UPL12mK+9YLUjCQ2uCUXMbYdjic5Odfv8SpXtw=;
        b=JHynQWbugy4Cre7zVazDOiiX6ngpiwUSYNeeRKv78CLrMwNA7ilqjPIE509zAAD21i
         OxETTMGiO7PUxpbSEFx4I414Ex5Jz/29bNhOmCsFbclz4+g+U4ChGjsc/pwNYwiVByiY
         OOwRB4n4iVuOqVqWzp0aO6aE8xuBbkogiR+0Vg02aw07RECbBIrjcS8qL871b9o2U5CI
         8RDDWa410mhqhWTCnbD4umKWUCgONF2UVh3aCYDPbUzjucivRrLaZXfP9lZtERqPh0nO
         ZoaZD68UTghvu5a7/sA0bgoqxzVP/v149nhGBTiROWpd5216QQdqQKK80emib3Q8KDJs
         1e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713904221; x=1714509021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Torx1UPL12mK+9YLUjCQ2uCUXMbYdjic5Odfv8SpXtw=;
        b=fq8XG3nvxiJri6NqLjcYAmNJMpc/VoCeK4NzzCeFhBjQoHxyy/B7qSC8pf6OW/biYo
         aV4b4xcBY+ubj5afUgXtodqpV3MhlNbhSJ5a/TbIXPpkw0P5wUR7v9VORN/bffxKXOj9
         0zIM/pfY0p8Y/5WTtqE35umDEJshkD03qP0QU3oQYfIRG82DyDlf315HzWHfBxVy9i+m
         bBHAw6CE2PUR6YPWplQnb1B08Wf2jjdkNaUmZTgt4rgzvMFFqxrdh0tDwHLM4F3CC6hD
         7HXYpqTF8ggw+l+/bnhiCoAfPWgT7cu6EFbFmUc9kMlqHiHI4vupPChTpUdeO+3nUY3P
         KbvA==
X-Forwarded-Encrypted: i=1; AJvYcCUr5jbED6scN2GY1t+nQBwcWHgnCCEzW/O7+c+joEjsy1cd9fBvT2KslV9y8NDWXRB/t/cJXayLu1H7D8whC6Pv4M7ALKOuSXLIDSZD
X-Gm-Message-State: AOJu0YxzRSSJQmjSS8AZA3rc9CpTT/OZ6N0vbPWDUryV3aGHzydtR53j
	RCDaauB9DpiQqrQY6GjqfkIga9WobGrMWYqnflS4Q1sBJPYof1kkhs4UAK43AkY=
X-Google-Smtp-Source: AGHT+IHiUxJyLagPh/XINCMcJOpOhbZaSAa+jmo6C+ieX//m+gTeBM2QnjuG/QPlu/Y4VeO/9CBQHw==
X-Received: by 2002:a05:6808:13d4:b0:3c7:5371:6a24 with SMTP id d20-20020a05680813d400b003c753716a24mr488139oiw.8.1713904221643;
        Tue, 23 Apr 2024 13:30:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9cfb])
        by smtp.gmail.com with ESMTPSA id w9-20020a0ca809000000b00696b1050be8sm4365264qva.133.2024.04.23.13.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:30:21 -0700 (PDT)
Date: Tue, 23 Apr 2024 16:30:20 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/1] mm: page_alloc: Avoid defining unused function
Message-ID: <20240423203020.GB318022@cmpxchg.org>
References: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
 <20240423111000.aaf74252a07d7e7fd56d7e12@linux-foundation.org>
 <Zif9e5ByqBKJ9rgQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zif9e5ByqBKJ9rgQ@smile.fi.intel.com>

On Tue, Apr 23, 2024 at 09:27:07PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 11:10:00AM -0700, Andrew Morton wrote:
> > On Tue, 23 Apr 2024 19:14:43 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > In some configurations I got
> > > mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
> > > Becuase the only user is guarged with a certain ifdeffery,
> > > do the same for add_to_free_list().
> 
> ...
> 
> > Thanks, I'll queue this as a fix against "mm: page_alloc: consolidate
> > free page accounting".
> 
> Thank you!

Thanks for the fix. We switched most callsites to __add_to_free_list()
now, I didn't realize the memory failure code was the only one left.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

