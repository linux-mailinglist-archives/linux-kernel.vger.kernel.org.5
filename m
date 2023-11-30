Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6347FFAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376275AbjK3TNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjK3TNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:13:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E91704
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:13:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C40CC433C8;
        Thu, 30 Nov 2023 19:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701371598;
        bh=Byw3Ja8D98qaaMIkq6NR0yFqF4YxOUcmr+nbGdlYZbA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QcpwT9cr6VnKlFKhpZTU8AJ6xS/OkxTlZHu897PUrxvEb73G+gy4AhQ1b2TCp9cGe
         KiG3QwWb64sxola+sTovgNLk3SzvK4/rVT5CC4OfjeXQOQ5ZDIbJ+41GtdcnU84Kpp
         Vh1xYgFovu9ScfxihtLf7I9Ej39BWAx+OSLPyK+tWdAt3FKv++Z+K5T5BqJebq7kvO
         DJyDgINL1G+sAyc2E8JkOaLyKBJ8mEKotWKsTkRibVZwOU6TURBLhDuxE//MpOvbH/
         d84hGgDW/B4nVNdf7YzTeb3DGrEzxRyt5qK+Z08VjafR7LfmB7r/TI/mGjq+2MNNuw
         CX/rhxWXCzzhg==
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
Message-ID: <170137159397.1963309.4329648460865757143.kvalo@kernel.org>
Date:   Thu, 30 Nov 2023 19:13:15 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Did this fix Lukas' problem? I couldn't see any answer to Ping's
question.

Patch set to Deferred.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231120115726.1569323-1-martin.blumenstingl@googlemail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

