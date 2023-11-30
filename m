Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D847FEB17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbjK3IqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjK3IqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:46:10 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E63A2;
        Thu, 30 Nov 2023 00:46:15 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SgqRN3BjGzMnZ8;
        Thu, 30 Nov 2023 16:41:20 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 Nov
 2023 16:46:12 +0800
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 03/14] page_pool: avoid
 calling no-op externals when possible
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-4-aleksander.lobakin@intel.com>
 <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
 <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
 <534e7752-38a9-3e7e-cb04-65789712fb66@huawei.com>
 <8c6d09be-78d0-436e-a5a6-b94fb094b0b3@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <4814a337-454b-d476-dabe-5035dd6dc51f@huawei.com>
Date:   Thu, 30 Nov 2023 16:46:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <8c6d09be-78d0-436e-a5a6-b94fb094b0b3@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/29 21:17, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Wed, 29 Nov 2023 11:17:50 +0800
> 
>> On 2023/11/27 22:32, Alexander Lobakin wrote:
>>>
>>> Chris, any thoughts on a global flag for skipping DMA syncs ladder?
>>
>> It seems there was one already in the past:
>>
>> https://lore.kernel.org/netdev/7c55a4d7-b4aa-25d4-1917-f6f355bd722e@arm.com/T/
> 
> It addresses a different problem, meaningless indirect calls, while this
> one addresses meaningless direct calls :>
> When the above gets merged, we could combine these two into one global,
> but Eric wasn't active with his patch and I remember there were some
> problems, so I wouldn't count on that it will arrive soon.

I went through the above patch, It seems to me that there was no
fundamental problem that stopping us from implementing it in the dma
layer basing on Eric' patch if Eric is no longer interested in working
on a newer version?

It is just that if we allow every subsystem and driver using dma API
doing their own trick of skipping dma sync, then there is less willing
to implement it in the dma layer.
