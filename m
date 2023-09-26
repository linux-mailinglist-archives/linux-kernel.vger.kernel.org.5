Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D97AE5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjIZGay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjIZGaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:30:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8636CF2;
        Mon, 25 Sep 2023 23:30:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q4PT08011646;
        Tue, 26 Sep 2023 06:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=R+ia+cvPbH+bAmUJdDBEKuS5Qt5VtNGnE7cTeyzU36c=;
 b=C0i1sssxbEYTw7HFwLJWS0jO2h86SODfro9WKkN7jtM7CjsFnp3Tr/QOfmlgD2TAc/xW
 3418N/Iqby07DTxj+35Hk6vvaosfIo/FA+5OiBHl+NgaJDPZ+99EJ0w1gq4ZCZ4zIpCO
 AzTT+X+1X/ItftZq0D4ssZsgeeu+rzl+nGo5CQEEPpPzh5FDrGiIYIpzimH3ahCKwv0D
 ld3TOBhkg1I8tDjznu88yGpMmS+aBZVloB/KItL/eYbvz/5yIkqZlqqmDFmeD1SFdQJd
 gtaRx9WGDOmYAdLbmPXVD+9BBX3f2aqBogkjIMakvy5yQ6EXGkDqPAalt6k3g9jwuB6t AA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbexgh4n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 06:30:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q6UfvU027087
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 06:30:41 GMT
Received: from [10.216.11.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 23:30:38 -0700
Message-ID: <a2b9e73a-e4eb-4c21-9d85-bf643cb353ca@quicinc.com>
Date:   Tue, 26 Sep 2023 12:00:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v2] usb: gadget: ncm: Handle decoding of multiple NTB's in
 unwrap call
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Linyu Yuan <quic_linyyuan@quicinc.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <stable@vger.kernel.org>
References: <20230915061001.18884-1-quic_kriskura@quicinc.com>
 <2023091743-tightly-drivable-4360@gregkh>
 <a890ac60-0562-48c3-9aa1-eb06ec21c69d@quicinc.com>
Content-Language: en-US
In-Reply-To: <a890ac60-0562-48c3-9aa1-eb06ec21c69d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uA439euBvtP9-O0uDRSYY4dV1SETZexH
X-Proofpoint-GUID: uA439euBvtP9-O0uDRSYY4dV1SETZexH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_04,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=996
 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/2023 1:07 PM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 9/17/2023 1:34 PM, Greg Kroah-Hartman wrote:
>>> Cc: stable@vger.kernel.org
>>
>> What commit id does this fix?
>>
> 
> Hi Greg,
> 
> This fixes the initial patch that added the driver:
> 9f6ce4240a2bf456402c15c06768059e5973f28c
> 
>>> Reviewed-by: Maciej Żenczykowski <maze@google.com>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>>   drivers/usb/gadget/function/f_ncm.c | 26 +++++++++++++++++++-------
>>>   1 file changed, 19 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/function/f_ncm.c 
>>> b/drivers/usb/gadget/function/f_ncm.c
>>> index feccf4c8cc4f..f00f051438ec 100644
>>> --- a/drivers/usb/gadget/function/f_ncm.c
>>> +++ b/drivers/usb/gadget/function/f_ncm.c
>>> @@ -1156,7 +1156,8 @@ static int ncm_unwrap_ntb(struct gether *port,
>>>                 struct sk_buff_head *list)
>>>   {
>>>       struct f_ncm    *ncm = func_to_ncm(&port->func);
>>> -    __le16        *tmp = (void *) skb->data;
>>> +    unsigned char    *ntb_ptr = (void *) skb->data;
>>
>> Why persist with the extra ' ', didn't checkpatch complain about this?
>>
>> And why the cast at all?
>>
> My bad. I ran the checkpatch and got the following result:
> 
> kriskura@hu-kriskura-hyd:/local/mnt/workspace/krishna/510/testncm/kernel$ ./scripts/checkpatch.pl --strict 0001-usb-gadget-ncm-Handle-decoding-of-multiple-NTB-s-in-.patch
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit 
> description?)
> #12:
> unwraps the obtained request data assuming only one NTB is present, we 
> loose
> 
> CHECK: No space is necessary after a cast
> #34: FILE: drivers/usb/gadget/function/f_ncm.c:1159:
> +       unsigned char   *ntb_ptr = (void *) skb->data;
> 
> CHECK: No space is necessary after a cast
> #46: FILE: drivers/usb/gadget/function/f_ncm.c:1176:
> +       tmp = (void *) ntb_ptr;
> 
> CHECK: No space is necessary after a cast
> #93: FILE: drivers/usb/gadget/function/f_ncm.c:1329:
> +               ntb_ptr = (unsigned char *) (ntb_ptr + block_len);
> 
> total: 0 errors, 1 warnings, 3 checks, 67 lines checked
> 
> 
> I ignored the checks and saw only that errors are 0. Seems like I missed 
> fixing the commit text wrapping to 75 chars (On line 12 it has 76 
> chars). Will fix it up in v3.
> 
> As per the cast, I initially didn't add any cast and saw that the code 
> was not able to parse the dwSignature of the NTH and decoding of all 
> packets was failing. Only when I added the cast, was the function able 
> to decode all packets properly.
> 
>>> +    __le16        *tmp;
>>>       unsigned    index, index2;
>>>       int        ndp_index;
>>>       unsigned    dg_len, dg_len2;
>>> @@ -1169,6 +1170,10 @@ static int ncm_unwrap_ntb(struct gether *port,
>>>       const struct ndp_parser_opts *opts = ncm->parser_opts;
>>>       unsigned    crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
>>>       int        dgram_counter;
>>> +    int        to_process = skb->len;
>>> +
>>> +parse_ntb:
>>> +    tmp = (void *) ntb_ptr;
>>
>> Again, no blank space please.
>>
>> And why the cast?
>>
> the second cast here was just to be in sync with the original code;
> __le16        *tmp = (void *) skb->data;
> 
> I didn't try removing this and running the test. Will check if the 
> second one is required or if decoding is proper without it or not.
> 
> Regards,
> Krishna,

Hi Greg,

  I rechecked the code and I don't see any error if I remove the 
typecast for ntb_ptr. If I remove the typecast for tmp, I see build 
errors as ntb_ptr is unsigned char and tmp is __le16. I have pushed v3 
removing the typecast for ntb_ptr and fixing the checkpatch errors. 
Thanks for pointing out that the typecast is not needed.

Regards,
Krishna,
