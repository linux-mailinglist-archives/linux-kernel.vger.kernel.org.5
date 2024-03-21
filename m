Return-Path: <linux-kernel+bounces-109615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB9881B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8CD282943
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63570B657;
	Thu, 21 Mar 2024 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cg9R2cJl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3411C05
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710990746; cv=none; b=AE5WGaFMK1q/cGWekRe2Kcqrh67vMt1NUqM5nT0uTu0Uc3FeyJvcWhfyZlhbfNat49j9gV8wU+b/LaeJDX0BB/HPsFKWfCZbDLFjU7c1Nonp1yIqdsKdLIh32Bhm7BJjkYOwaOnCAc+PjbH0fjjhHg1qzO62Hjj7QycpwaqpoNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710990746; c=relaxed/simple;
	bh=S2lhBlsfPnQiS/gcgNTesSaXPI68NceT5zrTZdf3A2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXZGd4VFDQgENSLPnBBb1SvLdXnXjBfMvXyKjCSQewo3P1zQYjtaEp/hYiQ6lBsx2dgQYJGBcRU0dgkDi7lkv0qNSnqhm7QNiEMpKzl3ET0XrC/0i13fDKtwnVBx4oGOkwG6/Jr04RNn3keyUHZfBo0/WnQj5gZxPGFgo5amimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cg9R2cJl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GxqvYjxV1d/jcpuBrpmdoSfZf4aAk2oAqqllkRuG7KQ=; b=cg9R2cJlyGOklevWoHxL43w2MA
	/6aaMDHs2edxpXBzTmoKWlYMR8sJYh7u+UI9xwP8cdAyI5m2hCXmx4lBRWm5lh8xpYdJHWuJAG9dY
	fohSSdGicQY9Ih8pFDiImDGwYOKhxtfiN7ULzxQEilOMMw9xLnjJuIS0SeEm6jd4e2LD/MJ++zKlm
	qAvMTwvDCEsvPPDMrMpX1hFSMHgkSE3nt9npRwYk67U951lEyIRpYe/lMEYvtkOZ2A6YFlX+3wnZO
	zn7pw4w4xz89KumAk3xiwWgOjVMldZcq41LEoHETTzdx1QuChHhivx9yt4gfpdAmrPHhDuQorTL95
	LN8hiYdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn8qn-00000005n7O-2ij5;
	Thu, 21 Mar 2024 03:12:17 +0000
Date: Thu, 21 Mar 2024 03:12:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hao Ge <gehao@kylinos.cn>
Cc: akpm@linux-foundation.org, gehao618@163.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/page-flags: make PageMappingFlags return bool
Message-ID: <ZfulkRCVL6d6S6JA@casper.infradead.org>
References: <20240307131304.169859-1-gehao@kylinos.cn>
 <20240321030712.80618-1-gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321030712.80618-1-gehao@kylinos.cn>

On Thu, Mar 21, 2024 at 11:07:12AM +0800, Hao Ge wrote:
> make PageMappingFlags return bool like folio_mapping_flags
> 
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> 
> ---
> v2: Send this patch on the latest version

I don't see v1 in my inbox.  Regardless, this is clearly the right
thing.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


