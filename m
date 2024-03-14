Return-Path: <linux-kernel+bounces-102703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC5E87B636
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77971C20B99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BEA4A1B;
	Thu, 14 Mar 2024 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o88uf++9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109E440C;
	Thu, 14 Mar 2024 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710381100; cv=none; b=mACpNkNq3R8wQVr5Lk7Bz7eUWFsCPV5oAYseRyCRkBV9UmcLW81qbVbreJWPd3TLSuLkNJleh6UFDTPn3HbgzYdWNbcQHNGZfh0J3A3n157hXPvAZU5VGZP1fR38dnv/r2sgROR1gV3cm1OI1lAdGQCqUkQ43X7JZrX00GfNY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710381100; c=relaxed/simple;
	bh=ysygYWOGeMQAohnSXmJR9KYUkCnmKWHH3aTVFgVfQUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7iLiuhufhvH6ha+KjNlHCDx7KIJoRhZL/h2XItsAcCwIiG9sT7NcBxpraCxwzaRKfPrUB6QInjeXtQRZLstjczaxdKCh2e+F+oZCaSwjLJ3RGVhKDVFrRmslyqw8NgPUmRSZ567b3Zk4J8g+Xvnb65BvXXuszjPhRm9JxxcsnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o88uf++9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB47C433C7;
	Thu, 14 Mar 2024 01:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710381099;
	bh=ysygYWOGeMQAohnSXmJR9KYUkCnmKWHH3aTVFgVfQUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o88uf++9Ax0S8z7M+AmMOXOWcPLwlSgvsAbCJfGMZZZoXLReocKaaxbl3ey0SgZsd
	 OAQL3KgDuc/632ZgBCLs5U/qgQr0vwMjhfM3hNZVbPWRtKoN7TAlhF58ttglHBWVGF
	 WH/Z/SEcoi/wEJhl316hReclEGyGbcNfwC688/2xNbAIVUFlgaC5xDKWZgZVTcCtkJ
	 jWUxdYm4odyFPpWsNV0YXEmXqk4IfPIXHkine2LXs7Uu/PvnNhcwEFhYars6yuegoD
	 sQiTYrN3ITAFtFLxw7ash4WOMEZOjz0AYldXdGsvnNaWSo3bfh6ZWldycQDtV8d9XD
	 1GlmaMfEF4Ftg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC IDEA] ACMA: Access/Contiguity-aware Memory Auto-scaling
Date: Wed, 13 Mar 2024 18:51:37 -0700
Message-Id: <20240314015137.62598-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231112195114.61474-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 12 Nov 2023 19:51:14 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> I'd like to share an idea for making systems automatically scale up/down memory
> in an access/contiguity-awared way.  It is designed for memory efficiency of
> free pages reporting-like collaboration based memory oversubscribed virtual
> machine systems, but it might also be potentially useful for memory/power
> efficiency and memory contiguity of general systems.  There is no
> implementation at the moment, but I'd like to hear any comments or concerns
> about the idea first if anyone has.  I will also share this in the upcoming
> kernel summit DAMON talk[1]'s future plans part.
> 
[...]
>
> ACMA: Access/Contiguity-aware Memory Auto-scaling
> =================================================
> 
> We therefore propose a new kernel feature for the requirements, namely
> Access/Contiguity-aware Memory Auto-scaling (ACMA).
> 
> Definitions
> -----------
> 
> ACMA defines a metric called DAMON-detected working set.  This is a set of
> memory regions that DAMON has detected access to those regions within a
> user-specifiable time interval, say, one minute.
> 
> ACMA also defines a new operation called stealing.  It receives a contiguous
> memory region as its input, and allocates the pages of the region.  If some
> pages in the region are not free, migrate those out.  Hence it could be thought
> of a variant, or a wrapper of memory offlining or alloc_contig_range().  If the
> allocation is successful, it further reports the region as safe to use to the
> host.  ACMA manages the stealing status of each memory block.  If the entire
> page of a memory block is stolen, it further hot-unplug the block.
> 
> It further defines a new operation called stolen pages returning.  The action
> receives an amount of memory size as input.  If there are not-yet-hot-unplugged
> stolen pages of the size, it frees the page.  If there are no such stolen pages
> but a hot-unplugged stolen memory block, it hot-plugs the block again, closer
> to the not-hot-unplugged blocks first.  Then the guest users can allocate pages
> of returned ones and access it.  When they access it, the host will notify that
> via page fault and assign/map a host-physical page for that.
> 
> Workflow
> --------
> 
> With these definitions, ACMA behaves based on system status as follows.
> 
> Phase 0. It periodically monitors the DAMON-based working set size and free
> memory size of the system.
> 
> Phase 1. If the free memory to the working set size ratio is more than a
> threshold (high), say, 2:1 (200%), ACMA steals report-granularity contiguous
> non-working set pages in the last not-yet-hot-unplugged memory block, colder
> pages first.  The ratio will decrease.
> 
> Phase 2. If the free memory to the working set size ratio becomes less than a
> threshold (normal), say, 1:1 (100%), ACMA stops stealing and start reclaiming
> non-workingset pages, colder pages first.  The ratio will increase.  The
> reclamation is continued until the ratio becomes higher than the normal
> threshold.
> 
> Phase 3. If the non-workingset reclamation is not increasing the ratio and it
> becomes less than yet another threshold (low), say, 1:2 (50%), ACMA starts
> returning stolen pages until the free memory to the working set ratio becomes
> higher than the low threshold.

So, the idea is to keep only specific portion of working set as free.  However,
the free memory to the working set size ratio is not easy to understand since
it changes very dynamically, based on the access pattern.  Hence, imagining how
it will works and what results the system will get without visualization or
detailed example scenario is not easy.  This would be much more challenging for
users.  The three thresholds may also be hard to be optimally tuned, especially
when the characteristic of the workload is dynamic.

Since we have user/self-feedback-driven auto-tuning, I believe we could make
this more simple.  Specifically, ACMA could ask user to set min/max memory of
the system to guarantee, and acceptable level of memory pressure.  Then, it
could do its best to make the system memory efficient while keeping the three
conditions.  Detailed mechanism will of course more complicated then this
simple statement, but I believe this simple statement is letting users
understand what the result of using ACMA is.

I will share more detailed specification of the updated idea as another "RFC
IDEA" mail soon.


Thanks,
SJ

[...]

