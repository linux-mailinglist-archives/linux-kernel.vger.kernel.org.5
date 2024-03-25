Return-Path: <linux-kernel+bounces-116471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF7889EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C957E1F3761A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3886416F0EE;
	Mon, 25 Mar 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2qN+W8S"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895FA18059;
	Mon, 25 Mar 2024 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711339034; cv=none; b=Unan8oeLmluS1AeLciIyPD6v5zs9OIsDcQYPjX7PEJrg3IYltpb/SR5jm1cFNR4iYnPY1U39bAwVabpybk5kknvs0USu5YF/hHtRwq1EH1LzlCYS2grnH8HzcjmTZeFZ7Rumlc3+WiX4f+Xh5yrns4K6G8ztjAjZINJ3pPDOoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711339034; c=relaxed/simple;
	bh=l/1f1MNGF9BfhwGztXj3ec5Igc6dItWl5AjiV9qkAQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isEMXOgpuE7UXZFaIFrxRabR6dtwrtKLrUGmpCyj3mbg7EaNOrYBdxZfIVS8mCmfeolwI4/VmiXyKxqLhhahO6puubJPYnVzBeA9FwMaSZ6US+NGAuRxt94XvkI98uIM1rp+9HVlKwEn1diwp2G8NtY1gOizsEHPDtqUwbjoUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E2qN+W8S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IU3Dlzl1rVEiTSxVgVMPzC88N9hT6GmfL1S9I/2JgO0=; b=E2qN+W8S3ZU5YGOKUUO9cBO5zJ
	B4vbyccJGdv9eLdysd3ijpij1NV9BRohz3uOmTf4NlnOEmU9plOLo3xO0baioyQzSVdsbO4iKAN1J
	3ctvmi7R3l4FWCQXAUEao1GPS8qQVI2oQOdPAuQNr6hXnl6I6vmm2j+3NoCxKKsDqY4qOWeiCgteg
	8gZJivN4pdxgLg2bOOZeUKG3WvLwqaEN6B80ItvTZkmoNGUDCORSFQ1vrAakpYtWx11ik/dTS6kqw
	sgoio6lafIToR7obrEZm5aMJU2MZ+TQZXFKI9Gm8Bv3pifGAjRp1U8Ab4CuAHnnl72Gs0h/IVT5DO
	wg4LmchQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1robSM-0000000FbhS-0cGD;
	Mon, 25 Mar 2024 03:57:06 +0000
Date: Mon, 25 Mar 2024 03:57:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Liu Shixin <liushixin2@huawei.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH stable-5.10] mm/memory-failure: fix an incorrect use of
 tail pages
Message-ID: <ZgD2EvkzS1Uz5wy6@casper.infradead.org>
References: <20240307124841.2838010-1-liushixin2@huawei.com>
 <026db58d-feea-8191-616a-3e6dca592786@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026db58d-feea-8191-616a-3e6dca592786@huawei.com>

On Mon, Mar 25, 2024 at 11:36:49AM +0800, Liu Shixin wrote:
> Hi,
> 
> After backport commit c79c5a0a00a9 ("mm/memory-failure: check the mapcount of the precise page"),
> 
> I got an error message as written on the patch. The problem can be fixed by the patch or just revert.
> 
> Now I prefer to revert because I think it is related to folio and no impact in stable, or maybe I'm wrong.

I checked out what is going wrong here, and Liu Shixin is correct.

Commit c79c5a0a00a9 was incorrectly backported to v5.10 and
commit 70168fdc743b changees the page passed to try_to_unmap().
It now passes the tail page, and should always have passed hpage.
Please apply the patch below to v5.10 (and any other trees that
c79c5a0a00a9 got backported to).

> 
> Thanks,
> 
> 
> On 2024/3/7 20:48, Liu Shixin wrote:
> > When backport commit c79c5a0a00a9 to 5.10-stable, there is a mistake change.
> > The head page instead of tail page should be passed to try_to_unmap(),
> > otherwise unmap will failed as follows.
> >
> >  Memory failure: 0x121c10: failed to unmap page (mapcount=1)
> >  Memory failure: 0x121c10: recovery action for unmapping failed page: Ignored
> >
> > Fixes: 70168fdc743b ("mm/memory-failure: check the mapcount of the precise page")
> > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> > ---
> >  mm/memory-failure.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index f320ff02cc19..dba2936292cf 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1075,7 +1075,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> >  				unmap_success = false;
> >  			}
> >  		} else {
> > -			unmap_success = try_to_unmap(p, ttu);
> > +			unmap_success = try_to_unmap(hpage, ttu);
> >  		}
> >  	}
> >  	if (!unmap_success)
> 
> 

