Return-Path: <linux-kernel+bounces-7829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B362881ADE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E62286763
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7E8BED;
	Thu, 21 Dec 2023 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ae7VBn7j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC76FBC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=p6d3JusNTbIjN7yfIOJ3VrarRe+uq8kWXbELto6+bKU=; b=ae7VBn7jMkc059d6wg7B4dq5V+
	ghRqhxdB2VsgXmGDT17BciX/HOdKWPNmUr8MA9D1iCwa9WnpkiU+Tr+vkEqwp0xQJXjiraH0ilTmr
	NDiEsri/7/8seTi1E1z1E1m01RXLSpTDKBHzS5a2IYXKV5AR0vP8AWsJzsYjHiBltqBMsIWM4WOUS
	n8khQ8McUz6Ozv1Kd+Swr8o8p7tI05Dmn1+c/RmrJR2fQWfSgbVSBY5n8Y9jCAbZb2ImMwFO+t3in
	0RhQNvghCDV/3I8B8Z7BcAS4GLmdspdPVy2YEsIFEyenkVE2VQMrl0H4A9MD1y1llLIxfX78tc/En
	tpMY8/9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGAN2-004e2w-Tg; Thu, 21 Dec 2023 04:09:16 +0000
Date: Thu, 21 Dec 2023 04:09:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
Message-ID: <ZYO6bLcCRYlo290g@casper.infradead.org>
References: <20231220102948.1963798-1-zhaoyang.huang@unisoc.com>
 <ZYL2rbD5UTz3s8gg@casper.infradead.org>
 <CAGWkznFcMkkqsKJSyHJfts9ZiYsxxg_dFTccieQ4+boRDJgG4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznFcMkkqsKJSyHJfts9ZiYsxxg_dFTccieQ4+boRDJgG4g@mail.gmail.com>

On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang wrote:
> On Wed, Dec 20, 2023 at 10:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Inactive mapped folio will be promoted to active only when it is
> > > scanned in shrink_inactive_list, while the vfs folio will do this
> > > immidiatly when it is accessed. These will introduce two affections:
> > >
> > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > 2. Low reclaiming efficiency caused by dummy nactive folio which should
> > >    be kept as earlier as shrink_active_list.
> > >
> > > I would like to suggest mark the folio be accessed in minor fault to
> > > solve this situation.
> >
> > This isn't going to be as effective as you imagine.  Almost all file
> > faults are handled through filemap_map_pages().  So I must ask, what
> > testing have you done with this patch?
> >
> > And while you're gathering data, what effect would this patch have on your
> > workloads?
> Thanks for heads-up, I am out of date for readahead mechanism. My goal

It's not a terribly new mechanism ... filemap_map_pages() was added nine
years ago in 2014 by commit f1820361f83d

> is to have mapped file pages behave like other pages which could be
> promoted immediately when they are accessed. I will update the patch
> and provide benchmark data in new patch set.

Understood.  I don't know the history of this, so I'm not sure if the
decision to not mark folios as accessed here was intentional or not.
I suspect it's entirely unintentional.

By the way, rather than inserting an explicit call to folio_set_accessed()
in filemap_fault(), change the filemap_get_folio() call to
__filemap_get_folio() and add FGP_ACCESSED to the fgp flags.

