Return-Path: <linux-kernel+bounces-62497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB2F8521B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1705A2847B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104AC4E1CA;
	Mon, 12 Feb 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umnWU0ZR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B93E474;
	Mon, 12 Feb 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778018; cv=none; b=OebSR/qoq0w80Fb1MgXlWLgHaBOJLr1wt1ifDSiU1hSVTVpowlwoOKBFcXsfPBIlzDHbXiy24uJfiwWJjxc/xsIadA2FJ8wGet0QRD4tBndYv5jyGrlApqVjQmq6rbEKaZW5RabiI71SoNIOsvT2AyU8OLfFn7TdcpeAe7l1vkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778018; c=relaxed/simple;
	bh=wSOHGyIDWYIPZ7l+oLIo5vrequYZhtFOvtQM7k7fYVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAzbIeF7JtszxaqGgnehUvsULdurwX5skJEXJRJWHI59Tk+XVyFyEiXrmT7kCNnzm9VHIosgSYkVcpuMtop17S/5pD0nKpmwinOuzT/VwbxtkJXJsZvfFRA9WX7DMbdPokh0RFJpAb3epBqtrMHpHkJeZQub8TAkwSD91hkydxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umnWU0ZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB45C433C7;
	Mon, 12 Feb 2024 22:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707778017;
	bh=wSOHGyIDWYIPZ7l+oLIo5vrequYZhtFOvtQM7k7fYVE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=umnWU0ZRrC2fA1vL4iQlz5ndL7e/IJOTsSflpsJG7siHYE0WizBtJlKBzoG62p7IT
	 J6UQyTAs2xXyWohaorzbwMHSRDQjyQEKrjgqmEd1GTUXZku7A+BVVUAkToE4CB//WR
	 ddyCnPDXasMoMaEr6y++nbSqbd4CoroT/vTHG1yENRlP9Asg8tDdIoEYUUonD2YFx0
	 BJFiEkKCKDV1+4Ea/pNrLh8TagRpfMZueR0orTn2AfDTPbG+N50MymHy+T/SL1loHK
	 bnSeO+lvcfV9r5DXUh2ehG8PuftUscQ7Jb2gWtG3lQ5Bp46o1/ZWCKoUOcwNPvJC3D
	 7yf432ZGIjN1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 62E45CE0FF5; Mon, 12 Feb 2024 14:46:57 -0800 (PST)
Date: Mon, 12 Feb 2024 14:46:57 -0800
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
Message-ID: <2d8b17f2-c22f-478f-b407-9d2dfd2064f7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
 <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212201038.GNZcp7PuIqIJndpDM9@fat_crate.local>
 <47901422-ac07-47db-bf44-3f4353e92b1d@paulmck-laptop>
 <20240212212741.GPZcqNTXfU2OX7uRtx@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212212741.GPZcqNTXfU2OX7uRtx@fat_crate.local>

On Mon, Feb 12, 2024 at 10:27:41PM +0100, Borislav Petkov wrote:
> On Mon, Feb 12, 2024 at 12:44:06PM -0800, Paul E. McKenney wrote:
> > If it is the #MC adding new memory, agreed.
> > 
> > If the #MC is simply traversing the list, and the interrupted context
> > was in the midst of adding a new element, this should be no worse than
> > some other CPU traversing the list while this CPU is in the midst of
> > adding a new element.
> 
> Right, Tony answered which context is doing what.
> 
> What I'm still scratching my head over is, why grab a spinlock around
> 
> 	list_add_rcu(&chunk->next_chunk, &pool->chunks);
> 
> ?
> 
> That's the part that looks really weird.
> 
> And that's the interrupted context, yap.

The usual reason is to exclude other CPUs also doing list_add_rcu()
on the same list.  Or is there other synchronization that is preventing
concurrent updates?

							Thanx, Paul

