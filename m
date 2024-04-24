Return-Path: <linux-kernel+bounces-157704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAC78B14D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7735284538
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332FE156962;
	Wed, 24 Apr 2024 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="r1UM6bc8"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEB1772F;
	Wed, 24 Apr 2024 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991499; cv=none; b=aZPMkRMmpUB50zOg+UUW7VutS3tdQtjh+Hjy0DMmjU4dNHkRf3/2QL0xvmWIPwrCRizcNQ3MfgjRHvRQwm0EHQfEdDyZVQrm6jrhuos95Pq3Z6P4tFSML24YZLGCDmx/5GP5oKrcHrqiLA8LIa96RuQplmgYJgRfiKdr0DcM050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991499; c=relaxed/simple;
	bh=nTEIRGVB1/SHv/Q71QQx9mQDZjVkaFHXUQ2ixRjCj+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHe45oxSFpIFkDa1RAbq4CxEtRCs7nP61mLe3qINMea7lCEVR8pWjhn1KHY7NyR0WmqewahD4t3I8/8XR+U0O/5M/z1fW+sZ15eZvQYHKWuJBXjxv4Eh6w4bL/EfiqCaz5PmpB3MAfocfKGbq8owDKtXd/nWHu5IDJ5J+yBivU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=r1UM6bc8; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id AB10A20039E;
	Wed, 24 Apr 2024 22:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=boX5e3fERJr2J8mbEA/m2P9U1AgJpSWICBhdrIjzhpw=; b=r1UM6bc8SMuhuUFYDvHlZ14NmL
	36/h5ZaIIB1L62WGFhmdXCSjO1o2EeYOMiD6hBZHfSj1PJsTKtIeHMrIttl8uxREy2Smk45KacF98
	axn+7NXEQtnT4z+ebKjhiABMxef4q3jR+KAqRPFcPBhNunMdQrYdhyNlkc6uELWLUjd8=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1rzjTv-000nug-03;
	Wed, 24 Apr 2024 22:44:43 +0200
Date: Wed, 24 Apr 2024 22:44:42 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <ZilvOi7ceSXmwkNq@bender.morinfr.org>
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>

On 24 Apr 22:09, David Hildenbrand wrote:
> > > Let me try to see if we can get this done cleaner.
> > > 
> > > One ugly part (in general here) is the custom page replacement in the
> > > registration part.
> > > 
> > > We are guaranteed to have a MAP_PRIVATE mapping. Instead of replacing pages
> > > ourselves (which we likely shouldn't do ...) ... maybe we could use
> > > FAULT_FLAG_UNSHARE faults such that we will get an anonymous folio
> > > populated. (like KSM does nowadays)
> > > 
> > > Punching FOLL_PIN|FOLL_LONGTERM into GUP would achieve the same thing, but
> > > using FOLL_WRITE would not work on many file systems. So maybe we have to
> > > trigger an unsharing fault ourselves.
> 
> ^ realizing that we already use FOLL_FORCE, so we can just use FOLL_WRITE to
> break COW.

It was never clear to me why uprobes was not doing FOLL_WRITE in the
first place, I must say.

One issue here is that FOLL_FORCE|FOLL_WRITE is not implemented for
hugetlb mappings. However this was also on my TODO and I have a draft
patch that implements it.

> 
> > > 
> > > That would do the page replacement for us and we "should" be able to lookup
> > > an anonymous folio that we can then just modify, like ptrace would.
> > > 
> > > But then, there is also unregistration part, with weird conditional page
> > > replacement. Zapping the anon page if the content matches the content of the
> > > original page is one thing. But why are we placing an existing anonymous
> > > page by a new anonymous page when the content from the original page differs
> > > (but matches the one from the just copied page?)?
> > > 
> > > I'll have to further think about that one. It's all a bit nasty.
> > 
> > Sounds good to me. I am willing to help with the code when you have a
> > plan or testing as you see fit. Let me know.
> 
> I'm hacking on a redesign that removes the manual COW breaking logic and
> *might* make it easier to integrate hugetlb. (very likely, but until I have
> the redesign running I cannot promise anything :) )
> 
> I'll let you know once I have something ready so you could integrate the
> hugetlb portion.

Sounds good.

-- 
Guillaume Morin <guillaume@morinfr.org>

