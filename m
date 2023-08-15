Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7077D1C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbjHOS0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbjHOS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:26:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA4FE52
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1743A6395A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73F9C433C7;
        Tue, 15 Aug 2023 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692123963;
        bh=RyNIXN83QHxSVLtO+IEVs/MXXMI1+uNpytdp2lq0x4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXH4lr3ZY2re3nsFyVfq8E7tcLVAQs1ATVJ/TP97OOox4/9Tp8Gr6TcEWCvBG47xr
         ci1h1lUj+1S4cFGNGmklKwZJPS1QSztMZn98mCtel7+zEh1bnMsMtPh+upKVsI+EVL
         /uyzSea6z6FfSuMJXnZq74j1/HwhmGcvp7zRR1s392aadIUBEPyJjrjpA3clC3C/g0
         vvaMXg0wpkcmS5nzPMtGpS0QOexVEeI9UrwqRrBjyq3An8fgbzDeayJnimkxY0vKru
         /vqe6b0oAG9hPHBuOlFq8W0czri9BliEt0E26zktjtXjF5bUzvulQ0kkgoHOq7gj5m
         oxXsBEJJ/vzEw==
Date:   Tue, 15 Aug 2023 21:25:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: hns3: move dump regs function to a
 separate file
Message-ID: <20230815182558.GP22185@unreal>
References: <20230815060641.3551665-1-shaojijie@huawei.com>
 <20230815060641.3551665-2-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060641.3551665-2-shaojijie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:06:38PM +0800, Jijie Shao wrote:
> The dump register function is being refactored.
> The first step in refactoring is put the dump regs function
> into a separate file.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/Makefile  |   4 +-
>  .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |   1 +
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 558 +----------------
>  .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 -
>  .../hisilicon/hns3/hns3pf/hclge_regs.c        | 567 ++++++++++++++++++
>  .../hisilicon/hns3/hns3pf/hclge_regs.h        |  17 +
>  .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 121 +---
>  .../hisilicon/hns3/hns3vf/hclgevf_main.h      |   1 +
>  .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 127 ++++
>  .../hisilicon/hns3/hns3vf/hclgevf_regs.h      |  13 +
>  10 files changed, 731 insertions(+), 680 deletions(-)
>  create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
>  create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.h
>  create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
>  create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.h
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
