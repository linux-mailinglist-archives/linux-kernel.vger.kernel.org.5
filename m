Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB58177CEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbjHOPNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbjHOPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:13:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091121991;
        Tue, 15 Aug 2023 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3FVkfmimyGLe7ZQLw14Bh2D/6Fym3SH8k3h8yeiqRQU=; b=gmRUb9WNZ1BobTGE+WroBYMCGl
        VnvndwBnm8gMluT/dcWJcPsQAD6bVncAtBXWdu7gVyMZhWErV/7upSyu62pyq2QmzlFetaQpEnh2M
        UAb8l/5UoZkiUgaDvFfMjP1txW3ONUpohtdTUOj2IjbVjNAKiTqSls1orWH2rWDgiBtlpTidb38tr
        Sfm7/fYiBxZBX6F2CE3zRq4QPl/LOKga/QCiqtVXwh15V/rVBINul+ZkaL9ZpWYH6IHhMb/rirGkS
        V+I80XXGzu0dK1J6H1hWm1wG+n9pY2Z6MLNFBcyoeXBX7t3b1e10ibPoVQNVnOrrOkMxMoSAXPxi6
        TabqlluQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVviz-001pNO-13;
        Tue, 15 Aug 2023 15:12:49 +0000
Message-ID: <c52210ab-48a5-d6bf-26ee-b828df0f9408@infradead.org>
Date:   Tue, 15 Aug 2023 08:12:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v6 5/6] page_pool: update document about frag API
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-6-linyunsheng@huawei.com>
 <479a9c1f-9db7-61c8-3485-9b330f777930@infradead.org>
 <0cbf592e-2f21-30ca-799e-5cc15e89c3f8@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0cbf592e-2f21-30ca-799e-5cc15e89c3f8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/23 05:24, Yunsheng Lin wrote:
> On 2023/8/15 6:42, Randy Dunlap wrote:
>> Hi--
> Thanks for the reviewing.
> 
> ...
> 
>>> @@ -100,6 +115,14 @@ static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
>>>       return __page_pool_alloc_frag(pool, offset, size, gfp);
>>>   }
>>>   +/**
>>> + * page_pool_dev_alloc_frag() - allocate a page frag.
>>> + * @pool[in]    pool from which to allocate
>>> + * @offset[out]    offset to the allocated page
>>> + * @size[in]    requested size
>> Please use kernel-doc syntax/notation here.
> Will change to:

Thanks. Those look good.

-- 
~Randy
