Return-Path: <linux-kernel+bounces-79822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DED862730
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A3D2839A7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B334CDE5;
	Sat, 24 Feb 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO3LnLyC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B84317B;
	Sat, 24 Feb 2024 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804976; cv=none; b=oFujsX7MwcuYIJx88PDKf5T6SGQli+lSt8NISHpl2ayIUik9XmAM24u90k/jZHzoY4RVnucvrDOYqZjyjvJagn/inTFsF6pxBha3WjfFgi5A7xXDECfTDWb91u4OPcMQa3Ihr3L3l6ZamJVzmUoDG6C9zqqRfzB8BGfEjphYSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804976; c=relaxed/simple;
	bh=Lyx+jlo3VcjazLK7FnQNRJu5zo/lPcZOySRjMGj+3Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mI/adKOyloo5bMs6wWJyOrzppkNucAItMQ8U/UDrXnm+D8Eumq2ChMXypAtM1182oOxuUkyxNvPo2PQF0MgCwS5vzdQ7eFsaCYfGQ2P2Q0r8dENxV2lkVovarbednutROWZ/xR7Kt4RRSbT+Fw4OYabaG/UsE+ofQOL2mzjx6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO3LnLyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D66C433F1;
	Sat, 24 Feb 2024 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708804975;
	bh=Lyx+jlo3VcjazLK7FnQNRJu5zo/lPcZOySRjMGj+3Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GO3LnLyCVMf46dnvqDxxfaXQJmLSC/y21eTEmcUy97WIlimYqNFHYqkAFAz41gW3a
	 Rk4Q4KzKxa8IdiptKMEaObfYFnu84PMWHvJTtjt+au5ZLOVsqJFju9d+8+3yCXhZsd
	 TJ0W7QMWcR9eCEbXO54SmRRW6A468yVm1GSZTcn7qv8WxPn7/X7sdmghe7ivAFxQvQ
	 V3phuCbt2eBOELhQIrrhfRHhoPvsSqvneebbBmG2G8n/SDJTVF3I4U6h9ixZjFP48y
	 ARZ2U7zsjiI52R2+O7KwO3wbbYrGXUb8fElgV/THkK5lnu4iL1xcxW3FcVF3gi+TlG
	 bTZ3PfSil9ddw==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	minchan@kernel.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than clearing young
Date: Sat, 24 Feb 2024 12:02:52 -0800
Message-Id: <20240224200252.46329-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAGsJ_4x-p+8SzyHQq_EJpbq+hSEu5MCtwpGWvafpk4xfpB1gKg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 25 Feb 2024 03:50:48 +0800 Barry Song <21cnbao@gmail.com> wrote:

> On Sun, Feb 25, 2024 at 3:02 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Fri, 23 Feb 2024 17:15:50 +1300 Barry Song <21cnbao@gmail.com> wrote:
> >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > While doing MADV_PAGEOUT, the current code will clear PTE young
> > > so that vmscan won't read young flags to allow the reclamation
> > > of madvised folios to go ahead.
> > > It seems we can do it by directly ignoring references, thus we
> > > can remove tlb flush in madvise and rmap overhead in vmscan.
> > >
> > > Regarding the side effect, in the original code, if a parallel
> > > thread runs side by side to access the madvised memory with the
> > > thread doing madvise, folios will get a chance to be re-activated
> > > by vmscan. But with the patch, they will still be reclaimed. But
> > > this behaviour doing PAGEOUT and doing access at the same time is
> > > quite silly like DoS. So probably, we don't need to care.
> >
> > I think we might need to take care of the case, since users may use just a
> > best-effort estimation like DAMON for the target pages.  In such cases, the
> > page granularity re-check of the access could be helpful.  So I concern if this
> > could be a visible behavioral change for some valid use cases.
> 
> Hi SeongJae,
> 
> If you read the code of MADV_PAGEOUT,  you will find it is not the best-effort.

I'm not saying about MADV_PAGEOUT, but the logic of ther user of MADV_PAGEOUT,
which being used for finding the pages to reclaim.

> It does clearing pte  young and immediately after the ptes are cleared, it reads
> pte and checks if the ptes are young. If not, reclaim it. So the
> purpose of clearing
> PTE young is helping the check of young in folio_references to return false.
> The gap between clearing ptes and re-checking ptes is quite small at
> microseconds
> level.
> 
> >
> > >
> > > A microbench as below has shown 6% decrement on the latency of
> > > MADV_PAGEOUT,
> >
> > I assume some of the users may use MADV_PAGEOUT for proactive reclamation of
> > the memory.  In the use case, I think latency of MADV_PAGEOUT might be not that
> > important.
> >
> > Hence I think the cons of the behavioral change might outweigh the pros of the
> > latench improvement, for such best-effort proactive reclamation use case.  Hope
> > to hear and learn from others' opinions.
> 
> I don't see  the behavioral change for MADV_PAGEOUT as just the ping-pong
> is removed. The only chance is in that very small time gap, somebody accesses
> the cleared ptes and makes it young again, considering this time gap
> is so small,
> i don't think it is worth caring.  thus, i don't see pros for MADV_PAGEOUT
> case, but we improve the efficiency of MADV_PAGEOUT and save the power of
> Android phones.

Ok, I agree the time gap is small enough and the benefit could be significant
on such use case.  Thank you for enlightening me with the nice examples and the
numbers :)


Thanks,
SJ

[...]

