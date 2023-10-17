Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B037CB7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjJQBIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjJQBIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:08:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F199AB;
        Mon, 16 Oct 2023 18:08:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F90C433C9;
        Tue, 17 Oct 2023 01:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697504931;
        bh=jHzMCQWvVZ1Q/xaW0hEOcnP75eSP2Fct28NmE+fM2ZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U5Ejo6A7IGivJxgjcnLAn/xvYjhejkxSLLUq+ISYOO4hgxkafLCn8H+gOyRFR9rsj
         55vPcR9PbV8r/+Zd/WmCmair8sw52RzbAswebcAHVUJIkQRHIyUZOcvGFurw1NBwzP
         2JAxU9Vqf17EOx2wBwDek3hce2tEDODuGGZqtoU66waHayDQsR6TDUCUeKDXsnqI/N
         SOAkbqABIJJalva1wtuOOJmF47ALmc+tQa6XtvEjcfGLL1z9HVeA3XLCXs4iKQGyk0
         wv2eH7UEqPfYDMNI2yZG5tvJdpuDjgey9j2Hyw3+P3kQ9uslM19cS17gS98qgKDfrq
         JF+g184XSUXjQ==
Date:   Mon, 16 Oct 2023 18:08:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/4] net: stmmac: move TX timer arm after
 DMA enable
Message-ID: <20231016180849.1cc29549@kernel.org>
In-Reply-To: <20231014092954.1850-4-ansuelsmth@gmail.com>
References: <20231014092954.1850-1-ansuelsmth@gmail.com>
        <20231014092954.1850-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2023 11:29:53 +0200 Christian Marangi wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 5124ee87286c..240a18b97825 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2545,7 +2545,8 @@ static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
>   * @queue: TX queue index
>   * Description: it reclaims the transmit resources after transmission completes.
>   */
> -static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
> +static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
> +			   bool *pending_packets)

Missing kdoc for new param, build with W=1 catches this.
-- 
pw-bot: cr
