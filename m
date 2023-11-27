Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854B37FA8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjK0SRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjK0SRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:17:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F1B194
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:17:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F6DC433C7;
        Mon, 27 Nov 2023 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701109041;
        bh=Kq8G4186oIvvG0OGelsVcM8Ma8D3c+DoqPy0UYxMLWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QG6ONPukVchwWErAMLaSIt1BRLdfpyvDFYvlAneifGBLLwxrgc9YT9DQUv+jORVZl
         Wv2eJmxqdYpysNKvq88faMBlo509G9gLB4g5hMFATiV5ip1MamKARiU7ZI0QrcJzby
         iBOmDkhn7cftAcy9e+M8XNePHSRWBpEgAucP8J5IOYslJywc08DLve2OOYLOKSUH9D
         dXV4vYiNlS555n5f3WzGRnn8Lj7S9VnIkJT3TNd8k8d8Wd2AEfeoacY5qE0wwD7bxj
         3zEqW/QBr4UsSEFa3hQSNHvf5Db9My2Ez9GHfnaqmQhtAynL/Th6EhJQ2Mwo2LLnyA
         KeVCUsFW2DZRA==
Date:   Mon, 27 Nov 2023 10:17:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 03/14] page_pool: avoid calling no-op
 externals when possible
Message-ID: <20231127101720.282862f6@kernel.org>
In-Reply-To: <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
        <20231124154732.1623518-4-aleksander.lobakin@intel.com>
        <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
        <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 15:32:19 +0100 Alexander Lobakin wrote:
> > Sorry for not remembering the suggestion:(  
> 
> In the previous versions of this change I used a global flag per whole
> page_pool, just like XSk does for the whole XSk buff pool, then you
> proposed to use the lowest bit of ::dma_addr and store it per page, so
> that it would be more granular/precise. I tested it and it doesn't
> perform worse than global, but in some cases may be beneficial.

FWIW I'd vote to stick to per-page pool. You seem to handle the
sizeof(dma_addr_t) > sizeof(long) case correctly but the code is
growing in complexity, providing no known/measurable benefit.
We can always do this later but for now it seems like a premature
optimization to me.
