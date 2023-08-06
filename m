Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6F7713AE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 07:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHFFI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 01:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFFI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 01:08:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E41FCB;
        Sat,  5 Aug 2023 22:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E18CC60D30;
        Sun,  6 Aug 2023 05:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C486AC433C8;
        Sun,  6 Aug 2023 05:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691298535;
        bh=3ky+wpe10b6Qv3cw6OkN3Avc7rZzkz3wNoVTLLLBIfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYERX3YfNz7P95IqZ88V737zWkUIzmscfYd1DozOVmoaStdqUu7qHhbFpYHD00yYu
         Jh2DGjnmwqneQvy4aU0iP9JQjDXgHiwskQSwtSN+PfNWR3RxJSQtFRnjdcFOvpE8Qr
         dcW+Oq+cdKGh6Qiv+LoC+1V0H/LVoS07+X+BCApEeMBQyh5TV6rBzfz3mcI2TOOyDY
         0Uhh8tCckU7nHZQJutnAREEmcJd4okuQc72soqe/gUCvsaB8q3Py5jnDiaMbUKBicK
         pj7kDJZPtFg5njJEJjxQ2GCiH7r/Fgb8TXEXNkBHUTI08lrKtcRa3FA6l1iaUvZbLv
         rnZ1D5m4bLqTw==
Date:   Sat, 5 Aug 2023 22:11:52 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v10 06/11] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Message-ID: <pyxerd3lirbh2p43m74ohwocjjb7uh56xxmaxbrkay3svossik@ksd3yojw5wgr>
References: <20230727223307.8096-1-quic_kriskura@quicinc.com>
 <20230727223307.8096-7-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727223307.8096-7-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:03:02AM +0530, Krishna Kurapati wrote:
> Refactor setup_irq call to facilitate reading multiport IRQ's along
> with non mulitport ones. For SA8295, there are 4-DP/4-DM and 2-SS
> IRQ's. Check whether device is multiport capable or not and read all
> interrupts for DP/DM/SS on each port accordingly.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 277 ++++++++++++++++++++++++-----------
>  1 file changed, 190 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 3de43df6bbe8..ad89ded116d3 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -64,33 +64,61 @@ struct dwc3_acpi_pdata {
>  	bool			is_urs;
>  };
>  
> +struct dwc3_qcom_of_match_data {
> +	u8	num_ports;
> +};
> +
>  struct dwc3_qcom {
> -	struct device		*dev;
> -	void __iomem		*qscratch_base;
> -	struct platform_device	*dwc3;
> -	struct platform_device	*urs_usb;
> -	struct clk		**clks;
> -	int			num_clocks;
> -	struct reset_control	*resets;
> -
> -	int			hs_phy_irq;
> -	int			dp_hs_phy_irq;
> -	int			dm_hs_phy_irq;
> -	int			ss_phy_irq;
> -	enum usb_device_speed	usb2_speed;
> -
> -	struct extcon_dev	*edev;
> -	struct extcon_dev	*host_edev;
> -	struct notifier_block	vbus_nb;
> -	struct notifier_block	host_nb;
> +	struct device				*dev;
> +	void __iomem				*qscratch_base;
> +	struct platform_device			*dwc3;
> +	struct platform_device			*urs_usb;
> +	struct clk				**clks;
> +	int					num_clocks;
> +	struct reset_control			*resets;
> +
> +	int					hs_phy_irq;
> +	int					dp_hs_phy_irq[DWC3_MAX_PORTS];
> +	int					dm_hs_phy_irq[DWC3_MAX_PORTS];
> +	int					ss_phy_irq[DWC3_MAX_PORTS];
> +	enum usb_device_speed			usb2_speed;
> +
> +	struct extcon_dev			*edev;
> +	struct extcon_dev			*host_edev;
> +	struct notifier_block			vbus_nb;
> +	struct notifier_block			host_nb;
> +
> +	const struct dwc3_acpi_pdata		*acpi_pdata;
> +
> +	enum usb_dr_mode			mode;
> +	bool					is_suspended;
> +	bool					pm_suspended;
> +	struct icc_path				*icc_path_ddr;
> +	struct icc_path				*icc_path_apps;
> +	const struct dwc3_qcom_of_match_data	*data;

Please don't adjust indentation of unrelated code, it makes it hard to
see what actually changed.

> +};
> +
> +static const struct dwc3_qcom_of_match_data qcom_dwc3  = {
> +	.num_ports = 1,
> +};
>  
> -	const struct dwc3_acpi_pdata *acpi_pdata;
> +static const struct dwc3_qcom_of_match_data sx8280xp_qcom_dwc3 = {
> +	.num_ports = 4,
> +};
>  
> -	enum usb_dr_mode	mode;
> -	bool			is_suspended;
> -	bool			pm_suspended;
> -	struct icc_path		*icc_path_ddr;
> -	struct icc_path		*icc_path_apps;
> +/*
> + * Driver needs to read HS/DP_HS/DM_HS/SS IRQ's. Currently, for
> + * SA8295 which supports mutliport, thre are 4 DP/ 4 DM/ 2 SS IRQ's
> + * and 1 HS IRQ present. So avoid trying to read HS_PHY_IRQ for 4
> + * ports of SA8295.
> + */

