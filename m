Return-Path: <linux-kernel+bounces-75842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B4185EFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC612B219F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444681754E;
	Thu, 22 Feb 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w7PD8r1N"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE67156E4;
	Thu, 22 Feb 2024 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571986; cv=none; b=iuLBS5m7GYZ9qzrU+U5Zj8cBZ0ftzpvktRvG3f2qaYjFWjDYjiiuVvViEmOcxYhVtzK6pCG0V5ImKAm7Ek79qQE2YqrGIPR9RTb0WOAZHJymby5Z095SZMEG2DMEbk9rFWKnHF5mA3LM//tQvzypUuedeJzmjpeSvqAGsUEgfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571986; c=relaxed/simple;
	bh=ZR4uoLQTiEOwo3CnieSljcC/pC2fqYtStebX1jAXWJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSCR4ac1oDWsSFnQvbxgfxc4Posn7XLEuw/nLLU6r88kMHXooeTE+tkXTonpVUx5TVndC47aVNKbnC1xmIedInLdTJYoldQKzsUEIgbuJKh7tpFBA8F+DE/alVmwwHLGGmuYKRxTE1TTpaYZ6/WK4x00wEUHSebZ2rqjcqfLIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w7PD8r1N; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708571981; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V9/JqdFP6+H5ZwF5GLxGFsL2hRG+X43V/o/Ie5ISJlI=;
	b=w7PD8r1NPQ2OClkdgI7DKPnp8Of/q/UEv9hYF3u3DZjeKfgslGyn+f5a1phMX83XibkpD2+8jOU4Doox+YtB3uIt1ct38PlNHQlASziveVFTUucvoEx/9l6kfum10V3+jJMX0cD2/2TX6n4Mnr0RR8WgK25UlIF0hU9Y6RQLgy0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1.d02z_1708571979;
Received: from 30.221.147.146(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W1.d02z_1708571979)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 11:19:40 +0800
Message-ID: <27a77b2a-ad9c-4247-9ddb-61fdf5bb3891@linux.alibaba.com>
Date: Thu, 22 Feb 2024 11:19:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix refcount on the metabuf used for inode
 lookup
Content-Language: en-US
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>
Cc: quic_wenjieli@quicinc.com, stable@vger.kernel.org,
 kernel-team@android.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240221210348.3667795-1-dhavale@google.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240221210348.3667795-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/22/24 5:03 AM, Sandeep Dhavale wrote:
> In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
> we do not assign the target metabuf. This causes the caller
> erofs_namei()'s erofs_put_metabuf() at the end to be not effective
> leaving the refcount on the page.
> As the page from metabuf (buf->page) is never put, such page cannot be
> migrated or reclaimed. Fix it now by putting the metabuf from
> previous loop and assigning the current metabuf to target before
> returning so caller erofs_namei() can do the final put as it was
> intended.
> 
> Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>


LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
> Changes since v1
> - Rearrange the cases as suggested by Gao so there is less duplication
>     of the code and it is more readable
> 
>  fs/erofs/namei.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index d4f631d39f0f..f0110a78acb2 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -130,24 +130,24 @@ static void *erofs_find_target_block(struct erofs_buf *target,
>  			/* string comparison without already matched prefix */
>  			diff = erofs_dirnamecmp(name, &dname, &matched);
>  
> -			if (!diff) {
> -				*_ndirents = 0;
> -				goto out;
> -			} else if (diff > 0) {
> -				head = mid + 1;
> -				startprfx = matched;
> -
> -				if (!IS_ERR(candidate))
> -					erofs_put_metabuf(target);
> -				*target = buf;
> -				candidate = de;
> -				*_ndirents = ndirents;
> -			} else {
> +			if (diff < 0) {
>  				erofs_put_metabuf(&buf);
> -
>  				back = mid - 1;
>  				endprfx = matched;
> +				continue;
> +			}
> +
> +			if (!IS_ERR(candidate))
> +				erofs_put_metabuf(target);
> +			*target = buf;
> +			if (!diff) {
> +				*_ndirents = 0;
> +				return de;
>  			}
> +			head = mid + 1;
> +			startprfx = matched;
> +			candidate = de;
> +			*_ndirents = ndirents;
>  			continue;
>  		}
>  out:		/* free if the candidate is valid */

-- 
Thanks,
Jingbo

