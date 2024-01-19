Return-Path: <linux-kernel+bounces-30654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E495832291
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCED61F23882
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD6E38E;
	Fri, 19 Jan 2024 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E09b9+pu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA43180
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623405; cv=none; b=MN4ckzTplBpmwYOOC+0h/7OnOlm16EMfcps7kHvvRt8OZrjJhQQ6llLD8IQr+6t5tI6h9M/ohW2S4hKZ4TJxvzGxr+fHDnwCi8CXT5ei8e340tn9b21LWS2rWrHd9ZyQLn8oTXb1K99bDmGQzR8tRbLz6/Mri+Rq+U5g0vsYxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623405; c=relaxed/simple;
	bh=fx8wb+F0IG13Fuw+CHMgt82vAzHtmHWYMxLE88gSjO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsXXjqAOH5Dd8s3VD8UqyVEVbmL0ztmYCd3M5ER6hiZcbKmmrDjnbpS6Eu4AnqDcWOKX+1ZfA235l2/CCuRX5jGZUP3Po1mgLzlldH38MxiesCbASbzClc3d698m5d0c/1rBXOLGA1WrRQ4VCxzhvrrE//uL67iJfuIFQC5+pY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E09b9+pu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cyFCAw+3MWHn7kvC5txRDNiZL7S1o52REXRdj6L83qY=; b=E09b9+pu/yyJLV8I9ejzRpgg27
	t2xrXuesPWZ4KyEi6kuTk33cV4T8pjHbRzMgUvjk1L9VGHpT0XE7+SPyOnurLRoq92kk+KYw2HFSU
	uP/mF+czpDJrS6uM6KmFpEqP0oM2Q8KzQK62tkjDIDtiQ1P/vv/TRG690RbIUdChuTnD7jTIKzDI7
	6CvB/ST7kqIRVSldOwkA2eB+CIBF+hEdgDBRZ30thiN9jIa65dahYalITEEvPva0BIEWoaYXsIv8N
	YOYviveCFqML+Sx20pSAILQiSLE+horKBAPw44gYuSIkDWPMaOVNURbfR3QlOLZ1M8MhhXfcplxEP
	hDS80hWA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQcYl-00000003Tb7-09Gt;
	Fri, 19 Jan 2024 00:16:35 +0000
Date: Fri, 19 Jan 2024 00:16:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yang Shi <shy828301@gmail.com>
Cc: jirislaby@kernel.org, surenb@google.com, riel@surriel.com, cl@linux.com,
	akpm@linux-foundation.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Message-ID: <Zam_Yv8ZLnNseBOW@casper.infradead.org>
References: <20240118133504.2910955-1-shy828301@gmail.com>
 <20240118180505.2914778-1-shy828301@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118180505.2914778-1-shy828301@gmail.com>

On Thu, Jan 18, 2024 at 10:05:05AM -0800, Yang Shi wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
> 
> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") caused two issues [1] [2] reported on 32 bit system or compat
> userspace.
> 
> It doesn't make too much sense to force huge page alignment on 32 bit
> system due to the constrained virtual address space.
> 
> [1] https://lore.kernel.org/linux-mm/d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org/
> [2] https://lore.kernel.org/linux-mm/CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com/
> 
> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Reported-by: Suren Baghdasaryan <surenb@google.com>
> Tested-by: Jiri Slaby <jirislaby@kernel.org>
> Tested-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

