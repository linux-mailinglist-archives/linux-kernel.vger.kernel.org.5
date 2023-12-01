Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A750800B31
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378898AbjLAMkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378879AbjLAMkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:40:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D652196
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:40:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439F5C433C7;
        Fri,  1 Dec 2023 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701434438;
        bh=d5Is7DQQkDJQMABKZBG5rDA8xuTnzdXWxPreoL723b0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WG2CbeairoHsy0gK2p97pSYlOfS093EuRS0fW5qaFiw1EKDUd5+2w656xYh8Y59+9
         dI7NHtmY4JtBeDVaraF2UTZan7aHmY/V3l1li7Pvfi5SGnfu+BTmvUCwVadvrJ8I6G
         /aGgUBg1oMs9UFImNjeZBZsot9G2c6qEHfIUUNDrccqp0Mk4krsTYistNW22igei6X
         0PufkONn8ybPJVt4Q4QYUosjCNS1cVObmGKMjyosmFUsvoLbArQ7LGWVwIwMSbzUGf
         YdyaXzlnyMmGp3eOhpByaI4WCd6cJPYWKGIJ32EEicdWHi97+O4mzP46LPZisLY1hC
         3KYyeN+NuIM1A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in the
 RX
 path
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
References: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, pkshih@realtek.com,
        ulf.hansson@linaro.org, tony0620emma@gmail.com, lukas@mntre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170143443423.2072551.2418172782235693510.kvalo@kernel.org>
Date:   Fri,  1 Dec 2023 12:40:36 +0000 (UTC)
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
> Lukas found that disabling or limiting RX aggregation works around the
> problem for some time (but does not fully fix it). In the following
> discussion a few key topics have been discussed which have an impact on
> this problem:
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
> Use multiple consecutive reads in rtw_sdio_read_port() and limit the
> number of bytes which are copied by the host from the card in one
> MMC/SDIO transfer. This allows receiving a buffer that's larger than
> the hosts max_req_size (number of bytes which can be transferred in
> one MMC/SDIO transfer). As a result of this the skb_over_panic error
> is gone as the rtw88 driver is now able to receive more than 1536 bytes
> from the card (either because the incoming packet is larger than that
> or because multiple packets have been aggregated).
> 
> In case of an receive errors (-EILSEQ has been observed by Lukas) we
> need to drain the remaining data from the card's buffer, otherwise the
> card will return corrupt data for the next rtw_sdio_read_port() call.
> 
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
> Reported-by: Lukas F. Hartmann <lukas@mntre.com>
> Closes: https://lore.kernel.org/linux-wireless/CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com/
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Lukas F. Hartmann <lukas@mntre.com>
> Reported-by: Lukas F. Hartmann <lukas@mntre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Lukas F. Hartmann <lukas@mntre.com>

Patch applied to wireless-next.git, thanks.

00384f565a91 wifi: rtw88: sdio: Honor the host max_req_size in the RX path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231120115726.1569323-1-martin.blumenstingl@googlemail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

