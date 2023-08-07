Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B3771993
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjHGFrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjHGFrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:47:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB481711;
        Sun,  6 Aug 2023 22:47:25 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3775l6qG013253;
        Mon, 7 Aug 2023 05:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=INOyYg0anY37YW6x8icaKf/SuLlBRNs40P3mnkpCiFQ=;
 b=KhHYjY+Lb1MZ/9cSTt1zhJvu+sPtEzLZ97+gK0VwdL2VrsEvV8jTmex/Pt3O7KMVqgQW
 /IuTUu1o5aX6+Ebh/TM/w0trEgcF6gqAWzUUrD9D4pV2OiSxAgGggm7LeFKLRh8y2ash
 8su8EuP1t+lXdjgYZx6h4ThOREZPS6IVUgp5L3bn9sbY5luy2iIKvpJk3WstMjqmYDKS
 pwpztg5ZrTq4K3LzNIGnkx4QJtYzokeAXOiAwbyrJrpJ7KZ6sFksS1eEOMWmVB24qbcK
 XASJ6tJX6y2yESGkSQDzTklhNqrCA9+DYxn5OkZTjhcEUKr4I/emEBxqnRyrOMrbynt/ Xw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9f6pjkmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 05:47:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3775l5U4017808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 05:47:05 GMT
Received: from [10.216.62.114] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 6 Aug
 2023 22:46:59 -0700
Message-ID: <70b2495f-1305-05b1-2039-9573d171fe24@quicinc.com>
Date:   Mon, 7 Aug 2023 11:16:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v10 06/11] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230727223307.8096-1-quic_kriskura@quicinc.com>
 <20230727223307.8096-7-quic_kriskura@quicinc.com>
 <pyxerd3lirbh2p43m74ohwocjjb7uh56xxmaxbrkay3svossik@ksd3yojw5wgr>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <pyxerd3lirbh2p43m74ohwocjjb7uh56xxmaxbrkay3svossik@ksd3yojw5wgr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f6hm02WNP_RRupHmMY4J6xmm2npvVba_
X-Proofpoint-GUID: f6hm02WNP_RRupHmMY4J6xmm2npvVba_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070052
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/2023 10:41 AM, Bjorn Andersson wrote:
> On Fri, Jul 28, 2023 at 04:03:02AM +0530, Krishna Kurapati wrote:
>> Refactor setup_irq call to facilitate reading multiport IRQ's along
>> with non mulitport ones. For SA8295, there are 4-DP/4-DM and 2-SS
>> IRQ's. Check whether device is multiport capable or not and read all
>> interrupts for DP/DM/SS on each port accordingly.
>> +/*
>> + * Driver needs to read HS/DP_HS/DM_HS/SS IRQ's. Currently, for
>> + * SA8295 which supports mutliport, thre are 4 DP/ 4 DM/ 2 SS IRQ's
>> + * and 1 HS IRQ present. So avoid trying to read HS_PHY_IRQ for 4
>> + * ports of SA8295.
>> + */
> 
> The last part here is relevant information, but it doesn't seem to
> relate to this define.
> 
> Also, does all platforms have this configuration of interrupts?
> 
Hi Bjorn,

Yes, all targets have the same IRQ's. Just that MP one's have multiple 
IRQ's of each type. But hs-phy_irq is only one in SC8280 as well.

