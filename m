Return-Path: <linux-kernel+bounces-80983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA2F866EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0DA1C24437
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84408605AA;
	Mon, 26 Feb 2024 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/d9E7GQ"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A451EEE9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937740; cv=none; b=XZ9EA8f1+4G75uqELVIO7qVplAfMH7mc9DRWg10Mscs/baHIon9Hivb26Hu9YPnQaE1Nr22cEzktPGPufdE5lFAW9yTfErkul37xuIPdZicm/nmUg9kjv+IddvbW+n/OJX3k8loUan2TwJ8QneUssdR22vDARl098L8gqrMYLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937740; c=relaxed/simple;
	bh=mQhdhs0eG99ugKitt0T802I/y8woUyUpvbpMhZE5pY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1HOERDJd/qp98rPNiZcqtLnUUnRs/M81qNpgDftgCkv5lg7bzSlvmLFHXzN1f3MIDKHh9nnAZpNG1kEJP4GuCgsV2yqRcKrER3xgKpaO44XG79bGQqb/uYRl2klcjBFV15XPXbBK+Av8KmsY0B9yH+aAd7TQpIWuGnjsz5VEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/d9E7GQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bda53361-d334-411b-8ac1-069d41025804@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708937736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edBZCaExlvThpicmDyNTy0RLjhxVcCzS4RTR1xHtImI=;
	b=E/d9E7GQdda0ZeIBeDukSRZjzoUWkgNHD1Zu1wUTZZ0R2M9SXXGijixZaaksWoqy4Bl9/T
	bjjWkSpoUkjpjOvCQ+dNqF+G0N38bYjKNAYi+62sDsv05KsudDn8yo/mQimA6J5qj+DLD3
	g6ahp1cllfckg/gFytEGepano0MSeuE=
Date: Mon, 26 Feb 2024 16:55:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
 Xiongwei.Song@windriver.com
References: <20240224134943.829751-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224134943.829751-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:49, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete explicitly to avoid confusion
for users. Here we can just remove all its users, which has no any
functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  net/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index ed3df2f749bf..7e9c8fc9a5b4 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -343,7 +343,7 @@ static void init_inodecache(void)
>  					      0,
>  					      (SLAB_HWCACHE_ALIGN |
>  					       SLAB_RECLAIM_ACCOUNT |
> -					       SLAB_MEM_SPREAD | SLAB_ACCOUNT),
> +					       SLAB_ACCOUNT),
>  					      init_once);
>  	BUG_ON(sock_inode_cachep == NULL);
>  }

