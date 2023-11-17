Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCF57EEC09
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 06:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjKQFnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 00:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQFnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 00:43:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B89919D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 21:43:42 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH5cX6G022114;
        Fri, 17 Nov 2023 05:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EwGl2Raou1wlZbgyA4gj3IIYc9SXGYbAdpUH+BDajbQ=;
 b=M54trlkb2i4UophFTxb6BvH1lUcpVdKRhLWFyJLbsqKmYjiWfZdoqKJPmjinEj//GzIq
 tjEQzWeeYzjPFoTeWmcvutLWRNwEF7l2iuA4zeSBpIF/78ZGLS6GavSkUXw6nykIKpMm
 U070KuSIDEfiMbGp3Bu5T/t+r20bQPRdUKmm9JFGNuzeIk5Su4esE06Rutyc5k0oin2o
 YTXgsPo6pTna7iVyq/ECQnMYKLfuXvVG7KmnEgO53vpVVyYOwXEh6XDCJH7/KydyMcNO
 0uJgejLlDiXogxQUodzRfK3QBPMMhAXgx65xr3LsOivnqB9GcNxKY7tayQ2Lf7AcmQCE Gw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udmw41tc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 05:43:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH5hQrR006839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 05:43:26 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 21:43:23 -0800
Message-ID: <45fc0324-4a1d-7b2c-6cbe-3755056d5981@quicinc.com>
Date:   Fri, 17 Nov 2023 11:13:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <david@redhat.com>, <vbabka@suse.cz>, <hannes@cmpxchg.org>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka>
 <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka>
 <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
 <ZVTRKTi2QCoMiv50@tiehlicka>
 <d531e69c-f0b4-f857-657f-48d981db3923@quicinc.com>
 <ZVYRJMUitykepLRy@tiehlicka>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <ZVYRJMUitykepLRy@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zyDbRmouoK97QZQYJmqa0ZJBhzr0aezq
X-Proofpoint-ORIG-GUID: zyDbRmouoK97QZQYJmqa0ZJBhzr0aezq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_03,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=661
 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170039
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal!!

On 11/16/2023 6:25 PM, Michal Hocko wrote:
>> May be other way to look at that patch is comment is really not being
>> reflected in the code. It says, " Limit the number reserved to 1
>> pageblock or roughly 1% of a zone.", but the current code is making it 2
>> pageblocks. So, for 4M block size, it is > 1%.
>>
>> A second patch, that I will post, like not reserving the high atomic
>> page blocks on small systems -- But how to define the meaning of small
>> systems is not sure. Instead will let the system administrators chose
>> this through either:
>> a) command line param, high_atomic_reserves=off, on by default --
>> Another knob, so admins may really not like this?
>> b) CONFIG_HIGH_ATOMIC_RESERVES, which if not defined, will not reserve.
> Please don't! I do not see any admin wanting to care about this at all.
> It just takes a lot of understanding of internal MM stuff to make an
> educated guess. This should really be auto-tuned. And as responded in
> other reply my take would be to reserve a page block on if it doesn't
> consume more than 1% of memory to preserve the existing behavior yet not
> overconsume on small systems.

This idea of auto tune, by reserving a pageblock only if it doesn't
consume more than 1% of memory, seems cleaner to me.  For a page block
size of 4MB, this will turnout to be upto 400MB of RAM.

If it is fine, I can post a patch with suggested-by: you.

>  
