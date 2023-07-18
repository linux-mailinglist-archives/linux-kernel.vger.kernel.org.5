Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C912D758459
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjGRSQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGRSQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:16:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15BB6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7106615B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964E8C433C7;
        Tue, 18 Jul 2023 18:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689704183;
        bh=dLw0o8GM5ZiBvdbNfsNS2F4dK0uCCiB3AzKY0zXlyXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sk34ZwNBe/3LC5ZIESpIzoRXj4R8CoaZFCUhRCCRjVBdh7WY6p9UGAQJ8anvUVIBk
         bwm6uah3bWKRroO9mMyGstbl+cmPOfMayBy0jMEdDp4ojAA5T1phqU2xDBfAqrfymG
         TT1zwfibNIIqZZTCMCdCFYUS9F3HE9UtrEF3w8g4nYDNByJlEUSSXnOIjVxtp0qkmV
         8jZCxDUu0QlDS2mYALIsha2JHv6NqdnVTBz/iNqiuqVNCNNGrmpGNms5pteH6v8xZq
         ZK2etPYINuucQ/iQ0VkMegoraBmpDAkaRKNtqbq6tNXFu39zkWnejECZVTzmYcSkQA
         iBVbYV3mFpcow==
Date:   Tue, 18 Jul 2023 11:16:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yunsheng Lin <yunshenglin0825@gmail.com>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230718111621.35a64a0b@kernel.org>
In-Reply-To: <6c94f7b8-f553-1fce-f3f1-66cdead9e056@huawei.com>
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
        <20230714105214.39ad4e4d@kernel.org>
        <6c94f7b8-f553-1fce-f3f1-66cdead9e056@huawei.com>
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

On Mon, 17 Jul 2023 20:33:05 +0800 Yunsheng Lin wrote:
> > Only those used in function prototypes. Pointers in structures 
> > are somewhat special and don't require fwd declaration.  
> 
> I gave it a try to split it, and something as below come out:
> 
> https://github.com/gestionlin/linux/commit/11ac8c1959f7eda06a7b987903f37212b490b292
> 
> As the 'helpers.h' is not really useful when splitting, so only
> 'page_pool_types.h' is added, and include 'page_pool_types.h' in
> 'page_pool.h', does it make sense?
> 
> As Alexander is sending a new RFC for the similar problem, I think
> we need to align on which is the better way to solve the problem.

LGTM, thanks!
