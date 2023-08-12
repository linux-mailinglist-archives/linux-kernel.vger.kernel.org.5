Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C55779D36
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjHLFJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHLFJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:09:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9A2722
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 22:09:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37C59Kpg030312;
        Sat, 12 Aug 2023 05:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=86mtJloUHa2cU6xz1krwxTUYHHYWBvUKL/iATDB/E+k=;
 b=ejQ/KB0xxNzhvQQMMu3fDEEMOHkBHkZyZ2+Wj78XLZQihQ8aUzFweazNT9NJo92w01EC
 uzZ6+WaQfXq/kemj/hkdcoy7nubvof8DObdYaTt87/V+FroieN9AAAA1miFgUXkBF8HW
 QYPJd19L+hkJwfP+ys74Vp0joG/+ejKbbQgKyvazKsmlWW7tYGqSiyxLuNsc4EsyW19A
 6dCuxdXkq0isczaeHwOTvpATe+uIdOjRRU6z1JwiZzmvnZe50xd9m+9VZr1vl7Mv/U4k
 sHZSh49b+qF3i8jbsaCLn1Ine50wYa3zidUcj2WKIqLnsUi9fdR5Hkk+3SLE6Qf3xqf2 dQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3hsr0bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 05:09:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37C59Jfc032040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 05:09:19 GMT
Received: from [10.216.41.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 22:09:16 -0700
Message-ID: <2dce810b-3fa8-0ae3-1f74-b0c447c1ed71@quicinc.com>
Date:   Sat, 12 Aug 2023 10:39:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Multi-gen LRU: skip CMA pages when they are not eligible
To:     Yu Zhao <yuzhao@google.com>
CC:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <zhaoyang.huang@unisoc.com>, <surenb@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>
References: <1691568344-13475-1-git-send-email-quic_charante@quicinc.com>
 <9d109a43-78a3-dee4-5aaa-385bdfe4bcb3@redhat.com>
 <CAC_TJvckhxwz9TxXgMSaiihHddY+AnEGqjLxvO6qF0eqTb5U8Q@mail.gmail.com>
 <CAOUHufarW3utTCqk+tes-tbU7iRKCYa_GMZvSNxJrFRKWXMbWw@mail.gmail.com>
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CAOUHufarW3utTCqk+tes-tbU7iRKCYa_GMZvSNxJrFRKWXMbWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GeKOCoDcCB0OB0bzUFKTHUlYkcGMTb3v
X-Proofpoint-ORIG-GUID: GeKOCoDcCB0OB0bzUFKTHUlYkcGMTb3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_03,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=687 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308120047
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2023 10:39 PM, Yu Zhao wrote:
>> On Wed, Aug 9, 2023 at 7:00 AM David Hildenbrand <david@redhat.com> wrote:
>>> On 09.08.23 10:05, Charan Teja Kalla wrote:
>>>> This patch is based on the commit 5da226dbfce3("mm: skip CMA pages when
>>>> they are not available") which skips cma pages reclaim when they are not
>>>> eligible for the current allocation context. In mglru, such pages are
>>>> added to the tail of the immediate generation to maintain better LRU
>>>> order, which is unlike the case of conventional LRU where such pages are
>>>> directly added to the head of the LRU list(akin to adding to head of the
>>>> youngest generation in mglru).
>>>>
>>>> No observable issue without this patch on MGLRU, but logically it make
>>>> sense to skip the CMA page reclaim when those pages can't be satisfied
>>>> for the current allocation context.
>>>>
>>>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
>> Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
> Thanks, Charan! Do we need a "Fixes" tag?
I think the below tag matches.

Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
> 
