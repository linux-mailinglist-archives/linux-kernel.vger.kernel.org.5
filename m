Return-Path: <linux-kernel+bounces-121711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806FE88ECD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC8128615F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D314C5AF;
	Wed, 27 Mar 2024 17:43:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0631DFF4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561392; cv=none; b=GpULjysp9VmR5fTQ5cli5bH6FttX1Zd7b6bOr4qMOtJKYIAtlrLvLPPFykq0syJDanZrdECuOjl2T8FMIlxn8PbHrHXu0u84Li+jAzb7gxEVb3hpAMyBfCHuv1iq1jTwpD+b7ngX6bf0fmCWJfNrc8UmwcgF9x2pFXMkL8CajPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561392; c=relaxed/simple;
	bh=B1claC9P9AYA+Mf5t5vgP4Smp2dxfxXkmd0XFGZLQj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHV2kgTcPNicsEL9PO6lgB95j0qgVINpOtspPH1C8LTsT9XnhjMY3xzgPzfWzitgJWioEjMiWHDE9w9RELBicUboF8w86Wrhpb1bkh8++LVJ6rPDJ25q8NHe1IxyAP9G9GXQBEBcYW49Dd0D86gYO0Gxtc27MVGUVvF8MpXTcIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B26C433C7;
	Wed, 27 Mar 2024 17:43:10 +0000 (UTC)
Date: Wed, 27 Mar 2024 17:43:08 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Audra Mitchell <aubaker@redhat.com>
Subject: Re: [PATCH v2] mm/kmemleak: Don't hold kmemleak_lock when calling
 printk()
Message-ID: <ZgRarOvI3Zhos9Gl@arm.com>
References: <20240307184707.961255-1-longman@redhat.com>
 <20240307114630.32702099ac24c182b91da517@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307114630.32702099ac24c182b91da517@linux-foundation.org>

On Thu, Mar 07, 2024 at 11:46:30AM -0800, Andrew Morton wrote:
> On Thu,  7 Mar 2024 13:47:07 -0500 Waiman Long <longman@redhat.com> wrote:
> > When some error conditions happen (like OOM), some kmemleak functions
> > call printk() to dump out some useful debugging information while holding
> > the kmemleak_lock. This may cause deadlock as the printk() function
> > may need to allocate additional memory leading to a create_object()
> > call acquiring kmemleak_lock again.
> > 
> > An abbreviated lockdep splat is as follows:
> >
> > ...
> > 
> > Fix this deadlock issue by making sure that printk() is only called
> > after releasing the kmemleak_lock.
> > 
> > ...
> >
> > @@ -427,9 +442,19 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
> >  		else if (untagged_objp == untagged_ptr || alias)
> >  			return object;
> >  		else {
> > +			if (!get_object(object))
> > +				break;
> > +			/*
> > +			 * Release kmemleak_lock temporarily to avoid deadlock
> > +			 * in printk(). dump_object_info() is called without
> > +			 * holding object->lock (race unlikely).
> > +			 */
> > +			raw_spin_unlock(&kmemleak_lock);
> >  			kmemleak_warn("Found object by alias at 0x%08lx\n",
> >  				      ptr);
> >  			dump_object_info(object);
> > +			put_object(object);
> > +			raw_spin_lock(&kmemleak_lock);
> >  			break;
> 
> Please include a full description of why this is safe.  Once we've
> dropped that lock, the tree is in an unknown state and we shouldn't
> touch it again.  This consideration should be added to the relevant
> functions' interface documentation and the code should be reviewed to
> ensure that we're actually adhering to this.  Or something like that.
> 
> To simply drop and reacquire a lock without supporting analysis and
> comments does not inspire confidence!

I agree it looks fragile. I think it works, the code tends to bail out
on those errors and doesn't expect the protected data to have remained
intact. But we may change it in the future and forgot about this.

I wonder whether we can actually make things slightly easier to reason
about, defer the printing until unlock, store the details in some
per-cpu variable. Another option would be to have a per-CPU array to
store potential recursive kmemleak_*() callbacks during the critical
regions. This should be bounded since the interrupts are disabled. On
unlock, we'd replay the array and add those pointers.

-- 
Catalin

