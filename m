Return-Path: <linux-kernel+bounces-62351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722D851ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E4C1C218CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB96F47A67;
	Mon, 12 Feb 2024 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM/EBlbJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB31DDCE;
	Mon, 12 Feb 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770647; cv=none; b=U1CkEBc+mNNmuLE9EvVamqlKIugdRHiUv1RMBHVSusvIjdrC0BAdLuCZjVOuxd3kqS/cAjg7R9K/19x4Jg+2H6oJ6SA5mEgft2LXSM1yLLDdXS46xyOD30JWEalmTafAPyaV8tazLTWWNi21f4PFa0uD2i5dqvdnypNFaKTAoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770647; c=relaxed/simple;
	bh=5cA2uv85XI2LqQAIeYs9/jOmkmdamdCwXV4Ahe+oydk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM2N131pQ9mfLozQInOD194QlspULgfz9mACOg26xPk8lXJpBdNsDzXI/ajvQUzPcBHM3Evajjdjzu8mNC9MVnqEm6J/nnJs9ALRwGLWf/oAJeolV1YghG2eq9yBVEQLIVvZPI4FZBMcX+R+22Nj3nGW05qw/3ooH7bRWa9EKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM/EBlbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9366DC433F1;
	Mon, 12 Feb 2024 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707770646;
	bh=5cA2uv85XI2LqQAIeYs9/jOmkmdamdCwXV4Ahe+oydk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dM/EBlbJbpdrbH/tNQF3OFzIUzA67cwBjvsHCCyuXhXUEUiItz5IVKyDWaLXJGn7j
	 sF1IVmI4GbMSOvh5pYnvMhyvAK7S6/EZ6Z38Jvjbzn8oymT0Oj6aANlESo5CVIzkme
	 ibBltYbgrNZsbJN1B0tKjt3ov1AboxXjDMbj0tVxRt9eiDd377+dqazPCN2T7UaRXi
	 yq8vF5LbIt/uffA76bH36zf+f6SrDOkLnPbRloEl7+O1M5Oeo2LDx03poZskGnCSXp
	 xKRg39hrnhsuyf8JoIGEHCKj/dEtNqg5NDk6GFLHTYUL5Fc8zPVZQiRlRmr6nP4Fsu
	 3tAo6KXFwvuww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2935ECE0DEC; Mon, 12 Feb 2024 12:44:06 -0800 (PST)
Date: Mon, 12 Feb 2024 12:44:06 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <47901422-ac07-47db-bf44-3f4353e92b1d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
 <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212201038.GNZcp7PuIqIJndpDM9@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212201038.GNZcp7PuIqIJndpDM9@fat_crate.local>

On Mon, Feb 12, 2024 at 09:10:38PM +0100, Borislav Petkov wrote:
> On Mon, Feb 12, 2024 at 07:49:43PM +0000, Luck, Tony wrote:
> > Yes. The question is whether a #MC that come in the middle of list_rcu_add()
> > can safely do list_for_each_entry_rcu() on the same list.
> > 
> > RCU is black magic ... maybe it can do this? Adding Paul.
> 
> Yeah, the list traversal might be ok as this is what that list_add does
> - you can't encounter an inconsistent list - but we still take
>  a spinlock on addition and the commit which added it:
> 
> 7f184275aa30 ("lib, Make gen_pool memory allocator lockless")
> 
> says
> 
>     The lockless operation only works if there is enough memory available.
>     If new memory is added to the pool a lock has to be still taken.  So
>     any user relying on locklessness has to ensure that sufficient memory
>     is preallocated.
> 
> and this is exactly what we're doing - adding new memory.

Is the #MC adding new memory, or is the interrupted context adding new
memory?

> So, until we're absolutely sure that it is ok to interrupt a context
> holding a spinlock with a #MC which is non-maskable, I don't think we
> wanna do this.

If it is the #MC adding new memory, agreed.

If the #MC is simply traversing the list, and the interrupted context
was in the midst of adding a new element, this should be no worse than
some other CPU traversing the list while this CPU is in the midst of
adding a new element.

Or am I missing a turn in here somewhere?

							Thanx, Paul

