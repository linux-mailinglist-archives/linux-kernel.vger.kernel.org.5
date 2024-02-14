Return-Path: <linux-kernel+bounces-64957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B99854523
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB301F294F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360C12B8F;
	Wed, 14 Feb 2024 09:27:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA7125CF;
	Wed, 14 Feb 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902875; cv=none; b=W6Ydv8T6M9ATFAUkbbnTCY0QphLHDLEoUTl9twG+EPE9Z6/wbJNLBuiXK+KW0wRQTdoJ/YgAAokFumRuXGmJzFObctjRk+GEaDJGizNpczvRs/VUxkIJKXWKY/yVaY9mDX3GQ+HuIPCvg8Dqo8S9cN/Au//02WduRRIVHNCjANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902875; c=relaxed/simple;
	bh=sIaagt7mtaQOaGtU4zI5wV9vS7vA86dOsiUcFH+wHcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqmGoKe6A4rlOOW9SsSW7DAy5cAJSi+lttkxUjOfblIuSdatCaVShfUBDI7n/uIaUJTSWelVvXNDtzod5822YXmtG3ZW50hbKKJL3+k4EVLLrPXx3bF+9UDbAMnHsIZ4P/JF3ul6GlLR2aYidRt6KS1OajPuxteFrfb1w2jrCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A3FC433F1;
	Wed, 14 Feb 2024 09:27:53 +0000 (UTC)
Message-ID: <fb4f6b74-8af4-43c6-9119-0c3ec2a3387b@xs4all.nl>
Date: Wed, 14 Feb 2024 10:27:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: ttpci: fix two memleaks in budget_av_attach
Content-Language: en-US, nl
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Yu Zhe <yuzhe@nfschina.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206073719.3133481-1-alexious@zju.edu.cn>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240206073719.3133481-1-alexious@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 08:37, Zhipeng Lu wrote:
> When saa7146_register_device and saa7146_vv_init fails, budget_av_attach
> should free the resources it allocates, like the error-handling of
> ttpci_budget_init does. Besides, there are two fixme comment refers to
> such deallocations.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/media/pci/ttpci/budget-av.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
> index 230b104a7cdf..4f897f848581 100644
> --- a/drivers/media/pci/ttpci/budget-av.c
> +++ b/drivers/media/pci/ttpci/budget-av.c
> @@ -1463,7 +1463,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
>  		budget_av->has_saa7113 = 1;
>  		err = saa7146_vv_init(dev, &vv_data);
>  		if (err != 0) {
> -			/* fixme: proper cleanup here */
> +			ttpci_budget_deinit(&budget_av->budget);
> +			kfree(budget_av);
>  			ERR("cannot init vv subsystem\n");
>  			return err;
>  		}
> @@ -1472,7 +1473,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
>  		vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
>  
>  		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_VIDEO))) {
> -			/* fixme: proper cleanup here */
> +			ttpci_budget_deinit(&budget_av->budget);
> +			kfree(budget_av);
I think this should go after the saa7146_vv_release() release below.
Just in case saa7146_vv_release() relies on budget_av somewhere. And
besides, it is good practice to release resources in the reverse order
they were allocated.

Regards,

	Hans

>  			ERR("cannot register capture v4l2 device\n");
>  			saa7146_vv_release(dev);
>  			return err;


