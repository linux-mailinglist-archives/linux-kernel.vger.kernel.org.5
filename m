Return-Path: <linux-kernel+bounces-125104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C589202B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD731F280E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CED1C0DE0;
	Fri, 29 Mar 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X1to8hkj"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D71C0DE1;
	Fri, 29 Mar 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724401; cv=none; b=A3++p5ea1qpmfgE4pZor838rKijeozHkNHa+kYCGseEZ8vOzYt9sXZDtk5xQ9TNlhfZ5z7RSFYXOJgCjeXcDoBJ37hVkFd1KoTnzh9MvD03SgRVq03Hrdo4wlIKE/OS0p7k2i9Zy4TF5cSGxmbiotKv4iXYtCz2x3AXPfRY+Eyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724401; c=relaxed/simple;
	bh=oo9yoNE/4vdjC3mpkkCYwwHuAL4KPvmK+aOqwWpVx4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgsUvcUzBCcjP5bAV78Xw+rOlyveDSlsMP5k+HYb+cDvf2Ga6lNB2xdzYxyVDaUtZSumYN2YP3QTmx5gw+/aVv58T6FXdozBnx4oFT73vTnhgJQi3Gaucf47tByFyKG8aTM09Yp5nF9Q419K43D+CWOZVGYtcM8PwFLR7m+IboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X1to8hkj; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70019C0006;
	Fri, 29 Mar 2024 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711724391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut6+VYlYDNS0PruLXbgV449Z+y6TKxDC1abGJqp/i40=;
	b=X1to8hkjVU22Adt/6BdO9P/aezjfFsS3d1jSwi7SuCUaH/l+0LP+uwuX4cFIgwU7rPafxG
	2Vf6WQR1Uq6WxjHxIrXjgFEou9Jh71W+ha+N6IJv/xuw3GUd9YKLnsKWlhiFR/3lCDLgBw
	BsAVsai9e0uNup5UwXYyx2wRxhlTt0+Drw0gJJzeBY6tsKAe6Vo9OKdVr0GtiM9Ba3TBtN
	wu7AwlOUQ+g6XNKrrPOBYqnUEu20hBbAz+EhfVQRXPevjV2E8auXPe7Qipr/D7tGSvqYo7
	c4z/g8Cv27t0wFdOEzcwa8Pf3Ecr6oMU8FiDhS8ZVpqM1IM3haF9HrAsarvVZA==
Date: Fri, 29 Mar 2024 15:59:51 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Diaz <daniel.diaz@linaro.org>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: test: Split rtc unit test into slow and normal
 speed test
Message-ID: <171172436464.1832232.11554976833985117207.b4-ty@bootlin.com>
References: <20240313174221.1999654-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313174221.1999654-1-linux@roeck-us.net>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 13 Mar 2024 10:42:21 -0700, Guenter Roeck wrote:
> On slow systems, the rtc unit test may result in soft lockups and/or
> generate messages such as
> 
>  # rtc_time64_to_tm_test_date_range: Test should be marked slow (runtime: 34.253230015s)
>  # rtc_time64_to_tm_test_date_range: pass:1 fail:0 skip:0 total:1
> 
> The test covers a date range of 160,000 years, resulting in the long
> runtime.
> 
> [...]

Applied, thanks!

[1/1] rtc: test: Split rtc unit test into slow and normal speed test
      https://git.kernel.org/abelloni/c/95c46336ab47

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

