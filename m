Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855E0773EF2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjHHQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjHHQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:38:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DCB3A4DF;
        Tue,  8 Aug 2023 08:54:10 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37858eka010911;
        Tue, 8 Aug 2023 08:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ub00QPPpk/iL7zcoQhlqqhUzZpIWn5fLPHHt0AbE4WQ=;
 b=Mb9y5DBEtG42ZQ1OsA6AVslg9FTOzLa/z/YnwK/+Wug/7oRDhRpYg32ue7zITP3Yzhxn
 CrVFYHqrF0UIWCb4lktbxn0RDiGbljSDQsGPZkG1fS1SDjfgiGbb9KctbjHxx/54el1q
 AVpYyQsEkYsNsAwvYFYXW+ik7KbsilCIjEdGRWhaBaTSvZ4vzQ4AJ4TGuPc3w2oIIhFU
 vVCC1TKr+zgt2dutGQ6uhSUK0uD0BoGpC3jpKU3eAAiUtqwt57mLZTkGTRIoZySAd1t7
 hyV1ekD1hpSBERevrYRl1fRT+WuEDIXcUmP2TnPNpzPji0WaMfKGbA+2jSTBRx5kopkL 6w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbcacrn0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 08:32:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3788WU28012945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 08:32:30 GMT
Received: from [10.216.8.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 01:32:24 -0700
Message-ID: <dc800b15-e35d-207b-73a8-9a3d2261f4f5@quicinc.com>
Date:   Tue, 8 Aug 2023 14:02:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v10 06/11] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
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
X-Proofpoint-GUID: 77Zs1XQU6JxIJkvWcShiIMdEHzrE2gaC
X-Proofpoint-ORIG-GUID: 77Zs1XQU6JxIJkvWcShiIMdEHzrE2gaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080076
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  +
>> +enum dwc3_qcom_phy_irq_identifier {
>> +	HS_PHY_IRQ = 0,
>> +	DP_HS_PHY_IRQ,
>> +	DM_HS_PHY_IRQ,
>> +	SS_PHY_IRQ,
>>   };
> 
> This enum is unused.
> 

Hi Bjorn,

  I didn't use the enum directly, but used its members in the 
get_port_irq call below.

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
>> +
>> +	return acpi_index;
>> +}
>> +
>> +static int dwc3_get_port_irq(struct platform_device *pdev, u8 port_index)
>> +{
>> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>> +	bool is_mp_supported = (qcom->data->num_ports > 1) ? true : false;
>> +	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
>> +	char *disp_name;
>> +	int acpi_index;
>> +	char *dt_name;
>> +	int ret;
>> +	int irq;
>> +	int i;
>> +
>> +	/*
>> +	 * We need to read only DP/DM/SS IRQ's here.
>> +	 * So loop over from 1->3 and accordingly modify respective phy_irq[].
>> +	 */
>> +	for (i = 1; i < MAX_PHY_IRQ; i++) {
>> +
>> +		if (!is_mp_supported && (port_index == 0)) {
>> +			if (i == DP_HS_PHY_IRQ) {
>> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"dp_hs_phy_irq");
>> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"qcom_dwc3 DP_HS");
>> +			} else if (i == DM_HS_PHY_IRQ) {
>> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"dm_hs_phy_irq");
>> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"qcom_dwc3 DM_HS");
>> +			} else if (i == SS_PHY_IRQ) {
>> +				dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"ss_phy_irq");
>> +				disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +					"qcom_dwc3 SS");
Bjorn, Konrad,

If we are to remove this repetitive loops, we might need to make a 2D 
array for all of Dp/Dm/Ss interrutps and make a global array of names to 
be used for irq lookup and use them to reduce the if-else-if stuff here. 
If that is fine, I can make those changes, else I would like to stick to 
this approach for now because if we don't add the global array of names, 
prepping them seperately for dp/dm/ss would again lead us to making 
if-else loops like above.

Please let me know your thoughts on this.

Regards,
Krishna,