The last part here is relevant information, but it doesn't seem to
relate to this define.

Also, does all platforms have this configuration of interrupts?

> +#define MAX_PHY_IRQ	4
> +
> +enum dwc3_qcom_phy_irq_identifier {
> +	HS_PHY_IRQ = 0,
> +	DP_HS_PHY_IRQ,
> +	DM_HS_PHY_IRQ,
> +	SS_PHY_IRQ,
>  };

This enum is unused.

>  
[..]
> +static int dwc3_get_acpi_index(const struct dwc3_acpi_pdata *pdata, int irq_index)
> +{
> +	int acpi_index = -1;
> +
> +	if (!pdata)
> +		return -1;
> +
> +	if (irq_index == DP_HS_PHY_IRQ)
> +		acpi_index = pdata->dp_hs_phy_irq_index;
> +	else if (irq_index == DM_HS_PHY_IRQ)
> +		acpi_index = pdata->dm_hs_phy_irq_index;
> +	else if (irq_index == SS_PHY_IRQ)
> +		acpi_index = pdata->ss_phy_irq_index;

It looks favourable to put these in an array, instead of having to pull
them out of 4 different variables conditionally.

> +
> +	return acpi_index;
> +}
> +
> +static int dwc3_get_port_irq(struct platform_device *pdev, u8 port_index)
> +{
> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> +	bool is_mp_supported = (qcom->data->num_ports > 1) ? true : false;
> +	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
> +	char *disp_name;
> +	int acpi_index;
> +	char *dt_name;
> +	int ret;
> +	int irq;
> +	int i;
> +
> +	/*
> +	 * We need to read only DP/DM/SS IRQ's here.
> +	 * So loop over from 1->3 and accordingly modify respective phy_irq[].
> +	 */
> +	for (i = 1; i < MAX_PHY_IRQ; i++) {
> +
> +		if (!is_mp_supported && (port_index == 0)) {
> +			if (i == DP_HS_PHY_IRQ) {
> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"dp_hs_phy_irq");
> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"qcom_dwc3 DP_HS");
> +			} else if (i == DM_HS_PHY_IRQ) {
> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"dm_hs_phy_irq");
> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"qcom_dwc3 DM_HS");
> +			} else if (i == SS_PHY_IRQ) {
> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"ss_phy_irq");
> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"qcom_dwc3 SS");
> +			}
> +		} else {
> +			if (i == DP_HS_PHY_IRQ) {
> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"dp_hs_phy_%d", port_index + 1);
> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"qcom_dwc3 DP_HS%d", port_index + 1);
> +			} else if (i == DM_HS_PHY_IRQ) {
> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"dm_hs_phy_%d", port_index + 1);
> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"qcom_dwc3 DM_HS%d", port_index + 1);
> +			} else if (i == SS_PHY_IRQ) {
> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"ss_phy_%d", port_index + 1);
> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +					"qcom_dwc3 SS%d", port_index + 1);
> +			}

There is too much repetition in this for my liking.

