Return-Path: <linux-kernel+bounces-142076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E176A8A2721
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF8A1C20FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0A247A48;
	Fri, 12 Apr 2024 06:53:07 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4D4652F;
	Fri, 12 Apr 2024 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904787; cv=none; b=fm8HqKp7EoQGv1DGCL/WJLSvdnMPZMWomR4oGI4WBtJXGR8jWwtYgDrVMy+prUfAF9KwAZ08t8exEiBSp7/T2OVC8P1nZSWaEwgcrctdfRrVcA6UhFyGw/t4oNtAP+UpCjO56AxQiI76/YlqE3b8KI5n4C8JnEJ5OpWEwZtL5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904787; c=relaxed/simple;
	bh=MJwKbK7opNn0X+MjquHdBM5/uyL6GuSmDDNRq43NiLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XawMgbJ34vVK4mhGb4gSfSkwNndzqwPv0eMyMOOIFnOdY7aKlGuqVRDlQOoxfjtiADI5SY/2/Yw7UyqD6OtwIZEvXh1li7LJ4lPeGzDHFvNt4koONv8G31gEyRqWDPrEJF0SQ9zzWpvjJ1CJhtHk0189KVbZsSGoN6CCu3Z0TuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VG6gd2Y6Rz1xmRx;
	Fri, 12 Apr 2024 14:52:13 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F71D18001A;
	Fri, 12 Apr 2024 14:53:01 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 14:53:01 +0800
Message-ID: <9ed2e6d6-186c-4b89-9c07-4b004de6bf23@huawei.com>
Date: Fri, 12 Apr 2024 14:53:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bcachefs: fix error path of __bch2_read_super()
Content-Language: en-US
To: Chao Yu <chao@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
CC: <linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240412063638.2068524-1-chao@kernel.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240412063638.2068524-1-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

On 2024/4/12 14:36, Chao Yu wrote:
> In __bch2_read_super(), if kstrdup() fails, it needs to release memory
> in sb->holder, fix to call bch2_free_super() in the error path.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - add error message in error path pointed out by Hongbo Li.
>   fs/bcachefs/super-io.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
> index ad28e370b640..cc80d7d30b8c 100644
> --- a/fs/bcachefs/super-io.c
> +++ b/fs/bcachefs/super-io.c
> @@ -698,8 +698,11 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
>   		return -ENOMEM;
>   
>   	sb->sb_name = kstrdup(path, GFP_KERNEL);
> -	if (!sb->sb_name)
> -		return -ENOMEM;
> +	if (!sb->sb_name) {
> +		ret = -ENOMEM;
> +		prt_printf(&err, "error allocating memory for sb_name");
> +		goto err;
> +	}
>   
>   #ifndef __KERNEL__
>   	if (opt_get(*opts, direct_io) == false)

