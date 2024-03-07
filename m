Return-Path: <linux-kernel+bounces-95043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5149874888
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761D51F25D84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3461D54F;
	Thu,  7 Mar 2024 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA23YDnO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663931CD2B;
	Thu,  7 Mar 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795678; cv=none; b=K9bsAhpNCM4tLd7R62/7sDR5ZQ/8hmPBLhRE+hJijAxU7+iJBrm425CZgr+d0j7+zBY9Z/pdQCMGR94BL1RN81GFC83VQHptsA0ifNJGq9HLRMKjlvpQZwNH3LuhYBdBayF936+DBkuMlAIPrssCyAfKFVPsupxT414LxZBkSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795678; c=relaxed/simple;
	bh=XrqHaXGwAuBpilTxp8gnF0TssLrIh3Pzrsw4cPIBHKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muRn+6GqwL+sCpiDjOZfM4G4bO9zcTZIu8alUtFwoNdo7yZnc69xFIcqS354OQLEB4wQCc3BU385F1brVrDqOsGx7qMOLUWHIsf5Jp2h6god620Y9UDxoqhf51dmF2mWMxgZvrJWm+qrbr0MaUpBa0gdOzduvD7PV0JK87mf3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA23YDnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A3AC433C7;
	Thu,  7 Mar 2024 07:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709795677;
	bh=XrqHaXGwAuBpilTxp8gnF0TssLrIh3Pzrsw4cPIBHKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XA23YDnORCr6xDhDoeiBEwyhLiTwSpRzvg+c5WYhzs2+2pT6W/GJuGCa1xphBKrH9
	 RBscEG6PkG8jCCJYSTfYhiyCWqaDVLeUzrV/cfruVHsunC9KqYJoFDZRvCGIH5dD3u
	 +5I9znWoPTRi1Xzol74q49RBos1teuk6efvsPE3ingU4xbOdNd9FILtA5MRfna79bi
	 27mz2D5mRd0p+qcLCemAiUSyY0xZo7Fdzo9Uln2wq1INkTCvfh+QBRfczijXG9LVo5
	 b2rnJYbCdH5HYIDF0XFB9K68Yj5T6xY/AFLTr0QLAgA+dCLF0T11qS9coi06ZzTlxE
	 R6/G0QNnlkBGw==
Date: Thu, 7 Mar 2024 09:13:41 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Calvin Owens <jcalvinowens@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Song Liu <song@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with
 CONFIG_MODULES=n
Message-ID: <ZelpJS4FqDTiwbfW@kernel.org>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <ZejhcP_r5QJZcS6j@bombadil.infradead.org>
 <Zej66vQInnDYgpNy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zej66vQInnDYgpNy@gmail.com>

Hi Calvin,

On Wed, Mar 06, 2024 at 03:23:22PM -0800, Calvin Owens wrote:
> On Wednesday 03/06 at 13:34 -0800, Luis Chamberlain wrote:
> > On Wed, Mar 06, 2024 at 12:05:07PM -0800, Calvin Owens wrote:
> > > Hello all,
> > > 
> > > This patchset makes it possible to use bpftrace with kprobes on kernels
> > > built without loadable module support.
> > 
> > This is a step in the right direction for another reason: clearly the
> > module_alloc() is not about modules, and we have special reasons for it
> > now beyond modules. The effort to share a generalize a huge page for
> > these things is also another reason for some of this but that is more
> > long term.
> > 
> > I'm all for minor changes here so to avoid regressions but it seems a
> > rename is in order -- if we're going to all this might as well do it
> > now. And for that I'd just like to ask you paint the bikeshed with
> > Song Liu as he's been the one slowly making way to help us get there
> > with the "module: replace module_layout with module_memory",
> > and Mike Rapoport as he's had some follow up attempts [0]. As I see it,
> > the EXECMEM stuff would be what we use instead then. Mike kept the
> > module_alloc() and the execmem was just a wrapper but your move of the
> > arch stuff makes sense as well and I think would complement his series
> > nicely.

Actually I've dropped module_alloc() in favor of execmem_alloc() ;-)
 
> I apologize for missing that. I think these are the four most recent
> versions of the different series referenced from that LWN link:
> 
>   a) https://lore.kernel.org/all/20230918072955.2507221-1-rppt@kernel.org/
>   b) https://lore.kernel.org/all/20230526051529.3387103-1-song@kernel.org/
>   c) https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel.org/
>   d) https://lore.kernel.org/all/20201120202426.18009-1-rick.p.edgecombe@intel.com/
> 
> Song and Mike, please correct me if I'm wrong, but I think what I've
> done here (see [1], sorry for not adding you initially) is compatible
> with everything both of you have recently proposed above. How do you
> feel about this as a first step?

No objections from me.

> For naming, execmem_alloc() seems reasonable to me? I have no strong
> feelings at all, I'll just use that going forward unless somebody else
> expresses an opinion.

I like execmem_alloc() and CONFIG_EXECMEM.
 
-- 
Sincerely yours,
Mike.

