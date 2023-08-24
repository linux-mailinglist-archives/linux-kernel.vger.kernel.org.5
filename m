Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E3786D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbjHXLDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbjHXLC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB0B1FC6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692874905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5WrWsrLG6AaEOOJ9A9ov3qY439ojh9QoBEVAKqojw0Y=;
        b=hjeIRNIHvE0HLk+blrQwnWbMT4kAI6cT5fyBtn0/EHbgoG/tGgEVqm2Oxwi3iOw5T/cpft
        XYFCqHGMSdQAatX/tlPME3iEbWHjPkkwyqaRjSLuaz+EyeqES9Ek63Qs44z6BNCqljspxj
        vs4+Xc9Czsjn8x/cSRmfuHES9Q+Wn90=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364--NgilucDOYqzzHP9ObFssA-1; Thu, 24 Aug 2023 07:01:44 -0400
X-MC-Unique: -NgilucDOYqzzHP9ObFssA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5007f3d3293so5657173e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874902; x=1693479702;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WrWsrLG6AaEOOJ9A9ov3qY439ojh9QoBEVAKqojw0Y=;
        b=Ac9/sJdH2YwY9YNrc/R+t8x3TD1W/R5l+ruH1mmBF7YB3rZ7VtTFshIXn11U8l06+j
         vc9iIhYucrO6Q5fztv0Rjl58lwbnpayCmkw9/z7866TM4gVrXQFUMWi+L65hPl3lwDVC
         cJQJ6es8P2iSslkrkgT4e/6wyS/U9gSt81/iacLCOYpcQBjQ2Fr5DNvgvEy3h91/OV33
         ryKSd4hR80/uoN06B8VvDfrg4K6thlpqxWw8p5q1er3EjW7kOeMZ1QmOMcuzXHXx93Ez
         MnN9PF+xeyqcFvC67I0eOTtB5CJf15LHYR/5jBLwZNkxxVQyKmgOinbIpNWc56cfyuR3
         wY7Q==
X-Gm-Message-State: AOJu0YwHwG7aDwdrJGHqwZD7Bc3Qp+sMUBvC0B+6xgQULPN1Xa2cKWbo
        2I1l+j2rJ+DUlHS/uH3o7i+jC4Jx6Xj+NKEv2aLLz4uWLth47YBnZQS+KomXhldSrS9ubcIJfB/
        0dfjykjP6X6jxqqCmB8r/6GI9
X-Received: by 2002:a05:6512:689:b0:4fd:d64f:c0a6 with SMTP id t9-20020a056512068900b004fdd64fc0a6mr13373791lfe.48.1692874902595;
        Thu, 24 Aug 2023 04:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/8JSIpvwRmqUiTu7BKn1NEXo81ltu5VANojRzPX7O9gRwpDR1OYO6jocVlLCUqX3t2VYMrg==
X-Received: by 2002:a05:6512:689:b0:4fd:d64f:c0a6 with SMTP id t9-20020a056512068900b004fdd64fc0a6mr13373761lfe.48.1692874902091;
        Thu, 24 Aug 2023 04:01:42 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id d6-20020a05640208c600b0052a3ad836basm1995473edz.41.2023.08.24.04.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 04:01:41 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <131877ae-cb72-1bc2-350d-8a21c3b4e27a@redhat.com>
Date:   Thu, 24 Aug 2023 13:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     brouer@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
        sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        hawk@kernel.org, alexander.duyck@gmail.com,
        ilias.apalodimas@linaro.org, linyunsheng@huawei.com,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3 net] octeontx2-pf: fix page_pool creation fail for
 rings > 32k
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824030301.2525375-1-rkannoth@marvell.com>
In-Reply-To: <20230824030301.2525375-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/08/2023 05.03, Ratheesh Kannoth wrote:
> octeontx2 driver calls page_pool_create() during driver probe()
> and fails if queue size > 32k. Page pool infra uses these buffers
> as shock absorbers for burst traffic. These pages are pinned down
> over time as working sets varies, due to the recycling nature
> of page pool, given page pool (currently) don't have a shrinker
> mechanism, the pages remain pinned down in ptr_ring.
> Instead of clamping page_pool size to 32k at
> most, limit it even more to 2k to avoid wasting memory.
> 
> This have been tested on octeontx2 CN10KA hardware.
> TCP and UDP tests using iperf shows no performance regressions.
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---

Again

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> ChangeLogs:
> 
> v2->v3: Fix macro aligment and header file changes suggested by
> 	Alexander Lobakin
> v1->v2: Commit message changes and typo fixes
> v0->v1: Commit message changes.
> ---
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h   | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 77c8f650f7ac..3e1c70c74622 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1432,7 +1432,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>   	}
>   
>   	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
> -	pp_params.pool_size = numptrs;
> +	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
>   	pp_params.nid = NUMA_NO_NODE;
>   	pp_params.dev = pfvf->dev;
>   	pp_params.dma_dir = DMA_FROM_DEVICE;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
> index b5d689eeff80..9e3bfbe5c480 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
> @@ -23,6 +23,8 @@
>   #define	OTX2_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN)
>   #define	OTX2_MIN_MTU		60
>   
> +#define OTX2_PAGE_POOL_SZ	2048
> +
>   #define OTX2_MAX_GSO_SEGS	255
>   #define OTX2_MAX_FRAGS_IN_SQE	9
>   

