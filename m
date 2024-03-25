Return-Path: <linux-kernel+bounces-116376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BBB88995B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D35F2C17B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A812D747;
	Mon, 25 Mar 2024 05:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j82140pl"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01F131E5C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331155; cv=none; b=P5s4Egdhoz+73YLVU9rQxxdaZeE7ejCAQuADs7RAqRpWUHJ9sgeqXRF1g+JKUefyJjT4hH67w15DVQ/xE55fO8uDupGd0jeRy7jO3TT7QQFBIJAGy4uo4Y6CwBn8CzKnZFaGK49cIRjzsGAKaI2xZEnzEIc+W1ga+bgaqoLGa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331155; c=relaxed/simple;
	bh=X4zju90W4aAfBambsMQ3pcHLK9uxkPBmVCvkCo1PWck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2n8C3y84eikvIp+YdhSjvThWwBodmDCJcThalKDXtJbtDl2BZ4b1dLdkVxssa44FsNHGl1i6A50IoG9goaXMI3GTJ2vmveVdW3G9Y6nOJaHL2DKgB7wrUWP4WmJ81JBUSN0IWFz23f8maUx4Vsu1irq/6aywlaF7Xrrop8xXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j82140pl; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711331149; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=leOOK6HGPDBEJ+kEPCPdIg2ftxOl2mg8R0qVMdcL5+c=;
	b=j82140plo8K1i85ScupO+l212FvJf/jTePdLhKeoQeUPCDjzP0n6RjcyaTqI8+emFfPNAH4lOdb/zVuNftzemcktdkGmtOpPV7P+1kFcO0nTgeJfnaG5TuyNUzZZz19EzFJmm6o052ggqTawBPa3+c0SGYi2ru0zVq2xqyYjZgY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W381Eop_1711331148;
Received: from 30.221.146.131(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W381Eop_1711331148)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 09:45:49 +0800
Message-ID: <ba57f22b-1237-4882-9972-6011c0fb924e@linux.alibaba.com>
Date: Mon, 25 Mar 2024 09:45:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: drop experimental warning for FSDAX
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240325005116.106351-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240325005116.106351-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/25/24 8:51 AM, Gao Xiang wrote:
> As EXT4/XFS filesystems, FSDAX functionality is considered to be stable.
> Let's drop this warning.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 6fbb1fba2d31..fc60a5a7794f 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -430,7 +430,6 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>  
>  	switch (mode) {
>  	case EROFS_MOUNT_DAX_ALWAYS:
> -		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
>  		set_opt(&ctx->opt, DAX_ALWAYS);
>  		clear_opt(&ctx->opt, DAX_NEVER);
>  		return true;

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

