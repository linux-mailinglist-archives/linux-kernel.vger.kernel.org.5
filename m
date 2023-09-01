Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8A78F6A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbjIABOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjIABOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:14:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5898495;
        Thu, 31 Aug 2023 18:14:13 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3810oIl2018694;
        Fri, 1 Sep 2023 01:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kwhYoQKIg6Wy2pdUrxkKnuzlqSenR2Djg8RzAaLH51U=;
 b=X4/ICo5qBdWT170iCxymOu7fTjxpA46w4RRnzOell9US1lkxh/RyAOH08h7UGh2WwqNw
 nFRL5xUC0SPnp65WW98Cpe/9YyPLAathnhf9obQFdEwScPfV1gLkWjeyF+xPeC0cjHn9
 1UoKWcefHDJKurDD1oNK/SSSgmwnZIRoQMXsp7Et8npgaDpmV+vS8ZHBjkjj/SFMpVFh
 irzthRz561+CQiggPIOPRIdsFWh6vPycw1yjBRrJVELSK90kcu6ALJCm1voRCiCNjFa0
 mQ6+g58OAzic6xARz+42KlIazOzrte7yxsykuDC+BtzrZVIcN1eB4qLbgoN2MUJnxbg3 IQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st6ctc72y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 01:13:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3811DwrO021855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 01:13:58 GMT
