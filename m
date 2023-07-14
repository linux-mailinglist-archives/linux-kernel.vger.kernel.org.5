Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050E8753BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjGNNp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjGNNpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BC82D64
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689342276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAomTBbogGjThZFN5TWIgkvChHNK0qU90/lhwutfJTU=;
        b=Y78Nk7FaSZE9BtASVGfAc5FHlJNvbs1ZskZe2C0/3eXGnLet6BmkOdtKWfSzK6hyNJG52V
        3oG6RoQYGd0vognTyxXC3H+AZ1+QTsmGdu9zrDvJcMxcM7Fca0JrmpEqbc2E+NRlp4nq8B
        OTgB9FxDqto2oq0K/llY9fcyaZEF4Vk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-u3AxuN5_PZ-Qgubd9Xxhig-1; Fri, 14 Jul 2023 09:44:35 -0400
X-MC-Unique: u3AxuN5_PZ-Qgubd9Xxhig-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-98e1085308eso374461766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342274; x=1691934274;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAomTBbogGjThZFN5TWIgkvChHNK0qU90/lhwutfJTU=;
        b=JaLnTJiodC20mLNJSD6ldCtXMr3sbR/MoWRVSttcM23H/eADwVx+zSYDZuyw4BAcpQ
         M18IKuxGAdMOkvo9yuaGDjaHNjgqr3YiqyEsFdwojJsSzKvQ7De+0cWbsS6Pr+NeDVD0
         L8I7hDCGPgZKpKyAgSggJRVgS0xilJRfBVBem9VWdBaU6PhqECaFGrfabHtOKc4dxTtm
         IYoCFEfhVxbs+CIrQPo6n1AhhKlAicrMDLY44mvr3lipF3tGVHcLrAYmblBfsPId93Yk
         zPA2iXvemcPVcgcpjw+adVCOUKGdgmzP5BDyGauX+tvYbxiCKR4MFmyRvy6uwmXHpBlk
         VLCw==
X-Gm-Message-State: ABy/qLYH+UcC1YNoGQe2xF2r4b6VdXMw66CwjDeGw7fNgbQ6/GxRdGMr
        X7Wd581ig4OYp/bz/yaA/U7LWr1vwUMeDB6G6Ac3LoLOhm/AjwKKAFKXeO25d4G7U6+inoxXhSc
        C4YinZHl2mXu1u+Lr4RQG992n
X-Received: by 2002:a17:907:1c21:b0:993:f664:ce25 with SMTP id nc33-20020a1709071c2100b00993f664ce25mr3298771ejc.19.1689342274074;
        Fri, 14 Jul 2023 06:44:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFC27aKyBCXDolJGd6c0/6zg8McfiWC7uOuZPAJsKU8BLBmGbGccw+CItaYySADg4w6PyZlOg==
X-Received: by 2002:a17:907:1c21:b0:993:f664:ce25 with SMTP id nc33-20020a1709071c2100b00993f664ce25mr3298744ejc.19.1689342273762;
        Fri, 14 Jul 2023 06:44:33 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906395700b00992a9bd70dasm5513143eje.10.2023.07.14.06.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:44:33 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6e0ca9e8-1238-0581-2742-acdc88b252ae@redhat.com>
Date:   Fri, 14 Jul 2023 15:44:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yunsheng Lin <yunshenglin0825@gmail.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-2-linyunsheng@huawei.com>
 <20230707170157.12727e44@kernel.org>
 <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
 <20230710113841.482cbeac@kernel.org>
 <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
 <20230711093705.45454e41@kernel.org>
 <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
 <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
 <20230712102603.5038980e@kernel.org>
 <9a5b4c50-2401-b3e7-79aa-33d3ccee41c5@huawei.com>
In-Reply-To: <9a5b4c50-2401-b3e7-79aa-33d3ccee41c5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/07/2023 14.16, Yunsheng Lin wrote:
>> I know that Olek has a plan to remove the skbuff dependency completely
>> but functionally / for any future dependencies - this should work?
 >
> I am not experienced and confident enough to say about this for now.
> 

A trick Eric once shared with me is this make command:

  make net/core/page_pool.i

It will generate a file "net/core/page_pool.i" that kind of shows how
the includes gets processed, I believe it is the C preprocess output.

--Jesper

