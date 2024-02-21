Return-Path: <linux-kernel+bounces-75595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D6485EBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534E41C22AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340B12880F;
	Wed, 21 Feb 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S040VVPj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC4127B68
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553706; cv=none; b=S2dogf/ROAwC3hO5ocYOdGlWZmzKPvxoEN2rP807Knp1SBUW/xu4LTo7qNkjmDqPW/x9fS5xx0dQw/HlH/elyggxGYJ4q0nlX1zt3jVRs5sUJ0KROOsYaUx1Di7vJJDrA6a3aUWFWIJEjidL1YwHCjwHHS3vnqbX8f58IIMupek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553706; c=relaxed/simple;
	bh=pVsIndEbFUfPsGagLBr+KPbde70KmO6aWFeU/fLbpjI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NWJJMWYYd3oCjM/DM0PIO7H0lkapeHc0skSkb/pSjWfYAhOeuG9s3C1W4hTCbR5NhPhUqh1GrPjAQjh/7Abo6VLJyPWHHvHxgfuDbeQWEXohGetDuJrYyYPZC9PIfg/6qyAm0kCfciAP6AaksmOXJRtk9j63KiZ3XFjTVWVKJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S040VVPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534B5C433C7;
	Wed, 21 Feb 2024 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708553705;
	bh=pVsIndEbFUfPsGagLBr+KPbde70KmO6aWFeU/fLbpjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S040VVPjk1Bp+pNjJutpGTQzoGao39dhsaZjMPROjzlanWRpsHOQC+ct+rVacI6Sa
	 p3U5uV3XZfsUIn1nNHhuLbgJV1BIicgGr4lzoIDgjcuItG/aRgh+ItkDr8OvDsARAM
	 L9rx5y1/uww8wzyT8tsYTd1PrybWbYrYlgS3Qikk=
Date: Wed, 21 Feb 2024 14:15:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
 mgorman@techsingularity.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: compaction: limit the suitable target page
 order to be less than cc->order
Message-Id: <20240221141504.3c3cec674553b4df4bd72ec1@linux-foundation.org>
In-Reply-To: <83bc1070-2eb4-4fac-aecf-9cc407003ca2@linux.alibaba.com>
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
	<20c8fa7c-62ae-4e48-aaec-8b512519cee9@suse.cz>
	<5277627F-6791-46A1-AFC2-54FBF0DABF1A@nvidia.com>
	<83bc1070-2eb4-4fac-aecf-9cc407003ca2@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 10:55:59 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 2024/2/12 23:00, Zi Yan wrote:
> > On 12 Feb 2024, at 4:13, Vlastimil Babka wrote:
> > 
> >> On 1/22/24 14:01, Baolin Wang wrote:
> >>> It can not improve the fragmentation if we isolate the target free pages
> >>> exceeding cc->order, especially when the cc->order is less than pageblock_order.
> >>> For example, suppose the pageblock_order is MAX_ORDER (size is 4M) and cc->order
> >>> is 2M THP size, we should not isolate other 2M free pages to be the migration
> >>> target, which can not improve the fragmentation.
> >>>
> >>> Moreover this is also applicable for large folio compaction.
> >>
> >> So why not Cc: Zi Yan? (done)
> >>
> > 
> > Thanks.
> > 
> > Hi Baolin,
> > 
> > How often do you see this happening?
> 
> This is theoretically analyzed from the code inspection.
> 
> >>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>
> >> I doubt this will make much difference, because if such a larger order free
> >> page exists, we shouldn't have a reason to be compacting for a lower order
> >> in the first place?
> > 
> > Unless kswapd gets us such a free block in the background right after
> > get_page_from_freelist() and before compaction finishes in the allocation
> > slow path.
> > 
> > If this happens often and cc->order is not -1, it might be better to stop
> > compaction and get_page_from_freelist() to save cycles on unnecessary pfn
> > scanning. For completeness, when cc->order == -1, the logic does not change.
> 
> Yes, this is one possible case. There are also some other concurrent 
> scenarios, such as when compaction is running (after 
> compaction_suitable()), at the same time, other applications release a 
> large folio to the free list. In this case, the free large folio 
> scanning should also be avoided.

This went quiet.

We have an ack from Mel.  Are people OK with sending this change
upstream?

