Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54176FF20
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjHDK7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjHDK7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:59:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE4E70;
        Fri,  4 Aug 2023 03:57:52 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RHN091dvgz1Z1Sd;
        Fri,  4 Aug 2023 18:55:05 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 18:57:49 +0800
Message-ID: <a59cb5df-ad95-61d8-b93c-ca993651f82f@huawei.com>
Date:   Fri, 4 Aug 2023 18:57:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] romfs: only select BUFFER_HEAD for the block based path
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20230804102648.78683-1-hch@infradead.org>
From:   Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20230804102648.78683-1-hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.176]
X-ClientProxiedBy: dggpeml100021.china.huawei.com (7.185.36.148) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2023/8/4 18:26, Christoph Hellwig wrote:
> selecting BUFFER_HEAD unconditionally does not work as romfs can also
> be built with only the MTD backend and thus without CONFIG_BLOCK.
> 
> Fixes: 0f842210d97a ("fs/Kconfig: Fix compile error for romfs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/romfs/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/romfs/Kconfig b/fs/romfs/Kconfig
> index 3f6b550eee6192..f24a96a331af1b 100644
> --- a/fs/romfs/Kconfig
> +++ b/fs/romfs/Kconfig
> @@ -2,7 +2,6 @@
>   config ROMFS_FS
>   	tristate "ROM file system support"
>   	depends on BLOCK || MTD
> -	select BUFFER_HEAD
>   	help
>   	  This is a very small read-only file system mainly intended for
>   	  initial ram disks of installation disks, but it could be used for
> @@ -58,6 +57,7 @@ endchoice
>   config ROMFS_ON_BLOCK
>   	bool
>   	default y if ROMFS_BACKED_BY_BLOCK || ROMFS_BACKED_BY_BOTH
> +	select BUFFER_HEAD
>   
>   config ROMFS_ON_MTD
>   	bool

I have tested the patch on my environment and it resolves the two 
compile errors reported by kernel test robot. The links are as follows:

Link1: 
https://lore.kernel.org/oe-kbuild-all/202308031810.pQzGmR1v-lkp@intel.com/
Link2: 
https://lore.kernel.org/oe-kbuild-all/202308041329.6SK97Asr-lkp@intel.com/

Tested-by: Li Zetao <lizetao1@huawei.com>

Thanks,
Li Zetao
