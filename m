Return-Path: <linux-kernel+bounces-38872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC8B83C79E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7C01F2768E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C96412A141;
	Thu, 25 Jan 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="THjYKDS9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B7129A70;
	Thu, 25 Jan 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199099; cv=none; b=X6l08ElURbqhJE7b7npD5Qo5BZKYWg+Q44h++v5tLHawJrdbqCmDC27Bl79GHlNxYsqvDctdjx++USuHoDtHGVDn3IZbeSKy4XqEPdcExtltj1NcmJXWb5edLJzHKZY2YM76HGUwx8t1aCTt84VwyblNCDNlOLsye4cD77pdh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199099; c=relaxed/simple;
	bh=qUeOGjqnJTDwJd8TRY8IOpT89uT1I9zRiXX5WELbkM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPMo56S9VLUrXoBvkQQEeNd6fG5zZsVQG8zvgd17XzwY8dQ4Eq1HUk9COyeTmGm4i7E5kz/tREM0QcBwf12o49Pu6BwU4t9OKirluA0/qRNkzx8wQjO9dUFPnCaJ+BbOCEEsYluoE9qQWnL1KSKCrtYy6I03uC5NSKxVfYJ+9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=THjYKDS9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kYtGfh7brmeXFx2nN/OWMcBywY6OoQSQw0s7tMqTk5s=; b=THjYKDS9V795JWmm7rTHeSVhHX
	QS2PO3MCt5dzAmV/++OnZ7MyMjDgK3S9sDuj63aK+ypZqQJ30li1oNMICJq2Y14bhNmBbjIjOEkRS
	eXcd5zp+FZyokuBChNeQYc12qvcSNobReQyAnEv5VaDNvOTk4bL0DazzEHsRlabzZ3VAj62mtbmE9
	zxcSZ3GZ1ORBR+jmTgMFYyvipo6jpndl7llpXYjmwuD2RbJOJky27O2Gzbwk+i8mdu8NxNoWDgQ3A
	Sp9cWp+pb3sWBPw0/fxAI+9fDiP5QURc0GMs9GG4GT8te4YMuopDPZI987MzQJ0SGKocYkjL4cJK8
	8eNulXaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2KG-0000000AS8B-0H2I;
	Thu, 25 Jan 2024 16:11:36 +0000
Date: Thu, 25 Jan 2024 16:11:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH, RFC] block: set noio context in submit_bio_noacct_nocheck
Message-ID: <ZbKIN5tn4MqHzw6U@casper.infradead.org>
References: <20240124093941.2259199-1-hch@lst.de>
 <be690355-03c6-42e2-a13f-b593ad1c0edd@kernel.dk>
 <20240125081050.GA21006@lst.de>
 <07de550c-2048-4b2f-8127-e20de352ffde@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07de550c-2048-4b2f-8127-e20de352ffde@kernel.dk>

On Thu, Jan 25, 2024 at 09:09:44AM -0700, Jens Axboe wrote:
> On 1/25/24 1:10 AM, Christoph Hellwig wrote:
> > On Wed, Jan 24, 2024 at 08:40:28AM -0700, Jens Axboe wrote:
> >> On 1/24/24 2:39 AM, Christoph Hellwig wrote:
> >>> Make sure all in-line block layer submission runs in noio reclaim
> >>> context.  This is a big step towards allowing GFP_NOIO, the other
> >>> one would be to have noio (and nofs for that matter) workqueues for
> >>> kblockd and driver internal workqueues.
> >>
> >> I really don't like adding this for no good reason. Who's doing non NOIO
> >> allocations down from this path?
> > 
> > If there is a non-NOIO allocation right now that would be a bug,
> > although I would not be surprised if we had a few of them.
> > 
> > The reason to add this is a different one:  The MM folks want to
> > get rid of GFP_NOIO and GFP_NOFS and replace them by these context.
> > 
> > And doing this in the submission path and kblockd will cover almost
> > all of the noio context, with the rest probably covered by other
> > workqueues.  And this feels a lot less error prone than requiring
> > every driver to annotate the context in their submission routines.
> 
> I think it'd be much better to add a DEBUG protected aid that checks for
> violating allocations. Nothing that isn't buggy should trigger this,
> right now, and then we could catch problems if there are any. If we do
> the save/restore there and call it good, then we're going to be stuck
> with that forever. Regardless of whether it's actually needed or not.

Nono, you don't understand.  The plan is to remove GFP_NOIO
entirely.  Allocations should be done with GFP_KERNEL while under a
memalloc_noio_save().

