Return-Path: <linux-kernel+bounces-72271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A05885B179
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC81228282C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5111E48C;
	Tue, 20 Feb 2024 03:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kmNL7KnP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4FA535C6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399849; cv=none; b=ckY18HKVYSQVIoV95RVKxCFPwwug/WQ2VBbMIswWLJxRXXKnPbGa3y7fEbLTYB4Y3u3PkkqGtkuF2U0fB70eVA6jUWSxf36OCsEZPyXnYLzqn6Dr3tnJ2RDiVMgLRzO6rP9p7LRqhgW5iq0cc3SZ6LzNKfm569tQQuYOw9953V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399849; c=relaxed/simple;
	bh=OWejHLNepLGujaSbGpbMAP1AbglW7ePwckLXsnJRIRA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gP/vyiHz8ucl01YjhSGjcPHeYzJOf7EQ/4U80+yiWFi7P4esQdQQlLWUEP7hMS9sIRo+aRGiTLWxY1pIJvSYkbXJyfv78lTvvcbci4i/qAqoWZpL+cg5vFIevWf1+qfmJjvl3Ovx7CtvQ1yNY67F16IvwiAUJsx5Tp1KOPCyczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kmNL7KnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2CAC433F1;
	Tue, 20 Feb 2024 03:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708399849;
	bh=OWejHLNepLGujaSbGpbMAP1AbglW7ePwckLXsnJRIRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kmNL7KnPWDgYtHVRH+k7+MYZngA/necwn0aQF/wGHYh/HzRTyQIpXcuc0lbVdJ2gB
	 xvZHH912ChleVwhFE00ZEmE2MhsjkL5hrC6ZcN0oJFClARNqs6B0cWKjww25WNmLJa
	 IwsNbkuXKvtgNbGvObptBrwtFvcQ9PWxKF0TtZ6Q=
Date: Mon, 19 Feb 2024 19:30:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>, Ryan
 Roberts <ryan.roberts@arm.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, David Hildenbrand <david@redhat.com>, "Yin, Fengwei"
 <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain
 <mcgrof@kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH v6 0/4] Enable >0 order folio memory compaction
Message-Id: <20240219193048.cbd010579aa3d2c790f6e2b9@linux-foundation.org>
In-Reply-To: <4f0b3586-25e2-4d21-bbb6-41f644d3d77f@linux.alibaba.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
	<20240219180617.89a0daaba45ce124ef01be50@linux-foundation.org>
	<9E3E6CD6-45DD-4E7F-B6DC-0897F38D5E81@nvidia.com>
	<4f0b3586-25e2-4d21-bbb6-41f644d3d77f@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 11:00:39 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> > The patch was based on top of my early version of this patchset, thus
> > uses "cc->nr_migratepages -= 1 << order;" and
> > "cc->nr_migratepages += 1 << order;", but now it is applied before
> > mine. The change should be "cc->nr_migratepages--;" and
> > "cc->nr_migratepages++;", respectively.
> > 
> >>
> >>> on nr_migratepages was based on this one, a better fixup
> >>> for it might be below. Since before my patchset, compaction only deals with
> >>> order-0 pages.
> >>
> >> I don't understand what this means.  The patchset you sent applies OK
> >> to mm-unstable so what else is there to do?
> > 
> > Your above fixup to Baolin's patch needs to be changed to the patch below
> > and my "mm/compaction: add support for >0 order folio memory compaction" will
> > need to be adjusted accordingly to be applied on top.
> > 
> > Let me know if anything is unclear.
> 
> Hi Andrew,
> 
> To avoid conflicts, you can drop these two patches, and I will send a 
> new version with fixing the issue pointed by Vlastimilb on top of 
> "mm/compaction: add support for >0 order folio memory compaction".
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-16-01-35&id=97f749c7c82f677f89bbf4f10de7816ce9b071fe
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-16-01-35&id=ea87b0558293a5ad597bea606fe261f7b2650cda

Well I thought I'd fixed everything up 10 minutes ago.  Please take a
look at next mm-unstable.

