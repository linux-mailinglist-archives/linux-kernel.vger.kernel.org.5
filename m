Return-Path: <linux-kernel+bounces-164763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C748B8235
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCB32848B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3411BF6CE;
	Tue, 30 Apr 2024 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="coTFXNn6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE131A0AF9;
	Tue, 30 Apr 2024 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514279; cv=none; b=bR0fxVDTSQK+SxALJGOAM3TB2ZqO650mqFxw2yGatATq/plzmo7rqbSuh3lZlSpHZgqTy7R6OXUO9mpkzIKX8bF2vWVIrb47IBspns3bJcPd0HcFruPKtYUO9hTLD6iBH/F2fDST5gU2Our4z4NxEWldLk/C14IAOOyKqXkOFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514279; c=relaxed/simple;
	bh=i/PgM4+9YzpPI2JE/sWr4KRAmUULs5TogIsWAyenxRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z5Jk6IVwFp+IMsxPBD5COcj0Mbda4X5GhRLW6NFQYLlEGDDwslI0o3S2cYZf3CPIYjzbUJh/GV+T6Idq2+XhenESN4nLe4vxmTW4z/VLY3nFips2HXPZKsUgHyz4S3uZWWaaGGzhYd1d5whnFDWjA1nUTm9QGnX7TK0omSdqe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=coTFXNn6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UKethg001390;
	Tue, 30 Apr 2024 21:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7jhPW16fQo6HuFqRFyf89B8cImkfjn+GX5pu77TR1SI=; b=co
	TFXNn60mugFAdEwR/rk1bX9OZnL0IrglDSqwbRyCM86GmPpHuDz8D0AEPLEIXReI
	hdo9LmpsbFHukvu2xZ9atp14ezXNnTYbWP600jSfTAst8TMmNSfwvTFJqQaIlyCS
	AxHxwzGIbBkA9vT+53N6ZPeu96VsEbU3gGW1yLs/518ZmDXChX/vllnHDBttyval
	FdTGHaG1DNdJJdUNpgSkmGNxKuSKEPR+x2NvlWmruNelZwUc9lMZelrmsEhuoxo3
	DDW3E02DL2ys3efX7CFnBDfF2LEwvPevTQoQisg1jnuAoMr3UzlDJRSSNLgXjdJn
	YRgCp0Rzr0momctfL7cw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvv80b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 21:57:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ULvTaL030479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 21:57:29 GMT
Received: from [10.110.61.50] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 14:57:29 -0700
Message-ID: <33dfa0c5-c43f-79f6-2700-beee2e5d389f@quicinc.com>
Date: Tue, 30 Apr 2024 14:57:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v20 03/41] usb: host: xhci: Repurpose event handler for
 skipping interrupter events
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
 <20240425215125.29761-4-quic_wcheng@quicinc.com>
 <12d29c54-c005-7112-0933-d9d28f11abd6@linux.intel.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <12d29c54-c005-7112-0933-d9d28f11abd6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UId7krUyvkycsAgm6iTt_AwrnACSfBku
X-Proofpoint-GUID: UId7krUyvkycsAgm6iTt_AwrnACSfBku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_13,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300156

Hi Mathias,

On 4/30/2024 4:02 AM, Mathias Nyman wrote:
> On 26.4.2024 0.50, Wesley Cheng wrote:
>> Depending on the interrupter use case, the OS may only be used to handle
>> the interrupter event ring clean up.  In these scenarios, event TRBs 
>> don't
>> need to be handled by the OS, so introduce an xhci interrupter flag to 
>> tag
>> if the events from an interrupter needs to be handled or not.
> 
> Could you elaborate on this a bit.
> 
> If I understood correctly the whole point of requesting a secondary xhci 
> interrupter
> for the sideband device without ever requesting a real interrupt for it 
> was to avoid
> waking up the cpu and calling the interrupt handler.
> 

Yes, this is the correct understanding.  We don't currently register the 
separate interrupt line (from GIC) for the secondary interrupter, so the 
main apps proc doesn't get interrupted on events generated on the 
secondary interrupter.

> with this flag is seems the normal xhci interrupt handler does get 
> called for
> sideband transfer events.
> 

Main intention was to utilize the refactoring you did to expose the 
xhci_handle_event_trb() for both handling events on the main 
interrupter, as well as the logic to skip events on the secondary 
interrupter.

https://lore.kernel.org/linux-usb/44a3d4db-7759-dd93-782a-1efbebfdb22c@linux.intel.com/

>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/host/xhci-ring.c | 17 +++++++++++++----
>>   drivers/usb/host/xhci.h      |  1 +
>>   2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index 52278afea94b..6c7a21f522cd 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -2973,14 +2973,22 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>>   }
>>   /*
>> - * This function handles one OS-owned event on the event ring. It may 
>> drop
>> - * xhci->lock between event processing (e.g. to pass up port status 
>> changes).
>> + * This function handles one OS-owned event on the event ring, or 
>> ignores one event
>> + * on interrupters which are non-OS owned. It may drop xhci->lock 
>> between event
>> + * processing (e.g. to pass up port status changes).
>>    */
>>   static int xhci_handle_event_trb(struct xhci_hcd *xhci, struct 
>> xhci_interrupter *ir,
>>                    union xhci_trb *event)
>>   {
>>       u32 trb_type;
>> +    /*
>> +     * Some interrupters do not need to handle event TRBs, as they 
>> may be
>> +     * managed by another entity, but rely on the OS to clean up.
>> +     */
>> +    if (ir->skip_events)
>> +        return 0;
>> +
> 
> I think we need another solution than a skip_events flag.
> 
> To make secondary xhci interrupters more useful in general it would make 
> more
> sense to add an interrupt handler function pointer to struct 
> xhci_interrupter.
> 
> Then call that function instead of xhci_handle_event_trb()
>

I agree that is how it should be for when support for actually utilizing 
secondary interrupters for routing events to different targets (instead 
of offloading).  However, since I don't have an existing use case that 
will exercise this functionality, its a bit difficult to verify that it 
should be working the way it was intended.

> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -3098,8 +3098,8 @@ static int xhci_handle_events(struct xhci_hcd 
> *xhci, struct xhci_interrupter *ir
> 
>          /* Process all OS owned event TRBs on this event ring */
>          while (unhandled_event_trb(ir->event_ring)) {
> -               err = xhci_handle_event_trb(xhci, ir, 
> ir->event_ring->dequeue);
> -
> +               if (ir->handle_event_trb)
> +                       err = ir->handle_event_trb(xhci, ir, 
> ir->event_ring->dequeue);
>                  /*
>                   * If half a segment of events have been handled in one 
> go then
>                   * update ERDP, and force isoc trbs to interrupt more 
> often
> 
> The handler function would be passed to, and function pointer set in
> xhci_create_secondary_interrupter()
> 
> For primary interrupter it would always be set to xhci_handle_event_trb()
> 

Yes, definitely agree with this for when we introduce support for 
handling the secondary interrupter GIC line within the apps proc itself. 
  Would prefer if we took up that effort in another series, but willing 
to go back to the skip events loop previously implemented if the above 
change isn't where you want to go with this.

Thanks
Wesley Cheng

> Thanks
> Mathias
> 

