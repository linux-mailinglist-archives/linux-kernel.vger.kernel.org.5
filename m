Return-Path: <linux-kernel+bounces-64142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB518853AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA021F27FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352435FB8F;
	Tue, 13 Feb 2024 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KJqLcmyN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8588A1F618
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851647; cv=none; b=exHMM2JW0aUad4exL1/VahlDMS+Cr7BP0rRV/9txUBmoJE5hdAze2B9OiQ8XSFezeIGzx0/Ft37KwlN2CVQAxzyyQ/8M2NQb12NVt517jM9kUzTZ6bRc1xN2lHMCbbIgMT6ZIGuBtTB7HPp0HaSGxqHeCxkiJTJBOd+dWHNb4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851647; c=relaxed/simple;
	bh=nsqZzaRbHgEpoftLtQKZFuGwBa8UA+XODfR/p50vqCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiWgx2GtmTD2DAYvsTo1MNhOnUqsQ2heuidc5NsiID5Mupka4dAd/mG99Tai4oU7uwKxAMU3Ll85T7TSyIjqY4ZblQnSExqBb21m1s5J9sdlj8nijJ6rrW+Q8NTD2CvVv8sy+bnyxldxPe3ZMHXNa7QnMS96sOa4NNcTPXcqIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KJqLcmyN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bCo4+lBbI64WhPZU3kcMmGaXmZq9ZOTK3k+CwvOqF5w=; b=KJqLcmyNqkCNtYib+A/xFwI1K1
	/TPlVfHxQtMQ5jckBAGYftm2JmplMofcNbRQPa5j9sF1wfTSMYhLTIPWQMt0AHdonqqtWZIXYtjXd
	0VYnHEJ+BTGfMIcO+7A0pE0Gl+rb6oqXlACfscMZWxfMjNqMfG3vMU8Xa6rr3GsZ7KdUAZjm9fyLj
	Soqm3vgJrtT6l9YjAslIk8JC9H2pMuflsglf76jKoIGcpQzqtSThjWQs8ST+uRdULIteuDvEZvU/v
	R/MYLWh9WcVK68qfTuJk4vGjRrQ6/ov6GejQJlU6UEpQwKgrc7bU0aH0kxq05VZ1rM+DXoxHm6Bds
	T7sHX5Ng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZyEH-0000000AQ30-3ZRC;
	Tue, 13 Feb 2024 19:14:05 +0000
Date: Tue, 13 Feb 2024 11:14:05 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH v1 1/1] dyndbg: Replace kstrdup() + strchr() with
 kstrdup_and_replace()
Message-ID: <Zcu_fYHSaxgFdqAy@bombadil.infradead.org>
References: <20240213162741.3102810-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213162741.3102810-1-andriy.shevchenko@linux.intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Feb 13, 2024 at 06:27:41PM +0200, Andy Shevchenko wrote:
> Replace open coded functionalify of kstrdup_and_replace() with a call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

