Return-Path: <linux-kernel+bounces-139514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E818A03E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402EA1F23B38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709861F602;
	Wed, 10 Apr 2024 23:11:14 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C24138E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712790674; cv=none; b=qDWRxXqNa7o1yWkJgWVvBfGBPhSOIVV4XSrGgGTtZcIRGWDr5DgjAgxPjGXthkoRGut/b0T4EK8Wlmz+P717IIRHIMIerF1pESYqIZ71fW8AKyacK0ONZfG/plWiOUgj0zj/gO20ASPzSVsDryOYmeQeVOuCKbfb83hp0Xzs018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712790674; c=relaxed/simple;
	bh=lzJuj20VpCLHchg2/Zfcm06SxrZ/tTwWdpqLy19ZBN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNlh1p66agHCNh368+xVTbuzHLMnk9ri5TMP97HZI8ZyoY2+SmQRGb67sAb/lGn3Dfk8oeAiEnkiPUvgjhQywBk/GZkF3UPN/VkXw8vAr2ch1SbWwRpipNsYClnpet86kqGqzn0L/3Bk2OGmwHP5UCjFKL47jN+VFM7bK/9u77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ruh5l-0002ER-22;
	Wed, 10 Apr 2024 23:10:57 +0000
Date: Thu, 11 Apr 2024 00:10:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: richard@nod.at, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ubi: ubi_init: Fix missed ubiblock cleanup in error
 handling path
Message-ID: <Zhccfw4HbC_MKj65@makrotopia.org>
References: <20240410074033.2523399-1-chengzhihao1@huawei.com>
 <20240410074033.2523399-3-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410074033.2523399-3-chengzhihao1@huawei.com>

Hi!

On Wed, Apr 10, 2024 at 03:40:33PM +0800, Zhihao Cheng wrote:
> The ubiblock_init called by ubi_init will register device number, but
> device number is not released in error handling path of ubi_init when
> ubi is loaded by inserting module (eg. attaching failure), which leads
> to subsequent ubi_init calls failed by running out of device number
> (dmesg shows that "__register_blkdev: failed to get major for ubiblock").
> Fix it by invoking ubiblock_exit() in corresponding error handling path.

Thank you for taking care of this issue.

See my comment inline below:

> 
> Fixes: 927c145208b0 ("mtd: ubi: attach from device tree")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/mtd/ubi/build.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 7f95fd7968a8..354517194099 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1380,12 +1380,13 @@ static int __init ubi_init(void)
>  	if (ubi_is_module()) {
>  		err = ubi_init_attach();
>  		if (err)
> -			goto out_mtd_notifier;
> +			goto out_block_exit;
>  	}
>  
>  	return 0;
>  
> -out_mtd_notifier:
> +out_block_exit:
> +	ubiblock_exit();

I believe that this call is the reason for the section mismatch we
are seeing on Intel's kernel test builds:

https://lore.kernel.org/oe-kbuild-all/202404110656.wLLc5mHR-lkp@intel.com/

Also note that Ben Hutchings has supplied a more complete and imho
better solution for this problem, which yet still suffers from the
same problem (calling __exit function from __init function which
results in section mismatch).


>  	unregister_mtd_user(&ubi_mtd_notifier);
>  out_debugfs:
>  	ubi_debugfs_exit();
> -- 
> 2.39.2
> 

