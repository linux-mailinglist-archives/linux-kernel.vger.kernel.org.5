Return-Path: <linux-kernel+bounces-159517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091DC8B2FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA301F22FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0B13A25E;
	Fri, 26 Apr 2024 05:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Od9Syz8/"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CC13A24E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107779; cv=none; b=A4BD1XwBAqjssoULIok7fSthgv7iC9zGqKSK0ZvEPCpOtal7BSOC+GcX3qsUzSNs4WwG2hEkMVsTFxKO87Fuy79fjZ/yX+jI6j+aMclVw78ye8TPYeoeP6waHSB57i6Zz4fURymiuDQmL+O33qc8Eb4CMNmS1JU8/xvFfui792o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107779; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0lQXT5j4Y6FkPT74fiFl7PxPlFDGV5xO6WXhgZvdzP3nqvZkU686lJe86PvAD+hVfZRhER8lQYp4YkzzwYXgpATgw9aHeDAiNshbbDHzqRf1peQGolrwKFBy6n5z+m+wG7T561vYeqY/lZavtx4Vh1nwlTxSdtmS/w4xvISxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Od9Syz8/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Od9Syz8/yBVWr7kee+LVKVusjh
	VZktemZu0kAUweUYIUEKby7jinGpX49pLRRSr9pfDKYREy1AfvHqYWIXsHbUOlbRSmcFxb9+B8+I5
	Ef+gODdDY8SfGUYhmJCh+0y6a7y9byVLIqD5VJH7chF9owcycDq9HTUQmyl0V5QIy/fUy89LC0M73
	vfz+mUY7Le8J/6g5FXaaPirdmhnGNXzkhpdfcms5J+IoSwyEEGQNZyxHFuutAYDu0eYRZMFPWfz70
	WDMMf5aOjcGU1rFbtwgCIpDq+DRZ4oI/tyWVF9+I6IKGBX1zl9AMEBaverOFwKR3jHASVvFKDgJV/
	NicnYYug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0DjX-0000000B8pP-1gOn;
	Fri, 26 Apr 2024 05:02:51 +0000
Date: Thu, 25 Apr 2024 22:02:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: hailong.liu@oppo.com
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, 21cnbao@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v3] mm/vmalloc: fix return value of vb_alloc if size is 0
Message-ID: <Zis1ex8U3Gvetgpu@infradead.org>
References: <20240426024149.21176-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426024149.21176-1-hailong.liu@oppo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

