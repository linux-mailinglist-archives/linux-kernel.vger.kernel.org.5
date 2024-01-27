Return-Path: <linux-kernel+bounces-41304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B009C83EE93
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23471C221F2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5954C2D60A;
	Sat, 27 Jan 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rqYs4I7p"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3492D603
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372586; cv=none; b=OgVuF23X4J8CkovxBVG21epvgijCRCbA/BG3672dNsqDgGi/7eGxJB4ojDHjrur9Me2WYOmWIC4v+eXXL+enhqOHZ2Wv1wGzE3bkyKogae992QBEo94brk6CcF0yqvZTXG90GomZ8PjNogOeVHxHD0neii59xyCRNzzl+ob03gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372586; c=relaxed/simple;
	bh=gg08MmGis9WStArL4LZ902VV0ssnodUvEEpCAPG85SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X08jBL0WeyXmJz8j+KenCoMKYeOIPi8YcYmnKkY0Ar45JxrTAG09ImX+xLyBvsT9YGCjC4aH1upKYaFZsUiwaBdXtEEEVyBh9oJDU4u65y7zIhyR/cX5uMPAiKX9ds/ZNu/GtQPBFALwVygKttO4LaTiWJyywbltpvclQ/IUtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rqYs4I7p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5MZNQZ+U0qN5MQqp/SbJWOMILdkVqVbvXC98OckCEaY=; b=rqYs4I7pZ1uOYVHIhQ1eakMTky
	xgx4C15f0/00wCdgi9w+JgeWxwvQXI4m5zt0xW9x1HgI8MB3/pSlrBYWyvgwwNeMygMCuxxDLIkPt
	LznO671hW7QiGV26CEanW4kgKOtg6pPianSOuKmxKgLYbPf7ohjtwlgnaqbEj6IkUA/tnrrdnNHkl
	r67/9lxhpcp1ykswGE1Kf92N5dKpB4/aJxKM+t8xa1V5KCy76D5c/jFU5UouJWmQRz1YJJqbmTavI
	Fs00/k4KhmC+WL1ygLW2KiV5ZaKYhaHU50ls9JEEDxnJdnJxYWzld8gnYSV8qUbQtWPlSfzieTztE
	eeDylA2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTlSP-0000000HM6Z-0ryK;
	Sat, 27 Jan 2024 16:23:01 +0000
Date: Sat, 27 Jan 2024 16:23:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Haiqiang Gong =?utf-8?B?KOm+mua1t+W8uik=?= <Haiqiang.Gong@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Mike Zhang =?utf-8?B?KOW8oOS8n+S8nyk=?= <Mike.Zhang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= mm/compaction:
 add check mechanism to avoid cma alloc fail
Message-ID: <ZbUt5WkdnH8cLntU@casper.infradead.org>
References: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>
 <Za3hf6A4V5QECvDy@casper.infradead.org>
 <JH0PR03MB8809FC349066C215C28DE119947B2@JH0PR03MB8809.apcprd03.prod.outlook.com>
 <ZbFZh-E7BZEGm_Ed@casper.infradead.org>
 <0da9c1215291afeebe2cd99b0d8691c7fe6bde3a.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0da9c1215291afeebe2cd99b0d8691c7fe6bde3a.camel@mediatek.com>

On Sat, Jan 27, 2024 at 11:03:48AM +0000, Haiqiang Gong (龚海强) wrote:
> On Wed, 2024-01-24 at 18:40 +0000, Matthew Wilcox wrote:
> >  On Wed, Jan 24, 2024 at 07:20:53AM +0000, Haiqiang Gong (龚海强) wrote:
> > > > I don't understand.  You say that the memory isn't movable, but
> > then you 
> > > > say that it's migrated in.  So it was movable, but it's no longer
> > > > movable after being moved once?  
> > > Sorry for not expressing clearly
> > > When doing memory migration, the kernel will determine whether the
> > current 
> > > page can be moved based on the refcount and mapcount of the current
> > page.
> > > This memory can be moved during kernel compaction. At this time,
> > refcount 
> > > is less than or equal to mapcount.
> > > After this memory is kcompacted and placed in the cma buffer,
> > under 
> > > certain special conditions, the refcount may be greater than the
> > mapcount
> > > （ex:the current page is being used by fs）, and then migrate will
> > fail.
> > 
> > But that's always true.  Any page that is currently in use might have
> > its refcount temporarily incremented.  There's nothing special about
> > pages that belong to a file.  You've basically just prevented all
> > filesystem memory from being migrated to the CMA area, and that's
> > wrong.
> > 
> Yes, we agree with you that refcount may temporarily incremented.
> Issues we have reproduced:
> The current page is migrated to the cma area by kcompactd, rather than
> allocated by kernel memory allocater.
> Our opinion is that if a page cannot be allocated to the CMA area, then
> we should not put it in the CMA area when doing kernel migration. This
> seems more reasonable. Do you agree with this view or do you have any
> other suggestions?

That does seem reasonable.  But I don't know if it helps you at all;
is there a type of allocation which is migratable but not allocatable
from the CMA area?

> > What's special about this page?  Or were you just unlucky?
> We didn't find anything special about this page. During our debugging,
> we found that once a similar problem occurs in the current page, it can
> no longer be migrated (retrying after an hour will not work).

Perhaps you can find out more information about this particular page; who
allocated it, why was it migratable initially but not the second time?
Perhaps something happens to this page to keep the refcount high, and
if we can find out that will happen, we can migrate it out of the CMA
area before incrementing the refcount.

