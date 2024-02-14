Return-Path: <linux-kernel+bounces-64929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73C28544C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68120B28951
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1D12B68;
	Wed, 14 Feb 2024 09:13:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DE10A3B;
	Wed, 14 Feb 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901995; cv=none; b=nNCfR/N+v9WLvnPUbhbpU/JWxzI9KTQcfjUeWdyN+MTzO+koX+EhTx5gInrySEQEBw597yY4Rb7itdRtzRlnWVxZSsNIsbnlNOWfiLvfb26elZGU5k0bq4pMwQMdxFZXNO67Nd8Ij9y+kKl1r9hAMhQKhoEXxLLDpaLRgpoCnV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901995; c=relaxed/simple;
	bh=084PSz5mTHd1ymonazP+69h/HE55dDuaNCkpC8rH7Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/Cr1/WJKih0PfUvYuwRMcuvTukaqZq2/4MIdYBznz3CQYDslf3HhKcjzgULPT6FdPMoqIJN+vV/gncAMUh3Vju+wW1rwjbkjegPO5bA6KLiVzj16wiErvhXh/ose9tS1o9kKJO19z0nBtNaj3iarFnMavkLRGZMGlOwM2+DvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A51C433F1;
	Wed, 14 Feb 2024 09:13:13 +0000 (UTC)
Message-ID: <e784e7b8-8e18-42b5-bb0f-76cbe6af025e@xs4all.nl>
Date: Wed, 14 Feb 2024 10:13:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] media: go7007: fix a memleak in go7007_load_encoder
Content-Language: en-US, nl
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206065008.3128493-1-alexious@zju.edu.cn>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240206065008.3128493-1-alexious@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 07:50, Zhipeng Lu wrote:
> In go7007_load_encoder, bounce(i.e. go->boot_fw), is allocated without
> a deallocation thereafter. After the following call chain:
> 
> saa7134_go7007_init
>   |-> go7007_boot_encoder
>         |-> go7007_load_encoder
>   |-> kfree(go)
> 
> go is freed and thus bounce is leaked.
> 
> Fixes: 95ef39403f89 ("[media] go7007: remember boot firmware")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
> Changelog:
> 
> v2: free go->boot_fw instead of bounce
> 
> P.S. I'm sincerely apologize for sending a wrong v2 patch with no
> change applied. I forgot to add the changes to commit and missing
> it when checking. Please use this patch as the version 2.
> ---
>  drivers/media/usb/go7007/go7007-driver.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/go7007/go7007-driver.c b/drivers/media/usb/go7007/go7007-driver.c
> index 0c24e2984304..c0a47e596339 100644
> --- a/drivers/media/usb/go7007/go7007-driver.c
> +++ b/drivers/media/usb/go7007/go7007-driver.c
> @@ -80,7 +80,7 @@ static int go7007_load_encoder(struct go7007 *go)
>  	const struct firmware *fw_entry;
>  	char fw_name[] = "go7007/go7007fw.bin";
>  	void *bounce;
> -	int fw_len, rv = 0;
> +	int fw_len;
>  	u16 intr_val, intr_data;
>  
>  	if (go->boot_fw == NULL) {
> @@ -109,9 +109,10 @@ static int go7007_load_encoder(struct go7007 *go)
>  	    go7007_read_interrupt(go, &intr_val, &intr_data) < 0 ||
>  			(intr_val & ~0x1) != 0x5a5a) {
>  		v4l2_err(go, "error transferring firmware\n");
> -		rv = -1;
> +		kfree(go->boot_fw);

I think it is best if you add this line here:

		go->boot_fw = NULL;

It makes the code more robust in case go7007_load_encoder() is called again.

Regards,

	Hans

> +		return -1;
>  	}
> -	return rv;
> +	return 0;
>  }
>  
>  MODULE_FIRMWARE("go7007/go7007fw.bin");


