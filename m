Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B837B4EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjJBJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbjJBJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:06:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E5B99;
        Mon,  2 Oct 2023 02:06:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30558C433C8;
        Mon,  2 Oct 2023 09:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696237591;
        bh=2diAPME2cCR6iA16Hgh40lXTEBhdoVmgO8i3mbpJqXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2fz6AveIUYh9hcYONkJFNzBTjUfjJAwyMB7DOHF/wl35uVUhFVZTMfh7aFMa9WNb
         /JzbgwlGq/C/rfcZBQIrS6VU3RMGhbN8S+v6FOSTxiWxV8HdnEzpCZ8FtOf0jEQvwr
         SZtXXhWnKBeN539sMl7i2FzA/nMVToO8KJpRYgiHd3sAtbh6vMjDJ5uiaw3/zb53+d
         FzancQsp5OsWEgpaTtyT1nQVo7qFC2vThrmnv6Dymj3EpYyVD0SRWgJRP6HFZBeWYl
         lV9dhvQAo41P6sPC7oDqBxJv073oe4HQSs8dZJz3rzO1kcSy8EJbv01EyZ6VeRj9RV
         qdqOrJuK9bCfw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qnEsv-0004eg-2W;
        Mon, 02 Oct 2023 11:06:38 +0200
Date:   Mon, 2 Oct 2023 11:06:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 4/5] phy: qcom: edp: Introduce support for DisplayPort
Message-ID: <ZRqIHSetajQf7Um1@hovoldconsulting.com>
References: <20220810040745.3582985-1-bjorn.andersson@linaro.org>
 <20220810040745.3582985-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810040745.3582985-5-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 09:07:44PM -0700, Bjorn Andersson wrote:
> The eDP phy can be used to drive either eDP or DP output, with some
> minor variations in some of the configuration and seemingly a need for
> implementing swing and pre_emphasis calibration.
> 
> Introduce a config object, indicating if the phy is operating in eDP or
> DP mode and swing/pre-emphasis calibration to support this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 80 +++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 32614fb838b5..301ac422d2fe 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -70,8 +70,19 @@
>  
>  #define TXn_TRAN_DRVR_EMP_EN                    0x0078
>  
> +struct qcom_edp_cfg {
> +	bool is_dp;
> +
> +	/* DP PHY swing and pre_emphasis tables */
> +	const u8 (*swing_hbr_rbr)[4][4];
> +	const u8 (*swing_hbr3_hbr2)[4][4];
> +	const u8 (*pre_emphasis_hbr_rbr)[4][4];
> +	const u8 (*pre_emphasis_hbr3_hbr2)[4][4];
> +};
 
>  static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
> @@ -315,7 +381,9 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp)
>  static int qcom_edp_phy_power_on(struct phy *phy)
>  {
>  	const struct qcom_edp *edp = phy_get_drvdata(phy);
> +	const struct qcom_edp_cfg *cfg = edp->cfg;
>  	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
> +	u8 ldo_config;
>  	int timeout;
>  	int ret;
>  	u32 val;
> @@ -332,8 +400,11 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>  	if (timeout)
>  		return timeout;
>  
> -	writel(0x01, edp->tx0 + TXn_LDO_CONFIG);
> -	writel(0x01, edp->tx1 + TXn_LDO_CONFIG);
> +
> +	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
> +
> +	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
> +	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);

When reviewing a patch from Konrad which will start using the eDP
configuration on the X13s, I noticed that this patch inverted these bits
for older SoCs (e.g. sc7280 and sc8180xp). They used to be set to 1,
but after this patch they will be set to 0.

Was that intentional even if it was never mentioned in the commit
message? Or was it a mistake that should be fixed?

Johan
