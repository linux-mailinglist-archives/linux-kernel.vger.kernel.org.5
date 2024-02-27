Return-Path: <linux-kernel+bounces-83879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1FC869FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB58286CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE151C4D;
	Tue, 27 Feb 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OyZ0imUF"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F951C5A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060428; cv=none; b=SRZMVo2ApZuzcOLMlgfg2kgvV2oSGW6Pn++hH23zgzVkt2RaIxAkfmxAIbmnlgDws5tPEEH9EbswpfVxiv9Gaw1kv7WthMKnHyvlMR7Ie+frS2inr9MTTIuH6xG7JIeRy120JCDpJSDsDwPFm4TbaoMVh+EGLyzdbUViOZ8a4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060428; c=relaxed/simple;
	bh=CQ7eH1Ilnoxrau6+WbQBd2Hi25j8nR7jSGSsru+q38w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6+ei6v6FXVDsEazuL1IGtFNcxMIgKUK1dZ4O4kUDA2YmzVQsyl4onderU+i6i7BV8pWDQXVQJW7KwYWB4n8BbPDfQoFtGuLGkd+JJQWKeq0vtVqU4tIjT9dTR0fKcl8b5W8EBBHOzvtclxQoEGg6IKZG1qwQeJN/0YiMJUE5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OyZ0imUF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J95vWGrA/itCKF08JGf7hvGbO2rEbVzRQpPI5oQMvNY=; b=OyZ0imUFdwOp/UeqVRt3hYUlLQ
	7NOCiitMox7FOpFW9S70Ih1iO25dq61wq+1Htm1+YaCEhJoLe2vP+RbVZpAU1eXzOQRskP+Jax0lY
	Iu7JlA5zENVoM4gSSRBJKSFm/HQ7lthI113D18lIW6ofixyG6feBDzv7LvsCHJxtqOnskqZFJ7lXo
	SQwlvPv/iA+NOsCBV8iiqxVBNqpHNa5BX4HneRgZHMiuYpqrTQtr8EwOe5HY83uRvH95psjJxAr/1
	URBknVaxxOcuQP9DZnmKZqylEWNiqgUbnMthalmg7DB1V3RdUe9Cam3cp7c49mWY9wJ2/JJBN+jC0
	Es2dkCxg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf2gh-000000038TL-2iOj;
	Tue, 27 Feb 2024 19:00:23 +0000
Date: Tue, 27 Feb 2024 19:00:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, sidhartha.kumar@oracle.com
Subject: Re: [PATCH] mm/cma: convert cma_alloc() to return folio
Message-ID: <Zd4xR9sojA-4Mdwm@casper.infradead.org>
References: <20240227181338.59932-1-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227181338.59932-1-jianfeng.w.wang@oracle.com>

On Tue, Feb 27, 2024 at 10:13:38AM -0800, Jianfeng Wang wrote:
> Change cma_alloc() to return struct folio. This further increases the
> usage of folios in mm/hugetlb.

I love the idea, but I don't think this works.  The memory returned
from cma_alloc() isn't set up to be a folio, is it?  That is, it
doesn't have compound_head initialised so that page_folio() on
consecutive pages will return the same pointer.

Or have I misunderstood?

