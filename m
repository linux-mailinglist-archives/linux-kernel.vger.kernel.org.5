Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3903B7B6329
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbjJCIGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjJCIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:05:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC5A1;
        Tue,  3 Oct 2023 01:05:55 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3937Fhtc026907;
        Tue, 3 Oct 2023 08:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1tal2cgRC6oqox3sOIDN/YYmG4aPIsYT09lyq1uKd/I=;
 b=msKMvmHqsCYyTWFmtYXUrbiNspn764yOpGWSgvEoerxHJKuAzU2dahfzq8pMtnUlUFSf
 rT9nTcyCZ4J39NviAkaP78/kVwo73Ri7K/84tKUwPINhtwzMQfS5/Mwu+0aQ/kf+mIgM
 ex0eCVPeHeQ6/MxGMXAjeUUElH6Kiy2e4Cc7VtDpCJ4cEIxebu3mWuE7S5WaxP7NUCFD
 UWH6gu2Bk4wHp1oKF3qFa9k/OVrEOpp0j0cQ8uL0PRkLgZQ+II7XYvMFaGmr27GEmiYI
 Uc82mX1gMD6QOQ39vqiL/E3bmctbM7iceWtc00iZx9ijjjo2qw7btvjmYBOoG2AQh3SH sw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgbjkrckc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 08:05:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39385KbK012279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 08:05:20 GMT
Received: from [10.50.29.64] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 3 Oct
 2023 01:05:14 -0700
Message-ID: <4c01666b-5f2b-616b-7f07-3c7603ce1bb1@quicinc.com>
Date:   Tue, 3 Oct 2023 13:35:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [RFC PATCH 0/4] PM: hibernate: LZ4 compression support
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
References: <cover.1695711299.git.quic_nprakash@quicinc.com>
From:   Nikhil V <quic_nprakash@quicinc.com>
In-Reply-To: <cover.1695711299.git.quic_nprakash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ljYaXZdlWXbwH_GntMayl7_70nF7fyNx
X-Proofpoint-ORIG-GUID: ljYaXZdlWXbwH_GntMayl7_70nF7fyNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030056
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2023 2:27 PM, Nikhil V wrote:
> This patch series covers the following:
> 1. Renaming lzo* to generic names, except for lzo_xxx() APIs. This is
> used in the next patch where we move to crypto based APIs for
> compression. There are no functional changes introduced by this
> approach.
> 
> 
> 2. Replace LZO library calls with crypto generic APIs
> 
> Currently for hibernation, LZO is the only compression algorithm
> available and uses the existing LZO library calls. However, there
> is no flexibility to switch to other algorithms which provides better
> results. The main idea is that different compression algorithms have
> different characteristics and hibernation may benefit when it uses
> alternate algorithms.
> 
> By moving to crypto based APIs, it lays a foundation to use other
> compression algorithms for hibernation.
> 
> 
> 3. LZ4 compression
> Extend the support for LZ4 compression to be used with hibernation.
> The main idea is that different compression algorithms
> have different characteristics and hibernation may benefit when it uses
> any of these algorithms: a default algorithm, having higher
> compression rate but is slower(compression/decompression) and a
> secondary algorithm, that is faster(compression/decompression) but has
> lower compression rate.
> 
> LZ4 algorithm has better decompression speeds over LZO. This reduces
> the hibernation image restore time.
> As per test results:
>                                      LZO             LZ4
> Size before Compression(bytes)   682696704       682393600
> Size after Compression(bytes)    146502402       155993547
> Decompression Rate               335.02 MB/s     501.05 MB/s
> Restore time                       4.4s             3.8s
> 
> LZO is the default compression algorithm used for hibernation. Enable
> CONFIG_HIBERNATION_DEF_COMP_LZ4 to set the default compressor as LZ4.
> 
> Compression Benchmarks: https://github.com/lz4/lz4
> 
> 4. Support to select compression algorithm
> 
> Currently the default compression algorithm is selected based on Kconfig.
> Introduce a kernel command line parameter "hib_compression" to
> override this behaviour.
> 
> Users can set "hib_compression" command line parameter to specify
> the algorithm.
> Usage:
>      LZO: hib_compression=lzo
>      LZ4: hib_compression=lz4
> LZO is the default compression algorithm used with hibernation.
> 
> Nikhil V (4):
>    PM: hibernate: Rename lzo* to make it generic
>    PM: hibernate: Move to crypto APIs for LZO compression
>    PM: hibernate: Add support for LZ4 compression for hibernation
>    PM: hibernate: Support to select compression algorithm
> 
>   .../admin-guide/kernel-parameters.txt         |   6 +
>   kernel/power/Kconfig                          |  25 ++-
>   kernel/power/hibernate.c                      |  83 +++++++-
>   kernel/power/power.h                          |  19 ++
>   kernel/power/swap.c                           | 189 +++++++++++-------
>   5 files changed, 248 insertions(+), 74 deletions(-)
> 

Hi,

Could you please let me know if you have any concerns/comments on this 
approach? If there are no comments, I could push another patch series 
with PATCH tag for review.

Thanks
Nikhil V
