Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610D67D2562
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjJVSmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:42:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16BAE0;
        Sun, 22 Oct 2023 11:42:15 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MINZlJ030162;
        Sun, 22 Oct 2023 18:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ritmfuc6Se9Vc4xPKPYBe0LSKU3x8kDYBvVduJlxJa4=;
 b=majhYMf+rJCUvCili4uIdEsm2I4n4ViWotBrIe0Pe8VNUvXLd4Z5FwKM7VFN4z27UOXd
 FKlk9Nkeb/aieN9zha4SKA2KvblKdxK+J9RXvr6BQBUSW2EkK+Ggh3tIKsd0Ca38Gw68
 uyFy+9daHZWTXWA8XeNVL4oVcUSGBvZFof/Kfu+5XWzYpZ37IV9Z2iefCeWfgGgCR0Gv
 Q32xf4JjSSjmqz2ik6CGvKk6PgS+IYRDXj75vKQ7+1CunAUnMWQBUwv21fcEADBv5vc/
 LKPOQ4xSsebPFpfsAQPIQ1I4osjZfOENL2C+LUDebkcS6YBnLBCNsKTiB/bDuBc6Xn3e XA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv7u3tpgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 18:41:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39MIfvam017543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 18:41:57 GMT
Received: from [10.216.52.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 11:41:50 -0700
Message-ID: <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
Date:   Mon, 23 Oct 2023 00:11:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
To:     Johan Hovold <johan@kernel.org>
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
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-6-quic_kriskura@quicinc.com>
 <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -STz74Ajs0z0XUfCN19hAX2Jv6XfQASf
X-Proofpoint-ORIG-GUID: -STz74Ajs0z0XUfCN19hAX2Jv6XfQASf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310220172
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 6:53 PM, Johan Hovold wrote:
> First, drop "QCOM Glue driver" from Subject, you already have the "qcom"
> prefix.
> 
> On Sat, Oct 07, 2023 at 09:18:01PM +0530, Krishna Kurapati wrote:
>> Refactor setup_irq call to facilitate reading multiport IRQ's along
> 
> "IRQs" or just "interrupts"
> 
>> with non mulitport ones. Read through the interrupt-names property
> 
> "multiport"
> 
> Please spell check all your patches (commit messages and code) before
> posting, it's not the reviewers job.
> 
>> to figure out, the type of interrupt (DP/DM/HS/SS) and to which port
>> it belongs. Also keep track of port index to calculate port count
>> based on interrupts provided as input in DT.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 210 +++++++++++++++++++++++++----------
>>   1 file changed, 154 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index ef2006db7601..863892284146 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -53,14 +53,25 @@
>>   #define APPS_USB_AVG_BW 0
>>   #define APPS_USB_PEAK_BW MBps_to_icc(40)
>>   
>> +#define NUM_PHY_IRQ		4
>> +
>> +enum dwc3_qcom_ph_index {
> 
> "phy_index"
> 
>> +	DP_HS_PHY_IRQ_INDEX = 0,
>> +	DM_HS_PHY_IRQ_INDEX,
>> +	SS_PHY_IRQ_INDEX,
>> +	HS_PHY_IRQ_INDEX,
>> +};
>> +
>>   struct dwc3_acpi_pdata {
>>   	u32			qscratch_base_offset;
>>   	u32			qscratch_base_size;
>>   	u32			dwc3_core_base_size;
>> +	/*
>> +	 * The phy_irq_index corresponds to ACPI indexes of (in order) DP/DM/SS
>> +	 * IRQ's respectively.
>> +	 */
>> +	int			phy_irq_index[NUM_PHY_IRQ - 1];
>>   	int			hs_phy_irq_index;
>> -	int			dp_hs_phy_irq_index;
>> -	int			dm_hs_phy_irq_index;
>> -	int			ss_phy_irq_index;
>>   	bool			is_urs;
>>   };
>>   
>> @@ -73,10 +84,12 @@ struct dwc3_qcom {
>>   	int			num_clocks;
>>   	struct reset_control	*resets;
>>   
>> +	/*
>> +	 * The phy_irq corresponds to IRQ's registered for (in order) DP/DM/SS
>> +	 * respectively.
>> +	 */
>> +	int			phy_irq[NUM_PHY_IRQ - 1][DWC3_MAX_PORTS];
>>   	int			hs_phy_irq;
>> -	int			dp_hs_phy_irq;
>> -	int			dm_hs_phy_irq;
>> -	int			ss_phy_irq;
> 
> I'm not sure using arrays like this is a good idea (and haven't you
> switched the indexes above?).
> 
> Why not add a port structure instead?
> 
> 	struct dwc3_qcom_port {
> 		int hs_phy_irq;
> 		int dp_hs_phy_irq;
> 		int dm_hs_phy_irq;
> 		int ss_phy_irq;
> 	};
> 
> and then have
> 
> 	struct dwc3_qcom_port ports[DWC3_MAX_PORTS];
> 
> in dwc3_qcom. The port structure can the later also be amended with
> whatever other additional per-port data there is need for.
> 
> This should make the implementation cleaner.
> 
> I also don't like the special handling of hs_phy_irq; if this is really
> just another name for the pwr_event_irq then this should be cleaned up
> before making the code more complicated than it needs to be.
> 
> Make sure to clarify this before posting a new revision.
> 

hs_phy_irq is different from pwr_event_irq.
AFAIK, there is only one of this per controller.

>> -static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, char *irq_name,
>> -				char *disp_name, int irq)
>> +static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, const char *irq_name,
>> +				const char *disp_name, int irq)
> 
> Ok, here you did drop the second name parameter, but without renaming
> the first and hidden in a long diff without any mention anywhere.
> 
I didn't understand the comment. Can you please elaborate.
I didn't drop the second parameter. In the usage of this call, I passed 
same value to both irq_name and disp_name:

