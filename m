Return-Path: <linux-kernel+bounces-88068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC686DCF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C70B1F26FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A6969D2C;
	Fri,  1 Mar 2024 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saBpVX3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBC69DE2;
	Fri,  1 Mar 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281416; cv=none; b=PoOb4nNb15FdCtwbV4M3tWOspRR3+50XamTChdhsDPhkJ5NM9MTgzIXN6+WcaLqecoNx8qrqsM3Eo0AlRRrs9OIgvo0hNlSAeniZBoUTsfCKJYwcqiIpJnQqzIN0QjdU7mPi+ok/Flk78qRTLiCFPfJJ+Hfi9/pXJ2o57tXcfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281416; c=relaxed/simple;
	bh=1KUKyW1krKHFz7wOeRii9DJH+wRpbx28AS7tGIgwrJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ9Hmmu/PfDaYHOzf+jbWOadnGgGAirWunioSdBY4Axl6DteR+lXaJHIKOcPB9pD3JfyMynnWdXC6xxvPe5d/89M9p0E6Cjmji3yXeh8d3y/bZJEorPYaPOgnPL1rBucRR7/f5xv2kLnsezeTjbarxUaZxJkbl09oux1e0WIH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saBpVX3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604EBC433F1;
	Fri,  1 Mar 2024 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709281416;
	bh=1KUKyW1krKHFz7wOeRii9DJH+wRpbx28AS7tGIgwrJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saBpVX3zewhhJIKVr385W4szyasUTa34y2yUnj49UH98LSYnHy/bSEnvBmk+xwSWV
	 n1dmU9Z9SsVAG/nAlsqdTZBs0vOWWlevy86MzXuE7YyB5gV5Wwe7bgPZcuzwc88Xcs
	 v7BnJZBVsuUUyNVMMEHCnW1i4E5JCMw/lSACUsHqoipYo6UcrMsAsqTj0INTAdORmb
	 AYRuPMnv9gsytc+1FhP67FXX7ObiDLD3m+uMQMcH+PQTpOYZw4aq8mPjl8fLMWopkK
	 HmWm7d3qQ8bsgZPhA8bfA7HyE1sSQC08lo5eP01fJat3OZxY2lSSVfemFDsXaXu2hc
	 Gl/mz4LNfiYkQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfyBH-000000006k4-0UHr;
	Fri, 01 Mar 2024 09:23:47 +0100
Date: Fri, 1 Mar 2024 09:23:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: fix resource unwinding order in error path
Message-ID: <ZeGQk82bOZA7H5kS@hovoldconsulting.com>
References: <20240229172549.444227-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229172549.444227-1-brgl@bgdev.pl>

On Thu, Feb 29, 2024 at 06:25:49PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Hogs are added *after* ACPI so should be removed *before* in error path.
> 
> Fixes: 6d86750ce623 ("gpio: fix gpio leak in gpiochip_add error path")

This Fixes tag is not correct. Back then hogs were only implemented by
OF so you need to find another commit to blame here.

	git grep -pW '^int gpiochip_add(' 6d86750ce62391f5a0a7985d5c050c2e3c823ab9

Johan

