Return-Path: <linux-kernel+bounces-10343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A5481D321
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1CF1C2221B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0734A8C13;
	Sat, 23 Dec 2023 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U5hcdZWS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D4CA48;
	Sat, 23 Dec 2023 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BN8SCv8002400;
	Sat, 23 Dec 2023 08:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QSXg0r0K7t8xw6d3E7LKmmEWgDR6KIgpGP+y4KnM42k=; b=U5
	hcdZWSkbsMJlWZO3+otp9BxZjOTZR/QCOtjsl1vssVdVv/OZ8c8OpM1LD+fGi8ks
	upMQEXyjOArH/jHIRSCU3ZUQIccIRDpKpC67U5YZRht5vCezlGx1m5KbI6c9wsSn
	Dfb1LlN9NDU9MfHskX1kp84sT85UJuP2pOEtIzS5q5sGqj/TlMq06IK6jTP8ZtTz
	y5gfREx5XAb5nUH4S6U4dDl8vErl12aj2S5LghzKZ+cwqqEE6UzdVerGdfTlcUWM
	aOeE0t/sU/BZQdf37YLRSbQFy8+YLW12EMgc3IjOf6x0wDJkwiW2pg0mGYdxwBpu
	PqhAbUNXoPSgxona+Iqw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5n8p0hf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Dec 2023 08:32:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BN8WtQe008970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Dec 2023 08:32:55 GMT
Received: from [10.216.46.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 23 Dec
 2023 00:32:53 -0800
Message-ID: <61d4f3f6-dc91-449a-9666-67f1eaca414c@quicinc.com>
Date: Sat, 23 Dec 2023 14:02:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: gadget: Ignore dwc3 interrupt if GEVNTCOUNT
 reads corrupt value
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20231221151620.16030-1-quic_kriskura@quicinc.com>
 <20231222221907.l7s5olt6uubwfjlh@synopsys.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20231222221907.l7s5olt6uubwfjlh@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wp-8x-NR9tJeRJ7Py9K1UlqhkMmbjhMa
X-Proofpoint-ORIG-GUID: Wp-8x-NR9tJeRJ7Py9K1UlqhkMmbjhMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=875
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312230065



On 12/23/2023 3:49 AM, Thinh Nguyen wrote:
> On Thu, Dec 21, 2023, Krishna Kurapati wrote:
>> In the current implementation, the check_event_buf call reads the
>> GEVNTCOUNT register to determine the amount of event data generated
>> and copies it from ev->buf to ev->cache after masking interrupt.
>>
>> During copy if the amount of data to be copied is more than
>> (length - lpos), we fill the ev->cache till the end of 4096 byte
>> buffer allocated and then start filling from the top (lpos = 0).
>>
>> In one instance of SMMU crash it is observed that GEVNTCOUNT register
>> reads more than 4096 bytes:
>>
>> dwc3_readl   base=0xffffffc0091dc000  offset=50188  value=63488
>>
>> (offset = 50188 -> 0xC40C)  -> reads 63488 bytes
>>
>> As per crash dump:
>> dwc->lpos = 2056
>>
>> and evt->buf is at 0xFFFFFFC009185000 and the crash is at
>> 0xFFFFFFC009186000. The diff which is exactly 0x1000 bytes.
>>
>> We first memcpy 2040 bytes from (buf + lpos) to (buf + 0x1000).
>>
>> And then we copy the rest of the data (64388 - 2040) from beginning
>> of dwc->ev_buf. While doing so we go beyond bounds as we are trying
>> to memcpy 62348 bytes into a 4K buffer resulting in crash.
>>
>> Fix this by ignoring the interrupt when GEVNTCOUNT register reads a
>> value more than the event ring allocated.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>> Changes in v2:
>> Instead of fixing amount of data being copied from ring, ignored
>> the interrupt when count is corrupt as per suggestion from Thinh.
>>
>> Link to v1:
>> https://urldefense.com/v3/__https://lore.kernel.org/all/20230521100330.22478-1-quic_kriskura@quicinc.com/__;!!A4F2R9G_pg!ewM3u9Pdk8yD9eU24sOuQqmhm8M2VpGXH8zALqVWGKffGbcJxrtyKKlUPuh8SS2arqO09DjnC9atC3bemEpx-g5UQMllbA$
>>
>>   drivers/usb/dwc3/gadget.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 858fe4c299b7..e27933fdcce3 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -4451,6 +4451,7 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
>>   static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>>   {
>>   	struct dwc3 *dwc = evt->dwc;
>> +	int ret = IRQ_WAKE_THREAD;
> 
> irqreturn_t instead of int?
> 
>>   	u32 amount;
>>   	u32 count;
>>   
>> @@ -4480,6 +4481,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>>   	if (!count)
>>   		return IRQ_NONE;
>>   
>> +	if (count > evt->length) {
>> +		dev_err(dwc->dev, "GEVTCOUNT corrupt\n");
>> +		ret = IRQ_NONE;
>> +		goto done;
>> +	}
>> +
>>   	evt->count = count;
>>   	evt->flags |= DWC3_EVENT_PENDING;
>>   
>> @@ -4493,9 +4500,10 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>>   	if (amount < count)
>>   		memcpy(evt->cache, evt->buf, count - amount);
>>   
>> +done:
>>   	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
> 
> Don't update the GEVNTCOUNT if the read is invalid. We're not processing
> any event, so we should not write back the "count" that we did not
> process.
> 
>>   
Thanks for the review Thinh.

If we don't update, won't the register always be non-zero ? It will keep 
triggering the dwc3_interrupt unnecessarily right ?

Regards,
Krishna,

