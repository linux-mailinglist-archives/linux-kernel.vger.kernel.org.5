Return-Path: <linux-kernel+bounces-77372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CE8860482
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C18B273F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D373F1D;
	Thu, 22 Feb 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uOCurYCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3D73F14
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636312; cv=none; b=OnSmvt+h/GXBwbTgR+8XkcZTLv1D3wiUK0lLi+crU9t/GPF2RjJL0O+bzNOqxarEIdsMUz9xvJlprWYwkK5zgfF/cXbAgpfDPv0JtiRdgCfaUTUyjBLswZ4ivBXyD0GJbyl7aimU9dQqlRSYFzScEZALAMrm8G3z8uHl7Ah002g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636312; c=relaxed/simple;
	bh=cO5FbUIKoUo6Fi1BzfMozcCS1a1h9addtucmfkKRLD8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WpuPrq0qBYXTCog/OedxomdkQOuesR4QHXL6g5y1Z5RGP/6J+tHzDc01O2VxmVliyzpuoKHdx6PTY43TLZpkmS4ZKqoALASduZFEw9JHLhk9KFVyx0q2aJcNOklPtFE7ZRN/4H2kaDfXy99lyXkrRHPRiQ5uMgxkRB2zOfYyd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uOCurYCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF91C433F1;
	Thu, 22 Feb 2024 21:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708636312;
	bh=cO5FbUIKoUo6Fi1BzfMozcCS1a1h9addtucmfkKRLD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uOCurYCA3JUZdI59VEhC1RuEHY1LYkqNKjw0wYTsLgfZ7airMIyJSlpmK0cG5wHs+
	 AKTx147BNNmldjDLlOXpW6eXB9Np2nTLb5tPWYoY+yTOffZTM00LQg32AOeHBLi3q/
	 3J2F7unRhZ9oGnhrSzODp+eOjGrHNOWTZR3KikYA=
Date: Thu, 22 Feb 2024 13:11:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <shy828301@gmail.com>
Cc: Lance Yang <ioworker0@gmail.com>, mhocko@suse.com, zokeefe@google.com,
 david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
Message-Id: <20240222131151.4d24563d58240e76a3b535db@linux-foundation.org>
In-Reply-To: <CAHbLzkoNFn6UE4Hn0gXTm2pLHD7pK4gYUe1zVh3247m30A5u2g@mail.gmail.com>
References: <20240129054551.57728-1-ioworker0@gmail.com>
	<CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
	<CAK1f24nk19eciysFqvTd=rqpiKePhstDWEEQ_mvT89WCDNrWNQ@mail.gmail.com>
	<CAHbLzkoNFn6UE4Hn0gXTm2pLHD7pK4gYUe1zVh3247m30A5u2g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 12:23:21 -0800 Yang Shi <shy828301@gmail.com> wrote:

> > VMA Count |   Old   |   New   |  Change
> > ---------------------------------------
> >     50     |   23us  |    9us  |  -60.9%
> >    100     |   32us  |    9us  |  -71.9%
> >    200     |   44us  |    9us  |  -79.5%
> >    400     |   75us  |    9us  |  -88.0%
> >    800     |   98us  |    9us  |  -90.8%
> >
> > IIUC, once the count of VMAs for the process
> > exceeds page_to_scan, khugepaged needs to
> > wait for scan_sleep_millisecs ms before scanning
> > the next process. IMO, unnecessary scans could
> > actually be skipped with a very inexpensive
> > mm->flags check in this case.
> 
> Thanks for following up on this, can you please capture all the
> information in the commit log?

I added it.

--- a/txt/mm-khugepaged-bypassing-unnecessary-scans-with-mmf_disable_thp-check.txt
+++ b/txt/mm-khugepaged-bypassing-unnecessary-scans-with-mmf_disable_thp-check.txt
@@ -9,6 +9,24 @@ and the MMF_DISABLE_THP flag is set later, this scanning process
 becomes unnecessary for that mm and can be skipped to avoid redundant
 operations, especially in scenarios with a large address space.
 
+On an Intel Core i5 CPU, the time taken by khugepaged to scan the
+address space of the process, which has been set with the
+MMF_DISABLE_THP flag after being added to the mm_slots list, is as
+follows (shorter is better):
+
+VMA Count |   Old   |   New   |  Change
+---------------------------------------
+    50    |   23us  |    9us  |  -60.9%
+   100    |   32us  |    9us  |  -71.9%
+   200    |   44us  |    9us  |  -79.5%
+   400    |   75us  |    9us  |  -88.0%
+   800    |   98us  |    9us  |  -90.8%
+
+Once the count of VMAs for the process exceeds page_to_scan, khugepaged
+needs to wait for scan_sleep_millisecs ms before scanning the next
+process.  IMO, unnecessary scans could actually be skipped with a very
+inexpensive mm->flags check in this case.
+
 This commit introduces a check before each scanning process to test the
 MMF_DISABLE_THP flag for the given mm; if the flag is set, the scanning
 process is bypassed, thereby improving the efficiency of khugepaged.


