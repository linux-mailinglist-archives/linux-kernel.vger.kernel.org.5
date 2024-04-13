Return-Path: <linux-kernel+bounces-143579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110E8A3B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DD9B22172
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AA51C2AD;
	Sat, 13 Apr 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cr2+k1TM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD718E1F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 04:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712983392; cv=none; b=GaZ2H7obcekqicyyIXTYLkdBejhpkhtxSKN4aimLpbbi3gOUgZynvg56hlEbdiOG8EaDnO2NAYV9FW7QfSAqQSfejWBzJirp98hSMowYXsDFfgUUq0TKOtCZWBYTEXcya4pc/18vXfj2MjsV7SPK/X5fi7XKrmGZJnpuFFV5f6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712983392; c=relaxed/simple;
	bh=/s7opqiQbIhRnAcsdD+azbzpYvUyNjVGVjFRqvT2bR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxk7HEiSVZBRoidkmEZDk9Uzec1KYftE5vix6RAH7DyZvuGKYEg8+olrBpacmuUtlW0184pk4xIwCBCWl+5hc6ipBTkwxmO/G9oO9bBbfDwNYhqqgbyuajLEGO/E0QPROsUgCgSB4XnwXGUttjIXQwcXp3fHqHihQW8mMj7QqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cr2+k1TM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UdCdCc4OOaJHmySLIXZx/NfTkh4B4k7wpkuGCGoPgMs=; b=Cr2+k1TMd9cRKjOcosXxijg5w7
	CDj1lngz9KM8Vcu91/2IuW+VCPJ3LpkLbgyJvBw+2UH8zn5eIaPmY8eqArYC8QU244SNdzk7dQkl3
	ES1r23pvRXJO3scDuwjTzmgOtt1Vyd55Z+rV+z86vDvWeXhV4A7+ecfPpZPBd5xD23oinrUPEnMaA
	KMwUmuG+SeHLhdphBWSV/vLAQblvbQx+mf6iUKIe4x6k3woTkEgCLxSruiEV+d1WeZSEQ0fvGk5O2
	vx0UfSwQPv1mm1sZAOm/ElHfYi2rlpRxXyVCbl2/DwEE6Vz02UHRSR986hDK7CsI/d7gfBcXvP1i+
	M8EjXN2g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvVEH-0000000AkBH-0uz4;
	Sat, 13 Apr 2024 04:43:05 +0000
Date: Sat, 13 Apr 2024 05:43:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jianfeng Wang <jianfeng.w.wang@oracle.com>,
	"Christoph Lameter (Ampere)" <cl@linux.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, junxiao.bi@oracle.com
Subject: Re: [External] : Re: [PATCH] slub: limit number of slabs to scan in
 count_partial()
Message-ID: <ZhoNWVfEWhFnVT1l@casper.infradead.org>
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
 <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
 <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz>
 <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com>
 <1207c5d7-8bb7-4574-b811-0cd5f7eaf33d@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1207c5d7-8bb7-4574-b811-0cd5f7eaf33d@suse.cz>

On Fri, Apr 12, 2024 at 10:20:48PM +0200, Vlastimil Babka wrote:
> On 4/12/24 7:29 PM, Jianfeng Wang wrote:
> > Yes.
> > On a server with one NUMA node, I create a case that uses many dentry objects.
> 
> Could you describe in more detail how do you make dentry cache to grow such
> a large partial slabs list? Thanks.

I don't know precisely which (customer) problem Jianfeng is looking
at, but here's one we got to publish a couple of years ago:

https://lore.kernel.org/linux-fsdevel/3a7abaca-e20f-ad59-f6f0-caedd8450f9f@oracle.com/

(is LSFMM coming up?  Must be time to have that discussion again!)
https://lwn.net/Articles/894098/


