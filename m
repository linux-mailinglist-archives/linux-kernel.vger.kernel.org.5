Return-Path: <linux-kernel+bounces-156569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03CA8B04A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14ACB23D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17187156C78;
	Wed, 24 Apr 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XVftnutz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88224157E9B;
	Wed, 24 Apr 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948304; cv=none; b=H5yA4PC8Tdbc+uFqvfrOu/ga6+Of+/cX4ZETjbbsYKVYBt9iO3Qgifr2GSiy7fgbYBI27hZ8bpvb13Xx/ZIlLZ8V8bCkkoGSzKfYG8C1zE4OL/wvMkgBACpmvEayUQy58xRziKx7uxjEQMKiWqd45DFrYzSsRyxpprw2fduyJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948304; c=relaxed/simple;
	bh=m6mPgGR3XU4U9ytPY5b8+9BmtF5hVjUzrdM+TlTLqvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D4DWiY3ecd7+1NMhQFRG4a5nrcZkQ4Quh35mQOkQ5RStrdurfxlDabog9OHVJxg5tHjkG9GOe/aAAgDvdnhlsTyoo/qPkH3vLB4UMGUt3CUxjQi/OdneCTOEB1dpYWex2YhXiiw6bLvXWAoEPpyAniUtnHv6xqBcKSrxR5ymSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XVftnutz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6Wwsi002725;
	Wed, 24 Apr 2024 08:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qlhC4LA3WR9b0s8i7i7LeULjyk7Shhr2cVGV9FtwGWQ=; b=XV
	ftnutzfgnLwSOg2pmA7z6lzo0+WKICXjOGaWUp5lLnLu2cJwRle+9M10bAsURAdm
	2+Spoi11jPGAFvHEOnL+ltXkv7Ic8WtYJVnEdt4uDkMkWMwsyf0Uq6vkX6CZmJ8F
	jI3BipjRPk+heSMsoKxO5Tw27gKXqQ34/ceodcDcvecoCX4/LFJ27yzUHDg5oF49
	Hg6amhN0EXFhPVNUCQqbTt0ie4HK1vmioDwNhOHUutnI6ekcSXq/Dz9yrUA1ZjTs
	RVF+z3U3KUk8iDhe9G4Oa2FDJ8F3BA3rY+nU/4Xj18j12X17rz3Fs4NJG1lQL2og
	aACoLAq/mi4wS3EiNgqQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e0bbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 08:44:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O8iwgN026882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 08:44:58 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 01:44:55 -0700
Message-ID: <168904cd-4806-0473-085d-43df45efba65@quicinc.com>
Date: Wed, 24 Apr 2024 14:14:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] usb: dwc3: Poll CMDACT after issuing EndXfer command
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
References: <20240422090539.3986723-1-quic_prashk@quicinc.com>
 <20240424013342.5itkoewx7jdonyk4@synopsys.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240424013342.5itkoewx7jdonyk4@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Tk-3iSxN75HC3TZlHHcU3bi9P02sl4pT
X-Proofpoint-ORIG-GUID: Tk-3iSxN75HC3TZlHHcU3bi9P02sl4pT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_06,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxlogscore=663 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240037



