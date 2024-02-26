Return-Path: <linux-kernel+bounces-80403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCDC866814
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477312819EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B75414F70;
	Mon, 26 Feb 2024 02:13:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15C14A85
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913607; cv=none; b=ccuZQAkxTKJSsLHWWo1+yzDddL7GTole5vswLq2qNbCLBBtI+Vxo1pe2QFREGnKM0OTV3wOn/+hShuNDWOPyaYaoHUpSxEtMgRp89kTY8GLPMd1zHMNTKLdqDYtrAYDPHBwtOFNksrSuwbyzrltIT4YEHrtYzOvVjgDMOLgyC58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913607; c=relaxed/simple;
	bh=A2/uoLowPnARdXuuFm2lFhFcljWmp7TOh3DBia2TOmg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ckdFah6uRvGLQsmFV3g1E89pFJ/X0RzGluqexIDC4dmOk9z+uaj6w8whDkAyEJxzyacdXgHbMUaNqQteBPEbI6AGfPcqnbhwxT8enIV24JlveXmAfHFxcyO6/+GQl6nEJUHbFo7mRgwp4E8lP5tSkO5cGJfKF3Skb7crtT8OqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TjkcR3ff3z1h0bh;
	Mon, 26 Feb 2024 10:11:03 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 40B391A0178;
	Mon, 26 Feb 2024 10:13:16 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 10:13:14 +0800
Subject: Re: [PATCH] jffs2: remove SLAB_MEM_SPREAD flag usage
To: <chengming.zhou@linux.dev>, <dwmw2@infradead.org>, <richard@nod.at>,
	<jack@suse.cz>, <chuck.lever@oracle.com>, <dave.kleikamp@oracle.com>,
	<amir73il@gmail.com>
CC: <zhouchengming@bytedance.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <vbabka@suse.cz>,
	<roman.gushchin@linux.dev>, <Xiongwei.Song@windriver.com>
References: <20240224134915.829634-1-chengming.zhou@linux.dev>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <dac3e4b6-2915-7d77-f5d4-4ba8d510d952@huawei.com>
Date: Mon, 26 Feb 2024 10:13:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240224134915.829634-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/2/24 21:49, chengming.zhou@linux.dev Ð´µÀ:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>   fs/jffs2/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index f99591a634b4..aede1be4dc0c 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -387,7 +387,7 @@ static int __init init_jffs2_fs(void)
>   	jffs2_inode_cachep = kmem_cache_create("jffs2_i",
>   					     sizeof(struct jffs2_inode_info),
>   					     0, (SLAB_RECLAIM_ACCOUNT|
> -						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +						SLAB_ACCOUNT),
>   					     jffs2_i_init_once);
>   	if (!jffs2_inode_cachep) {
>   		pr_err("error: Failed to initialise inode cache\n");
> 


