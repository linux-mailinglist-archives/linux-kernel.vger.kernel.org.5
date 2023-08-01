Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE03C76B6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjHAOLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjHAOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B7918D;
        Tue,  1 Aug 2023 07:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA6C615A5;
        Tue,  1 Aug 2023 14:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9157AC433C8;
        Tue,  1 Aug 2023 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690899072;
        bh=Va+3BpK80OaOladXcfkefzEKQDa7NapSdHQhUuxB8IY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aKmKRyrrWqC3G193vS32cSDtgtS7OvNINFtMQGWdR0HnYrOsPwzriMcAg0XAN+QZ7
         xqLSODj1BmwE1D031eb+P6ERJiuT74u8o/1oo7pVV6HDL+8OL5OJGZS59YUesflW3j
         5NeMVDSrpKfPlw3unLZH+SXEIAEYFtfOh/lEjCbCgNcbL67i+wXNQsqE3Kqnw0pG7k
         sR0rL2wb1o7biLoYIbHngkU4IUFNXzn7C9uixH1maqMqWUl9gQMYGp/ghy0K/AlUmC
         mT9yF49BOgNj1FgJSxQjVG+XKD7RIPZHZFpeH6JH2LevFQxr40wo7K/TMswKpl7Pnv
         /7G+EHFhRa6UQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX
 path
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230709195712.603200-1-martin.blumenstingl@googlemail.com>
References: <20230709195712.603200-1-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, pkshih@realtek.com,
        ulf.hansson@linaro.org, tony0620emma@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Lukas F . Hartmann" <lukas@mntre.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169089906853.212423.17095176293160428610.kvalo@kernel.org>
Date:   Tue,  1 Aug 2023 14:11:10 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Lukas reports skb_over_panic errors on his Banana Pi BPI-CM4 which comes
> with an Amlogic A311D (G12B) SoC and a RTL8822CS SDIO wifi/Bluetooth
> combo card. The error he observed is identical to what has been fixed
> in commit e967229ead0e ("wifi: rtw88: sdio: Check the HISR RX_REQUEST
> bit in rtw_sdio_rx_isr()") but that commit didn't fix Lukas' problem.
> 
> Lukas found that disabling or limiting RX aggregation fix the problem
> for him. In the following discussion a few key topics have been
> discussed which have an impact on this problem:
> - The Amlogic A311D (G12B) SoC has a hardware bug in the SDIO controller
>   which prevents DMA transfers. Instead all transfers need to go through
>   the controller SRAM which limits transfers to 1536 bytes
> - rtw88 chips don't split incoming (RX) packets, so if a big packet is
>   received this is forwarded to the host in it's original form
> - rtw88 chips can do RX aggregation, meaning more multiple incoming
>   packets can be pulled by the host from the card with one MMC/SDIO
>   transfer. This Depends on settings in the REG_RXDMA_AGG_PG_TH
>   register (BIT_RXDMA_AGG_PG_TH limits the number of packets that will
>   be aggregated, BIT_DMA_AGG_TO_V1 configures a timeout for aggregation
>   and BIT_EN_PRE_CALC makes the chip honor the limits more effectively)
> 
> Use multiple consecutive reads in rtw_sdio_read_port() to limit the
> number of bytes which are copied by the host from the card in one
> MMC/SDIO transfer. This allows receiving a buffer that's larger than
> the hosts max_req_size (number of bytes which can be transferred in
> one MMC/SDIO transfer). As a result of this the skb_over_panic error
> is gone as the rtw88 driver is now able to receive more than 1536 bytes
> from the card (either because the incoming packet is larger than that
> or because multiple packets have been aggregated).
> 
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
> Reported-by: Lukas F. Hartmann <lukas@mntre.com>
> Closes: https://lore.kernel.org/linux-wireless/CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com/
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Ping, should I take or drop the patch? It wasn't quite clear for me.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230709195712.603200-1-martin.blumenstingl@googlemail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

