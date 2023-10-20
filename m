Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8D7D1070
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377395AbjJTNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377121AbjJTNXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:23:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112E19E;
        Fri, 20 Oct 2023 06:23:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6ABC433C8;
        Fri, 20 Oct 2023 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697808201;
        bh=TXLUQxsI9mTYageNVxgktdbFEEqiw6lkZcz9AFp4qBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6BPaSqGyPLft1OpOae26qJfcW2BHB791GbPCRW5WdcqIO7PwnREweScJjXR//tNh
         2/ANzlOcenyu5Q3hEhIB4yJCoaMmeAzbhNNnCAp9zT6VjwWxjZoA18h2XEMcN0QgM0
         GZFZknRBsWDlbyn9RcI17nyACYLUVEeXLeBFG5pnJ5TrDBEf7xdWlHjw//3dXG/It/
         lJg5tozdst6Me5SZ6m5SrRUFO8X7cgtmdbhyuksC+QAXkGCAGqNhCyTQQuPF1X8XZ0
         MuR0jm8PJyIPo0jLDyLlCf69SnOLRjT/acp8iE1nZUDoNiuQsPpWKkCjQ4ZXzv93/C
         9WHB+P3M0dMMQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qtpTL-0002fV-0v;
        Fri, 20 Oct 2023 15:23:27 +0200
Date:   Fri, 20 Oct 2023 15:23:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Message-ID: <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-6-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007154806.605-6-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, drop "QCOM Glue driver" from Subject, you already have the "qcom"
prefix.

On Sat, Oct 07, 2023 at 09:18:01PM +0530, Krishna Kurapati wrote:
> Refactor setup_irq call to facilitate reading multiport IRQ's along

"IRQs" or just "interrupts"

> with non mulitport ones. Read through the interrupt-names property

"multiport"

Please spell check all your patches (commit messages and code) before
posting, it's not the reviewers job.

> to figure out, the type of interrupt (DP/DM/HS/SS) and to which port
> it belongs. Also keep track of port index to calculate port count
> based on interrupts provided as input in DT.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 210 +++++++++++++++++++++++++----------
>  1 file changed, 154 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index ef2006db7601..863892284146 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -53,14 +53,25 @@
>  #define APPS_USB_AVG_BW 0
>  #define APPS_USB_PEAK_BW MBps_to_icc(40)
>  
> +#define NUM_PHY_IRQ		4
> +
> +enum dwc3_qcom_ph_index {

"phy_index"

> +	DP_HS_PHY_IRQ_INDEX = 0,
> +	DM_HS_PHY_IRQ_INDEX,
> +	SS_PHY_IRQ_INDEX,
> +	HS_PHY_IRQ_INDEX,
> +};
> +
>  struct dwc3_acpi_pdata {
>  	u32			qscratch_base_offset;
>  	u32			qscratch_base_size;
>  	u32			dwc3_core_base_size;
> +	/*
> +	 * The phy_irq_index corresponds to ACPI indexes of (in order) DP/DM/SS
> +	 * IRQ's respectively.
> +	 */
> +	int			phy_irq_index[NUM_PHY_IRQ - 1];
>  	int			hs_phy_irq_index;
> -	int			dp_hs_phy_irq_index;
> -	int			dm_hs_phy_irq_index;
> -	int			ss_phy_irq_index;
>  	bool			is_urs;
>  };
>  
> @@ -73,10 +84,12 @@ struct dwc3_qcom {
>  	int			num_clocks;
>  	struct reset_control	*resets;
>  
> +	/*
> +	 * The phy_irq corresponds to IRQ's registered for (in order) DP/DM/SS
> +	 * respectively.
> +	 */
> +	int			phy_irq[NUM_PHY_IRQ - 1][DWC3_MAX_PORTS];
>  	int			hs_phy_irq;
> -	int			dp_hs_phy_irq;
> -	int			dm_hs_phy_irq;
> -	int			ss_phy_irq;

I'm not sure using arrays like this is a good idea (and haven't you
switched the indexes above?).

Why not add a port structure instead?

	struct dwc3_qcom_port {
		int hs_phy_irq;
		int dp_hs_phy_irq;
		int dm_hs_phy_irq;
		int ss_phy_irq;
	};

