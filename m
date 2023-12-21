Return-Path: <linux-kernel+bounces-7960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038881AFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4146B23A99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01168156E1;
	Thu, 21 Dec 2023 07:46:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74C156C3;
	Thu, 21 Dec 2023 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SwjCR6mPNz1wp7V;
	Thu, 21 Dec 2023 15:45:39 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 812C414011B;
	Thu, 21 Dec 2023 15:45:55 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Thu, 21 Dec
 2023 15:45:54 +0800
Date: Thu, 21 Dec 2023 15:45:43 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Andrew Morton <akpm@linux-foundation.org>, Changbin Du
	<changbin.du@huawei.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20231221074543.ahl6zmvmkgw7i52k@M910t>
References: <20231221183803.1dd342aa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231221183803.1dd342aa@canb.auug.org.au>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100002.china.huawei.com (7.221.188.184)

Hi, Rothwell,
Please hold this patch. It need more discussion and probably the flush can be
simply removed.

On Thu, Dec 21, 2023 at 06:38:03PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (x86_64 allnoconfig)
> failed like this:
> 
> x86_64-linux-gnu-ld: init/main.o: in function `kernel_init':
> main.c:(.ref.text+0xbf): undefined reference to `flush_module_init_free_work'
> 
> Caused by commit
> 
>   1d8053432676 ("modules: wait do_free_init correctly")
> 
> This build has
> # CONFIG_MODULES is not set
> 
> I have applied this (hack) patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 21 Dec 2023 18:27:07 +1100
> Subject: [PATCH] fix up for "modules: wait do_free_init correctly"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  init/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index f0b7e21ac67f..1df1106ff09b 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1407,7 +1407,9 @@ static void mark_readonly(void)
>  		 * flushed so that we don't hit false positives looking for
>  		 * insecure pages which are W+X.
>  		 */
> +#ifdef CONFIG_MODULES
>  		flush_module_init_free_work();
> +#endif
>  		mark_rodata_ro();
>  		rodata_test();
>  	} else
> -- 
> 2.43.0
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Cheers,
Changbin Du

