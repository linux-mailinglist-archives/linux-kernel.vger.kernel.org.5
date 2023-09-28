Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2C87B1BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjI1MRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjI1MRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:17:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00409180;
        Thu, 28 Sep 2023 05:16:52 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RxC8T5gKYz15NRK;
        Thu, 28 Sep 2023 20:14:33 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 20:16:50 +0800
Subject: Re: [PATCH net] octeontx2-pf: Fix page pool frag allocation failure.
To:     Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <hawk@kernel.org>, <alexander.duyck@gmail.com>,
        <ilias.apalodimas@linaro.org>, <bigeasy@linutronix.de>
References: <20230928025236.3051774-1-rkannoth@marvell.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <171ff520-e716-0e98-85d2-837181e8d8dc@huawei.com>
Date:   Thu, 28 Sep 2023 20:16:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230928025236.3051774-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/28 10:52, Ratheesh Kannoth wrote:
> Since page pool param's "order" is set to 0, will result
> in below crash if interface is configured higher rx buffer
> length.

If I understand it correctly, it is not a crash, but a warning
as the requsted size is bigger than PAGE_SIZE for order 0, so
the below checking triggered the warning, right?

https://elixir.bootlin.com/linux/v6.6-rc2/source/net/core/page_pool.c#L748

> 
> Steps to reproduce the issue.
> 1. devlink dev param set pci/0002:04:00.0 name receive_buffer_size \
>    value 8196 cmode runtime
> 2. ifconfig eth0 up
> 
> [   19.901356] ------------[ cut here ]------------
> [   19.901361] WARNING: CPU: 11 PID: 12331 at net/core/page_pool.c:567 page_pool_alloc_frag+0x3c/0x230
> [   19.901449] pstate: 82401009 (Nzcv daif +PAN -UAO +TCO -DIT +SSBS BTYPE=--)
> [   19.901451] pc : page_pool_alloc_frag+0x3c/0x230
> [   19.901453] lr : __otx2_alloc_rbuf+0x60/0xbc [rvu_nicpf]
> [   19.901460] sp : ffff80000f66b970
> [   19.901461] x29: ffff80000f66b970 x28: 0000000000000000 x27: 0000000000000000
> [   19.901464] x26: ffff800000d15b68 x25: ffff000195b5c080 x24: ffff0002a5a32dc0
> [   19.901467] x23: ffff0001063c0878 x22: 0000000000000100 x21: 0000000000000000
> [   19.901469] x20: 0000000000000000 x19: ffff00016f781000 x18: 0000000000000000
> [   19.901472] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   19.901474] x14: 0000000000000000 x13: ffff0005ffdc9c80 x12: 0000000000000000
> [   19.901477] x11: ffff800009119a38 x10: 4c6ef2e3ba300519 x9 : ffff800000d13844
> [   19.901479] x8 : ffff0002a5a33cc8 x7 : 0000000000000030 x6 : 0000000000000030
> [   19.901482] x5 : 0000000000000005 x4 : 0000000000000000 x3 : 0000000000000a20
> [   19.901484] x2 : 0000000000001080 x1 : ffff80000f66b9d4 x0 : 0000000000001000
> [   19.901487] Call trace:
> [   19.901488]  page_pool_alloc_frag+0x3c/0x230
> [   19.901490]  __otx2_alloc_rbuf+0x60/0xbc [rvu_nicpf]
> [   19.901494]  otx2_rq_aura_pool_init+0x1c4/0x240 [rvu_nicpf]
> [   19.901498]  otx2_open+0x228/0xa70 [rvu_nicpf]
> [   19.901501]  otx2vf_open+0x20/0xd0 [rvu_nicvf]
> [   19.901504]  __dev_open+0x114/0x1d0
> [   19.901507]  __dev_change_flags+0x194/0x210
> [   19.901510]  dev_change_flags+0x2c/0x70
> [   19.901512]  devinet_ioctl+0x3a4/0x6c4
> [   19.901515]  inet_ioctl+0x228/0x240
> [   19.901518]  sock_ioctl+0x2ac/0x480
> [   19.901522]  __arm64_sys_ioctl+0x564/0xe50
> [   19.901525]  invoke_syscall.constprop.0+0x58/0xf0
> [   19.901529]  do_el0_svc+0x58/0x150
> [   19.901531]  el0_svc+0x30/0x140
> [   19.901533]  el0t_64_sync_handler+0xe8/0x114
> [   19.901535]  el0t_64_sync+0x1a0/0x1a4
> [   19.901537] ---[ end trace 678c0bf660ad8116 ]---
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 997fedac3a98..78a4547e7001 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1357,7 +1357,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>  	struct page_pool_params pp_params = { 0 };
>  	struct npa_aq_enq_req *aq;
>  	struct otx2_pool *pool;
> -	int err;
> +	int err, sz;
>  
>  	pool = &pfvf->qset.pool[pool_id];
>  	/* Alloc memory for stack which is used to store buffer pointers */
> @@ -1403,6 +1403,8 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>  		return 0;
>  	}
>  
> +	sz = ALIGN(ALIGN(SKB_DATA_ALIGN(buf_size), OTX2_ALIGN), PAGE_SIZE);
> +	pp_params.order = (sz / PAGE_SIZE) - 1;

Perhaps use PAGE_ALIGN() and get_order() for the above?

>  	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
>  	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
>  	pp_params.nid = NUMA_NO_NODE;
> 