and then have

	struct dwc3_qcom_port ports[DWC3_MAX_PORTS];

in dwc3_qcom. The port structure can the later also be amended with
whatever other additional per-port data there is need for.

This should make the implementation cleaner.

I also don't like the special handling of hs_phy_irq; if this is really
just another name for the pwr_event_irq then this should be cleaned up
before making the code more complicated than it needs to be.

Make sure to clarify this before posting a new revision.

>  	enum usb_device_speed	usb2_speed;
>  
>  	struct extcon_dev	*edev;
  
>  	if (qcom->usb2_speed == USB_SPEED_LOW) {
> -		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);

For example, this would become

	dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq);

which is much more readable.

> -static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, char *irq_name,
> -				char *disp_name, int irq)
> +static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, const char *irq_name,
> +				const char *disp_name, int irq)

Ok, here you did drop the second name parameter, but without renaming
the first and hidden in a long diff without any mention anywhere.

> +static int dwc3_qcom_get_port_index(const char *irq_name, int irq_index)
> +{
> +	int port_index = -1;
> +
> +	switch (irq_index) {
> +	case DP_HS_PHY_IRQ_INDEX:
> +		if (strcmp(irq_name, "dp_hs_phy_irq") == 0)
> +			port_index = 1;
> +		else
> +			sscanf(irq_name, "dp_hs_phy_%d", &port_index);
> +		break;
> +

No need for newlines after break.

> +	case DM_HS_PHY_IRQ_INDEX:
> +		if (strcmp(irq_name, "dm_hs_phy_irq") == 0)
> +			port_index = 1;
> +		else
> +			sscanf(irq_name, "dm_hs_phy_%d", &port_index);
> +		break;
> +
> +	case SS_PHY_IRQ_INDEX:
> +		if (strcmp(irq_name, "ss_phy_irq") == 0)
> +			port_index = 1;
> +		else
> +			sscanf(irq_name, "ss_phy_%d", &port_index);
> +		break;
> +
> +	case HS_PHY_IRQ_INDEX:
> +		port_index = 1;
> +		break;
> +	}
> +
> +	if (port_index > DWC3_MAX_PORTS)
> +		port_index = -1;
> +
> +	return port_index;
> +}

>  static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  {
>  	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> -	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
> +	struct device_node *np = pdev->dev.of_node;
> +	const char **irq_names;
> +	int port_index;
> +	int acpi_index;
> +	int irq_count;
> +	int irq_index;
>  	int irq;
>  	int ret;
> +	int i;
>  
> -	irq = dwc3_qcom_get_irq(pdev, "hs_phy_irq",
> -				pdata ? pdata->hs_phy_irq_index : -1);
> -	if (irq > 0) {
> -		ret = dwc3_qcom_prep_irq(qcom, "hs_phy_irq", "qcom_dwc3 HS", irq);
> -		if (ret)
> -			return ret;
> -		qcom->hs_phy_irq = irq;
> -	}
> +	irq_count = of_property_count_strings(np, "interrupt-names");

of_property_count_strings() can return negative errnos and you don't
have any sanity checks for the return value...

Please slow down, and also make sure to get your patches reviewed
internally before posting new revisions.

> +	irq_names = devm_kzalloc(&pdev->dev, sizeof(*irq_names) * irq_count, GFP_KERNEL);

devm_kcalloc()

> +	if (!irq_names)
> +		return -ENOMEM;
>  
> -	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
> -				pdata ? pdata->dp_hs_phy_irq_index : -1);
> -	if (irq > 0) {
> -		ret = dwc3_qcom_prep_irq(qcom, "dp_hs_phy_irq", "qcom_dwc3 DP_HS", irq);
> -		if (ret)
> -			return ret;
> -		qcom->dp_hs_phy_irq = irq;
> -	}
> +	ret = of_property_read_string_array(np, "interrupt-names",
> +						irq_names, irq_count);

No sanity check here either?

> +	for (i = 0; i < irq_count; i++) {
> +		irq_index = dwc3_qcom_get_irq_index(irq_names[i]);
> +		if (irq_index == -1) {
> +			dev_dbg(&pdev->dev, "Invalid IRQ not handled");
> +			continue;
> +		}

I'll just stop reviewing here. This is a waste of my time.

Johan
