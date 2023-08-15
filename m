Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E977C980
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjHOImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjHOIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630010F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92B7A617E6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA94FC433C7;
        Tue, 15 Aug 2023 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692088916;
        bh=WqQoOnB/jc8Ton23ktHqTDSvzOIg7daMCkV5SRI4gPM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=KegzqopzoNJ3z0MXzToUFtlYs73e60whma4YHay7nEuhv6CqbmvVEVZsYukjEo0k1
         3oiwWcBeKrx4SVHyPvTgnCNI+SKL4KvBa7Q5T0l1g+86y5f10LccrcSSrKnMzcEmZ2
         i242c7r5Zig+XQNiqYIpZquKDc4U43oJrsyhm/FX31sQ00rwAYJC9tOQZWuS3Tjc8L
         1fVYK/u0kvv2XrDj8ajBqGKc2A5J+OKISGVDYEmvRgKJlzkHNZXAT44RbkyUAhqInY
         PNlqiXsYQ3bPAYEBElAEoaXyoP6+O2b1iqklhrw4wnY7Kafj6nEW2pZ1l0CClausIm
         skkqbr0EyhcrQ==
Message-ID: <110797fb-fea6-cb4d-af3c-4665e8246479@kernel.org>
Date:   Tue, 15 Aug 2023 10:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     kuba@kernel.org, pabeni@redhat.cm, edumazet@google.com,
        aleksander.lobakin@intel.com, hawk@kernel.org,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com
Subject: Re: [PATCH v1 net] octeontx2-pf: fix page_pool creation fail for
 rings > 32k
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230814132411.2475687-1-rkannoth@marvell.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230814132411.2475687-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/2023 15.24, Ratheesh Kannoth wrote:
> octeontx2 driver calls page_pool_create() during driver probe()
> and fails if queue size > 32k. Page pool infra uses these buffers
> as shock absorbers for burst traffic. These pages are pinned
> down as soon as page pool is created. 

It isn't true that "pages are pinned down as soon as page pool is created".
We need to improve this commit text.
My suggestion:

  These pages are pinned down over time as working sets varies, due to
  the recycling nature of page pool, given page pool (currently) don't
  have a shrinker mechanism, the pages remain pinned down in ptr_ring.

> As page pool does direct
> recycling way more aggressivelyi, often times ptr_ring is left
                                  ^
Typo
(my suggestion already covers recycling)

> unused at all. Instead of clamping page_pool size to 32k at
> most, limit it even more to 2k to avoid wasting memory on much
> less used ptr_ring.

I would adjust and delete "much less used".

I assume you have the octeontx2 hardware available (which I don't).
Can you test that this adjustment to 2k doesn't cause a performance
regression on your hardware?
And then produce a statement in the commit desc like:

  This have been tested on octeontx2 hardware (devel board xyz).
  TCP and UDP tests using netperf shows not performance regressions.


2K with page_size 4KiB is around 8MiB if PP gets full.

It would be convincing if commit message said e.g. PP pool_size 2k can
maximum pin down 8MiB per RX-queue (assuming page size 4K), but that is
okay as systems using octeontx2 hardware often have many GB of memory.

> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> 
> ChangeLogs:
> 
> v0->v1: Commit message changes.
> ---
> ---
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 77c8f650f7ac..fc8a1220eb39 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1432,7 +1432,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>   	}
>   
>   	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
> -	pp_params.pool_size = numptrs;
> +	pp_params.pool_size = OTX2_PAGE_POOL_SZ;
>   	pp_params.nid = NUMA_NO_NODE;
>   	pp_params.dev = pfvf->dev;
>   	pp_params.dma_dir = DMA_FROM_DEVICE;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index ba8091131ec0..f6fea43617ff 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -30,6 +30,8 @@
>   #include <rvu_trace.h>
>   #include "qos.h"
>   
> +#define OTX2_PAGE_POOL_SZ 2048
> +
>   /* IPv4 flag more fragment bit */
>   #define IPV4_FLAG_MORE				0x20
>   
