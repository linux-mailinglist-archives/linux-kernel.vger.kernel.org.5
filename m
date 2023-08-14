Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9877B486
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjHNIph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjHNIpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B8810E5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692002653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnSmpMtBnju2Es/eNnXEAlLkCISBszhY2/ZRBT0PYVI=;
        b=c9gThx0Aa3JjvyodfKE/M3f69x5C3KHwZ7XOki/dBVm4ffppDKfhTrqrpGu3O5ZNEx8qLN
        hrtcEPT7lWHOR1A3xXzKojipaDddkdkZIkdp/ZGTOhpR1ok+U979XY8zNGap5Xr+8gMBRK
        8s9hvY3krRDhx8V9j45BQmk0tZNImBE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-kWTwFTMgNuC2TXwUE5BFLA-1; Mon, 14 Aug 2023 04:44:12 -0400
X-MC-Unique: kWTwFTMgNuC2TXwUE5BFLA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe08579d93so3809342e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692002651; x=1692607451;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnSmpMtBnju2Es/eNnXEAlLkCISBszhY2/ZRBT0PYVI=;
        b=i7QF3yvV4n8wCjv7BKP4NO1x0Bb4qRYEAjrvyMt+jljxV7CcVZdINmbrOc+rDyyhL7
         3JEIdpflLyPBux/G8bcLAlDmWn49gLXFpQovCSFToLegLKQKkSs63esXaqZsKZ5hKeqQ
         0bJB5VSU2gL4NKCFNsNfTT0Q8z42yTuMntXEqyA2DlHNlNu9PtK+Ig6T2pCAOWYAZ+Wz
         xsAZy1o+kdPTAAtwr5hthrglbzEtnPKyl/nmZGee/7xOyU84bypn4wa9OEs+Gg63/gww
         aNge4vGTPMbQNF2ykWyImCE7r6cjOQhgcbbZvkUgJPP9O9yWo72uwD7SPV8xnZSYgRH5
         UFPg==
X-Gm-Message-State: AOJu0YxyGFLl+bqJYcTQnm+wDCfhZqXFACYEyVcrgFn+8cUxjTLPGFgd
        jnN7+YiGlQTz3PtjmFHtx7itF/z5NR502b5YTnJNwIqS3J73WygqYzl5Rc17EoP/DfNLmg9b5Xx
        QQuHb8xUV/RsxY4wsCQ/OiTQh
X-Received: by 2002:a05:6512:b95:b0:4fb:9f24:bba9 with SMTP id b21-20020a0565120b9500b004fb9f24bba9mr7721373lfv.5.1692002650950;
        Mon, 14 Aug 2023 01:44:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWuGv18XCUJgMHhVarBxXjgbCqo+qcGaxWZJveWkq9lThhn9826Bwg+3yptDSMj29CcqAg3Q==
X-Received: by 2002:a05:6512:b95:b0:4fb:9f24:bba9 with SMTP id b21-20020a0565120b9500b004fb9f24bba9mr7721355lfv.5.1692002650560;
        Mon, 14 Aug 2023 01:44:10 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7c995000000b005234011bb44sm5312241edt.11.2023.08.14.01.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:44:10 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <88793701-f37e-000f-f659-6428ad03b345@redhat.com>
Date:   Mon, 14 Aug 2023 10:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     brouer@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
        linyunsheng@huawei.com,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next] page_pool: Set page pool size.
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230809021920.913324-1-rkannoth@marvell.com>
In-Reply-To: <20230809021920.913324-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/08/2023 04.19, Ratheesh Kannoth wrote:
> https://lore.kernel.org/netdev/
> 	15d32b22-22b0-64e3-a49e-88d780c24616@kernel.org/T/
> 

For the record I like this code change better than changing page_pool
core code. I like and agree with Olek's (Alexander Lobakin) suggestion.

But the commit message need to be improved as it is too thin.
(And link is getting split in two lines for some reason)

> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 8336cea16aff..2986e238104e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1434,7 +1434,8 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>   	}
>   
>   	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
> -	pp_params.pool_size = numptrs;
> +#define OTX2_PAGE_POOL_SIZE 2048
> +	pp_params.pool_size = OTX2_PAGE_POOL_SIZE;
>   	pp_params.nid = NUMA_NO_NODE;
>   	pp_params.dev = pfvf->dev;
>   	pp_params.dma_dir = DMA_FROM_DEVICE;

