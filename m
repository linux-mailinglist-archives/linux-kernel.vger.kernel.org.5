Return-Path: <linux-kernel+bounces-96778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25F0876152
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38731C22568
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2CE5380E;
	Fri,  8 Mar 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QG1dOEGP"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC5535BA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891614; cv=none; b=qNcvA7HoH6SIbCIU8oNDEYyXOg0JMhFWUYcGTDpbbWAN5C1JX4demdf4/n8PUJTplgOr5zMCVOnI0XGQg1w1YmEcz6bnwi8xsVKLzOqRIuo+8GGfg9LHDhE1mgUmGxxasHO614U650GU5R7PN2auDx9/FINiltTbpvjTeBlrYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891614; c=relaxed/simple;
	bh=ndHO+dbK771sCXkhMw7b5U4+3upvw4nenUdZ5aegvaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V72pLDo0be/F/fvE9VGxI30ha6n6ZslERC7q8Y5ah44xONZJn6nMkTUiCQoSSpeG44hy0yseAJeBqc6WsezR1C2h6qPUxJyW0ST2MP/wJ9hBKLmXpQWooFaoF8HPJcnjxzhLoT2SXzOKRvjIaFF4ZVnNXbJCXwR4tJ9QEK2lpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QG1dOEGP; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709891607; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SVLuV58Wf88RJz4QCYei0USy2gOFJ7vIuBSJPd4JPzE=;
	b=QG1dOEGP0AM81HMX5YvQCdCLyiEfSIxFCOGgYXWZnkKltwDbaa3JfLfHHD88tmogsG1XKHfSRPu4cZFaAW42zAgKHPI4zjLbg+B6SR40LPpJ3pzp4slmolU6d80+7oaXGohOy4L/ObBkHpwuFywgB7we0XyFtYML6WQweKujs5s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W22PPMk_1709891605;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W22PPMk_1709891605)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 17:53:27 +0800
Message-ID: <54e39ceb-834a-4f37-9dc3-7db84fa59927@linux.alibaba.com>
Date: Fri, 8 Mar 2024 17:53:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: make iov_iter describe target buffers over
 fscache
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20240308094159.40547-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240308094159.40547-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/8 17:41, Jingbo Xu wrote:
> So far the fscache mode supports uncompressed data only, and the data
> read from fscache is put directly into the target page cache.  As the
> support for compressed data in fscache mode is going to be introduced,
> rework the fscache internals so that the following compressed part
> could make the raw data read from fscache be directed to the target
> buffer it wants, decompress the raw data, and finally fill the page
> cache with the decompressed data.
> 
> As the first step, a new structure, i.e. erofs_fscache_io (io), is
> introduced to describe a generic read request from the fscache, while
> the caller can specify the target buffer it wants in the iov_iter
> structure (io->iter).  Besides, the caller can also specify its
> completion callback and private data through erofs_fscache_io, which
> will be called to make further handling, e.g. unlocking the page cache
> for uncompressed data or decompressing the read raw data, when the read
> request from the fscache completes.  Now erofs_fscache_read_io_async()
> serves as a generic interface for reading raw data from fscache for both
> compressed and uncompressed data.
> 
> The erofs_fscache_rq structure is kept to describe a request to fill the
> page cache in the specified range.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

As we discussed offline, for the whole series:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks for the work!

Thanks,
Gao Xiang

