Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD2F80B202
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 05:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjLIEUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 23:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIEUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 23:20:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F61E7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 20:20:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C7FC433C8;
        Sat,  9 Dec 2023 04:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702095612;
        bh=TdKoeYJCmyQ3JKD16K1s4NTFRZ9JYlkC3z82L25IMLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZq+7p+NKT2MXm0FV9mEvEHC6nMEhkB/wQW6MCdKZV0MpgZo+hJJdiR6SDe+wG56Z
         o95UHAJKMTANcMMg4g7KDlIhEkB3M1nrgHznj/2uQghQIrEwTwMei7n9+pJXcaZE8X
         D1sf9eBnbI7SmjIKgVJMxPNR87poc8/HAGwgiurxtN/kw97wsW6PckiDGBfr3kl2lV
         giLvCprU9zZlk25TzEfPGaWJWD5+0ooGkXlKyLjNJzDpDc+puDAeWlQB/Ylk28H9wZ
         Y1maZVajOiyHsmoPipm3viNTC+0JKXC3JRaKLt+M3sDkKEnoqi1JDWYwBYFnqUZrap
         x4IK5+QJl42sw==
Date:   Fri, 8 Dec 2023 20:24:44 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sneh Shah <quic_snehshah@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net v3] net: stmmac: update Rx clk divider for 10M SGMII
Message-ID: <5luxwdjyzkg5o6w27mqixggr65ebosnn53vaqrbtsclfudet4v@kse23pgyj7ld>
References: <20231208062502.13124-1-quic_snehshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208062502.13124-1-quic_snehshah@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 11:55:02AM +0530, Sneh Shah wrote:
> SGMII 10MBPS mode needs RX clock divider to avoid drops in Rx.
> Update configure SGMII function with rx clk divider programming.

Are you trying saying that the RX clock is completely wrong in 10MBps
mode? Or is the RX clock good, but without some division of some other
clock signal you loose some packets now and then?

Please write your commit message such that it describe the actual
problem you're having. This will help others to know if this fix is
applicable to some issue they are seeing on their hardware, now and in
the future.

> 
> Fixes: 463120c31c58 ("net: stmmac: dwmac-qcom-ethqos: add support for SGMII")
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> ---
> v3 changelog:
> - Added comment to explain why MAC needs to be reconfigured for SGMII
> v2 changelog:
> - Use FIELD_PREP to prepare bifield values in place of GENMASK
> - Add fixes tag
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index d3bf42d0fceb..ab2245995bc6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -34,6 +34,7 @@
>  #define RGMII_CONFIG_LOOPBACK_EN		BIT(2)
>  #define RGMII_CONFIG_PROG_SWAP			BIT(1)
>  #define RGMII_CONFIG_DDR_MODE			BIT(0)
> +#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)

This new bitfield overlaps with existing fields, is it the same
register? Did the fields move? Is it applicable to all versions?

What will existing writes to RGMII_IO_MACRO_CONFIG do to this new
layout? What will the new write do to hardware with the existing field
layout?

>  
>  /* SDCC_HC_REG_DLL_CONFIG fields */
>  #define SDCC_DLL_CONFIG_DLL_RST			BIT(30)
> @@ -598,6 +599,9 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
>  	return 0;
>  }
>  
> +/* On interface toggle MAC registetrs gets reset.
> + * Configure MAC block for SGMII on ethernet phy link up
> + */
>  static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  {
>  	int val;
> @@ -617,6 +621,9 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  	case SPEED_10:
>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
>  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
> +		rgmii_updatel(ethqos, RGMII_CONFIG_SGMII_CLK_DVDR,
> +			      FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR, 0x31),

Is this just a magic constant, or does 0x31 of some convenient unit?
Could we give it name/define?

Regards,
Bjorn

> +			      RGMII_IO_MACRO_CONFIG);
>  		break;
>  	}
>  
> -- 
> 2.17.1
> 
> 
