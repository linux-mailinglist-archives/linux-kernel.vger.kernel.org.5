Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735037B27B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjI1Vs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjI1Vsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:48:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89DD19E;
        Thu, 28 Sep 2023 14:48:51 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SLZGch006680;
        Thu, 28 Sep 2023 21:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=vgmNGeMBAhmijdPijzuJfCS+lyPil3fUYE/6JzEm1OE=;
 b=RBWqyxviVo2hgov/1CrQXs32MwD697eLH691isCQYMYIIqh0OI7BzapEAmP1LBqPTQ1Z
 PIuvuiGuWXCQyG1BRkVpOj4i6cbfFjMCvk8rj0rd4Hd6YXxpkHQZHy1iClBbpTHcx9iX
 9P//1htww4YEjC9GVJ4Zbpkdwy3l6L1OvdPpzxE8ggeRLWAI0Ux8yWuyGuErRf6NvZo/
 8QET3p4qeReua0asFeldNzMxz7A9s7C1KrPleh1KMwsFygkZ07+RwQtqm7tDrwjhrXFe
 poPESRnPmKM66jpv52nEh0i8eq7bv+JhAWh0XKzVS54mlholIxJw4sNJW+KiApXRa6uO Qg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td8wdsaqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 21:48:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SLmTgP017298
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 21:48:29 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 28 Sep 2023 14:48:28 -0700
Date:   Thu, 28 Sep 2023 14:48:27 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v11 07/13] usb: dwc3: qcom: Add helper function to
 request threaded IRQ
Message-ID: <20230928214827.GC3553829@hu-bjorande-lv.qualcomm.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-8-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828133033.11988-8-quic_kriskura@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kbYv7G0Yxy3LsaaSpltaOdOq-DQ8SDl0
X-Proofpoint-GUID: kbYv7G0Yxy3LsaaSpltaOdOq-DQ8SDl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_21,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=636 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 clxscore=1011 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:00:27PM +0530, Krishna Kurapati wrote:
> Cleanup setup irq call by implementing a new prep_irq helper function
> and using it to request threaded IRQ's.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 63 +++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 3de43df6bbe8..f14ddc9c541d 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -535,6 +535,24 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, char *irq_name,
> +				char *disp_name, int irq)
> +{
> +	int ret;
> +
> +	/* Keep wakeup interrupts disabled until suspend */
> +	irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +	ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					disp_name, qcom);
> +
> +	if (ret)
> +		dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
> +
> +	return ret;
> +}
> +
>  static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  {
>  	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> @@ -545,61 +563,40 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  	irq = dwc3_qcom_get_irq(pdev, "hs_phy_irq",
>  				pdata ? pdata->hs_phy_irq_index : -1);
>  	if (irq > 0) {
> -		/* Keep wakeup interrupts disabled until suspend */
> -		irq_set_status_flags(irq, IRQ_NOAUTOEN);
> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> -					qcom_dwc3_resume_irq,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> -					"qcom_dwc3 HS", qcom);
> -		if (ret) {
> -			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
> +		ret = dwc3_qcom_prep_irq(qcom, "hs_phy_irq",
> +						"qcom_dwc3 HS", irq);

Please leave these lines unwrapped.

Nice cleanup.

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn
