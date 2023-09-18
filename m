Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F757A4300
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbjIRHlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbjIRHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:40:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AA61708;
        Mon, 18 Sep 2023 00:38:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38I7SOD0030988;
        Mon, 18 Sep 2023 07:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r2hWKlEpKe/JKJubx7igl+rfCDrfvf22cMzTlHAy4t8=;
 b=XiZhIz1xqNMtaNAHZTmPN3N11LA57HogMY2oYOkI+ApYuLrvc7ZoP4cCVjrFHSCr/smM
 vZLtLppQoXrMsDNJnGSEwM9HHYwLQu9JwG61qOXeTkPaPONBfRstGE47IwIXImSpfjZw
 w/8XvdBORFna5qkHpQ7u2T47PpbhxFCY0nx80gQZ063TpeAjYUN0PXe2pLsgtRxcJnSt
 S6P0mw6OGWhpT8e8x8BWIJwwBNK8DdcmDm2imRcJ7Eulc4zAoytNJt1+qFbKGRzcSttB
 wqAcSDmR+LEzC1wLd7o6hT6RqbHZFdESpwf0WLGP1VAZ99f+X6DZeoJRscYDsB70XMhz xw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t53ayaqb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 07:37:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38I7btsL009318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 07:37:55 GMT
Received: from [10.216.25.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 18 Sep
 2023 00:37:52 -0700
Message-ID: <a890ac60-0562-48c3-9aa1-eb06ec21c69d@quicinc.com>
Date:   Mon, 18 Sep 2023 13:07:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <2023091743-tightly-drivable-4360@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A_gBGT8CUmtoqORQV7dXy2fqtBhJWHR6
X-Proofpoint-ORIG-GUID: A_gBGT8CUmtoqORQV7dXy2fqtBhJWHR6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2023 1:34 PM, Greg Kroah-Hartman wrote:
>> Cc: stable@vger.kernel.org
> 
> What commit id does this fix?
> 

Hi Greg,

This fixes the initial patch that added the driver:
9f6ce4240a2bf456402c15c06768059e5973f28c

>> Reviewed-by: Maciej Żenczykowski <maze@google.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/gadget/function/f_ncm.c | 26 +++++++++++++++++++-------
>>   1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
>> index feccf4c8cc4f..f00f051438ec 100644
>> --- a/drivers/usb/gadget/function/f_ncm.c
>> +++ b/drivers/usb/gadget/function/f_ncm.c
>> @@ -1156,7 +1156,8 @@ static int ncm_unwrap_ntb(struct gether *port,
>>   			  struct sk_buff_head *list)
>>   {
>>   	struct f_ncm	*ncm = func_to_ncm(&port->func);
>> -	__le16		*tmp = (void *) skb->data;
>> +	unsigned char	*ntb_ptr = (void *) skb->data;
> 
> Why persist with the extra ' ', didn't checkpatch complain about this?
> 
> And why the cast at all?
> 
My bad. I ran the checkpatch and got the following result:

kriskura@hu-kriskura-hyd:/local/mnt/workspace/krishna/510/testncm/kernel$ 
./scripts/checkpatch.pl --strict 
0001-usb-gadget-ncm-Handle-decoding-of-multiple-NTB-s-in-.patch
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit 
description?)
#12:
unwraps the obtained request data assuming only one NTB is present, we loose

CHECK: No space is necessary after a cast
#34: FILE: drivers/usb/gadget/function/f_ncm.c:1159:
+       unsigned char   *ntb_ptr = (void *) skb->data;

CHECK: No space is necessary after a cast
#46: FILE: drivers/usb/gadget/function/f_ncm.c:1176:
+       tmp = (void *) ntb_ptr;

CHECK: No space is necessary after a cast
#93: FILE: drivers/usb/gadget/function/f_ncm.c:1329:
+               ntb_ptr = (unsigned char *) (ntb_ptr + block_len);

total: 0 errors, 1 warnings, 3 checks, 67 lines checked


I ignored the checks and saw only that errors are 0. Seems like I missed 
fixing the commit text wrapping to 75 chars (On line 12 it has 76 
chars). Will fix it up in v3.

As per the cast, I initially didn't add any cast and saw that the code 
was not able to parse the dwSignature of the NTH and decoding of all 
packets was failing. Only when I added the cast, was the function able 
to decode all packets properly.

>> +	__le16		*tmp;
>>   	unsigned	index, index2;
>>   	int		ndp_index;
>>   	unsigned	dg_len, dg_len2;
>> @@ -1169,6 +1170,10 @@ static int ncm_unwrap_ntb(struct gether *port,
>>   	const struct ndp_parser_opts *opts = ncm->parser_opts;
>>   	unsigned	crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
>>   	int		dgram_counter;
>> +	int		to_process = skb->len;
>> +
>> +parse_ntb:
>> +	tmp = (void *) ntb_ptr;
> 
> Again, no blank space please.
> 
> And why the cast?
> 
the second cast here was just to be in sync with the original code;
__le16		*tmp = (void *) skb->data;

I didn't try removing this and running the test. Will check if the 
second one is required or if decoding is proper without it or not.

Regards,
Krishna,
