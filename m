Return-Path: <linux-kernel+bounces-90074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267886F9D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2B02811E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29623BE68;
	Mon,  4 Mar 2024 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h0PmJG41"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E324B666
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709532284; cv=none; b=OFq1iYZReSQardUoEdsv/NG4YHPPf/BPD3BEvVt/QfkP/1uFLlOtOlYrwFzL3vPECzAQMcy0MsQSAR641/q6aMwvie0yH9iMQja4Ltoat527fpNBw8eOvTsrPo03ziFVhct5bm0u9jkIz3S143emh+KwN3dYyyxjwsbPUHNNJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709532284; c=relaxed/simple;
	bh=j1N9CytCpZ1A/5cEBov9dniiOXlJSyDrvcVElBK+Qsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsCoffC4SxHkbrJRKbG7mqhYNiY6DdDMPLfj2Ag3vufat8+8SeYixEFl1er/RAUYlXLuWKh1QQDjQiFkAqGqzeBvAjnGTSjV6cQiQevXtKgH+F5ZVAVqUc3XzkhfZB9/kGEg4MK2/A0aODKNucNYEbxNXv9R3CGp+FL12+TSP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h0PmJG41; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709532272; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ADibi9+LqS/ZbdWl7A42/kCs0BgntDzko1HwYihHMqE=;
	b=h0PmJG41RmFR1ERwxj1z1jfJT8PZw9L4jEqqTH9c4QF7QzVUKeUNRHBtVWUfFd3qaGmVso5Mes8/pcLIA9Wp0jyUB6i0qRDB6RdCwMULGPO6hJ6XRPGIq46aVDI8AMs3bXeTrbNzt0D6bbVom33i8WoaaXgwDEB3oaYJK1CVvJ4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1jQ1i1_1709532271;
Received: from 30.97.48.196(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1jQ1i1_1709532271)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 14:04:32 +0800
Message-ID: <dfd05ad0-1dae-4121-abba-59b55ad22c99@linux.alibaba.com>
Date: Mon, 4 Mar 2024 14:04:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
To: linux-erofs@lists.ozlabs.org, syzkaller-bugs@googlegroups.com
Cc: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 LKML <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
 <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

On 2024/3/4 11:53, Gao Xiang wrote:
> syzbot reports a KMSAN reproducer [1] which generates a crafted
> filesystem image and causes IMA to read uninitialized page cache.
> 
> Later, (rq->outputsize > rq->inputsize) will be formally supported
> after either large uncompressed pclusters (> block size) or big
> lclusters are landed.  However, currently there is no way to generate
> such filesystems by using mkfs.erofs.
> 
> Thus, let's mark this condition as unsupported for now.
> 
> [1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com
> 
> Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
> Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-page block support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/decompressor.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d4cee95af14c..2ec9b2bb628d 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -323,7 +323,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
>   	u8 *kin;
>   
> -	DBG_BUGON(rq->outputsize > rq->inputsize);
> +	if (rq->outputsize > rq->inputsize)
> +		return -EOPNOTSUPP;
>   	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
>   		cur = bs - (rq->pageofs_out & (bs - 1));
>   		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;