Received: from [10.71.114.68] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 18:13:57 -0700
Message-ID: <9eee5666-8bd1-9a42-53b4-6a07ccba652e@quicinc.com>
Date:   Thu, 31 Aug 2023 18:13:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v11 06/13] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Johan Hovold" <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Harsh Agarwal <quic_harshq@quicinc.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-7-quic_kriskura@quicinc.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230828133033.11988-7-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fd5PkVGzNFK8tOlIEa7yt48Qs7vOVXfQ
X-Proofpoint-ORIG-GUID: fd5PkVGzNFK8tOlIEa7yt48Qs7vOVXfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_22,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010009
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On 8/28/2023 6:30 AM, Krishna Kurapati wrote:
> From: Harsh Agarwal <quic_harshq@quicinc.com>
> 
> Currently the DWC3 driver supports only single port controller
> which requires at most one HS and one SS PHY.
> 
> But the DWC3 USB controller can be connected to multiple ports and
> each port can have their own PHYs. Each port of the multiport
> controller can either be HS+SS capable or HS only capable
> Proper quantification of them is required to modify GUSB2PHYCFG
> and GUSB3PIPECTL registers appropriately.
> 
> Add support for detecting, obtaining and configuring phy's supported
> by a multiport controller and. Limit the max number of ports
> supported to 4 as only SC8280 which is a quad port controller supports
> Multiport currently.
> 
> Co-developed-by: Harsh Agarwal <quic_harshq@quicinc.com>
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> Co-developed-by:Krishna Kurapati <quic_kriskura@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>   drivers/usb/dwc3/core.c | 252 +++++++++++++++++++++++++++-------------
>   drivers/usb/dwc3/core.h |  11 +-
>   drivers/usb/dwc3/drd.c  |  15 ++-
>   3 files changed, 190 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 6eacf0ff90b5..31400c309bff 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -124,6 +124,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>   	int ret;
>   	u32 reg;
>   	u32 desired_dr_role;
> +	int i;
>   
>   	mutex_lock(&dwc->mutex);
>   	spin_lock_irqsave(&dwc->lock, flags);
> @@ -201,8 +202,10 @@ static void __dwc3_set_mode(struct work_struct *work)
>   		} else {
>   			if (dwc->usb2_phy)
>   				otg_set_vbus(dwc->usb2_phy->otg, true);
> -			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
> -			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
> +			for (i = 0; i < dwc->num_usb2_ports; i++) {
> +				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
> +				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
> +			}
>   			if (dwc->dis_split_quirk) {
>   				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
>   				reg |= DWC3_GUCTL3_SPLITDISABLE;
> @@ -217,8 +220,8 @@ static void __dwc3_set_mode(struct work_struct *work)
>   
>   		if (dwc->usb2_phy)
>   			otg_set_vbus(dwc->usb2_phy->otg, false);
> -		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
> -		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
> +		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
> +		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
>   

Throughout this patch, you are looping across all PHYs irrespective of 
if we are in device mode or not.  This is the only exception where you 
are setting only PHY index 0 (for both SS and HS PHYs).  Do you think we 
should also only modify PHY index#0 for other PHY related sequences?

>   		ret = dwc3_gadget_init(dwc);
>   		if (ret)
> @@ -589,22 +592,14 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
>   	return ret;
>   }
>   
> -/**
> - * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
> - * @dwc: Pointer to our controller context structure
> - *
> - * Returns 0 on success. The USB PHY interfaces are configured but not
> - * initialized. The PHY interfaces and the PHYs get initialized together with
> - * the core in dwc3_core_init.
> - */
> -static int dwc3_phy_setup(struct dwc3 *dwc)
> +static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
>   {
>   	unsigned int hw_mode;
>   	u32 reg;
>   
>   	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>   
> -	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(index));
>   
>   	/*
>   	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
> @@ -659,9 +654,19 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>   	if (dwc->dis_del_phy_power_chg_quirk)
>   		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
>   
> -	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> +	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(index), reg);
>   
> -	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +	return 0;
> +}
> +
> +static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
> +{
> +	unsigned int hw_mode;
> +	u32 reg;
> +
> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> +
> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
>   
>   	/* Select the HS PHY interface */
>   	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
> @@ -673,7 +678,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>   		} else if (dwc->hsphy_interface &&
>   				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
>   			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
> -			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
>   		} else {
>   			/* Relying on default value. */
>   			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
> @@ -740,7 +745,35 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>   	if (dwc->ulpi_ext_vbus_drv)
>   		reg |= DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV;
>   
> -	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
> +
> +	return 0;
> +}
> +
> +/**
> + * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
> + * @dwc: Pointer to our controller context structure
> + *
> + * Returns 0 on success. The USB PHY interfaces are configured but not
> + * initialized. The PHY interfaces and the PHYs get initialized together with
> + * the core in dwc3_core_init.
> + */
> +static int dwc3_phy_setup(struct dwc3 *dwc)
> +{
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < dwc->num_usb3_ports; i++) {
> +		ret = dwc3_ss_phy_setup(dwc, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = dwc3_hs_phy_setup(dwc, i);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return 0;
>   }
> @@ -748,23 +781,32 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>   static int dwc3_phy_init(struct dwc3 *dwc)
>   {
>   	int ret;
> +	int i;
> +	int j;
>   
>   	usb_phy_init(dwc->usb2_phy);
>   	usb_phy_init(dwc->usb3_phy);
>   
> -	ret = phy_init(dwc->usb2_generic_phy);
> -	if (ret < 0)
> -		goto err_shutdown_usb3_phy;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = phy_init(dwc->usb2_generic_phy[i]);
> +		if (ret < 0)
> +			goto err_exit_phy;
>   
> -	ret = phy_init(dwc->usb3_generic_phy);
> -	if (ret < 0)
> -		goto err_exit_usb2_phy;
> +		ret = phy_init(dwc->usb3_generic_phy[i]);
> +		if (ret < 0) {
> +			phy_exit(dwc->usb2_generic_phy[i]);
> +			goto err_exit_phy;
> +		}
> +	}
>   
>   	return 0;
>   
> -err_exit_usb2_phy:
> -	phy_exit(dwc->usb2_generic_phy);
> -err_shutdown_usb3_phy:
> +err_exit_phy:
> +	for (j = i - 1; j >= 0; j--) {
> +		phy_exit(dwc->usb2_generic_phy[j]);
> +		phy_exit(dwc->usb3_generic_phy[j]);
> +	}
> +
>   	usb_phy_shutdown(dwc->usb3_phy);
>   	usb_phy_shutdown(dwc->usb2_phy);
>   
> @@ -773,8 +815,12 @@ static int dwc3_phy_init(struct dwc3 *dwc)
>   
>   static void dwc3_phy_exit(struct dwc3 *dwc)
>   {
> -	phy_exit(dwc->usb3_generic_phy);
> -	phy_exit(dwc->usb2_generic_phy);
> +	int i;
> +
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		phy_exit(dwc->usb3_generic_phy[i]);
> +		phy_exit(dwc->usb2_generic_phy[i]);
> +	}
>   
>   	usb_phy_shutdown(dwc->usb3_phy);
>   	usb_phy_shutdown(dwc->usb2_phy);
> @@ -783,23 +829,32 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
>   static int dwc3_phy_power_on(struct dwc3 *dwc)
>   {
>   	int ret;
> +	int i;
> +	int j;
>   
>   	usb_phy_set_suspend(dwc->usb2_phy, 0);
>   	usb_phy_set_suspend(dwc->usb3_phy, 0);
>   
> -	ret = phy_power_on(dwc->usb2_generic_phy);
> -	if (ret < 0)
> -		goto err_suspend_usb3_phy;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = phy_power_on(dwc->usb2_generic_phy[i]);
> +		if (ret < 0)
> +			goto err_power_off_phy;
>   
> -	ret = phy_power_on(dwc->usb3_generic_phy);
> -	if (ret < 0)
> -		goto err_power_off_usb2_phy;
> +		ret = phy_power_on(dwc->usb3_generic_phy[i]);
> +		if (ret < 0) {
> +			phy_power_off(dwc->usb2_generic_phy[i]);
> +			goto err_power_off_phy;
> +		}
> +	}
>   
>   	return 0;
>   
> -err_power_off_usb2_phy:
> -	phy_power_off(dwc->usb2_generic_phy);
> -err_suspend_usb3_phy:
> +err_power_off_phy:
> +	for (j = i - 1; j >= 0; j--) {
> +		phy_power_off(dwc->usb2_generic_phy[j]);
> +		phy_power_off(dwc->usb3_generic_phy[j]);
> +	}
> +
>   	usb_phy_set_suspend(dwc->usb3_phy, 1);
>   	usb_phy_set_suspend(dwc->usb2_phy, 1);
>   
> @@ -808,8 +863,12 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
>   
>   static void dwc3_phy_power_off(struct dwc3 *dwc)
>   {
> -	phy_power_off(dwc->usb3_generic_phy);
> -	phy_power_off(dwc->usb2_generic_phy);
> +	int i;
> +
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		phy_power_off(dwc->usb3_generic_phy[i]);
> +		phy_power_off(dwc->usb2_generic_phy[i]);
> +	}
>   
>   	usb_phy_set_suspend(dwc->usb3_phy, 1);
>   	usb_phy_set_suspend(dwc->usb2_phy, 1);
> @@ -1082,6 +1141,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
>   	unsigned int		hw_mode;
>   	u32			reg;
>   	int			ret;
> +	int			i;
>   
>   	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>   
> @@ -1125,15 +1185,19 @@ static int dwc3_core_init(struct dwc3 *dwc)
>   	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
>   	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
>   		if (!dwc->dis_u3_susphy_quirk) {
> -			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> -			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
> -			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> +			for (i = 0; i < dwc->num_usb3_ports; i++) {
> +				reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
> +				reg |= DWC3_GUSB3PIPECTL_SUSPHY;
> +				dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
> +			}
>   		}
>   
>   		if (!dwc->dis_u2_susphy_quirk) {
> -			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> -			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
> -			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +			for (i = 0; i < dwc->num_usb2_ports; i++) {
> +				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
> +				reg |= DWC3_GUSB2PHYCFG_SUSPHY;
> +				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
> +			}
>   		}
>   	}
>   
> @@ -1276,7 +1340,9 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>   {
>   	struct device		*dev = dwc->dev;
>   	struct device_node	*node = dev->of_node;
> +	char phy_name[11];
>   	int ret;
> +	int i;
>   
>   	if (node) {
>   		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
> @@ -1302,22 +1368,36 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>   			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>   	}
>   
> -	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> -	if (IS_ERR(dwc->usb2_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb2_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb2_generic_phy = NULL;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		if (dwc->num_usb2_ports == 1)
> +			sprintf(phy_name, "usb2-phy");
>   		else
> -			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> -	}
> +			sprintf(phy_name, "usb2-port%d", i);
>   
> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> -	if (IS_ERR(dwc->usb3_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb3_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb3_generic_phy = NULL;
> +		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
> +		if (IS_ERR(dwc->usb2_generic_phy[i])) {
> +			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb2_generic_phy[i] = NULL;
> +			else
> +				return dev_err_probe(dev, ret,
> +					"failed to lookup phy %s\n", phy_name);
> +		}
> +
> +		if (dwc->num_usb2_ports == 1)
> +			sprintf(phy_name, "usb3-phy");
>   		else
> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +			sprintf(phy_name, "usb3-port%d", i);
> +
> +		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
> +		if (IS_ERR(dwc->usb3_generic_phy[i])) {
> +			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb3_generic_phy[i] = NULL;
> +			else
> +				return dev_err_probe(dev, ret,
> +					"failed to lookup phy %s\n", phy_name);
> +		}
>   	}
>   
>   	return 0;
> @@ -1327,6 +1407,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>   {
>   	struct device *dev = dwc->dev;
>   	int ret;
> +	int i;
>   
>   	switch (dwc->dr_mode) {
>   	case USB_DR_MODE_PERIPHERAL:
> @@ -1334,8 +1415,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>   
>   		if (dwc->usb2_phy)
>   			otg_set_vbus(dwc->usb2_phy->otg, false);
> -		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
> -		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
> +		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
> +		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
>   
>   		ret = dwc3_gadget_init(dwc);
>   		if (ret)
> @@ -1346,8 +1427,10 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>   
>   		if (dwc->usb2_phy)
>   			otg_set_vbus(dwc->usb2_phy->otg, true);
> -		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
> -		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
> +		for (i = 0; i < dwc->num_usb2_ports; i++) {
> +			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
> +			phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
> +		}
>   
>   		ret = dwc3_host_init(dwc);
>   		if (ret)
> @@ -1804,9 +1887,12 @@ static int dwc3_read_port_info(struct dwc3 *dwc)
>   
>   	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
>   			dwc->num_usb2_ports, dwc->num_usb3_ports);
> -
>   	iounmap(base);
>   
> +	if ((dwc->num_usb2_ports > DWC3_MAX_PORTS) ||
> +		(dwc->num_usb3_ports > DWC3_MAX_PORTS))
> +		return -ENOMEM;
> +

Shouldn't this be more applicable to be included in patch#4 in this series?

Thanks
Wesley Cheng

>   	return 0;
>   }
>   
> @@ -2042,6 +2128,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>   {
>   	unsigned long	flags;
>   	u32 reg;
> +	int i;
>   
>   	switch (dwc->current_dr_role) {
>   	case DWC3_GCTL_PRTCAP_DEVICE:
> @@ -2060,17 +2147,21 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>   		/* Let controller to suspend HSPHY before PHY driver suspends */
>   		if (dwc->dis_u2_susphy_quirk ||
>   		    dwc->dis_enblslpm_quirk) {
> -			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> -			reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
> -				DWC3_GUSB2PHYCFG_SUSPHY;
> -			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +			for (i = 0; i < dwc->num_usb2_ports; i++) {
> +				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
> +				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
> +					DWC3_GUSB2PHYCFG_SUSPHY;
> +				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
> +			}
>   
>   			/* Give some time for USB2 PHY to suspend */
>   			usleep_range(5000, 6000);
>   		}
>   
> -		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
> -		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> +		for (i = 0; i < dwc->num_usb2_ports; i++) {
> +			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
> +			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
> +		}
>   		break;
>   	case DWC3_GCTL_PRTCAP_OTG:
>   		/* do nothing during runtime_suspend */
> @@ -2100,6 +2191,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>   	unsigned long	flags;
>   	int		ret;
>   	u32		reg;
> +	int		i;
>   
>   	switch (dwc->current_dr_role) {
>   	case DWC3_GCTL_PRTCAP_DEVICE:
> @@ -2119,17 +2211,21 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>   			break;
>   		}
>   		/* Restore GUSB2PHYCFG bits that were modified in suspend */
> -		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> -		if (dwc->dis_u2_susphy_quirk)
> -			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
> +		 for (i = 0; i < dwc->num_usb2_ports; i++) {
> +			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
> +			if (dwc->dis_u2_susphy_quirk)
> +				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
>   
> -		if (dwc->dis_enblslpm_quirk)
> -			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
> +			if (dwc->dis_enblslpm_quirk)
> +				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
>   
> -		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
> +		}
>   
> -		phy_pm_runtime_get_sync(dwc->usb2_generic_phy);
> -		phy_pm_runtime_get_sync(dwc->usb3_generic_phy);
> +		for (i = 0; i < dwc->num_usb2_ports; i++) {
> +			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
> +			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
> +		}
>   		break;
>   	case DWC3_GCTL_PRTCAP_OTG:
>   		/* nothing to do on runtime_resume */
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 5b0f2aa115d2..5521dc9ca034 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -33,6 +33,9 @@
>   
>   #include <linux/power_supply.h>
>   
> +/* Number of ports supported by a multiport controller */
> +#define DWC3_MAX_PORTS 4
> +
>   #define DWC3_MSG_MAX	500
>   
>   /* Global constants */
> @@ -1024,8 +1027,8 @@ struct dwc3_scratchpad_array {
>    * @usb_psy: pointer to power supply interface.
>    * @usb2_phy: pointer to USB2 PHY
>    * @usb3_phy: pointer to USB3 PHY
> - * @usb2_generic_phy: pointer to USB2 PHY
> - * @usb3_generic_phy: pointer to USB3 PHY
> + * @usb2_generic_phy: pointer to array of USB2 PHY
> + * @usb3_generic_phy: pointer to array of USB3 PHY
>    * @num_usb2_ports: number of USB2 ports
>    * @num_usb3_ports: number of USB3 ports
>    * @phys_ready: flag to indicate that PHYs are ready
> @@ -1164,8 +1167,8 @@ struct dwc3 {
>   	struct usb_phy		*usb2_phy;
>   	struct usb_phy		*usb3_phy;
>   
> -	struct phy		*usb2_generic_phy;
> -	struct phy		*usb3_generic_phy;
> +	struct phy		*usb2_generic_phy[DWC3_MAX_PORTS];
> +	struct phy		*usb3_generic_phy[DWC3_MAX_PORTS];
>   
>   	u8			num_usb2_ports;
>   	u8			num_usb3_ports;
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 039bf241769a..9aec41f1ad43 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -331,6 +331,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>   	u32 reg;
>   	int id;
>   	unsigned long flags;
> +	int i;
>   
>   	if (dwc->dr_mode != USB_DR_MODE_OTG)
>   		return;
> @@ -386,9 +387,12 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>   		} else {
>   			if (dwc->usb2_phy)
>   				otg_set_vbus(dwc->usb2_phy->otg, true);
> -			if (dwc->usb2_generic_phy)
> -				phy_set_mode(dwc->usb2_generic_phy,
> -					     PHY_MODE_USB_HOST);
> +			for (i = 0; i < dwc->num_usb2_ports; i++) {
> +				if (dwc->usb2_generic_phy[i]) {
> +					phy_set_mode(dwc->usb2_generic_phy[i],
> +						     PHY_MODE_USB_HOST);
> +				}
> +			}
>   		}
>   		break;
>   	case DWC3_OTG_ROLE_DEVICE:
> @@ -400,9 +404,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>   
>   		if (dwc->usb2_phy)
>   			otg_set_vbus(dwc->usb2_phy->otg, false);
> -		if (dwc->usb2_generic_phy)
> -			phy_set_mode(dwc->usb2_generic_phy,
> -				     PHY_MODE_USB_DEVICE);
> +		if (dwc->usb2_generic_phy[0])
> +			phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
>   		ret = dwc3_gadget_init(dwc);
>   		if (ret)
>   			dev_err(dwc->dev, "failed to initialize peripheral\n");
