Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F157C9E05
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjJPDsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjJPDsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:48:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB7DA;
        Sun, 15 Oct 2023 20:48:31 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39G3hjJQ014194;
        Mon, 16 Oct 2023 03:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qNg14GcggDnrj3270YNJfGynOyIYi98iCn9wUS7HdVo=;
 b=TMqDbG8MiB/m4qsgHGITwiMljlKkmVjP41DQgGNk1pqZiLAyOGoeZ+d11+p+wgJGpXiR
 Wb93k0rmrt2+YpCYdjVD5/BMJe77IWOB6NKcBJmLHC5C3+FutoNMdtyNckmvwt3/7p2C
 +i26HAmWbVsJkkcpqm/KQzyEL3zA/u1fZXhkplE7f+7f2LBI2FZG63A47/9pauZWQgdc
 zKMnv3HMnFRkQa87VzDF1Qt79bFYRZjzRwb84rDKVxej+lFUnStsPqgh6DuKW3FCqrEa
 Fh8YMtAmAx9OqO+77MhHTGdf2+bCP/i6FxcMfcZ9B9Kh5hg3fcS1RI41sBFK7U6+3aQJ yA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqm9f3133-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 03:48:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39G3mLjG014926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 03:48:21 GMT
Received: from [10.216.5.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 15 Oct
 2023 20:48:17 -0700
Message-ID: <20632da6-3144-47d3-b1dc-0446e4e55a19@quicinc.com>
Date:   Mon, 16 Oct 2023 09:18:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        onathan Corbet <corbet@lwn.net>,
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
 <8ff92053-52ff-4950-95c8-0e986f6a028a@quicinc.com>
 <CANP3RGd4G4dkMOyg6wSX29NYP2mp=LhMhmZpoG=rgoCz=bh1=w@mail.gmail.com>
 <b12eb7b1-54e7-406f-8c19-0046555b82d3@quicinc.com>
 <CANP3RGcUrFTaFL8V3tpuh+qQoEi84O0Dy9ie+XD=-H01c2btAw@mail.gmail.com>
 <70c15867-ccce-4788-a0dd-38a73decb785@quicinc.com>
 <d395d631-239a-43f1-bcbf-b88b11852c76@quicinc.com>
 <CANP3RGcnpkcLK_CRfSLvxyGM3L0j5R3fybeF_L1bmRV9hNBcuQ@mail.gmail.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGcnpkcLK_CRfSLvxyGM3L0j5R3fybeF_L1bmRV9hNBcuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: evt7DBbyAbvVM6Ra1o0BpfWsxn-xxEy8
X-Proofpoint-ORIG-GUID: evt7DBbyAbvVM6Ra1o0BpfWsxn-xxEy8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-15_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=302
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310160032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2023 6:49 AM, Maciej Żenczykowski wrote:

>>>>
>>>> Hmm, I'm not sure.  I know I've experimented with high mtu ncm in the
>>>> past
>>>> (around 2.5 years ago).  I got it working between my Linux desktop (host)
>>>> and a Pixel 6 (device/gadget) with absolutely no problems.
>>>>
>>>> I'm pretty sure I didn't change my desktop kernel, so I was probably
>>>> limited to 8192 there
>>>> (and I do more or less remember that).
>>>>   From what I vaguely remember, it wasn't difficult (at all) to hit
>>>> upwards of 7gbps for iperf tests.
>>>> I don't remember how close to the theoretical USB 10gbps maximum of
>>>> 9.7gbps I could get...
>>>> [this was never the real bottleneck / issue, so I didn't ever dig
>>>> particularly deep]
>>>>
>>>> I'm pretty sure my gadget side changes were non-configurable...
>>>> Probably just bumped one or two constants...
>>>>
>>> Could you share what parameters you changed to get this high value of
>>> iperf throughput.
> 
> Eh, I really don't remember, but it wasn't anything earth shattering.
>  From what I recall it was just a matter of bumping mtu, and tweaking
> irq pinning to stronger cores.
> Indeed I'm not even certain that the mtu was required to be over 5gbps.
> Though I may be confusing some things, as at least some of the testing was done
> with the kernel's built in packet generator.
> 
>>>
>>>> I do *very* *vaguely* recall there being some funkiness though, where
>>>> 8192 was
>>>> *less* efficient than some slightly smaller value.
>>>>
>>>> If I recall correctly the issue is that 8192 + ethernet overhead + NCM
>>>> overhead only fits *once* into 16384, which leaves a lot of space
>>>> wasted.
>>>> While ~7.5 kb + overhead fits twice and is thus a fair bit better.
>>> Right, same goes for using 5K vs 5.5K MTU. If MTU is 5K, 3 packets can
>>> conveniently fit into an NTB but if its 5.5, at max only two (5.5k)
>>> packets can fit in (essentially filling ~11k of the 16384 bytes and
>>> wasting the rest)
>>
>> Formatting gone wrong. So pasting the first paragraph again here:
>>
>> "Right, same goes for using 5K vs 5.5K MTU. If MTU is 5K, 3 packets can
>> conveniently fit into an NTB but if its 5.5, at max only two (5.5k)
>> packets can fit in (essentially filling ~11k of the 16384 bytes and
>> wasting the rest)"
>>
>>>
>>> And whether its Ipv4/Ipv6 like you mentioned on [1], the MTU is what NCM
>>> layer receives and we append the Ethernet header and add NCM headers and
>>> send it out after aggregation. Why can't we set the MAX_DATAGRAM_SIZE to
>>> ~8050 or ~8100 ? The reason I say this value is, obviously setting it to
>>> 8192 would not efficiently use the NTB buffer. We need to fill as much
>>> space in buffer as possible and assuming that each packet received on
>>> ncm layer is of MTU size set (not less that that), we can assume that
>>> even if only 2 packets are aggregated (minimum aggregation possible), we
>>> would be filling (2 * (8050 + ETH_HLEN) + (room for NCM headers)) would
>>> almost be close to 16384 ep max packet size. I already check 8050 MTU
>>> and it works. We can add a comment in code detailing the above
>>> explanation and why we chose to use 8050 or 8100 as MAX_DATAGRAM_SIZE.
>>>
>>> Hope my reasoning of why we can chose 8.1K or 8.05K makes sense. Let me
>>> know your thoughts on this.
> 
> Maybe just use an L3 mtu of 8000 then?  That's a nice round number...
> But I'm also fine with 8050 or 8100.. though 8100 seems 'rounder'.
> 
> I'm not sure what the actual overhead is... I guess we control the
> overhead in one direction, but not in the other, and there could be
> some slop, so we need to be a little generous?
> 
>>>
Hi Maciej,

   Sure. Let's go with 8000 to leave some space for headers. And would 
add the following paragraph as comment for readers to understand why 
this value was set:

"Although max mtu as dictated by u_ether is 15412 bytes, setting 
max_segment_size to 15426 would not be efficient. If user chooses 
segment size to be (> 8192), then we can't aggregate more than one 
buffer in each NTB (assuming each packet coming from network layer is > 
8192 bytes) as ep maxpacket limit is 16384. So let max_segment_size be 
limited to 8000 to allow atleast 2 packets to be aggregated reducing 
wastage of NTB buffer space"

Hope that would be fine.

Regards,
Krishna,
