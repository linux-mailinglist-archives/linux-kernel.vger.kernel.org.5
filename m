Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9555D7F2D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjKUMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjKUMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:25:06 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F69519F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:25:02 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1848259276.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700569501; x=1701174301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7DbtpzK1w4tm0MAmW+BGPDlzSNx3OWVKQWgUITDxBs=;
        b=PitmgaUKxW3UkwX2TzLdo6kVDmlY2ZB2gsxUdv9uh0H1R5yf1+VDHOj+dYFHHDnbvl
         1cACAaNP80opv53jdRHbcOoqL2zItp4Ik1tENDmdle9tWD/0E+0SNKwzvxfV3k0d/wRr
         ALyECvytj22hsZoQQlpZouf1ZT/ZS0cPjPOPTDJI266EblbUGuQsAiUUdavcmZKSD0fN
         npcEaNyM/z9pRDQbQblQDwpHmpUkFApDB3rSIlQNGn4guVO72Cl1EC2OQnESudPbPO9a
         ETAwGR0v0QvxSG+GMCe1gugUqu6ZaSbrF7aJpjdeMSkF05U8GdbEo7mSi8cqp4YwNZv9
         PP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700569501; x=1701174301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7DbtpzK1w4tm0MAmW+BGPDlzSNx3OWVKQWgUITDxBs=;
        b=ii7AH1iK4TkMv2fpCq13v4ehSjEBJNaRwOM2rmH5z7fz8h5sG8SWOB+prtk5X/k2oB
         r2G4nmthqiFkSkXiJT/piA5OQKn/ZFLAmwxS++CEXKcl4tAmwqKK/BMGdrqK44CSOcIH
         P4EGVuKMWqGjVdbQf0WY+mIfUkw6MqnSlSxlfeuDqI7B2H78u1Iv/lc3N2mAlpL6VG43
         lp5xB1Kk0Fw7zyunHwPpTQoH7tnvYRt2uQeo9TVXJYIBISeoTPGKJ0nmexzBV8uM2/73
         VKvy67LmEguz4szWKUxnM9DVC+1As8S/xI6moKAPKcmAXhfrSkQDr6r3MKq8LcKUZonX
         8ZSg==
X-Gm-Message-State: AOJu0Ywp0IUBeeeaFCGYUUTgrX5OBwT0cVkIg4XX8tZFHxb5Q4ZJYYOZ
        0kRutRXu5RcUDqeZKn4XXp35Kh2G5wLSkmhh7uWp4g==
X-Google-Smtp-Source: AGHT+IHO9SI0g8jKJS+nrXiKFU2C6WTzZGogCn6Twc/6jcAlzKSJQF7xfIjxeV6WHAHDe/RecHXy2FlYGEl64dmPgLo=
X-Received: by 2002:a25:8907:0:b0:da0:400e:750c with SMTP id
 e7-20020a258907000000b00da0400e750cmr9033029ybl.27.1700569501269; Tue, 21 Nov
 2023 04:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Nov 2023 13:24:25 +0100
Message-ID: <CAPDyKFoncctOOCu1Gam4dQJh0mhekxj=5V0aAhrWKfPF0NW=1A@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in the
 RX path
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, pkshih@realtek.com, kvalo@kernel.org,
        tony0620emma@gmail.com, lukas@mntre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 at 12:57, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
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

From the SDIO interface point of view, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Changes since v2 at [2]:
> - Don't initialize err to zero as that intiial value is never used.
>   Thanks Ping-Ke for spotting this!
> - Add a comment explaning why we need to continue reading but still
>   have to return an error to the caller of rtw_sdio_read_port()
>
> Changes since v1 at [0]:
> - We need to read all bytes if we split the transaction into multiple
>   smaller reads. This is even the case when one of N reads reports an
>   error. Otherwise the next read port call will return garbage (partially
>   containing zeros, ...). A similar-ish approach can be found in the
>   vendor driver, see [1] (specifically the call to sdio_recv_and_drop())
> - Update the patch description accordingly
>
> With a preliminary version of this updated patch Lukas reported off-
> list: "i've been using this laptop for almost 3 hours with heavy wifi
> usage and so far no problems"
>
>
> [0] https://lore.kernel.org/lkml/169089906853.212423.17095176293160428610.kvalo@kernel.org/T/
> [1] https://github.com/chewitt/RTL8822CS/blob/ad1391e219b59314485739a499fb442d5bbc069e/hal/rtl8822c/sdio/rtl8822cs_io.c#L468-L477
> [2] https://lore.kernel.org/linux-wireless/20230806181656.2072792-1-martin.blumenstingl@googlemail.com/
>
>
>  drivers/net/wireless/realtek/rtw88/sdio.c | 35 ++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
> index 2c1fb2dabd40..0cae5746f540 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -500,19 +500,40 @@ static u32 rtw_sdio_get_tx_addr(struct rtw_dev *rtwdev, size_t size,
>  static int rtw_sdio_read_port(struct rtw_dev *rtwdev, u8 *buf, size_t count)
>  {
>         struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
> +       struct mmc_host *host = rtwsdio->sdio_func->card->host;
>         bool bus_claim = rtw_sdio_bus_claim_needed(rtwsdio);
>         u32 rxaddr = rtwsdio->rx_addr++;
> -       int ret;
> +       int ret = 0, err;
> +       size_t bytes;
>
>         if (bus_claim)
>                 sdio_claim_host(rtwsdio->sdio_func);
>
> -       ret = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
> -                                RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr), count);
> -       if (ret)
> -               rtw_warn(rtwdev,
> -                        "Failed to read %zu byte(s) from SDIO port 0x%08x",
> -                        count, rxaddr);
> +       while (count > 0) {
> +               bytes = min_t(size_t, host->max_req_size, count);
> +
> +               err = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
> +                                        RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr),
> +                                        bytes);
> +               if (err) {
> +                       rtw_warn(rtwdev,
> +                                "Failed to read %zu byte(s) from SDIO port 0x%08x: %d",
> +                                bytes, rxaddr, err);
> +
> +                        /* Signal to the caller that reading did not work and
> +                         * that the data in the buffer is short/corrupted.
> +                         */
> +                       ret = err;
> +
> +                       /* Don't stop here - instead drain the remaining data
> +                        * from the card's buffer, else the card will return
> +                        * corrupt data for the next rtw_sdio_read_port() call.
> +                        */
> +               }
> +
> +               count -= bytes;
> +               buf += bytes;
> +       }
>
>         if (bus_claim)
>                 sdio_release_host(rtwsdio->sdio_func);
> --
> 2.42.1
>
