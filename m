Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E6B805F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjLEUPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:15:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87304D3;
        Tue,  5 Dec 2023 12:15:41 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5KCPfO027444;
        Tue, 5 Dec 2023 20:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uEhLb0Ninn2CfLq9LAvSGMVPwpAwACXLQKE397HR4Ls=;
 b=Jhhq4y0rTm8z9lqLHFXr7p/UQ+YEG6vzMG5kuZ8XoqpSOb5K7CcbVC4rigAkJCoymTHf
 +nE8Bl4Xrls64ESwXoyW493HBm60tStq9EdzCYhtGHfCwrPaAPejx93/i16rYNwhGy06
 +9Mq6NAQIIIRpEIU/++iMA25QgWxCEZ3MbSgX742DVgW7REitM0D9Jiz/cJJYdTAd6zT
 6mjAVwHW1UHw3vPQIwkL0n74Hwn/m19wP5qvX3hyvqqiI3dkt3SN/e3kcHDleWTe4Ct9
 I0sV3esCO4MjHCQ8UGY4KoJy3q4ez/N+Ycgy88rWb+aep+bWr5x+3k3APX7eOkv4NEEr iA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utapgr07y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 20:15:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B5KAlxN011615
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 20:10:47 GMT
Received: from [10.110.40.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 12:10:47 -0800
Message-ID: <5aa271d5-1d7b-ed6a-2066-ad86ed5edc8b@quicinc.com>
Date:   Tue, 5 Dec 2023 12:10:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: gadget: Handle EP0 request dequeuing properly
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231121232003.20249-1-quic_wcheng@quicinc.com>
 <20231205014647.jvw5yscdn232nddk@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20231205014647.jvw5yscdn232nddk@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r-xYL6KFRaqQzd-Vu9pawnS-TyEASiOv
X-Proofpoint-GUID: r-xYL6KFRaqQzd-Vu9pawnS-TyEASiOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_15,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312050160
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 12/4/2023 5:46 PM, Thinh Nguyen wrote:
> On Tue, Nov 21, 2023, Wesley Cheng wrote:
>> Current EP0 dequeue path will share the same as other EPs.  However, there
>> are some special considerations that need to be made for EP0 transfers:
>>
>>    - EP0 transfers never transition into the started_list
>>    - EP0 only has one active request at a time
>>
>> In case there is a vendor specific control message for a function over USB
>> FFS, then there is no guarantee on the timeline which the DATA/STATUS stage
>> is responded to.  While this occurs, any attempt to end transfers on
>> non-control EPs will end up having the DWC3_EP_DELAY_STOP flag set, and
>> defer issuing of the end transfer command.  If the USB FFS application
>> decides to timeout the control transfer, or if USB FFS AIO path exits, the
>> USB FFS driver will issue a call to usb_ep_dequeue() for the ep0 request.
>>
>> In case of the AIO exit path, the AIO FS blocks until all pending USB
>> requests utilizing the AIO path is completed.  However, since the dequeue
>> of ep0 req does not happen properly, all non-control EPs with the
>> DWC3_EP_DELAY_STOP flag set will not be handled, and the AIO exit path will
>> be stuck waiting for the USB FFS data endpoints to receive a completion
>> callback.
>>
>> Fix is to utilize dwc3_ep0_reset_state() in the dequeue API to ensure EP0
>> is brought back to the SETUP state, and ensures that any deferred end
>> transfer commands are handled.  This also will end any active transfers
>> on EP0, compared to the previous implementation which directly called
>> giveback only.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/dwc3/gadget.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 858fe4c299b7..88d8d589f014 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2103,7 +2103,17 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>>   
>>   	list_for_each_entry(r, &dep->pending_list, list) {
>>   		if (r == req) {
>> -			dwc3_gadget_giveback(dep, req, -ECONNRESET);
>> +			/*
>> +			 * Explicitly check for EP0/1 as dequeue for those
>> +			 * EPs need to be handled differently.  Control EP
>> +			 * only deals with one USB req, and giveback will
>> +			 * occur during dwc3_ep0_stall_and_restart().  EP0
>> +			 * requests are never added to started_list.
>> +			 */
>> +			if (dep->number > 1)
>> +				dwc3_gadget_giveback(dep, req, -ECONNRESET);
>> +			else
>> +				dwc3_ep0_reset_state(dwc);
>>   			goto out;
>>   		}
>>   	}
> 
> Should we add Fixes tag?
> 

Sure will add and resubmit.

Thanks
Wesley Cheng
