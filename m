Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4527845B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbjHVPi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjHVPiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:38:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA61B2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB0D628DE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5141C433C9;
        Tue, 22 Aug 2023 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692718703;
        bh=IYNjysX3W/sYGXBHygamD0+donpwS/LB4TT3PYl1vGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JPA4jJRnhGOl1rVsiZYRI1GhwFAn8t24el2czrAK3ybCjc7QtqgaWq7WJFRsOPdzs
         55rPGiFYa18WzzZbMzTnW/y3EqErGPFC97Q5uxrJiDffRLvCynyIdlFEaZIjnXUAHm
         3N0RFzI8Y/9LwjgTwJFAH5bzMEBtjMpE6rgcGInu4DLwKsL05soKn8t5XnpGWLu7vH
         NyhhDmQGIj9blHEckYto/JQ9dXNhDgcPwGC/SNtj70E2pk3tULdIBnNYm58pgd0sVN
         xxjOE1+JJRNIofK+xFh7IjYuVpDiSyznEtxShoH82PdNspCtmiGB9aQgBShrsVwzw6
         FceF3pNEmBUXA==
Date:   Tue, 22 Aug 2023 08:38:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230822083821.58d5d26c@kernel.org>
In-Reply-To: <5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
        <20230816100113.41034-2-linyunsheng@huawei.com>
        <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
        <20230817091554.31bb3600@kernel.org>
        <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
        <20230817165744.73d61fb6@kernel.org>
        <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
        <20230818145145.4b357c89@kernel.org>
        <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
        <20230821113543.536b7375@kernel.org>
        <5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 17:21:35 +0800 Yunsheng Lin wrote:
> > .. we should also add a:
> > 
> > 	WARN_ONCE(1, "misaligned DMA address, please report to netdev@");  
> 
> As the CONFIG_PHYS_ADDR_T_64BIT seems to used widely in x86/arm/mips/powerpc,
> I am not sure if we can really make the above assumption.
> 
> https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_ADDR_T_64BIT

Huh, it's actually used a lot less than I anticipated!

None of the x86/arm/mips/powerpc systems matter IMHO - the only _real_
risk is something we don't know about returning non-aligned addresses.

Unless we know about specific problems I'd suggest we took the simpler
path rather than complicating the design for systems which may not
exist.

Alex, do you know of any such cases? Some crazy swiotlb setting?
WDYT about this in general?
