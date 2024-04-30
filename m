Return-Path: <linux-kernel+bounces-164548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE68C8B7F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C424BB22014
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77670180A93;
	Tue, 30 Apr 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5MCou+I"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA147180A70
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499113; cv=none; b=qqQqIHYxFUQ/USempieTAg59sITvub34DcIKsJcrUd7njNjJF//f3MLE/ud+/h49bDeCkLancCf+0zG0zMBcM6D1orUXINjEXDGE175b6Bn8ezgekmU6337X3SaxGMhq4T998Euud3Zmx0GtalBCjYWSCHtuMVr1MMg2tjY3RoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499113; c=relaxed/simple;
	bh=jqF1Nk/S7NILrmXQBSBZ/M0xVtd86KHGbUgyPhMIe4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDbtApFaZU3fq3e5yeBA4FFJHoZF/7YPoaNtFnkJuvQw9ggYHHa1HDkMNOtF2r3xnCD00JmnEO1rAqko0+iBf0jlcq92Q+6hkdnhzbuNEBzuwNfELr2e2SrOGK/C+Xyr7eqtKMuY9yw6+NRClE0XJqLl8S6MOJhcmZaCAIIUwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5MCou+I; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 30 Apr 2024 10:45:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714499110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pybzdGcdEs63Bij7DWZmHPl3clx+Ov+QZxJvlEZLe1g=;
	b=C5MCou+Ib5hMMFkCmrDrgwVBFWJbmii5S72vI/X86+3XIb/SCBgGBWAn6Dbs4KQkBB7hbp
	DqHW8ACmPg7WVtGNqRJJwRHuXiqsbM8rZtmMDV4r3j3aCMIhEq6Mm/0RZ2lZB3J42ZL1CM
	lc7Gzxh3xMJ/g/TdeH0eWMYsBrTlAv0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] memcg: reduce memory for the lruvec and memcg
 stats
Message-ID: <c6hxrlzj7ycrcodkmq4hrbxvdpcqet2wvckjit3xeewxjkavwp@zb2uxoxeqs6p>
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
 <20240430060612.2171650-5-shakeel.butt@linux.dev>
 <CABdmKX0jGpZ4VSvQrLDB9ntLEb-tJTWFEfVLC5ukkZDi1CK2yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX0jGpZ4VSvQrLDB9ntLEb-tJTWFEfVLC5ukkZDi1CK2yQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 30, 2024 at 10:30:51AM -0700, T.J. Mercier wrote:
> On Mon, Apr 29, 2024 at 11:06 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > +
> > +static inline int memcg_stats_index(int idx)
> > +{
> > +       return mem_cgroup_stats_index[idx] - 1;
> 
> Could this just be: return mem_cgroup_stats_index[idx];
> with a postfix increment of j in init_memcg_stats instead of prefix increment?
> 

The -1 is basically for error checking but I will do a followup patch to
initialize the array/indirection-table with -1 and remove the
subtraction from the fast path.

Thanks for the review.