"dwc3_qcom_prep_irq(qcom, irq_names[i], irq_names[i], irq);"

I mentioned in cover-letter that I am using same name as obtained from 
DT to register the interrupts as well. Should've mentioned that in 
commit text of this patch. Will do it in next version.

>> +static int dwc3_qcom_get_port_index(const char *irq_name, int irq_index)
>> +{
>> +	int port_index = -1;
>> +
>> +	switch (irq_index) {
>> +	case DP_HS_PHY_IRQ_INDEX:
>> +		if (strcmp(irq_name, "dp_hs_phy_irq") == 0)
>> +			port_index = 1;
>> +		else
>> +			sscanf(irq_name, "dp_hs_phy_%d", &port_index);
>> +		break;
>> +
> 
> No need for newlines after break.
> 
>> +	case DM_HS_PHY_IRQ_INDEX:
>> +		if (strcmp(irq_name, "dm_hs_phy_irq") == 0)
>> +			port_index = 1;
>> +		else
>> +			sscanf(irq_name, "dm_hs_phy_%d", &port_index);
>> +		break;
>> +
>> +	case SS_PHY_IRQ_INDEX:
>> +		if (strcmp(irq_name, "ss_phy_irq") == 0)
>> +			port_index = 1;
>> +		else
>> +			sscanf(irq_name, "ss_phy_%d", &port_index);
>> +		break;
>> +
>> +	case HS_PHY_IRQ_INDEX:
>> +		port_index = 1;
>> +		break;
>> +	}
>> +
>> +	if (port_index > DWC3_MAX_PORTS)
>> +		port_index = -1;
>> +
>> +	return port_index;
>> +}
> 
>>   static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>>   {
>>   	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>> -	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
>> +	struct device_node *np = pdev->dev.of_node;
>> +	const char **irq_names;
>> +	int port_index;
>> +	int acpi_index;
>> +	int irq_count;
>> +	int irq_index;
>>   	int irq;
>>   	int ret;
>> +	int i;
>>   
>> -	irq = dwc3_qcom_get_irq(pdev, "hs_phy_irq",
>> -				pdata ? pdata->hs_phy_irq_index : -1);
>> -	if (irq > 0) {
>> -		ret = dwc3_qcom_prep_irq(qcom, "hs_phy_irq", "qcom_dwc3 HS", irq);
>> -		if (ret)
>> -			return ret;
>> -		qcom->hs_phy_irq = irq;
>> -	}
>> +	irq_count = of_property_count_strings(np, "interrupt-names");
> 
> of_property_count_strings() can return negative errnos and you don't
> have any sanity checks for the return value...
> 
> Please slow down, and also make sure to get your patches reviewed
> internally before posting new revisions.
> 
It did go through internal review but probably went un-noticed. Will add 
sanity checks here and below.

>> +	irq_names = devm_kzalloc(&pdev->dev, sizeof(*irq_names) * irq_count, GFP_KERNEL);
> 
> devm_kcalloc()
> 
>> +	if (!irq_names)
>> +		return -ENOMEM;
>>   
>> -	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
>> -				pdata ? pdata->dp_hs_phy_irq_index : -1);
>> -	if (irq > 0) {
>> -		ret = dwc3_qcom_prep_irq(qcom, "dp_hs_phy_irq", "qcom_dwc3 DP_HS", irq);
>> -		if (ret)
>> -			return ret;
>> -		qcom->dp_hs_phy_irq = irq;
>> -	}
>> +	ret = of_property_read_string_array(np, "interrupt-names",
>> +						irq_names, irq_count);
> 
> No sanity check here either?
> 
>> +	for (i = 0; i < irq_count; i++) {
>> +		irq_index = dwc3_qcom_get_irq_index(irq_names[i]);
>> +		if (irq_index == -1) {
>> +			dev_dbg(&pdev->dev, "Invalid IRQ not handled");
>> +			continue;
>> +		}
> 
> I'll just stop reviewing here. This is a waste of my time.
> 

Regards,
Krishna,
