Return-Path: <linux-kernel+bounces-65325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD7D854B37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7256D1C21BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048655C04;
	Wed, 14 Feb 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MxzaA5Ac"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242445C15;
	Wed, 14 Feb 2024 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920298; cv=none; b=loV4XX4JpSkVmVhTTKSTZc96Q9Q3o0Bh1ZLd1tdlT8VeW1f1f68SUUk+kXym6m4ekn9svcO80Sxo1yYxkS504PJB4+MABc+TUXvCu0mhxakJNr8LuAS37dDZicNoXc8VlOnJvwVd92ZTjW0Mx3Ql1GVrpG7m8FjbtNVfQW5OK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920298; c=relaxed/simple;
	bh=F/m7H9XcLg+gnuaRo9ZLUMqLmFCPe8stNoV8lxI9SqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+yD/wIaI0Z+fEyPkxqmvaSNhdWWs54PihAXwJmFHL0lH1twtOR/0IlaaGzTphvpcso9fpr6FEqAg6t2xLVHRl6OyS5MZ/iE0cbkmessRVoqHrQnzjboi+b0BhaOonwoQXIokro9pg5FGC4axHh+mAX37W9troc+F2jHR1uumZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MxzaA5Ac; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xx3kjMO2T22FWPmvqpk/qy733P8AnnIkS7R4fayZqCM=; b=MxzaA5AcaLprG4OZFJelwSCpVl
	VR59HG6x3rHCUPUh4IeHN6nmNeHGfGZ8AeDXxtphOXVRyW/P1G9+d0RpmzVy44NDKhBF4OgXYJscc
	K4X1ca5yntHy6vsl+SdfVS5zh4IvS/uJIiz05g/PqYC8erwhhkrbQn6OXkGmfdhlo1XBZus7y3/7n
	WMVlEdDgIHTc0KJ8y8Qsb/VAyWDnrLZXwcseM0cQ019hUBHpzQPqSq0VgY0usNmgMMsipWROoYNXw
	OF8zErOzwDJk1IJj9/uc4yD0mpLk0tVBQBMNtAiVSysZUaRvOELZaE4jKrqN5ePPxmju/ptfpYRcY
	HZoj9xEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raG5Q-0000000Gn3y-2ZrO;
	Wed, 14 Feb 2024 14:18:08 +0000
Date: Wed, 14 Feb 2024 14:18:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: David Hildenbrand <david@redhat.com>, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, vbabka@suse.cz, dhowells@redhat.com,
	surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	# see patch description <stable@vger.kernel.org>
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Message-ID: <ZczLoOqdpMJpkO5N@casper.infradead.org>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
 <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
 <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
 <bc1a5e36-1983-1a39-4d06-8062993a4ca4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc1a5e36-1983-1a39-4d06-8062993a4ca4@quicinc.com>

On Wed, Feb 14, 2024 at 12:04:10PM +0530, Charan Teja Kalla wrote:
> > 1) Is it broken in 5.15? Did you actually try to reproduce or is this
> >    just a guess?
> > 
> 
> We didn't run the tests with THP enabled on 5.15, __so we didn't
> encounter this issue__ on older to 6.1 kernels.
> 
> I mentioned that issue exists is based on my understanding after code
> walk through. To be specific, I just looked to the
> migrate_pages()->..->migrate_page_move_mapping() &
> __split_huge_page_tail() where the ->private field of thp sub-pages is
> not filled with swap entry. If it could have set, I think these are the
> only places where it would have done, per my understanding. CMIW.

I think you have a misunderstanding.  David's patch cfeed8ffe55b (part
of 6.6) _stopped_ us using the tail ->private entries.  So in 6.1, these
tail pages should already have page->private set, and I don't understand
what you're fixing.

> > 2) How did you come up with 417013e0d18 ("mm/migrate: Add
> >    folio_migrate_mapping()")
> OOPS, I mean it is Fixes: 3417013e0d18 ("mm/migrate: Add
> folio_migrate_mapping()").
> 
> My understanding is that it a miss in folio_migrate_mapping() where the
> sub-pages should've the ->private set. But this is just a
> reimplementation of migrate_page_move_mapping()(where also the issue
> exists, tmk).
> 
> commit 3417013e0d183be9b42d794082eec0ec1c5b5f15
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Fri May 7 07:28:40 2021 -0400
> 
>     mm/migrate: Add folio_migrate_mapping()
> 
>     Reimplement migrate_page_move_mapping() as a wrapper around
>     folio_migrate_mapping().  Saves 193 bytes of kernel text.
> 
> Thanks.
> 

