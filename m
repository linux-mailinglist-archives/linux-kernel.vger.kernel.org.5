Return-Path: <linux-kernel+bounces-166280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA7F8B986F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAF61C23773
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFC557888;
	Thu,  2 May 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flyTCNeB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2256B78;
	Thu,  2 May 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644222; cv=none; b=aAPllHrfhDNokpL3NgK3RI6/WAKxMyd5L92iIBeDCV0lQXYiUjjUZbYwrcrk0NFOgR4KMkhRPTSsb2y8qlfUdua08Cx7iwzSDtX5THhy8tsTw4XWNtwgreo4gOWW7Pvgz3vsBbJg+a/g1ZmI1bJkvyHCjTix/YlVYZ+D5YqZ0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644222; c=relaxed/simple;
	bh=ENkbJLHRwFRQxCc8aY+6hcE4ZTb8Z+QG0pGceE0w8a4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iw75Qxyn1OAw9suc25335ZmqOwz8Y46kwoSGzwXl3WJFBW4OPuFswerLNtDsz4MS96qz1rBPW24DOy8bj6i5GcnqsHkUJYvm8MGRB/U4FJih5fDEIzziZqiBzHoO9RxPqWp9Ads5enJ4kAEC2o9l9a2in7EA3nYXUVRD9v28DIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flyTCNeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08E3C113CC;
	Thu,  2 May 2024 10:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644222;
	bh=ENkbJLHRwFRQxCc8aY+6hcE4ZTb8Z+QG0pGceE0w8a4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=flyTCNeBhEr+gQyCTC5kBU39G6/4eT+ECUJ/7HXC4NLgZw/35a629PnuyYdhRRTPH
	 PWLKBk9Wom5EjiPT9o2eB/jrJNt6RgeS2gOW5oMRG+flFq3ZhmH+BQkso+Q4LbTbmw
	 uLIPOTNavgz9j2d0k3Te0MsWCCLNUaqJfzBA8ryUVE9mxXquQg+sgfmYLUwhDYk7Vo
	 sAgGIjNhQWOojbKm04Bo52Uw2nPnrfFUWUh7DDahJ042yrbKNyxKRo+Pe4P5iHicIt
	 i3OwbFv9AHyqp0yWyHhcD83uXcHL0/Z9UrfZgVzPW7u9u/nQ0wTLwtiVi6tE/nSg1N
	 EKlp7/2aY1zMA==
Date: Thu, 2 May 2024 11:03:35 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-media@vger.kernel.org,
 Bingbu Cao <bingbu.cao@intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH 1/1] media: ipu6: Fix vmalloc memory allocation
Message-ID: <20240502110335.7b3495ab@sal.lan>
In-Reply-To: <20240502061525.1004018-1-sakari.ailus@linux.intel.com>
References: <20240501102236.3b2585d1@canb.auug.org.au>
	<20240502061525.1004018-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu,  2 May 2024 09:15:25 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:

> The driver was calling vmalloc() to allocate memory, something which isn't
> available except when particular Kconfig settings are enabled.
> 
> Use kvmalloc() instead.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 25fedc021985 ("media: intel/ipu6: add Intel IPU6 PCI device driver")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi Stephen,
> 
> Thanks for reporting this. I'm a bit surprised this wasn't catched
> earlier. But it seems vmalloc() is defined in some configuration.
> 
> - Sakari
> 
>  drivers/media/pci/intel/ipu6/ipu6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
> index 4b1f69d14d71..082b1d6196be 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6.c
> @@ -526,7 +526,7 @@ static int request_cpd_fw(const struct firmware **firmware_p, const char *name,
>  	}
>  
>  	dst->size = fw->size;
> -	dst->data = vmalloc(fw->size);
> +	dst->data = kvmalloc(fw->size, GFP_KERNEL);

Where are you freeing it? If I understood the code right, you're storing
dst at isp->cpd_fw, but I can't see any code freeing it nor cpw_fw->data
at device removal.

Also, there is a logic there at the same function checking for vmalloc:

	if (is_vmalloc_addr(fw->data)) {
		*firmware_p = fw;
		return 0;
	}

As now the memory may not be inside vmalloc space, shouldn't this
be changed as well?

Regards,
Mauro

>  	if (!dst->data) {
>  		kfree(dst);
>  		ret = -ENOMEM;

