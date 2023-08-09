Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611C077664F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjHIRWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjHIRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:22:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E8DA;
        Wed,  9 Aug 2023 10:22:13 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379F7YDh005276;
        Wed, 9 Aug 2023 17:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sm3j7VgayPsDUlrykA9iKDac5VQ++FXQuCp6jmO/X6o=;
 b=PE+q20I+mgLl0eF0Ruz05/EVgKnxMYisJsd01+w4NsKD5a3URe3LHTFJ2KXi45ZrJUKc
 vyIgKcjkQ46UqAiEc3sLaW4USyLCWo6xcUeOrVcmbRZE+co7MGOFOl1eXn+k3IPA+U1/
 mSu5GEi+A3Gy9F4IZURw/tz6ysaywOC1c/NJF1ROnIhN0K1jHmuUPN/tp0oyRChBzDZJ
 /dtsP8kz6at11xcitozh/NCu6C/iYr3Czh+QRKqIiGIscn7sej07IfV3OzDlKyjmtyOr
 0Fld1FYwtXjjB5hpOLXE16VhRAe85kxZqBtLuq+95/wk/XosRUWBQ+EAMUrF6T3+qDhs BA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbp17kbt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 17:22:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379HM31S028113
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 17:22:03 GMT
Received: from [10.216.52.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 10:21:57 -0700
Message-ID: <9be10770-d3df-467e-0541-8839bcd22fee@quicinc.com>
Date:   Wed, 9 Aug 2023 22:51:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND] tty: serial: qcom-geni-serial: Poll primary
 sequencer irq status after cancel_tx
Content-Language: en-CA
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     <agross@kernel.org>, <bjorn.andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <bartosz.golaszewski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <dianders@chromium.org>, <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>
References: <1691583100-15689-1-git-send-email-quic_vnivarth@quicinc.com>
 <20230809091951.fbcc682d00deacd4d7b55b44@hugovil.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <20230809091951.fbcc682d00deacd4d7b55b44@hugovil.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AS5TP4EygJbGJ_QRDRCmDpR07OnZxLbT
X-Proofpoint-GUID: AS5TP4EygJbGJ_QRDRCmDpR07OnZxLbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090152
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you very much for the review...


On 8/9/2023 6:49 PM, Hugo Villeneuve wrote:
> On Wed,  9 Aug 2023 17:41:40 +0530
> Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com> wrote:
>
>> TX is handled by primary sequencer. After cancelling primary command, poll
>> primary sequencer's irq status instead of that of secondary.
> Hi,
> it is not clear to me if this is a bug fix or an improvement?
This is a bug fix.
>
>> While at it, also remove a couple of redundant lines that read from IRQ_EN
>> register and write back same.
> This should go into a separate patch.

The changes were too close by so I wasn't sure it could be split into 2 
patches.

I see that the earlier patch has already been signed off by Greg. (I did 
a RESEND after realising that I had Bjorn Andersson's email address 
incorrect)

Will post another version if original patch doesn't get merged for any 
reason.

Thank you,

Vijay/


>
> Hugo Villeneuve.
>
>
>> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 3ca5db2..b8aa4c1 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -591,7 +591,6 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
>>   {
>>   	struct qcom_geni_serial_port *port = to_dev_port(uport);
>>   	bool done;
>> -	u32 m_irq_en;
>>   
>>   	if (!qcom_geni_serial_main_active(uport))
>>   		return;
>> @@ -603,12 +602,10 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
>>   		port->tx_remaining = 0;
>>   	}
>>   
>> -	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>> -	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>>   	geni_se_cancel_m_cmd(&port->se);
>>   
>> -	done = qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
>> -					 S_CMD_CANCEL_EN, true);
>> +	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>> +					 M_CMD_CANCEL_EN, true);
>>   	if (!done) {
>>   		geni_se_abort_m_cmd(&port->se);
>>   		done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>> -- 
>> 2.7.4
>>
