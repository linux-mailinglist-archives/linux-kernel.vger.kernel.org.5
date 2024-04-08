Return-Path: <linux-kernel+bounces-135982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A13789CE8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA250B21B99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D029CEB;
	Mon,  8 Apr 2024 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LOYpK2w1"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C0D171B0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616528; cv=none; b=o3MpIVaG9bF2eg2FCGdXUeENzgE1lCzUGGPd3p+jpKUlBrIjuUk7oJTVTZZoe/6fdm3puWehQEimMxij8n3XNEW0radKcB28YrE/9kAdfwJAx6IHUQHIWMgVrrsybXK7j4zpsINF+cDROXakHw7gyA40mEKmfSx8FLEecXbHIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616528; c=relaxed/simple;
	bh=RRWWx01pPfJbdFi3MWVf0eOueg30+ChmYzjuX0MhCRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpzVdWAos/0MHR4cO5saIyFZuK3VaGh6+tEGmwxijIamoBpKRF2FNS2XIodkhmVBeCeClog+mBqZBIyg84muE0hHXz8psqxl5J20VggiuXvIgIkGBJf95sYUXfv/TW/fy1scIAxpFRFPDVg6dLxDul/0xBzXYQfrL7+czZFPmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LOYpK2w1; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712616523; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nz3YIIIQmU8yWVDXM1ZV8xt6EYuCL7CXXu2zWkKWpgo=;
	b=LOYpK2w1Y3YxK3id5xrc5JL/9ncb6O5LUO6dPO5/v2epvhGUwwpMv3IN/0QvGxi5MRPVtSw0CpFSJESdW8zRHZ4v11gFdwQJQsyszkO6bLqTBnCAOzgDaTeTD/iC5SoGgDkzqPyQIDE4ll30QlW2+MBkFKAzgKdnHsEu2cLORy8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W4CNr.I_1712616521;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4CNr.I_1712616521)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 06:48:42 +0800
Message-ID: <3b3d0b99-f7b5-4dcc-a631-1018f4025acf@linux.alibaba.com>
Date: Tue, 9 Apr 2024 06:48:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: use raw_smp_processor_id() to get buffer from
 global buffer pool
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org,
 syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20240408215231.3376659-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240408215231.3376659-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sandeep,

On 2024/4/9 05:52, Sandeep Dhavale wrote:
> erofs will decompress in the preemptible context (kworker or per cpu
> thread). As smp_processor_id() cannot be used in preemptible contexts,
> use raw_smp_processor_id() instead to index into global buffer pool.
> 
> Reported-by: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com
> Fixes: 7a7513292cc6 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Thanks for catching this, since the original patch is
for next upstream cycle, may I fold this fix in the
original patch?

I will add your credit into the original patch.

Thanks,
Gao Xiang

> ---
>   fs/erofs/zutil.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index b9b99158bb4e..036024bce9f7 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -30,7 +30,7 @@ static struct shrinker *erofs_shrinker_info;
>   
>   static unsigned int z_erofs_gbuf_id(void)
>   {
> -	return smp_processor_id() % z_erofs_gbuf_count;
> +	return raw_smp_processor_id() % z_erofs_gbuf_count;
>   }
>   
>   void *z_erofs_get_gbuf(unsigned int requiredpages)

