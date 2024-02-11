Return-Path: <linux-kernel+bounces-60924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A739A850B0D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624952839B1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7875D73E;
	Sun, 11 Feb 2024 19:16:43 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837095D72A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679003; cv=none; b=d2fg4f7nHE/CV1G8AU6DajXYGOcfjxYA5n6PA9Xjsyrmz2VdEzzSM1iCFW/v1AvQZBjFMdUwJvr9fRZ28zd8RuhpuKHAu/UvDI0YCuG4pJCs9MPWKeaE82Lk1YPKlmBQJqCP4f1oYKuGYmFel6k5Nkr0n6QD6rzpuNEY1Cucc3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679003; c=relaxed/simple;
	bh=B8UFaFN2PijZW2D2EgFj8CBpfvYCa/Z8YGiQieVd8JY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZJRtGywFI7WbLhE7nQnx+T+5MRH76dIPBil0M2027Q4Fy+NecHsN6l4PoA0v8RV5tvkfxeTDIys1L++PfQqkXjwas57Vj+gJ/RzmdkCx3gjSaxVXEmpIhakK86ph5I2keopYjk0F1gw1AKp3brdFJIupe4M3W+vs8UDfDZJYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 10e5dd00-c912-11ee-b972-005056bdfda7;
	Sun, 11 Feb 2024 21:16:33 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 11 Feb 2024 21:16:32 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix memleak in iio_device_register_sysfs
Message-ID: <ZckdEDbAqin1Fsgt@surfacebook.localdomain>
References: <20231208073119.29283-1-dinghao.liu@zju.edu.cn>
 <20231210133228.5fd425ea@jic23-huawei>
 <20231217132800.27e83a01@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217132800.27e83a01@jic23-huawei>

Sun, Dec 17, 2023 at 01:28:00PM +0000, Jonathan Cameron kirjoitti:
> On Sun, 10 Dec 2023 13:32:28 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri,  8 Dec 2023 15:31:19 +0800
> > Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> > 
> > > When iio_device_register_sysfs_group() fails, we should
> > > free iio_dev_opaque->chan_attr_group.attrs to prevent
> > > potential memleak.
> > > 
> > > Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
> > > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>  
> > Hi.
> > 
> > Looks good to me, but I'd like to leave this one on the list a little
> > longer to see if anyone else has comments.
> > 
> Guess no comments!

This patch does not fix anything.

Yet, it might be considered as one that increases robustness, but with this applied the 
goto
https://elixir.bootlin.com/linux/v6.8-rc3/source/drivers/iio/industrialio-core.c#L2007
can be amended, right?

-- 
With Best Regards,
Andy Shevchenko



