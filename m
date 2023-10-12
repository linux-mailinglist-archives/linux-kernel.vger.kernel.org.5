Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C917C71B9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378971AbjJLPlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347155AbjJLPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:41:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC84C6;
        Thu, 12 Oct 2023 08:40:57 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CATjnD003983;
        Thu, 12 Oct 2023 15:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7MCaYfPBEG4wO9qlImg2hPGzgMMBLqG18sck647HVtE=;
 b=ffUmEuBg8K0s4GANuDEVvWf6DgnKx9sfQ+I9VjC2Vv7Bg1PaSxK4q2E5rpQ8Quanil8M
 EkB1uG3+nr2CFvoURM6IoB01dc5W2Zv8CmZMy0ti/lcOjihu8o83zag1pge+A/J6vke3
 hjiQw3bk71RAVzQxGdB8ovUqrWXuaXrV9SVKwB3klEIiXdaOeYeAQgfMRLP+DiwrH0mH
 76LG3rGuJOGaPCAZjWvswQvLuEh7mxok2bvecEsGX2qFaQJzFyeTcl9qvALPYmxS975b
 rm7DyvwKGWYNBPobwZwiDKCmY+IfWY+cgxtS5EuWCgy+yXaNh0fiGyeLuSOGBiBDHQmU 5g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tp0vwaf1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 15:40:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CFer4x001522
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 15:40:53 GMT
Received: from [10.216.58.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 08:40:49 -0700
Message-ID: <8ff92053-52ff-4950-95c8-0e986f6a028a@quicinc.com>
Date:   Thu, 12 Oct 2023 21:10:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <20231009142005.21338-2-quic_kriskura@quicinc.com>
 <CANP3RGfEk2DqZ3biyN78ycQYbDxCEG+H1me2vnEYuwXkNdXnTA@mail.gmail.com>
 <CANP3RGcCpNOuVpdV9n0AFxZo-wsfwi8OfYgBk1WHNHaEd-4V-Q@mail.gmail.com>
 <CANP3RGdY4LsOA6U5kuccApHCzL0_jBnY=pLOYrUuYtMZFTvnbw@mail.gmail.com>
 <d19d9d08-c119-4991-b460-49925f601d15@quicinc.com>
 <fad5a7fb-cce1-46bc-a0af-72405c76d107@quicinc.com>
 <CANP3RGcqWBYd9FqAX47rE9pFgBTB8=0CGdwkScm-OH1epHcVWQ@mail.gmail.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGcqWBYd9FqAX47rE9pFgBTB8=0CGdwkScm-OH1epHcVWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FjK8zgFgOuyNa0Qn9upiXD3sg5aHPF1h
X-Proofpoint-ORIG-GUID: FjK8zgFgOuyNa0Qn9upiXD3sg5aHPF1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=897
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 6:02 PM, Maciej Żenczykowski wrote:
> On Thu, Oct 12, 2023 at 1:48 AM Krishna Kurapati PSSNV
> 
> Could you paste the full patch?
> This is hard to review without looking at much more context then email
> is providing
> (or, even better, send me a link to a CL in gerrit somewhere - for
> example aosp ACK mainline tree)

Sure. Will provide a gerrit on ACK for review before posting v2.

The intent of posting the diff was two fold:

1. The question Greg asked regarding why the max segment size was 
limited to 15014 was valid. When I thought about it, I actually wanted 
to limit the max MTU to 15000, so the max segment size automatically 
needs to be limited to 15014. But my commit text didn't mention this 
properly which was a mistake on my behalf. But when I looked at the 
code, limiting the max segment size 15014 would force the practical 
max_mtu to not cross 15000 although theoretical max_mtu was set to:
(GETHER_MAX_MTU_SIZE - 15412) during registration of net device.

So my assumption of limiting it to 15000 was wrong. It must be limited 
to 15412 as mentioned in u_ether.c  This inturn means we must limit 
max_segment_size to:
GETHER_MAX_ETH_FRAME_LEN (GETHER_MAX_MTU_SIZE + ETH_HLEN)
as mentioned in u_ether.c.

I wanted to confirm that setting MAX_DATAGRAM_SIZE to 
GETHER_MAX_ETH_FRAME_LEN was correct.

2. I am not actually able to test with MTU beyond 15000. When my host 
device is a linux machine, the cdc_ncm.c limits max_segment_size to:
CDC_NCM_MAX_DATAGRAM_SIZE		8192	/* bytes */

When connected to windows machine, I am able to set the mtu to a max 
value of 15000. So not sure how to test the patch if I set the 
max_segment_size to GETHER_MAX_ETH_FRAME_LEN.

By pasting the diff, I wanted to confirm both the above queries.

And you are right, while assigning value to ecm.wMaxSegmentSize, we must 
use cpu_to_le16(...). Will ensure to make this change in v2. It worked 
without that too, not sure how.

Let me know your thoughts on the above.

Regards,
Krishna,
