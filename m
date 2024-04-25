Return-Path: <linux-kernel+bounces-159205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB08B2AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD17E1C21BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F046715572E;
	Thu, 25 Apr 2024 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YmQbhvqT"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11D153812
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080360; cv=none; b=H5U5w2DgUDkCwpoCtHQdaLsDCBykdiUZwL3ob+CvR+sGlOShzVacK0WL+uowDMb0iawRvGxngbmf4LXUCfftnvm/rK9jmelVOCpSrAh9z3WXVfUmEOwfDB1U/j46bosqd65AwhEIK0xftC7XilrkmIr+YSlqHHUw7DFC4o60RBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080360; c=relaxed/simple;
	bh=ANuUZMaTH+/J+cSi8lFPdQJweuKHc3U1ixJgR978CHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEAhfqPQs+4U99cVq3mAzt/jDupLfiUcxOAazbAbSUHlFpdLIXgiPDWLqZ799ljFEo4RHopOF9JNHol6ovkUdR2t/hyTnalpkUJMoYc5czMJPSDJsWXUJy6jSjoX6GNeWNnsfEEYx8RClF2r+XgAaYKD7KWAkCwgEyh9UMQkqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YmQbhvqT; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 17:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714080356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcs3Nm1/9Fh3J4Kqjg9L7siFh+ejjk1lAbPq3D1UGRw=;
	b=YmQbhvqToPD8nhSNDwaoX67lVDstd2lh5nC43lMUz2k/EOy6dFPKAW4SrYT2ZhD3p560p6
	Bmlbsij0Gfehhr1YbVmUEz7InnK3T+SwykJMgqp0T5g3mGed6q/JUm/btmDRDBA/mP/cW+
	RtYzd/Y/R+KOSDYGIsjIm8vMj6bjhdw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <flylmwja66rqcefjbfrtec4awu3chdkaiek7eajlyw76zalgg4@o6gznuiniu7g>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <CAJuCfpGiRFAOp-aqpVk6GRpG=4LEF3XyuV_LijzwDYRHKqHWWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGiRFAOp-aqpVk6GRpG=4LEF3XyuV_LijzwDYRHKqHWWg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 25, 2024 at 02:21:39PM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 25, 2024 at 2:04 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Apr 25, 2024 at 09:51:56PM +0100, Matthew Wilcox wrote:
> > > On Thu, Apr 25, 2024 at 04:45:51PM -0400, Kent Overstreet wrote:
> > > > On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> > > > > The /proc/allocinfo file exposes a tremendous about of information about
> > > > > kernel build details, memory allocations (obviously), and potentially
> > > > > even image layout (due to ordering). As this is intended to be consumed
> > > > > by system owners (like /proc/slabinfo), use the same file permissions as
> > > > > there: 0400.
> > > >
> > > > Err...
> > > >
> > > > The side effect of locking down more and more reporting interfaces is
> > > > that programs that consume those interfaces now have to run as root.
> > >
> > > sudo cat /proc/allocinfo | analyse-that-fie
> >
> > Even that is still an annoyance, but I'm thinking more about a future
> > daemon to collect this every n seconds - that really shouldn't need to
> > be root.
> 
> Yeah, that would preclude some nice usecases. Could we maybe use
> CAP_SYS_ADMIN checks instead? That way we can still use it from a
> non-root process?

A sysctl would be more in line with what we do for perf. Capabilities
aren't very usable, and CAP_SYS_ADMIN is already way too much of an
everything bucket.