>> +#define MAX_PHY_IRQ	4
>> +
>> +enum dwc3_qcom_phy_irq_identifier {
>> +	HS_PHY_IRQ = 0,
>> +	DP_HS_PHY_IRQ,
>> +	DM_HS_PHY_IRQ,
>> +	SS_PHY_IRQ,
>>   };
> 
> This enum is unused.
> 
>>   
> [..]
>> +static int dwc3_get_acpi_index(const struct dwc3_acpi_pdata *pdata, int irq_index)
>> +{
>> +	int acpi_index = -1;
>> +
>> +	if (!pdata)
>> +		return -1;
>> +
>> +	if (irq_index == DP_HS_PHY_IRQ)
>> +		acpi_index = pdata->dp_hs_phy_irq_index;
>> +	else if (irq_index == DM_HS_PHY_IRQ)
>> +		acpi_index = pdata->dm_hs_phy_irq_index;
>> +	else if (irq_index == SS_PHY_IRQ)
>> +		acpi_index = pdata->ss_phy_irq_index;
> 
> It looks favourable to put these in an array, instead of having to pull
> them out of 4 different variables conditionally.
> 
Sure, will move them to an array to remove this if-else stuff.
>> +
>> +	return acpi_index;
>> +		} else {
>> +			if (i == DP_HS_PHY_IRQ) {
>> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"dp_hs_phy_%d", port_index + 1);
>> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"qcom_dwc3 DP_HS%d", port_index + 1);
>> +			} else if (i == DM_HS_PHY_IRQ) {
>> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"dm_hs_phy_%d", port_index + 1);
>> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"qcom_dwc3 DM_HS%d", port_index + 1);
>> +			} else if (i == SS_PHY_IRQ) {
>> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"ss_phy_%d", port_index + 1);
>> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"qcom_dwc3 SS%d", port_index + 1);
>> +			}
> 
> There is too much repetition in this for my liking.
Will try to put dp/dm/ss too in an array in dwc3_qcom structure and 
merge these 3 loops into '1'. But that would mean I need to add a global 
structure to avoid adding if else statements to do proper kasprintf 
stuff. If its fine to add a global array with all names and use them 
here, then it would be easy to merge the loops into one for loop. But if 
we are not supposed to add global array of names, then I would keep 
these 3 repetitive code blocks as is.
> 
>>   		}
>> -		qcom->hs_phy_irq = irq;
>> -	}
>>   
>> -	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
>> -				pdata ? pdata->dp_hs_phy_irq_index : -1);
>> -	if (irq > 0) {
>> -		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> -					qcom_dwc3_resume_irq,
>> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> -					"qcom_dwc3 DP_HS", qcom);
>> -		if (ret) {
>> -			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
>> -			return ret;
>> +		if (!dt_name || !disp_name)
>> +			return -ENOMEM;
>> +
>> +		acpi_index = !is_mp_supported ? dwc3_get_acpi_index(pdata, i) : -1;
>> +
>> +		irq = dwc3_qcom_get_irq(pdev, dt_name, acpi_index);
>> +		if (irq > 0) {
>> +			ret = dwc3_qcom_prep_irq(qcom, dt_name, disp_name, irq);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (i == DP_HS_PHY_IRQ)
>> +				qcom->dp_hs_phy_irq[port_index] = irq;
>> +			else if (i == DM_HS_PHY_IRQ)
>> +				qcom->dm_hs_phy_irq[port_index] = irq;
>> +			else if (i == SS_PHY_IRQ)
>> +				qcom->ss_phy_irq[port_index] = irq;
>>   		}
>> -		qcom->dp_hs_phy_irq = irq;
>>   	}
>>   
>> -	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
>> -				pdata ? pdata->dm_hs_phy_irq_index : -1);
>> +	return 0;
>> +}
>> +
>> +static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>> +{
>> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>> +	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
>> +	int irq;
>> +	int ret;
>> +	int i;
>> +
>> +	irq = dwc3_qcom_get_irq(pdev, "hs_phy_irq",
>> +				pdata ? pdata->hs_phy_irq_index : -1);
>>   	if (irq > 0) {
>> -		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> -					qcom_dwc3_resume_irq,
>> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> -					"qcom_dwc3 DM_HS", qcom);
>> -		if (ret) {
>> -			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
>> +		ret = dwc3_qcom_prep_irq(qcom, "hs_phy_irq", "qcom_dwc3 HS",irq);
>> +		if (ret)
> 
> It would be nice to have this refactored out in a separate commit.
> 
Sure, will add the prep irq in a seperate commit before we read the MP 
IRQ's.
>>   			return ret;
>> -		}
>> -		qcom->dm_hs_phy_irq = irq;
>> +		qcom->hs_phy_irq = irq;
>>   	}
>>   
>> -	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
>> -				pdata ? pdata->ss_phy_irq_index : -1);
>> -	if (irq > 0) {
>> -		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> -					qcom_dwc3_resume_irq,
>> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> -					"qcom_dwc3 SS", qcom);
>> -		if (ret) {
>> -			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
>> +	for (i = 0; i < qcom->data->num_ports; i++) {
>> +		ret = dwc3_get_port_irq(pdev, i);
>> +		if (ret)
>>   			return ret;
>> -		}
>> -		qcom->ss_phy_irq = irq;
>>   	}
>>   
>>   	return 0;
>> @@ -811,6 +905,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, qcom);
>>   	qcom->dev = &pdev->dev;
>>   
>> +	qcom->data = of_device_get_match_data(qcom->dev);
>> +
>>   	if (has_acpi_companion(dev)) {
>>   		qcom->acpi_pdata = acpi_device_get_match_data(dev);
>>   		if (!qcom->acpi_pdata) {
>> @@ -1023,8 +1119,15 @@ static const struct dev_pm_ops dwc3_qcom_dev_pm_ops = {
>>   };
>>   
>>   static const struct of_device_id dwc3_qcom_of_match[] = {
>> -	{ .compatible = "qcom,dwc3" },
>> -	{ }
>> +	{
>> +		.compatible = "qcom,dwc3",
>> +		.data = &qcom_dwc3,
>> +	},
>> +	{
>> +		.compatible = "qcom,sc8280xp-dwc3-mp",
>> +		.data = &sx8280xp_qcom_dwc3,
>> +	},
> 
> I would prefer that we don't add a separate compatible, but rather just
> try to parse the interrupts for multiport and fall back to single port.
> 
> If/when we figure out how to peak into the dwc3 core, we could
> potentially introduce a check to aid the developer.
> 

Only reason I chose this path is it is unabiguous. With this path, we 
don't need to worry about whether the user skipped any irq's in the DT 
or not. If we rely on the IRQ parsing from DT, then we might need to 
calculate effective port count while parsing the irq loop making it 
ambigous and prone to error I believe. I would like to keep this 
compatible as it and use this in the file wherever needed. And since 
peeking into dwc3-core before we call of_platform_populate is not 
possible and we need port_count, I kept a compatible here. I could move 
the setup_irq call to after completion of of_platform_populate, but 
still there is risk of dwc3 probe getting deferred or failing and we end 
up not being able to peek into dwc3.

Request you to reconsider and accept adding a compatible here.

Regards,
Krishna,

