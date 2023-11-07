Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED97E38AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjKGKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjKGKRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:17:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D28DB7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:17:35 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SPkZD3HvzzPnlj;
        Tue,  7 Nov 2023 18:13:24 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 18:17:02 +0800
Message-ID: <029f5c1c-6251-4112-8ce0-ef3d46596089@huawei.com>
Date:   Tue, 7 Nov 2023 18:17:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next,V2] cachefiles: support to disable assert macro
To:     <dhowells@redhat.com>
CC:     <linux-cachefs@redhat.com>, <linux-kernel@vger.kernel.org>,
        <yangerkun@huawei.com>, <hsiangkao@linux.alibaba.com>
References: <20231101163431.2108688-1-wozizhi@huawei.com>
From:   Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20231101163431.2108688-1-wozizhi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping

在 2023/11/2 0:34, WoZ1zh1 写道:
> In fs/cachefiles/internal.h, ASSERT macro is enabled by default and can
> not be disabled, then assert failure will crash the kernel as the BUG()
> is included in the ASSERT macro. Therefore, add CACHEFILES_ASSERT to
> control it.
>
> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
> ---
>   fs/cachefiles/Kconfig    | 11 +++++++++++
>   fs/cachefiles/internal.h |  2 +-
>   2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
> index 8df715640a48..83d8ec3ba2d8 100644
> --- a/fs/cachefiles/Kconfig
> +++ b/fs/cachefiles/Kconfig
> @@ -38,3 +38,14 @@ config CACHEFILES_ONDEMAND
>   	  and is delegated to userspace.
>   
>   	  If unsure, say N.
> +
> +config CACHEFILES_ASSERT
> +	bool "CACHEFILES asserts"
> +	default n
> +	depends on CACHEFILES
> +	help
> +	  Support the ASSERT mode for failure behavior.
> +	  Say N here to disable the ASSERT by default.
> +	  Say Y to add assertion checks in some places. But the assertion
> +	  failure will result in fatal errors that BUG() the kernel.
> +
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 2ad58c465208..263b1f13e943 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -425,7 +425,7 @@ do {							\
>   #define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
>   #endif
>   
> -#if 1 /* defined(__KDEBUGALL) */
> +#ifdef CONFIG_CACHEFILES_ASSERT
>   
>   #define ASSERT(X)							\
>   do {									\
