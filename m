Return-Path: <linux-kernel+bounces-37532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2645383B152
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64E72861BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2A1131732;
	Wed, 24 Jan 2024 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g+zmg+Ym"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113587CF3F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121612; cv=none; b=PNxpiwI1yhQt0EWg5li/x2T5cFNlS1cJE4FBZgVAxRl/ffaL02ucSRFZjjR5HGoHsTiO3SOi4EHE3ahBSA1drvTCw3D2teAeOEYGhWIxBVs26OJY0lggHdPqSbJ7xFe75LsevC1P7NVjnWJWWorUD9bX1J8F8M7qXiQv9qwmrCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121612; c=relaxed/simple;
	bh=EMjjgo6EOUSHuhiIbOnLdaQNvcS1crAmIlcHC3Ptc8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeaZ8A7ILc7SPmYcT44bM2bWCB23p3OuXF8MmR+9SAg2veush0++viZjBIr/6lzL/ffbYtSy/aGTMo1ewpaw3GJxIXwotUkrPcyOyc9XvEXc4oH0BvSab+o7gMAfTDTYWC4mXmPKfO58pIXLiP2GJ5LlhVB4BxLKpnY9hPEJcmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g+zmg+Ym; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=draqL+CE/rP10cXaUi8xoo+aCaYER4SdwSjRFB4PIm8=; b=g+zmg+YmwmdzlghpYwJW/wat/t
	I/cEHh96j3CYzc1CTJqQpLR5HDfuqmoh7R+NZ42ScpDxaJF6gVLHWAL2nZchFm5v58pWmvbMeglcZ
	MzyF6Q2qAJeOzsmHNiGeTCRXXfqxTMW5L6tBKrwj5/B/oTA3UQ4ZS004KWeY9HEpm3HT5JyHChscz
	UFlgYfyno6PQR58/cQhX1glfFvyaelEpSFCbyIa0W8qR5M3QHKUwgZOhkm9A8xE9xMd05M/SaoN7s
	payZ5Eq73rquLSQmgMppR1ujBfIE5U0Xfucr3M/h90xU8t2SQfIvShi22ZeFYcHm+/0UNeBD9xqcB
	X3Zp449A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSiAR-00000007SKc-2nnP;
	Wed, 24 Jan 2024 18:40:07 +0000
Date: Wed, 24 Jan 2024 18:40:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Haiqiang Gong =?utf-8?B?KOm+mua1t+W8uik=?= <Haiqiang.Gong@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mike Zhang =?utf-8?B?KOW8oOS8n+S8nyk=?= <Mike.Zhang@mediatek.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= mm/compaction:
 add check mechanism to avoid cma alloc fail
Message-ID: <ZbFZh-E7BZEGm_Ed@casper.infradead.org>
References: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>
 <Za3hf6A4V5QECvDy@casper.infradead.org>
 <JH0PR03MB8809FC349066C215C28DE119947B2@JH0PR03MB8809.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <JH0PR03MB8809FC349066C215C28DE119947B2@JH0PR03MB8809.apcprd03.prod.outlook.com>

On Wed, Jan 24, 2024 at 07:20:53AM +0000, Haiqiang Gong (龚海强) wrote:
> > I don't understand.  You say that the memory isn't movable, but then you 
> > say that it's migrated in.  So it was movable, but it's no longer
> > movable after being moved once?  
> Sorry for not expressing clearly
> When doing memory migration, the kernel will determine whether the current 
> page can be moved based on the refcount and mapcount of the current page.
> This memory can be moved during kernel compaction. At this time, refcount 
> is less than or equal to mapcount.
> After this memory is kcompacted and placed in the cma buffer, under 
> certain special conditions, the refcount may be greater than the mapcount
> （ex:the current page is being used by fs）, and then migrate will fail.

But that's always true.  Any page that is currently in use might have
its refcount temporarily incremented.  There's nothing special about
pages that belong to a file.  You've basically just prevented all
filesystem memory from being migrated to the CMA area, and that's wrong.

What's special about this page?  Or were you just unlucky?

