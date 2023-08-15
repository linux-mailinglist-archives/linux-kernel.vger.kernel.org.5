Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8944F77D1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbjHOS0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbjHOS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC9DE52
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:26:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E18D63CA8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5233FC433C8;
        Tue, 15 Aug 2023 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692123983;
        bh=p+TzmT/E7cNgjIPEMoOKL8P17OHBULu+kPazD0IWDAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwuByQoGDbVgdFeMlsyO4cu1F4HcXCJLBrQbBfbIsUj+0mY+W78uDhXsKGB7X1X7X
         nuNJlC3SpdrYQVvLgjHsZ4HIFO15Gq9P4pzxs/JeRTYOGha/awAJS2LTFJAiutodQ4
         j4Dg4ipilE94GoVUtigmDk1NTNHL/tjAQD2Ghu2JGLL8Lf4rkHf1M86dzqq7/wYD3F
         BHdZAl1xNkm2YkvmBvqxLMsDWDGm0e9voCQ5Ff2s2g5dG5STquHeE4+Bvcpz0bOTIO
         SfCCaA2m9HdPTPrTn6Ww8UewjHyp9UYWuT9BALHZzX0YFUB4VPeP8mQQxiMv7SX9tA
         HQrA1Eg+cIshQ==
Date:   Tue, 15 Aug 2023 21:26:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: hns3: Support tlv in regs data for
 HNS3 VF driver
Message-ID: <20230815182619.GR22185@unreal>
References: <20230815060641.3551665-1-shaojijie@huawei.com>
 <20230815060641.3551665-4-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815060641.3551665-4-shaojijie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:06:40PM +0800, Jijie Shao wrote:
> The dump register function is being refactored.
> The third step in refactoring is to support tlv info in regs data for
> HNS3 PF driver.
> 
> Currently, if we use "ethtool -d" to dump regs value,
> the output is as follows:
>   offset1: 00 01 02 03 04 05 ...
>   offset2：10 11 12 13 14 15 ...
>   ......
> 
> We can't get the value of a register directly.
> 
> This patch deletes the original separator information and
> add tag_len_value information in regs data.
> ethtool can parse register data in key-value format by -d command.
> 
> a patch will be added to the ethtool to parse regs data
> in the following format:
>   reg1 : value2
>   reg2 : value2
>   ......
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 85 +++++++++++++------
>  1 file changed, 61 insertions(+), 24 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
