Return-Path: <linux-kernel+bounces-153173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A338ACA91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2868D1F21AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4D1420B6;
	Mon, 22 Apr 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PcF2evvv"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC7140E2F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781534; cv=none; b=DDq19SBEHs9UKki98FuzaKK8mf9KrzWD4Ud55/mTHoE3tBvJa16zth3TlDnmUR3h0hsGC/IA32NXcfh8d57wj3an3BDhrXWTYep6DYHsC6pcmxmQ3Qu1xXUza18i9jeaWKnYL88UdRcj0jxGaOYAOzt9X2KUvUv9+QZaJW31qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781534; c=relaxed/simple;
	bh=jWmT5lxfQifexFCNNjVJXfUlsC5ZHfg49HTAwaoia34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GazWfWYAXfNls9emaGwthGRvW8TTuWt18O9WJn7Aq9gcGUA2P3hvc5ClHiK+Mq3B4Zw7iKlqfortF9D6Mmay+hsF9EuXlHVugDWlsvW+hdQnNA5fY2xTXBqNIIkgJJPMBRckUmIQbzBD/0Orpoq8mT+XUVtdN00OT/LhzBIQBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PcF2evvv; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713781529; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TvioAWeIxSSIl9wCtF/pXYCI+u21pfzAVY3/7/ShKE8=;
	b=PcF2evvvCfH5a6NBMW4AOknxdJZPAxRlzaAMBE6J1u9KAQB1CysKLljV+FwIIHM6gfbwup0WXXEGOwAAsMmg/ZOZ/1R4QixKRZoWIAMhHcZmw3kSCf8e6LMrnhUUfph/HmytKkMjTt5I7zV6EYa1W7C6NtbgmvjJt+0aR1ytomI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W51vfY7_1713781527;
Received: from 30.221.150.42(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W51vfY7_1713781527)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 18:25:28 +0800
Message-ID: <8d751a33-af11-4aa8-8fad-cc24e825bde7@linux.alibaba.com>
Date: Mon, 22 Apr 2024 18:25:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/2] erofs: get rid of erofs_fs_context
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-2-libaokun1@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240419123611.947084-2-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/19/24 8:36 PM, Baokun Li wrote:

> @@ -761,12 +747,15 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
>  
>  static void erofs_fc_free(struct fs_context *fc)
>  {
> -	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
> +
> +	if (!sbi)
> +		return;


This is the only difference comparing to the original code literally.
Is there any chance that fc->s_fs_info can be NULL when erofs_fc_free()
is called?

Otherwise looks good to me.



-- 
Thanks,
Jingbo