On 24-04-24 07:03 am, Thinh Nguyen wrote:
> On Mon, Apr 22, 2024, Prashanth K wrote:
>> Currently DWC3 controller revisions 3.10a and later supports
> 
> DWC3 -> DWC_usb3 to highlight not being DWC_usb31 and DWC_usb32.
> 
>> GUCTL[14: Rst_actbitlater] bit which allows polling CMDACT bit
> 
> GUCTL -> GUCTL2
> 
>> to know whether ENDXFER command is completed. Other revisions
>> wait 1ms for ENDXFER completion after issuing the command.
>>
>> Consider a case where an IN request was queued, and parallelly
>> soft_disconnect was called (due to ffs_epfile_release). This
>> eventually calls stop_active_transfer with IOC cleared, hence
>> send_gadget_ep_cmd() skips waiting for CMDACT cleared during
>> endxfer. For DWC3 controllers with revisions >= 310a, we don't
>> forcefully wait for 1ms either, and we proceed by unmapping the
>> requests. If ENDXFER didn't complete by this time, it leads to
>> SMMU faults since the controller would still be accessing those
>> requests.
>>
>> DWC3 databook specifies that CMDACT bit can be polled to check
>> completion of the EndXfer. Hence use it in stop_active_transfer
>> to know whether the ENDXFER got completed.
>>
>> Section 3.2.2.7 Command 8: End Transfer (DEPENDXFER)
>> Note: If GUCTL2[Rst_actbitlater] is set, Software can poll the
>> completion of the End  Transfer command by polling the command
>> active bit to be cleared to 0.
>>
>> Fixes: b353eb6dc285 ("usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
>>   drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 4df2661f6675..acb54c48451f 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1701,8 +1701,8 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>>   {
>>   	struct dwc3 *dwc = dep->dwc;
>>   	struct dwc3_gadget_ep_cmd_params params;
>> -	u32 cmd;
>> -	int ret;
>> +	u32 cmd, reg;
>> +	int ret, retries = 500;
> 
> Please separate variable declarations per line.
> 
>>   
>>   	cmd = DWC3_DEPCMD_ENDTRANSFER;
>>   	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
>> @@ -1726,6 +1726,24 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>>   	if (!interrupt) {
>>   		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
>>   			mdelay(1);
>> +		else {
>> +			/*
>> +			 * ENDXFER polling is available on version 3.10a and later of
> 
> Try to note the IP along with version (eg. DWC_usb3 v3.10a).
> 
Will update all of the above in next patch.

>> +			 * the DWC3 controller (This is enabled by setting GUCTL2[14])
> 
> Did we check to know that we set GUCTL2.Rst_actbitlater to start
> polling for CMDACT?
GUCTL2[14] is set only for DWC3_usb3 controllers prior to version 310a, 
because the register is not available for other versions/revisions.

dwc3/core.c - dwc3_core_init()
	/*
	 * ENDXFER polling is available on version 3.10a and later of
	 * the DWC_usb3 controller. It is NOT available in the
	 * DWC_usb31 controller.
	 */
	if (DWC3_VER_IS_WITHIN(DWC3, 310A, ANY)) {
		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
		reg |= DWC3_GUCTL2_RST_ACTBITLATER;
		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
	}

Hence the we have added the CMDACT polling in else case of the following 
check in __dwc3_stop_active_transfer().

if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))

> 
>> +			 */
>> +			do {
>> +				reg = dwc3_readl(dep->regs, DWC3_DEPCMD);
>> +				if (!(reg & DWC3_DEPCMD_CMDACT))
>> +					break;
>> +				udelay(2);
> 
> udelay of 2 is really small. Try at least 200us.
Agreed, Will make it 200us with 5 retries. I'm not really sure how many 
retries we need here. I just made the aggregate to 1ms since we use 1ms 
delay for other revisions.
> 
>> +			} while (--retries);
>> +
>> +			if (!retries && (dwc->ep0state != EP0_SETUP_PHASE)) {
>> +				dep->flags |= DWC3_EP_DELAY_STOP;
>> +				return -ETIMEDOUT;
>> +			}
>> +		}
>> +
>>   		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
>>   	} else if (!ret) {
>>   		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
>> -- 
>> 2.25.1
>>
> 
> Did you observe issues with DWC_usb31? How much longer did your setup
> need to complete End Transfer command?
> 
The problem here is that we are immediately unmapping the request after 
issuing the ENDXER, we aren't waiting for the completion unlike other 
commands.

90.872628:    dbg_send_ep_cmd: ep1in: cmd 'End Transfer' [30c08] params 
00000000 00000000 00000000 --> status: UNKNOWN
90.872652:    dbg_ep_queue: ep1in: req 937bc75c length 0/1069 zsI ==> -108

 From the above traces, we can we see that the time gap between 
send_ep_cmd and dequeue/unmap is 24us, which is pretty small.
And immediately we got an smmu fault (since ENDXFER didn't complete in 
this 24us time-frame). I dumped the DWC3 regs and saw that cmdact was 
not cleared for ep1in which means the cmd never got completed.

90.873360:    [DEPCMD(3): 0xc83c	0x00030C08]
--> CMDACT (bit10) still set.

> I would prefer a solution that applies for all IPs. Do you observe any
> impact should we increase the mdelay()? I don't expect much impact since
> this should only happen during endpoint disbling, which is not a common
> operation.
> 
I checked the following comments in dwc3_stop_active_transfer(), since 
we don't use IOC for ENDXFER, we are use CMDACT polling on revisions 
which supports it, other revisions uses delay of 1ms instead.

But currently for DWC3_usb3 >= 310a, we don't poll cmdact (even though 
it supports it) nor we wait 1ms for command completion. For me waiting 
1ms was also helping, but that doesn't guarantee the  command completion 
though (we just assume that it gets completed by that time).

	 * As of IP version 3.10a of the DWC_usb3 IP, the controller
	 * supports a mode to work around the above limitation. The
	 * software can poll the CMDACT bit in the DEPCMD register
	 * after issuing a EndTransfer command. This mode is enabled
	 * by writing GUCTL2[14]. This polling is already done in the
	 * dwc3_send_gadget_ep_cmd() function so if the mode is
	 * enabled, the EndTransfer command will have completed upon
	 * returning from this function.
	 *
	 * This mode is NOT available on the DWC_usb31 IP.  In this
	 * case, if the IOC bit is not set, then delay by 1ms
	 * after issuing the EndTransfer command.  This allows for the
	 * controller to handle the command completely before DWC3
	 * remove requests attempts to unmap USB request buffers.

But anyways I conducted a small experiment to calculate the ENDXFER cmd 
completion, added traces before writing to DEPCMD and immediately polled 
for the CMDACT to get cleared. Observed that it takes 10-15us on average 
(checked on DWC3_REVISION_310A), but these are the best case scenarios.

191.623016: dwc3_writel: addr xx offset 000c value 00040c08 - write to 
DEPCMD
191.623027: dwc3_readl: addr xx offset 000c value 00040808 -- CMACT cleared
191.623076: dwc3_gadget_ep_cmd: ep2out: cmd 'End Transfer' [40c08] 
params 00000000 00000000 00000000 --> status: Successful
.
191.623425: dwc3_writel: addr xx offset 000c value 00070c08
191.623436: dwc3_readl: addr xx offset 000c value 00070808
191.623483: dwc3_gadget_ep_cmd: ep3in: cmd 'End Transfer' [70c08] params 
00000000 00000000 00000000 --> status: Successful

Thanks,
Prashanth K

