Return-Path: <linux-kernel+bounces-158788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9C8B24E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AA01F2351E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791B14AD0D;
	Thu, 25 Apr 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="kKsaPGXP"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B214A0A8;
	Thu, 25 Apr 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058377; cv=none; b=n9pBbwPmh96AXRcc2PlbnWLWDC781hULBpfUsj1g8DZ84c9ZZngY8oPLR+UCa3DmEOyP9iJ65+YFY58Q+qwHgMZjBkBHxbPSt7GtU74GOoYDuqhr2bwOTjjaoA9pCWPmndcG+Ak455uvCKlH5t35SQ5vzqiezptiSdSC5vsh0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058377; c=relaxed/simple;
	bh=Udp4TbJuoAH1fZFzgzQ2FS/97plqnMkt3dI1CULb9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGSVWts/V/iZt4OhJbqlNSpXZIyYUG2xh5QU3tuWT2AjU+VaTqfvjhMKxCyTtqzV5vii4tGDILF4mOc1jltDg9SirI5AqfVKSuQzzRR3kccuhnSTskmkZL2HW7+wywV8h+CwdToH2nq7xy0Hqz/9hkaOTvUI3g4Kez+VePbo5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=kKsaPGXP; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 892672003CC;
	Thu, 25 Apr 2024 17:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tCdmysF9MWE0CXzC7izlZP+QM8RV5lckKSV0SGoKIus=; b=kKsaPGXPV/dESdejp1+YwqKA4x
	u0jnWodXaYVmqRgRUWDMJAGSX3IOFtzDxI1cdtbeIhWVqrBQLXyd7ddGsPaj0fwbQ2diHIIyw3YQK
	NWyW4sfqdIqL4EQXINlhTskkIN/ZhO+e4F+7IXhrIEgwikAQSI6U/OMCcGkwUcvqhbWA=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1s00se-001N10-2L;
	Thu, 25 Apr 2024 17:19:24 +0200
Date: Thu, 25 Apr 2024 17:19:24 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <Zip0fEliGeL0qmID@bender.morinfr.org>
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>

On 24 Apr 23:00, David Hildenbrand wrote:
> > One issue here is that FOLL_FORCE|FOLL_WRITE is not implemented for
> > hugetlb mappings. However this was also on my TODO and I have a draft
> > patch that implements it.
> 
> Yes, I documented it back then and added sanity checks in GUP code to fence
> it off. Shouldn't be too hard to implement (famous last words) and would be
> the cleaner thing to use here once I manage to switch over to
> FOLL_WRITE|FOLL_FORCE to break COW.

Yes, my patch seems to be working. The hugetlb code is pretty simple.
And it allows ptrace and the proc pid mem file to work on the executable
private hugetlb mappings.

There is one thing I am unclear about though. hugetlb enforces that
huge_pte_write() is true on FOLL_WRITE in both the fault and
follow_page_mask paths. I am not sure if we can simply assume in the
hugetlb code that if the pte is not writable and this is a write fault
then we're in the FOLL_FORCE|FOLL_WRITE case.  Or do we want to keep the
checks simply not enforce it for FOLL_FORCE|FOLL_WRITE?

The latter is more complicated in the fault path because there is no
FAULT_FLAG_FORCE flag.

-- 
Guillaume Morin <guillaume@morinfr.org>

