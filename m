Return-Path: <linux-kernel+bounces-153818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC5B8AD3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0D51C20B62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC7154430;
	Mon, 22 Apr 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="JqvJugGk"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E9154427;
	Mon, 22 Apr 2024 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713809527; cv=none; b=denn9etGOC0BQegSueZwSvjWtg5Ig6bf+GEB2j/PdLveZtvLe9GTO/MrT3ChFTlpDGIdfyU5dwS1nCHeKPwOZywkXa0DAFn38r3/YKhyVx274jCoJIFXfXIP8oM9lnXbem8YeouFT5AdI60ol39frkSqINH+f7BAnTOmhqoJzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713809527; c=relaxed/simple;
	bh=1MNA6BD/wkkFyMR6iFDbhB+dKlSGnsGlINodyvEQKg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqCMB+r0Toooh88mRRFehLg/AdShgB9jMXcmYaRdCLYRn0acfyw3GW2z5XyOhaOuw7juk/xpACRzv2GJ+ADjBmaVBPB+CzoZ7HsSTcHAV4LkCPC33MUhG0PyH+HaXY4e8e/P3Ti56QNDZQnHFyB/o8IEDLERpj/MnYHSngL4Vew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=JqvJugGk; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 6B5772003CC;
	Mon, 22 Apr 2024 20:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mmoOHxOmhH8xOg3t9ZcJpcTIHR4KgHsjfCJHduRGVbI=; b=JqvJugGk8i1bs0KPI3j4zKhZue
	xw/nwMLl2RE2g6vM4gqUxnxI/VxJdDYNoidbzy79Bfm9wwUJqFmeDzfj8dlstX8cfQfqNDGTnHf/5
	0BUf8pldaaW9psL2HSiiiYfL+m29Zu4rB/l1thm05wYgzpJm11H17gcmgMipfghQOYcI=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1ryy8s-0056Nh-26;
	Mon, 22 Apr 2024 20:11:50 +0200
Date: Mon, 22 Apr 2024 20:11:50 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <ZiaoZlGc_8ZV3736@bender.morinfr.org>
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>

(Dropping Mike Kravetz as CC since he has retired and his email is no
longer valid, adding Muchun since he's the current hugetlb maintainer,
as well as linux-trace-kernel)

On 22 Apr 11:39, David Hildenbrand wrote:
>
> On 19.04.24 20:37, Guillaume Morin wrote:
> > libhugetlbfs, the Intel iodlr code both allow to remap .text onto a
> > hugetlb private mapping. It's also pretty easy to do it manually.
> > One drawback of using this functionality is the lack of support for
> > uprobes (NOTE uprobe ignores shareable vmas)
> > 
> > This patch adds support for private hugetlb mappings.  It does require exposing
> > some hugetlbfs innards and relies on copy_user_large_folio which is only
> > available when CONFIG_HUGETLBFS is used so I had to use an ugly #ifdef
> > 
> > If there is some interest in applying this patch in some form or
> > another, I am open to any refactoring suggestions (esp getting rid the
> > #ifdef in uprobes.c) . I tried to limit the
> > amount of branching.
> 
> All that hugetlb special casing .... oh my. What's the benefit why we should
> be interested in making that code less clean -- to phrase it in a nice way
> ;) ?

I do appreciate the nice phrasing. Believe me, I did try to limit the
special casing to a minimum :-).

Outside of __replace_page, I added only 3-ish branches so I do not think
it's *too* bad. The uprobe code is using PAGE_{SHIFT,MASK} quite liberally so I
had to add calls to retrieve these for the hugetlb vmas.

__replace_page has a lot of special casing. I certainly agree (and
unfortunately for me it's at the beginning of the patch :)).  It's doing
something pretty uncommon outside of the mm code so it has to make a
bunch of specific hugetlb calls. I am not quite sure how to improve it
but if you have suggestions, I'd be happy to refactor.

The benefit - to me - is very clear. People do use hugetlb mappings to
run code in production environments. The perf benefits are there for some
workloads. Intel has published a whitepaper about it etc.
Uprobes are a very good tool to do live tracing. If you can restart the
process and reproduce, you should be able to disable hugetlb remapping
but if you need to look at a live process, there are not many options.
Not being able to use uprobes is crippling.

> Yes, libhugetlbfs exists. But why do we have to support uprobes with it?
> Nobody cared until now, why care now?

I think you could ask the same question for every new feature patch :)

Since the removal a few releases ago of the __morecore() hook in glibc,
the main feature of libhugetlbfs is ELF segments remapping. I think
there are definitely a lot of users that simply deal with this
unnecessary limitation.

I am certainly not shoving this patch through anyone's throat if there
is no interest. But we definitely find it a very useful feature ...

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>

