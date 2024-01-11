Return-Path: <linux-kernel+bounces-24101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B167A82B6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E611C210E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F094A5820B;
	Thu, 11 Jan 2024 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xet3vbjy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A456B83
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518A8C433F1;
	Thu, 11 Jan 2024 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705010045;
	bh=5T6qmUEqSEe0y8Obv/o5UTTw7CLDO4G0csQ596TuakI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xet3vbjyx49+zfrk6MoGZp+RE0E2OV0FzrKZ0ZXmFapYLTO35UsS1r5wNfkz/t7Ci
	 WJPKnqknMB31sMqW/lhl4CfY/mRU88A/qTLaNF0sg2Z0Eq06Ry54XJPDv0c37pz6Zs
	 QrkOb2PFKYrp1Ufezc7HHacf5qcOkOpd4lFQwQq8=
Date: Thu, 11 Jan 2024 13:54:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, oom: Add lru_add_drain() in __oom_reap_task_mm()
Message-Id: <20240111135404.609af4a26d0118c0d290f11c@linux-foundation.org>
In-Reply-To: <b2096bcb-bda6-4831-85a2-67759e783e4d@oracle.com>
References: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
	<ZZ5Zb3FYqY8FZgB3@tiehlicka>
	<1d866f1b-94b3-43ec-8f4c-2de31b82d3d1@oracle.com>
	<ZZ-q0PZ-XCDwA4oG@tiehlicka>
	<b2096bcb-bda6-4831-85a2-67759e783e4d@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 10:54:45 -0800 Jianfeng Wang <jianfeng.w.wang@oracle.com> wrote:

> 
> > Unless you can show any actual runtime effect of this patch then I think
> > it shouldn't be merged.
> > 
> 
> Thanks for raising your concern.
> I'd call it a trade-off rather than "not really correct". Look at
> unmap_region() / free_pages_and_swap_cache() written by Linus. These are in
> favor of this pattern, which indicates that the trade-off (i.e. draining
> local CPU or draining all CPUs or no draining at all) had been made in the
> same way in the past. I don't have a specific runtime effect to provide,
> except that it will free 10s kB pages immediately during OOM.

I don't think it's necessary to run lru_add_drain() for each vma.  Once
we've done it it once, it can be skipped for additional vmas.

That's pretty minor because the second and successive calls will be
cheap.  But it becomes much more significant if we switch to
lru_add_drain_all(), which sounds like what we should be doing here. 
Is it possible?


