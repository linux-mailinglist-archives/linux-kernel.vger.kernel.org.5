Return-Path: <linux-kernel+bounces-167841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF48BB025
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1297328497F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6A315358B;
	Fri,  3 May 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="AqzuWbvo"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6579E3
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750781; cv=none; b=G3IE6633B0Iao+T6QuxVeqp88STce6owM540ImNjLljXmfaEAzom3Ymw0UpDzpplDQGV59gTDhehym5eXOcTP6MWQB+s8B8qe5tC5HhOVX41pGHnVcwxS3DH/Sj5INf0WB/SzbygawUxyPrFHY2berOUSNwOZbw56084uvRiR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750781; c=relaxed/simple;
	bh=V93HdGLwMZ7/VJVybupXO0YXtn+XaLniqbxkd+Milzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUPctTYtXZz7T6NsV7vYhHdBaFt0F5IkhtDwOc60zDZMqJnjCw5xe+DnG2wUt2fwY4XtKtPe9ktZzZSIGE1Gpr+Uz91ZDZgCnXzNlS3mnTTZpdLr7Pch1pAvaTD5jFHmoWt0bdWergZjD0d1Q7FwoXq5UgPha+CxdtYcLQfsQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=AqzuWbvo; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0 (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8E9B34078539;
	Fri,  3 May 2024 15:39:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8E9B34078539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714750774;
	bh=SpE7/+FxkwXnbNhXpVFjsvlzjuFu6B6sxg+PjjB7/wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqzuWbvoVk1jb0hT3lDNWLZwHevKst58XvtUZUkHItLv0sc+oP1ofyt6SMkJV26BD
	 eiMqjH8xeR/fgshO93w/XjvOdYQbTG1YK80quk52CJygRmCr1PUmlfgSdAXIO/IUjT
	 WArrQDfCfOQksn9zrLLulo2vRilJko5/3GsTCqtI=
Date: Fri, 3 May 2024 18:39:29 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Barry Song <21cnbao@gmail.com>
Cc: Xiang Chen <chenxiang66@hisilicon.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Barry Song <song.bao.hua@hisilicon.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: prevent potential kthread
 hang
Message-ID: <20240503-20a2c3986084e60eaac15672-pchelkin@ispras.ru>
References: <20240502161827.403338-1-pchelkin@ispras.ru>
 <20240502161827.403338-3-pchelkin@ispras.ru>
 <CAGsJ_4zKRSnpoepYsw8qiwVHY-ztWYixKjtD7D1SKbhYho=pUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zKRSnpoepYsw8qiwVHY-ztWYixKjtD7D1SKbhYho=pUw@mail.gmail.com>

On Fri, 03. May 13:44, Barry Song wrote:
> On Fri, May 3, 2024 at 4:29 AM Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> 

[...]

> do we still need to do copy_to_user(argp, &map->bparam, sizeof(map->bparam)
> after  do_map_benchmark(map) fails?
> do we also need the below?
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 02205ab53b7e..28ca165cb62c 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -252,6 +252,9 @@ static long map_benchmark_ioctl(struct file *file,
> unsigned int cmd,
>                  * dma_mask changed by benchmark
>                  */
>                 dma_set_mask(map->dev, old_dma_mask);
> +
> +               if (ret)
> +                       return ret;
>                 break;
>         default:
>                 return -EINVAL;
> 
> 

Good point, thank you! If benchmark failed, nothing new to be copied back
to user, indeed.

I'll add this as the third patch of the series and post v2.

