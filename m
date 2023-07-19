Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5B75902F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjGSIYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGSIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:24:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B70E47
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:24:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A813D660704A;
        Wed, 19 Jul 2023 09:24:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689755074;
        bh=eD8QzZ9d79NiTyGzIqtIll+xqD7fGW1diaZBMcwUNII=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ITogaG+HeOljK2CNEP2vEIT4dgx1l5G8M09tLAax9WSLJ82rNFhSM/J4xSIya6gcm
         F/6yWYE6PbDPiPJDHvB4HLGZLM9FVt7XsVcIvMkC4MIP4qjRAusfhi0kb04jU8dA91
         kRqz9M1mWO03eJ2Z2WKifU/qHD0tEyP0H3l2Wxfkvvamm/muWI2ylNMB1RuQt+Wtcn
         0P2mVUnEtdaPhIwmGBThq4Q/1IHAXq3h2xSKJQ3mjEAutQbYABT1e8KEkqRtb2clam
         l1EkHkYRgLeiKbdE6uvUdSz5ReRBdP+iA69cSBOoC7fBE8kTWbKFdINa7s2KhbTWQB
         CfdeOojS/Bpsw==
Message-ID: <febc5cee-17fb-b524-add7-5d6c295b946b@collabora.com>
Date:   Wed, 19 Jul 2023 10:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] spmi: mtk-pmif: Serialize PMIF status check and command
 submission
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@collabora.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        James Lo <james.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230714211739.42928-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230714211739.42928-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/07/23 23:17, Nícolas F. R. A. Prado ha scritto:
> Before writing the read or write command to the SPMI arbiter through the
> PMIF interface, the current status of the channel is checked to ensure
> it is idle. However, since the status only changes from idle when the
> command is written, it is possible for two concurrent calls to determine
> that the channel is idle and simultaneously send their commands. At this
> point the PMIF interface hangs, with the status register no longer being
> updated, and thus causing all subsequent operations to time out.
> 
> This was observed on the mt8195-cherry-tomato-r2 machine, particularly
> after commit 46600ab142f8 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for
> drivers between 5.10 and 5.15") was applied, since then the two MT6315
> devices present on the SPMI bus would probe assynchronously and
> sometimes read the bus simultaneously, breaking the PMIF interface and
> consequently slowing down the whole system.
> 
> To fix the issue, introduce locking around the channel status check and
> the command write, so that both become an atomic operation. A spinlock
> is used since this is a fast bus, as indicated by the usage of the
> atomic variant of readl_poll, and '.fast_io = true' being used in the
> mt6315 driver, so spinlocks are already used for the regmap access.
> 
> Fixes: b45b3ccef8c0 ("spmi: mediatek: Add support for MT6873/8192")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

I agree. After all, switching back to synchronous probe would solve the issue
but that wouldn't be enough, as there's another latent issue in this driver.

You missed an important part for this commit's description!

Concurrent R/W may happen *not only* during probe, but *also* (and that's why
we *really* need this locking action) during runtime as some platforms may
have multiple regulator ICs, or others, over SPMI.

Anyway, look further, there are some comments to address for this patch.

> ---
> 
>   drivers/spmi/spmi-mtk-pmif.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
> index b3c991e1ea40..208ba0adfb98 100644
> --- a/drivers/spmi/spmi-mtk-pmif.c
> +++ b/drivers/spmi/spmi-mtk-pmif.c
> @@ -50,6 +50,7 @@ struct pmif {
>   	struct clk_bulk_data clks[PMIF_MAX_CLKS];
>   	size_t nclks;
>   	const struct pmif_data *data;
> +	spinlock_t lock;
>   };
>   
>   static const char * const pmif_clock_names[] = {
> @@ -314,6 +315,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   	struct ch_reg *inf_reg;
>   	int ret;
>   	u32 data, cmd;
> +	unsigned long flags;
>   
>   	/* Check for argument validation. */
>   	if (sid & ~0xf) {
> @@ -334,6 +336,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   	else
>   		return -EINVAL;
>   
> +	spin_lock_irqsave(&arb->lock, flags);
>   	/* Wait for Software Interface FSM state to be IDLE. */
>   	inf_reg = &arb->chan;
>   	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
> @@ -350,6 +353,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   	/* Send the command. */
>   	cmd = (opc << 30) | (sid << 24) | ((len - 1) << 16) | addr;
>   	pmif_writel(arb, cmd, inf_reg->ch_send);
> +	spin_unlock_irqrestore(&arb->lock, flags);

NACK. If readl_poll_timeout_atomic() fails you're leaving the spinlock locked!!!

Please fix :-)

>   
>   	/*
>   	 * Wait for Software Interface FSM state to be WFVLDCLR,
> @@ -377,6 +381,7 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   	struct ch_reg *inf_reg;
>   	int ret;
>   	u32 data, cmd;
> +	unsigned long flags;
>   
>   	if (len > 4) {
>   		dev_err(&ctrl->dev, "pmif supports 1..4 bytes per trans, but:%zu requested", len);
> @@ -394,6 +399,7 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   	else
>   		return -EINVAL;
>   
> +	spin_lock_irqsave(&arb->lock, flags);
>   	/* Wait for Software Interface FSM state to be IDLE. */
>   	inf_reg = &arb->chan;
>   	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
> @@ -414,6 +420,7 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   	/* Send the command. */
>   	cmd = (opc << 30) | BIT(29) | (sid << 24) | ((len - 1) << 16) | addr;
>   	pmif_writel(arb, cmd, inf_reg->ch_send);
> +	spin_unlock_irqrestore(&arb->lock, flags);
>   

For performance, do the memcpy() outside of the spinlock, before waiting for IDLE.

Cheers,
Angelo

