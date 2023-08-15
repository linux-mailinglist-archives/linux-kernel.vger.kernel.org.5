Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AE77C8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjHOHjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjHOHjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCCE10F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A447E62FD2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D60C433C7;
        Tue, 15 Aug 2023 07:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692085150;
        bh=rCqZCoD8GYMxT8ghf9mzmgtDV/HSiAPVnrB3VXhlAKE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=EfdJgRsFIx3k3dwgPMxxbHsQDD10+6Ar94HLm00OuQCYEn62QTJri0eQIfU9cYPms
         f2rMg0tga9PhT7McysLTv/NMF4nMLESuQxoD0SXjr/6AHOl6TUX2sgPqfOHlvNFiDR
         +0GL6rHnJb223wTjNTs9gXcAbj/jH8pUXBf0PWHHWrsL+Sk43WNKyC+pWqKHm/GwYm
         B2Ju9d9DmOuKriwJPHwXRX0mMzAg85S4f1ZecBQAXXT7QPqrMqP/lJi8qyS37ZFmxr
         OMpol2yhjOfJgAxE/tKE5mL3IXpIRcW1sfAuARxF+PHLCJ965BY5Mv7jiXYsrHKKKm
         S5pIbRa3oPE5w==
Message-ID: <b2ce9811-b001-d235-d74f-7db8b052b9cd@kernel.org>
Date:   Tue, 15 Aug 2023 09:39:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH V6 net-next 0/2] net: fec: add XDP_TX feature support
Content-Language: en-US
To:     Wei Fang <wei.fang@nxp.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        larysa.zaremba@intel.com, aleksander.lobakin@intel.com,
        jbrouer@redhat.com, netdev@vger.kernel.org
References: <20230815051955.150298-1-wei.fang@nxp.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230815051955.150298-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/2023 07.19, Wei Fang wrote:
> This patch set is to support the XDP_TX feature of FEC driver, the first
> patch is add initial XDP_TX support, and the second patch improves the
> performance of XDP_TX by not using xdp_convert_buff_to_frame(). Please
> refer to the commit message of each patch for more details.
> 
> Wei Fang (2):
>    net: fec: add XDP_TX feature support
>    net: fec: improve XDP_TX performance
> 
>   drivers/net/ethernet/freescale/fec.h      |   6 +-
>   drivers/net/ethernet/freescale/fec_main.c | 187 +++++++++++++++-------
>   2 files changed, 132 insertions(+), 61 deletions(-)
> 

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
