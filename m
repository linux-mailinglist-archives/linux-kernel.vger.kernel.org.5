Return-Path: <linux-kernel+bounces-75865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C385EFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91FDDB240F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2843F1755A;
	Thu, 22 Feb 2024 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmuIeskV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1B14296
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573312; cv=none; b=sd3Vz+euREv8RgY1hPH8GfjHfNXoGrbZ8D0x6vDJCBd7nnw6PEK0ZiQrPx8eXng+w1B8Kt1BwiQvVhUTZvxkTe9MIxGC904QNxdehSYoKmgSIpJI/TiVYyZSGNhI/8HMD3L+CFiOlVZFMqKipM4JqCE94owIh3Vbp5ak6kNP5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573312; c=relaxed/simple;
	bh=1ulRBrYzQdOmihVOfbwMuFBbUbV59yc+rUQ7cABoEHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5jk0OSWxTykrxUskM8lqQHjFYwjolmMwCvXElXBJkxuwOPlbBpveUGiYhVehAwSWlh+133OMIsoTFbaXVVYgDYVkP3K02jCYJO0hrEFCKMN4T5tdzGcFvW6ZCsJjxzN0Azki+8HM5dy90D9offd8b0FKruetlQFb1QyJ2Vedt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RmuIeskV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e9Kb7+9juqy5FhJMaaMa784eYLFmC0FDrVU0K/noLKM=; b=RmuIeskVf1E2Kxz6/IxeCqW04N
	CrbDilGBItIwOekuLDghEjj2hDdun5rXc3L4bAfOV99PtDvb67Mf1ba7arpix6VXSnbs00G6mssY5
	nlD564ezWwhpmki+hHXLXeBn54a2r/lbeEQH/3+s7amcsl4nSNK6LSDKLDC5M8Zdh0itiqeQ7nG5D
	x8HgU2+kJhxsR9SNjgXwWwkEiJFy2ugsGThnhoDc7OjyDsLMZDF2/V+mFLt/yQl08do2cPbXKpJ7D
	+4Zqr/hAW8DYfRg6rUvXFK9Mx/nfM2T0ObcCtOIFnrH1RRtnaT97Zeo2AScvocj+WF4jPFTjQ93rR
	qxEMcOsw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rczy0-00000002UCI-2zDG;
	Thu, 22 Feb 2024 03:41:48 +0000
Date: Thu, 22 Feb 2024 03:41:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev
Subject: Re: [PATCH v2 3/5] hugetlb: Pass struct vm_fault through to
 hugetlb_handle_userfault()
Message-ID: <ZdbCfLo85Gi_a7OI@casper.infradead.org>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
 <20240221234732.187629-4-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221234732.187629-4-vishal.moola@gmail.com>

On Wed, Feb 21, 2024 at 03:47:30PM -0800, Vishal Moola (Oracle) wrote:
> Now that hugetlb_fault() has a struct vm_fault, have
> hugetlb_handle_userfault() use it instead of creating one of its own.
> 
> This lets us reduce the number of arguments passed to
> hugetlb_handle_userfault() from 7 to 3, cleaning up the code and stack.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/hugetlb.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)

I love the look of this ...

> @@ -6116,7 +6098,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  			struct vm_area_struct *vma,
>  			struct address_space *mapping, pgoff_t idx,
>  			unsigned long address, pte_t *ptep,
> -			pte_t old_pte, unsigned int flags)
> +			pte_t old_pte, unsigned int flags,
> +			struct vm_fault *vmf)

Should we remove vma, address, idx and flags?


