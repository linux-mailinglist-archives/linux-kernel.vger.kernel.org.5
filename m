Return-Path: <linux-kernel+bounces-118961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D7688C1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A1E1C37C32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC471B5D;
	Tue, 26 Mar 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Md/x4yH8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22971B5E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455710; cv=none; b=b5IbVHOEZ8ANY1HqAiqqBzLETDccI5WMWgj8Zyr3mrfoRPyMsh1AELoZDwosSWyOpmhWPQtArPSsq6c8erMJLT21IYGqgqFGtLmIKI3GMuoQm5ZOiVOWb8W83EIPSDPRMXqfxfvcHsPaQIMQORhnkqYJA8qQpe3RoEorUioCMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455710; c=relaxed/simple;
	bh=+HULUAtlNQ3MvWiH8WLL0jBlfjkDhhBdZ5vAO5ZkBLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaLjo15EdUiU/gOk8q05nNBzV+vkAlA07tLicA/ixSZoqobUHhgRmReER31jATPijrDEHWSZoM/k+EAlJ/IH86oBB0AGGE8L2BoUMHVAcy8WnKlYWAi6q9RvWfVxSKMFJtFCWZtawIKQpncCV/MBTnjj0QjV8E5dyFHltBE6990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Md/x4yH8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FZXEPvoG9Rls8PIO0odIAJYGvb7rtlOkN7UCiLUWwBk=; b=Md/x4yH8d9E5HoKw0wvTvsk+wZ
	FJOVgTvLxA35NtYaTkHPJM2R941CMY/A8v/mwdaj/fObKchdnHAfY7IntSz9j2um8iKECpAcumTDl
	HaA0ESdg3j0QFb3gtJDnnaGCsYNZ5GRylQavSE5uUQ+1t+W6B4GnaJmUZAuSORsEk3C1OA5zCQsPr
	2B8x8/dhmDdMqGPArmN7PCawWhksFelmn8lq+yr2hJayEfOJcF12krpr9YKfzACqx6ojX36RT4g6M
	hQzzM7xCt+b8u92+rv9c/pQY9LUV1UIN46M30Ohmd6CpurctTmLZ2ytLcKpecm9xbvUhmUf3L8hRA
	k5eILGxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5oC-00000001FQ5-46kw;
	Tue, 26 Mar 2024 12:21:41 +0000
Date: Tue, 26 Mar 2024 12:21:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <ZgK91II_eSYY6D2F@casper.infradead.org>
References: <Zfg0WLrcOmCtdn_M@casper.infradead.org>
 <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
 <Zfj_-LbiIsAVWcPX@casper.infradead.org>
 <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
 <ZfwpuRjAZV07_lc3@casper.infradead.org>
 <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
 <Zfz4_GJAHRInB8ul@casper.infradead.org>
 <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
 <ZgDt9mwN-Py5Y-xr@casper.infradead.org>
 <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>

On Tue, Mar 26, 2024 at 05:06:55PM +0800, Zhaoyang Huang wrote:
> 1. Thread_readahead remove the folio from page cache and drop 2 refcnt
> by readahead_folio & filemap_remove_folio(get rid of the folios which
> failed to launch IO during readahead)
>     refcnt == 0, PG_lru == true, PG_lock == true
>     read_pages
> ...
>         folio = readahead_folio
>         <one refcnt dropped here>
> ********For the folio which can not launch IO, we should NOT drop
> refcnt here??? replaced by __readahead_folio???**********
>         folio_get
>         filemap_remove_folio(folio)
>         folio_unlock
>         <one refcnt dropped here>
>         folio_put

Ignoring any other thread, you're basically saying that there's a
refcount imbalance here.  Which means we'd hit an assert (that folio
refcount went below zero) in the normal case where another thread wasn't
simultaneously trying to do anything.

