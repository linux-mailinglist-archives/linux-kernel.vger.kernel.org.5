Return-Path: <linux-kernel+bounces-159228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B515F8B2B15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D9C1F218EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD33156676;
	Thu, 25 Apr 2024 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HIApaua1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005ED156645;
	Thu, 25 Apr 2024 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081124; cv=none; b=BD+7hKVQ2z+1PE8VpSceOr00zjSETIuVAnd58mQaSbYdwD3FTJf8kRqXQkIOXML/lPK7vDl+gS4nXIg5gBIERi+BiAIVrsN83FjDeiVxivmn3iFtSZDn0PO9FVeX32/cXrv513/oHWjGD9PWJlJmLD0MEXPdW8YpBOfUhu7ajwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081124; c=relaxed/simple;
	bh=c/w30T3d2xLjoPV7BOj7cdIM3uDt5brThstTtJMw1qw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eVWREov6IcO76Q9TN5lmIqAx2l0aWd1Xf/sTKa71FeGkxQpvZ0g1GTR5EyqTR7FkGuwCsvORrh2qnrNDi78tutCpkqvVjgB/YWGy7KiE+oSj73nhG6FYidwqgjRx4MEC8bRGe/Cs7EFz3jJwSL9KIIjH/0bD+xVaYIODF46f85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HIApaua1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ECCC113CE;
	Thu, 25 Apr 2024 21:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714081123;
	bh=c/w30T3d2xLjoPV7BOj7cdIM3uDt5brThstTtJMw1qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HIApaua1Lra3WV8XfIDrQSiFAgLFluP6pDWigAGa+kys+mss6Iar5kIVbzQv4MGFC
	 PXHzGlBiBpU2dHYpxJcvCKdIQUpIuljiylgUK4Gke54aTMqZAVAbWzyWxVm3nxNVgO
	 uC3RQrfd4XIvRR2eZJK0bW4GTZhD55zJ93BFXebs=
Date: Thu, 25 Apr 2024 14:38:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Matthew Wilcox
 <willy@infradead.org>, Kees Cook <keescook@chromium.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-Id: <20240425143842.fe54147e4073c7d5e8b48d7b@linux-foundation.org>
In-Reply-To: <CAJuCfpGiRFAOp-aqpVk6GRpG=4LEF3XyuV_LijzwDYRHKqHWWg@mail.gmail.com>
References: <20240425200844.work.184-kees@kernel.org>
	<w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
	<ZirCbPR1XwX2WJSX@casper.infradead.org>
	<64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
	<CAJuCfpGiRFAOp-aqpVk6GRpG=4LEF3XyuV_LijzwDYRHKqHWWg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 14:21:39 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

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

I'm inclined to keep Kees's 0400.  Yes it's a hassle but security is
always a hassle.  Let's not make Linux less secure, especially for
people who aren't even using /proc/allocinfo.

If someone really wants 0666 then they can chmod the thing from
initscripts, can't they?

