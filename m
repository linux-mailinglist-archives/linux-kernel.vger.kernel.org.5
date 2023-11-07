Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A437E38A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjKGKQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjKGKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:16:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13409ED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:16:49 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SPkf02dH9zfZxn;
        Tue,  7 Nov 2023 18:16:40 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 18:16:00 +0800
Message-ID: <d3a50c46-93c9-4b60-8609-9465e1605f77@huawei.com>
Date:   Tue, 7 Nov 2023 18:16:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next,V2] fscache: support to disable assert macro
To:     <dhowells@redhat.com>
CC:     <linux-cachefs@redhat.com>, <linux-kernel@vger.kernel.org>,
        <yangerkun@huawei.com>, <hsiangkao@linux.alibaba.com>
References: <20231101163414.2105727-1-wozizhi@huawei.com>
From:   Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20231101163414.2105727-1-wozizhi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping

在 2023/11/2 0:34, WoZ1zh1 写道:
> In fs/fscache/internal.h, ASSERT macro is enabled by default and can not
> be disabled, then assert failure will crash the kernel as the BUG() is
> included in the ASSERT macro. Therefore, add FSCACHE_ASSERT to control it.
>
> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
> ---
>   fs/fscache/Kconfig    | 10 ++++++++++
>   fs/fscache/internal.h |  2 +-
>   2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
> index b313a978ae0a..7ff844038bc3 100644
> --- a/fs/fscache/Kconfig
> +++ b/fs/fscache/Kconfig
> @@ -38,3 +38,13 @@ config FSCACHE_DEBUG
>   	  enabled by setting bits in /sys/modules/fscache/parameter/debug.
>   
>   	  See Documentation/filesystems/caching/fscache.rst for more information.
> +
> +config FSCACHE_ASSERT
> +	bool "FSCACHE asserts"
> +	default n
> +	depends on FSCACHE
> +	help
> +	  Support the ASSERT mode for failure behavior.
> +	  Say N here to disable the ASSERT by default.
> +	  Say Y to add assertion checks in some places. But the assertion
> +	  failure will result in fatal errors that BUG() the kernel.
> diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
> index 1336f517e9b1..951166ed772f 100644
> --- a/fs/fscache/internal.h
> +++ b/fs/fscache/internal.h
> @@ -225,7 +225,7 @@ do {						\
>   /*
>    * assertions
>    */
> -#if 1 /* defined(__KDEBUGALL) */
> +#ifdef CONFIG_FSCACHE_ASSERT
>   
>   #define ASSERT(X)							\
>   do {									\