>  		}
> -		qcom->hs_phy_irq = irq;
> -	}
>  
> -	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
> -				pdata ? pdata->dp_hs_phy_irq_index : -1);
> -	if (irq > 0) {
> -		irq_set_status_flags(irq, IRQ_NOAUTOEN);
> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> -					qcom_dwc3_resume_irq,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> -					"qcom_dwc3 DP_HS", qcom);
> -		if (ret) {
> -			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
> -			return ret;
> +		if (!dt_name || !disp_name)
> +			return -ENOMEM;
> +
> +		acpi_index = !is_mp_supported ? dwc3_get_acpi_index(pdata, i) : -1;
> +
> +		irq = dwc3_qcom_get_irq(pdev, dt_name, acpi_index);
> +		if (irq > 0) {
> +			ret = dwc3_qcom_prep_irq(qcom, dt_name, disp_name, irq);
> +			if (ret)
> +				return ret;
> +
> +			if (i == DP_HS_PHY_IRQ)
> +				qcom->dp_hs_phy_irq[port_index] = irq;
> +			else if (i == DM_HS_PHY_IRQ)
> +				qcom->dm_hs_phy_irq[port_index] = irq;
> +			else if (i == SS_PHY_IRQ)
> +				qcom->ss_phy_irq[port_index] = irq;
>  		}
> -		qcom->dp_hs_phy_irq = irq;
>  	}
>  
> -	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
> -				pdata ? pdata->dm_hs_phy_irq_index : -1);
> +	return 0;
> +}
> +
> +static int dwc3_qcom_setup_irq(struct platform_device *pdev)
> +{
> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> +	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
> +	int irq;
> +	int ret;
> +	int i;
> +
> +	irq = dwc3_qcom_get_irq(pdev, "hs_phy_irq",
> +				pdata ? pdata->hs_phy_irq_index : -1);
>  	if (irq > 0) {
> -		irq_set_status_flags(irq, IRQ_NOAUTOEN);
> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> -					qcom_dwc3_resume_irq,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> -					"qcom_dwc3 DM_HS", qcom);
> -		if (ret) {
> -			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
> +		ret = dwc3_qcom_prep_irq(qcom, "hs_phy_irq", "qcom_dwc3 HS",irq);
> +		if (ret)

It would be nice to have this refactored out in a separate commit.

>  			return ret;
> -		}
> -		qcom->dm_hs_phy_irq = irq;
> +		qcom->hs_phy_irq = irq;
>  	}
>  
> -	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
> -				pdata ? pdata->ss_phy_irq_index : -1);
> -	if (irq > 0) {
> -		irq_set_status_flags(irq, IRQ_NOAUTOEN);
> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> -					qcom_dwc3_resume_irq,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> -					"qcom_dwc3 SS", qcom);
> -		if (ret) {
> -			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
> +	for (i = 0; i < qcom->data->num_ports; i++) {
> +		ret = dwc3_get_port_irq(pdev, i);
> +		if (ret)
>  			return ret;
> -		}
> -		qcom->ss_phy_irq = irq;
>  	}
>  
>  	return 0;
> @@ -811,6 +905,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, qcom);
>  	qcom->dev = &pdev->dev;
>  
> +	qcom->data = of_device_get_match_data(qcom->dev);
> +
>  	if (has_acpi_companion(dev)) {
>  		qcom->acpi_pdata = acpi_device_get_match_data(dev);
>  		if (!qcom->acpi_pdata) {
> @@ -1023,8 +1119,15 @@ static const struct dev_pm_ops dwc3_qcom_dev_pm_ops = {
>  };
>  
>  static const struct of_device_id dwc3_qcom_of_match[] = {
> -	{ .compatible = "qcom,dwc3" },
> -	{ }
> +	{
> +		.compatible = "qcom,dwc3",
> +		.data = &qcom_dwc3,
> +	},
> +	{
> +		.compatible = "qcom,sc8280xp-dwc3-mp",
> +		.data = &sx8280xp_qcom_dwc3,
> +	},

I would prefer that we don't add a separate compatible, but rather just
try to parse the interrupts for multiport and fall back to single port.

If/when we figure out how to peak into the dwc3 core, we could
potentially introduce a check to aid the developer.

Regards,
Bjorn

> +	{ },
>  };
>  MODULE_DEVICE_TABLE(of, dwc3_qcom_of_match);
>  
> -- 
> 2.40.0
> 
