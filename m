Return-Path: <linux-kernel+bounces-149350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643C98A8FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226C21F220F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491164F;
	Thu, 18 Apr 2024 00:20:21 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16815C3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399621; cv=none; b=cDZRE+HLci3vFIXMrWoGrkKVO1YwhUTt5A7CdKlMxY5otX+piyz62KJjeZpQUYdqHAZDwFdd1Jw13HrNh5M5za+MO6ukkX+J6hMxDlyPC53FDwqfwK5YpSRXD5uuzZ1G+1qP3CaEG7DNF+zy7SHqHiStCTP6dGKb49I+KoGM50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399621; c=relaxed/simple;
	bh=NFzlsbK07pt2WYy9cHPGToQsa2pus3HKKGJ2e71BD9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ02jvFdWfZnWATUB0qxpq+4kESNQp/OQKipf9OVjr3ztDM1EQ6u7778h5hUsPnqco2xzo+QfbAaMen5+FT/QeWlXDgN24xA84LQNvnDfr67Coes6oqLSlgvcvE15/m+GU1M2KWTSebNnZNGaZH0Eo52ranXszdnMDIGp04RjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-5a-6620673d3442
Date: Thu, 18 Apr 2024 09:20:08 +0900
From: Byungchul Park <byungchul@sk.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, david@redhat.com,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [PATCH v9 7/8] mm: add folio_put_mgen() to deliver migrc's
 generation number to pcp or buddy
Message-ID: <20240418002008.GA3592@system.software.com>
References: <20240417071847.29584-1-byungchul@sk.com>
 <20240417071847.29584-8-byungchul@sk.com>
 <Zh_xC76oTjrgutl_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh_xC76oTjrgutl_@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC9ZZnka5tukKawdtPKhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugStj
	/p4vjAVnOSuuzr7J1MC4j72LkZNDQsBE4uPnv6xdjBxg9vkPTiBhFgFViRfnrjKC2GwC6hI3
	bvxkBikREdCQeLPFCCTMLPCKSeLGCUMQW1ggW6L//BkmEJtXwFxi4ZJjzCC2kEA3o8TWqZEQ
	cUGJkzOfsED0aknc+PeSCWQks4C0xPJ/HCBhTqADbvdfANsqKqAscWDbcaASLqDDVrFLPNz3
	HupiSYmDK26wTGAUmIVk7CwkY2chjF3AyLyKUSgzryw3MTPHRC+jMi+zQi85P3cTIzAGl9X+
	id7B+OlC8CFGAQ5GJR7ekwfk04RYE8uKK3MPMUpwMCuJ8LYIy6YJ8aYkVlalFuXHF5XmpBYf
	YpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYHR80VT+pIHxeIEgZ2vnQdfrnamNn8Xz
	ZrJUyZb1PpDdb1hpea9tzcO5H3e+CmbtffhRZvdTEd49F6R62UK23foZyNFutpNt70d793n9
	FkvntslO3qa/8f/mawERFot4oj51lkfazfU7cmLVKoed2tzd64T9HqTvmPvQ+d+sbv099gtb
	Hjw7a6bEUpyRaKjFXFScCAB3earRvQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXC5WfdrGubrpBmsOa/pMWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4Mubv+cJYcJaz4ursm0wNjPvYuxg5OCQETCTOf3DqYuTkYBFQlXhx7iojiM0m
	oC5x48ZPZpASEQENiTdbjEDCzAKvmCRunDAEsYUFsiX6z59hArF5BcwlFi45xgxiCwl0M0ps
	nRoJEReUODnzCQtEr5bEjX8vmUBGMgtISyz/xwES5gQ64Hb/BbCtogLKEge2HWeawMg7C0n3
	LCTdsxC6FzAyr2IUycwry03MzDHVK87OqMzLrNBLzs/dxAiMqGW1fybuYPxy2f0QowAHoxIP
	74kD8mlCrIllxZW5hxglOJiVRHhbhGXThHhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmk
	J5akZqemFqQWwWSZODilGhiL0o3fnoud+r78ce15pTK5TQ1BDSuF32/1dHlw/75vHF/tmzly
	7GuuXLNs5+grKb/ZLnCiJDrS5/QRIfvES79m3qubYi/ff3nxHufK6SqqJa4Lyp8U7NnKviZm
	2QWGW75TReMaXs2bMO8q/7zKV0kO8qdTuLlPdn9tU+N+2FZvFV+U9Dz3Q64SS3FGoqEWc1Fx
	IgAGAOccpAIAAA==
X-CFilter-Loop: Reflected

On Wed, Apr 17, 2024 at 04:55:55PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 17, 2024 at 04:18:46PM +0900, Byungchul Park wrote:
> > Introduced a new API, folio_put_mgen(), to deliver migrc's generation
> > number to pcp or buddy that will be used by migrc mechanism to track
> > need of tlb flush for each page residing in pcp or buddy.
> > 
> > migrc makes decision whether tlb flush is needed or not, based on a
> > generation number stored in the interesting page and the global
> > generation number, for that tlb flush required has been completed.
> > 
> > For now, the delivery works only for the following call path but not for
> > e.g. free_the_page(), __free_pages_ok() and free_unref_page_list() that
> > are not for releasing source folios during migration:
> > 
> >    folio_put_mgen()
> >       __folio_put_mgen()
> > 	__folio_put_small()
> > 	   free_unref_page()
> > 	      free_unref_page_commit()
> > 	      free_one_page()
> > 	         __free_one_page()
> 
> You're going to want to rebase this on mm-unstable.  __folio_put_small()
> went away in "mm: combine __folio_put_small, __folio_put_large and
> __folio_put"

I checked it. Indeed. Thanks for the information.

	Byungchul

