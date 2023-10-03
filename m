Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64577B62C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjJCHrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjJCHq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C012AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696319162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=badhJh7j9vTt4lYRj3w4dzKDnX5l9fCk+488RmtlxLs=;
        b=i3BPWSR0EZVzk69Xi2Qt7MwyNY7AGGPZvevn2TWiLcMpggFGxo8jDjowDQoXnxmGYdNxzJ
        yOrwSSVAfF89TqoNObiZ7TsElEOtmqHcTX4leJEnmVtcpw2JHRbHMep1oWLE2wrY8aJXZt
        vC+pRYGIXmIObXtAx7bXoI1fUlPqMco=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-aFpjadpGMNKX3Xl5mjQclg-1; Tue, 03 Oct 2023 03:46:01 -0400
X-MC-Unique: aFpjadpGMNKX3Xl5mjQclg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2d2d8f9e0so10125766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696319160; x=1696923960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=badhJh7j9vTt4lYRj3w4dzKDnX5l9fCk+488RmtlxLs=;
        b=CTdF8CGWqy/ipkteCirdr1G8TSi8eS2UlSDMMrxveOK9ogWBa9UX10MULH4YEVqTUn
         4GYi5anCS3FGY4+yCeT7ak0OUpZ/7q3pLtYPEajKKg6GyJbFMF1xKz4JMu3+h1RXH+5F
         6J9NNLlyknNLoDu7lc4pNBnoA6UE8RJmidS4rgQ28v6CZm1xov8Esa1Pe6qmeDGxUTVp
         jYXtD9ZQVJ4Cxn/KMIx+pfW+spyXgxFLdH5PIZ1d19Rz9naPaVMDdCpX42XvyhF568Sp
         hhDbHW2wlypPmMSbJTG4ryW/mF4diRMOH8O4uNYPvDcUN4dW+nuMaLraRYdVntdgLx8Q
         MiNw==
X-Gm-Message-State: AOJu0Yx36XtpaJ0XTC1oHitK9Qxr/cgwBZ/6zjCaEL/o/7C6vObU389w
        Bx4mcDwYvluZgIkCBaPXWUOclLK/4YLJJTOL0P9chUlKuruIx6LrwGoVmW02nwaQOGqhye6smmj
        PRj7aWcSGgF7qK8PVaPhPpnxvlPDOTUOL
X-Received: by 2002:a17:906:19b:b0:9ae:6da8:181c with SMTP id 27-20020a170906019b00b009ae6da8181cmr12064775ejb.7.1696319159819;
        Tue, 03 Oct 2023 00:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWzeUW1QUpPdAL7ev6RQA1+N2TB0hOVem0AAU3/MPZFHW0EnnDEy+RK9wC9vjYR/dvQPeDRw==
X-Received: by 2002:a17:906:19b:b0:9ae:6da8:181c with SMTP id 27-20020a170906019b00b009ae6da8181cmr12064749ejb.7.1696319159406;
        Tue, 03 Oct 2023 00:45:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709067ad300b009a193a5acffsm592740ejo.121.2023.10.03.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:45:58 -0700 (PDT)
Message-ID: <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
Subject: Re: [PATCH net-next v10 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Date:   Tue, 03 Oct 2023 09:45:56 +0200
In-Reply-To: <20230922091138.18014-2-linyunsheng@huawei.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
         <20230922091138.18014-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-22 at 17:11 +0800, Yunsheng Lin wrote:
> Currently page_pool_alloc_frag() is not supported in 32-bit
> arch with 64-bit DMA because of the overlap issue between
> pp_frag_count and dma_addr_upper in 'struct page' for those
> arches, which seems to be quite common, see [1], which means
> driver may need to handle it when using fragment API.
>=20
> It is assumed that the combination of the above arch with an
> address space >16TB does not exist, as all those arches have
> 64b equivalent, it seems logical to use the 64b version for a
> system with a large address space. It is also assumed that dma
> address is page aligned when we are dma mapping a page aligned
> buffer, see [2].
>=20
> That means we're storing 12 bits of 0 at the lower end for a
> dma address, we can reuse those bits for the above arches to
> support 32b+12b, which is 16TB of memory.
>=20
> If we make a wrong assumption, a warning is emitted so that
> user can report to us.
>=20
> 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.=
com/
> 2. https://lore.kernel.org/all/20230818145145.4b357c89@kernel.org/
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Guillaume Tucker <guillaume.tucker@collabora.com>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Linux-MM <linux-mm@kvack.org>
> ---
>  include/linux/mm_types.h        | 13 +------------
>  include/net/page_pool/helpers.h | 20 ++++++++++++++------
>  net/core/page_pool.c            | 14 +++++++++-----
>  3 files changed, 24 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 36c5b43999e6..74b49c4c7a52 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -125,18 +125,7 @@ struct page {
>  			struct page_pool *pp;
>  			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr;
> -			union {
> -				/**
> -				 * dma_addr_upper: might require a 64-bit
> -				 * value on 32-bit architectures.
> -				 */
> -				unsigned long dma_addr_upper;
> -				/**
> -				 * For frag page support, not supported in
> -				 * 32-bit architectures with 64-bit DMA.
> -				 */
> -				atomic_long_t pp_frag_count;
> -			};
> +			atomic_long_t pp_frag_count;
>  		};
>  		struct {	/* Tail pages of compound page */
>  			unsigned long compound_head;	/* Bit zero is set */

As noted by Jesper, since this is touching the super-critcal struct
page, an explicit ack from the mm people is required.

@Matthew: could you please have a look?

I think it would be nice also an explicit ack from Jesper and/or Ilias.

Cheers,

Paolo

