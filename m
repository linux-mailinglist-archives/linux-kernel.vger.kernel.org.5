Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24BD75C326
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGUJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGUJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:36:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7EE30EC;
        Fri, 21 Jul 2023 02:36:04 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L67sqS004103;
        Fri, 21 Jul 2023 09:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hT/Hvkvkw2UyT6qEmcVlLXgM/BmaZd0oKyvjZLonQa4=;
 b=P8RYka+hNHRKTLiGkw7IQJeFOoHCXsOAk1rfECNawsxF7ZhVzqK+Ii6GDmcfkkjOtjXG
 T565kR+TPn7qmBGIKstYY884d/HUw8enKy1tT5PHLVydp0BIO0PY6Q0h0po9L/C9zl2K
 bUuXqpYIRp7IdHxcrqCaLoV2+kU4oDMp9dcy4NcMA5hzdxrX6q2rTPQH75iQsQZ4/uS9
 KNZbBc86jO7jd7YY9W1oNXhOjPkih67gh/T1qw9+s4kYB7ijAcSy43yvsx4lunul6rqi
 lMR7AbC9iWjq+yurCPSihMJOq/5d7arjfQKukltQspMxEKo4dJ42n1vNSpNpZqGZrd/w UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxpyqv2ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 09:35:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L9ZkWa014502
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 09:35:46 GMT
Received: from [10.216.63.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 02:35:40 -0700
Message-ID: <4b58fdfa-83a4-290b-f7e8-e82feba4586a@quicinc.com>
Date:   Fri, 21 Jul 2023 15:05:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZJryrhuUrL5APh4o@hovoldconsulting.com>
 <7e32cf95-1565-5736-cc3e-c70e8d8f3ca7@quicinc.com>
 <ZLo-feuIr2FzCoxa@hovoldconsulting.com>
 <f6f2456d-0067-6cd6-3282-8cae7c47a2d3@quicinc.com>
 <ZLpOI9ZAHb_AB_Fr@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZLpOI9ZAHb_AB_Fr@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0C-ftZxKohf9FxNmafqt0CU_SvWSKlmB
X-Proofpoint-ORIG-GUID: 0C-ftZxKohf9FxNmafqt0CU_SvWSKlmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=418 malwarescore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307210084
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 2:51 PM, Johan Hovold wrote:
> Again, please remember to trim your replies.
> 
> On Fri, Jul 21, 2023 at 01:49:37PM +0530, Krishna Kurapati PSSNV wrote:
>> On 7/21/2023 1:44 PM, Johan Hovold wrote:
>>> On Mon, Jul 03, 2023 at 12:29:41AM +0530, Krishna Kurapati PSSNV wrote:
>>>> On 6/27/2023 8:01 PM, Johan Hovold wrote:
> 
> [...]
> 
>>>>> So the above should all be merged in either a single helper looking up
>>>>> all the interrupts for a port and resused for the non-MP case.
> 
>>    How about the implementation in the attached patches. This way we
>> don't need to know if we are multiport capable or not.
> 
> As I wrote above, I think you should instead add a common helper for
> setting up all the interrupts for a port. For example, along the lines
> of:
> 
> 	dwc3_setup_port_irq(int index)
> 	{
> 		if (index == 0)
> 			try non-mp name
> 		else
> 			generate mp name
> 
> 		lookup and request hs irqs
> 		lookup and request ss irq
> 		lookup and request power irq
> 	}
> 
> 	dwc3_setup_irq()
> 	{
> 		determine if MP (num_ports)
> 
> 		for each port
> 			dwc3_setup_port_irq(port index)
> 	}
> The port irq helper can either be told using a second argument that this
> is a non-mp controller, or you can first try looking up one of the
> non-mp names.
> 


I think I did something similar. I prepared a helper to request IRQ in 
the patch and the main logic would reside in setup_irq where i would try 
and get IRQ's.

Irrespective of whether we are MP capable or not, how about we read all 
IRQ's like in the patch attached previously. And the implementation 
facilitates addition of ACPI to multiport also if required. I am just 
trying to cover all cases like this by declaring IRQ info in global section.

static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, char *irq_name,
                                char *disp_name, int irq)
{
        int ret;

        /* Keep wakeup interrupts disabled until suspend */
        irq_set_status_flags(irq, IRQ_NOAUTOEN);
        ret = devm_request_threaded_irq(/* Give inouts here*/);
        if (ret)
               dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);

        return ret;
}


static int dwc3_qcom_setup_irq(struct platform_device *pdev)
{
   for (DP_IRQ[ i = 0-3] {
      try getting dp_irq_i using MP_IRQ strings
      if ((ret < 0)  and (i == 0))
	try getting dp_irq_i using NON_MP_IRQ strings

      call prep_irq accordingly.
   }

   //Run same loop for DM and SS
}

The second patch was just enabling IRQ's for all ports to support wakeup.

> My mailer discarded your second patch, but you cannot assume that the
> devices connected to each port are of the same type (e.g. HS or SS)
> based on what is connected to the first port.
> 
Are you referring to enabling IRQ's for different ports before going to 
suspend ? Meaning get the speed of enum on each port and accordingly 
enable IRQ's ?

Regards,
Krishna,
