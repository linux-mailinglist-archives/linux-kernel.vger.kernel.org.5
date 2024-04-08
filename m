Return-Path: <linux-kernel+bounces-135648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A42589C93A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F91F219E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C31422B1;
	Mon,  8 Apr 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G7ayW8YJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5A1411C9;
	Mon,  8 Apr 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592009; cv=none; b=ulkgIhi/YxXh/sUK+7FjKxRi7m7mdXLb9dO4RVUV19BjTqLFABV4OW09x58hHRJUQ3BwojeYcsl7RCKSmr6eiFvfTFcqD+53Cscye+eVZOQf8MP5nd8sDk3T24v/wPhWDMIvP5NPhb5Ha5WUij+2hDKcbYgc84vVSzjm1IImPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592009; c=relaxed/simple;
	bh=EsluPGBp8z3WBuyBSd9yS9dXpcZyDXvLR8NR4Vhr3vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHCdvPxbIAkNF3kbKgb34y8LHMkYufkEvUrezu9nczehvv3QARQ/UWXwDmI2/cK+v4jpf9bDlYjb+apFki7s6XOAek0WeNaCGqsrmIcKAisxGtZ1xsoWKfwvzzYwT7ONB8D5rwe4nfeYVhMrr5Q94xIu8NVoJOc7zAX6QyYPOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G7ayW8YJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i+CnLiyt3a/2zi5nZLCIWovq8ywq+T8g1xLxm8wLpf0=; b=G7ayW8YJwpLfRcKPNK//Na+wnG
	JFvLxiIAB9r/u3thtdxelqWM1GqjtIPobvbqqvf3uE1H+rlE9mv4N5Go5/ti2N4rIbuWe34xwlSKS
	K1KRJB3BJsgwi+AYdpkqJGYpbaM6O0VgVQhS0gvvxqcMe/j63N0CmQGJ9y6vdx2WqN6f7g/lzen9B
	Ls9d2c6G0E333K8CG4FJ9pquS/kQzN+MvHD67cuHsqpQ3UnlnfUuz2tGFrAS46W3KfnEKyaGprxQq
	9kPiUcEytYy6iU4P99SV6HL6DA0db/rUwpuSAYOMI6S1zqR150mVJyaj50c6pPDCanx6JuI/v5jsY
	/5Hw3VzA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtrPi-0000000G84E-1mFm;
	Mon, 08 Apr 2024 16:00:06 +0000
Date: Mon, 8 Apr 2024 09:00:06 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v4] module: don't ignore sysfs_create_link() failures
Message-ID: <ZhQUhvSCpz48f6tw@bombadil.infradead.org>
References: <20240408080616.3911573-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408080616.3911573-1-arnd@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Apr 08, 2024 at 10:05:58AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sysfs_create_link() return code is marked as __must_check, but the
> module_add_driver() function tries hard to not care, by assigning the
> return code to a variable. When building with 'make W=1', gcc still
> warns because this variable is only assigned but not used:
> 
> drivers/base/module.c: In function 'module_add_driver':
> drivers/base/module.c:36:6: warning: variable 'no_warn' set but not used [-Wunused-but-set-variable]
> 
> Rework the code to properly unwind and return the error code to the
> caller. My reading of the original code was that it tries to
> not fail when the links already exist, so keep ignoring -EEXIST
> errors.
> 
> Fixes: e17e0f51aeea ("Driver core: show drivers in /sys/module/")
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

