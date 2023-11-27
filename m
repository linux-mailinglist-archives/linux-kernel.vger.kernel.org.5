Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D817FA005
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjK0Mvr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 07:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjK0Mvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:51:45 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF232137
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:51:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r7b5A-0003Jf-Mc; Mon, 27 Nov 2023 13:51:24 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r7b55-00Bwme-Ia; Mon, 27 Nov 2023 13:51:19 +0100
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r7b55-000C2j-1c;
        Mon, 27 Nov 2023 13:51:19 +0100
Message-ID: <23011695aafca595c3c8722fda2a8e194c5318df.camel@pengutronix.de>
Subject: Re: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host
 driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     conor+dt@kernel.org, asutoshd@codeaurora.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
Date:   Mon, 27 Nov 2023 13:51:19 +0100
In-Reply-To: <20231121091101.5540-3-jyanchou@realtek.com>
References: <20231121091101.5540-1-jyanchou@realtek.com>
         <20231121091101.5540-3-jyanchou@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Di, 2023-11-21 at 17:10 +0800, Jyan Chou wrote:
> We implemented cmdq feature on Synopsys DesignWare mmc driver.
> The difference between dw_mmc.c and dw_mmc_cqe.c were distinct
> register definitions, mmc user flow and the addition of cmdq.
> 
> New version of User Guide had modify mmc driver's usage flow,
> we may need to renew code to precisely follow user guide.
> 
> More over, We added a wait status function to satisfy synopsys
> user guide's description, since this flow might be specific in
> synopsys host driver only.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> —--
[...]
> diff --git a/drivers/mmc/host/dw_mmc_cqe.c b/drivers/mmc/host/dw_mmc_cqe.c
> new file mode 100644
> index 000000000000..eb00d6a474b2
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc_cqe.c
> @@ -0,0 +1,1467 @@
[...]
> +#ifdef CONFIG_OF
> +static struct dw_mci_board *dw_mci_cqe_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_board *pdata;
> +	struct device *dev = host->dev;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	int ret;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pdata->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(pdata->rstc)) {
> +		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
> +			return ERR_PTR(-EPROBE_DEFER);

This should

		return ERR_CAST(pdata->rstc);

instead.

There is no reason to hide device tree parsing errors here, and I'd
argue pdata should not be returned with rstc set to an error value.
devm_reset_control_get_optional_exclusive() returns NULL if there are
no errors and no reset is specified in the device tree.

Then you can just use dev_err_probe() at the call site in
dw_mci_cqe_probe().


[...]
> +int dw_mci_cqe_probe(struct dw_mci *host)
> +{
[...]
> +	if (!IS_ERR(host->pdata->rstc)) {
> +		reset_control_assert(host->pdata->rstc);
> +		usleep_range(10, 50);
> +		reset_control_deassert(host->pdata->rstc);
> +	}

This should be changed to

	if (host->pdata->rstc) {
		reset_control_assert(host->pdata->rstc);
		usleep_range(10, 50);
		reset_control_deassert(host->pdata->rstc);
	}

[...]
> +	return 0;
> +
> +err_dmaunmap:
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);

This should be just

	reset_control_assert(host->pdata->rstc);

as reset_control_assert() is a no-op if host->pdata->rstc == NULL.

[...]
> +void dw_mci_cqe_remove(struct dw_mci *host)
> +{
[...]
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);

	reset_control_assert(host->pdata->rstc);


regards
Philipp
