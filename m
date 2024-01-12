Return-Path: <linux-kernel+bounces-24248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475F682B9BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A19B1C240ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35A15AF;
	Fri, 12 Jan 2024 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d2zC4uzX"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230E136B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Jan 2024 21:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705027969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WGRvqKfKKjOW3jwQBWKqWmSsWWXWXxNdLOh25a2djs=;
	b=d2zC4uzXBKnAD4YRD4kgwiqldlv/EANQt7WRysVCN78K4SIysaV0eFXDOJfvoZYa8OCzI6
	jNzoNt4oqaOvG4m+Gw8qXN5BVNh1svKfWImcFhen8d9qMT57eyiJfWpqgHGeZRplaYEtbi
	BI+GZhAuBrOBDEw0JstWl4nednrcgp4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>, 
	Jason Gunthorpe <jgg@nvidia.com>, jirislaby@kernel.org, dhowells@redhat.com, 
	linux-kernel@vger.kernel.org, pinskia@gmail.com, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <v32ygf4fyse7cqqf5bljwrak3qapxlfcdxxp4u3ydz6tejnme7@ltatskfcerg3>
References: <938ebce3-74c5-4fcf-9de3-849271d3581d@kernel.org>
 <20240110130456.142763-1-neal@gompa.dev>
 <20240110155233.GA623732@nvidia.com>
 <CAEg-Je_P6-3PWNxM4HCzcgM=H4Y1vmywaM3gbwK0gAe0UVoZGw@mail.gmail.com>
 <20240110175755.GC1006537@mit.edu>
 <e5949a27-999d-4b6e-8c49-3dbed32a00bc@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5949a27-999d-4b6e-8c49-3dbed32a00bc@zytor.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 11, 2024 at 06:23:10PM -0800, H. Peter Anvin wrote:
> 
> 
> On 1/10/24 09:57, Theodore Ts'o wrote:
> > On Wed, Jan 10, 2024 at 11:25:29AM -0500, Neal Gompa wrote:
> > > 
> > > For what it's worth, I'm totally in favor of C++20 as well. I've
> > > mostly written C++17 as of late and it is really nice to me, but I'm
> > > genuinely excited about C++20 and newer revisions.
> > > 
> > > I also think that Linux adopting C++ and intentionally adopting safety
> > > features that exist and are being added to C++ over time would also
> > > further encourage the ecosystem to use them as well as make the Linux
> > > codebase much easier to work with.
> > 
> > Can someone speak to whether the C++ standards committee and C++
> > compiler implementations are more or less unreasonable compared to
> > their C counterparts regarding compilers being able to arbitrary
> > statement reordering, or other random futzing all in the name of
> > better benchmarks, but which make life a living nightmware for honest
> > kernel developers?
> > 
> 
> I suspect that the gcc and clang developers are more motivated these days
> about such issues since they are now using C++ as their own implementation
> language.
> 
> I had a member of the C++ standards committee reach out to me already, and
> I'm going to have a discussion with him next week.
> 
> I have a lot more to say in response to all the (excellent!) comments, but
> I'm about to leave for a long birthday weekend, so my apologies if I don't
> get back to things until next week.

Happy birthday, Peter :)

Would this cause any issues for the Rust people, e.g. linking? I'd like
to hear their input.

