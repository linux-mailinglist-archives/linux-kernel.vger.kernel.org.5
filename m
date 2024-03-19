Return-Path: <linux-kernel+bounces-106953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9402F87F5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE532824C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0467BAEC;
	Tue, 19 Mar 2024 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PMBSEe31"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291BC2F26
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710817284; cv=none; b=F+2fic7FDduMsMTiiICF9wwwSmqoTy6VjHouxhLvi7UVJLuimT3jkg45phcsutJ0vz6hXW8dA5EUmn3BUBudPRxCCgI2+5KRXgoB1NvC3ISF1N5tJs0dSC340Lz+4O251plN4UcRLgKar0xPvfqHku+2vdITejOgAIZjrm9oiB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710817284; c=relaxed/simple;
	bh=iOjqKZ1LMen7RBQYSaE3Rc5bvdCp6OclfyTv4S1fdZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLRcpjWPoP1Z+uCJfTNPgLBRTLnyMCJQ73oN8xe0SNj+Tdw1nv4TLwuUSUfUeLbzVFLVXGPOwiU7aPvSrIIcsOXk/1rtI+X3feMOp2GWI78moCC8o6TDgJNZxQxyrOxcSIC9LwyK83XWOXLHsyE5TOm3PERtaDhzq8qvulRmB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PMBSEe31; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q+r//xnTa4Swggn0SjTyOA2AYX42tQNVwNF2RqmybzA=; b=PMBSEe318beFqCJgbQI+P4T3pF
	qOgVRjM+X23Ssfkd9/ZGzcfFX2sdwfFZDo9k9fn7wUf1EzKiEQuDycY4DTeheAfH4A5x/Q1Sd/Pmy
	NxG3invp4y+M0B0/XB+dpv1RV55s+VUm6Q9dOG49qFqu4p2EoXUJt5POAmPjuY7qZuOgCHAzzfHXe
	k3UZc4f41XmYRYfeRBX+3URVZzhzNpxYJrr85yvppFf11oQbxokIDemnZks+AuiczP2rZsa45tjrg
	x+o3jdyZZ3hCKNFpBJSYR90pwjeShqC97ZQO6VmBEgVhP/ph8UqiuHqCBXzxPkqpKucZIkKYMeBFn
	gKD/5L7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmPiz-00000000zr6-0G1V;
	Tue, 19 Mar 2024 03:01:13 +0000
Date: Tue, 19 Mar 2024 03:01:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <Zfj_-LbiIsAVWcPX@casper.infradead.org>
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>
 <Zfg0WLrcOmCtdn_M@casper.infradead.org>
 <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>

On Tue, Mar 19, 2024 at 08:48:42AM +0800, Zhaoyang Huang wrote:
> BTW, damon_pa_pageout is a potential risk over this race

No it isn't.

               struct folio *folio = damon_get_folio(PHYS_PFN(addr));

                if (!folio)
                        continue;

                if (damos_pa_filter_out(s, folio))
                        goto put_folio;

                folio_clear_referenced(folio);
                folio_test_clear_young(folio);
                if (!folio_isolate_lru(folio))
                        goto put_folio;
                if (folio_test_unevictable(folio))
                        folio_putback_lru(folio);
                else
                        list_add(&folio->lru, &folio_list);
put_folio:
                folio_put(folio);

It clearly has a folio reference when it calls folio_isolate_lru().

