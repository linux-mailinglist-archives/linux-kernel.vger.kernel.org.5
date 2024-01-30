Return-Path: <linux-kernel+bounces-44355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEAD8420AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1471C27270
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113E960DC9;
	Tue, 30 Jan 2024 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRKZFTlX"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389E6089B;
	Tue, 30 Jan 2024 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609202; cv=none; b=DnTZqNEOX9n242TQxmWvSO96iI7I5X12X14uj7uuuN7i2leQro6eO/HhASGzIwS5RjlRi+lADu/k0uh1S2mqEozp+NJLPf/dkTpsolsLTEi7bM9JVW+TVk2vj+8mDkq+UE0tVASVg5Z3EXL+EPH2yLyK2qrVw+MI0SHnwJbJ44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609202; c=relaxed/simple;
	bh=33yxRTwJsY9+vLQ1tvEYDMF6ElkJnKd+wgSpP79NvCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+jgrz++8Lzr66MZb5K/W7CYI9/IaJlCmA6TXE+AhCVxCZbGAK3OOyE5lCwrDfu0oKzxFy1ToB4c2GC7A3dhK7VG4kFrgw907vRgSQ4Xh4nZxiInUOkr5VlYubupqXgj+2LcxwSv72D9EoukKhWPrZp4Iv7hQspxbh6yLPQ9W8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRKZFTlX; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706609200; x=1738145200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=33yxRTwJsY9+vLQ1tvEYDMF6ElkJnKd+wgSpP79NvCE=;
  b=fRKZFTlXbPAC4KtEH7IxKJfOErLIVNCyJCnJJdk2XhYxAa76jzxfzAX4
   7T4oQXVGMn4Ma+iDO3qObm9nl3y9o+Pi4q+Y5Gnkem176cqzd3MM3ZRlt
   /KzFBFVwPATBTxSYaPFIWJX0Z5PY5sygJBzOE4GqBU0vPsNJMkzifRwVh
   yJUskODaJWeTC7e66FtkakUjY9edPJ0TMpusnzKLymXk5fzTWZgJAfyKZ
   nsI9V0VFQZNzV08iu7vhfodfSq5/qt5USGzVHAoDiBh+s5RjyUmyw/InT
   XeFTjkjdD7LzOWOAvYIuBfZQVjX7mWxE5wZ9Zr9CiAjzWDdRLF6Xq53GX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="467486605"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="467486605"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 02:06:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="1119213778"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="1119213778"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2024 02:06:37 -0800
Date: Tue, 30 Jan 2024 18:03:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luwei Kang <luwei.kang@intel.com>, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] fpga: dfl: fme: Return directly after a failed
 devm_kasprintf() call in fme_perf_pmu_register()
Message-ID: <ZbjJYMlDifIv0WId@yilunxu-OptiPlex-7050>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>

On Sat, Jan 27, 2024 at 03:55:19PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 27 Jan 2024 15:43:42 +0100
> 
> The result from a call of the function “devm_kasprintf” was passed to
> a subsequent function call without checking for a null pointer before
> (according to a memory allocation failure).
> This issue was detected by using the Coccinelle software.
> 
> Thus return directly after a failed devm_kasprintf() call.
> 
> Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting support")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/dfl-fme-perf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 7422d2bc6f37..db56d52411ef 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -925,6 +925,8 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
>  				PERF_PMU_CAP_NO_EXCLUDE;
> 
>  	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
> +	if (!name)
> +		return -ENOMEM;
> 
>  	ret = perf_pmu_register(pmu, name, -1);
>  	if (ret)
> --
> 2.43.0
> 
> 

