Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5057FD3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjK2KUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjK2KUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:20:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACCED6C;
        Wed, 29 Nov 2023 02:20:07 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT4pp4H024125;
        Wed, 29 Nov 2023 10:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ofNrLaFHuTHD21qgrZ0jFGb9u6mJ9w59ETMZ/XgMEeQ=;
 b=J8KfmemKXBfJxdBtQ67t+ToRjfYg/+/5qR+rbi/2uGMoE40sei1OoXA0BmfQAwTOs39X
 B/c5dCYyiDxd58gU7Q8G8ctElmJnkrDf2c6nMt3hMB6XSSD9BzYKjqDqV/vknEe4JdAz
 JJXQqsKPTsFslQpt7NwvHtYBx4Yh4o8ygMGV3R1LiqCeRrEohdQILualLehqVHrsn/xR
 juzh4wLv1lA2t19mt70wxgiFpmWiyol3t8T3uETzi8gQBRaOl/+1yRT09afBYWbfIp+m
 uWjq1GmpJUZZAoVO10rVThqruwKkHeagCEeWQvS8E3pqWcFRLVPbX0Xy6Nfs0DxmDbiG Og== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ungruay6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:19:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATAJkBV008994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:19:46 GMT
Received: from [10.216.19.148] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 02:19:39 -0800
Message-ID: <2153c549-2a45-3d1d-a407-e175a34b77bf@quicinc.com>
Date:   Wed, 29 Nov 2023 15:49:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH RESEND v2 0/4] PM: hibernate: LZ4 compression support
To:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
References: <cover.1700048610.git.quic_nprakash@quicinc.com>
Content-Language: en-US
From:   Nikhil V <quic_nprakash@quicinc.com>
In-Reply-To: <cover.1700048610.git.quic_nprakash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D2UV9IUTVY72oSXmHAhNleX6Qw4PO4VD
X-Proofpoint-ORIG-GUID: D2UV9IUTVY72oSXmHAhNleX6Qw4PO4VD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_07,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290077
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 5:52 PM, Nikhil V wrote:
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
> 
> Extend the support for LZ4 compression to be used with hibernation.
> The main idea is that different compression algorithms have different
> characteristics and hibernation may benefit when it uses any of these
> algorithms: a default algorithm, having higher compression rate but is
> slower(compression/decompression) and a secondary algorithm, that is
> faster(compression/decompression) but has lower compression rate.
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
> 
> 4. Support to select compression algorithm
> 
> Currently the default compression algorithm is selected based on
> Kconfig. Introduce a kernel command line parameter "hib_compression" to
> override this behaviour.
> 
> Users can set "hib_compression" command line parameter to specify
> the algorithm.
> Usage:
>      LZO: hib_compression=lzo
>      LZ4: hib_compression=lz4
> LZO is the default compression algorithm used with hibernation.
> 
> 
> Changes in v2:
>   - Fixed build issues reported by kernel test robot for ARCH=sh, [1].
> [1] https://lore.kernel.org/oe-kbuild-all/202310171226.pLUPeuC7-lkp@intel.com/
> 
> Nikhil V (4):
>    PM: hibernate: Rename lzo* to make it generic
>    PM: hibernate: Move to crypto APIs for LZO compression
>    PM: hibernate: Add support for LZ4 compression for hibernation
>    PM: hibernate: Support to select compression algorithm
> 
>   .../admin-guide/kernel-parameters.txt         |   6 +
>   kernel/power/Kconfig                          |  26 ++-
>   kernel/power/hibernate.c                      |  85 +++++++-
>   kernel/power/power.h                          |  19 ++
>   kernel/power/swap.c                           | 189 +++++++++++-------
>   5 files changed, 251 insertions(+), 74 deletions(-)
> 
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86

Hi @Rafael/@Pavel/@Len,

Could you please let me know if you have any concerns on this approach?

FYI: We have tested this on QEMU and its working fine.

Logs(suspend):
[   75.242227] PM: Using 3 thread(s) for lz4 compression
[   75.243043] PM: Compressing and saving image data (17495 pages)...
[   75.243917] PM: Image saving progress:   0%
[   75.261727] PM: Image saving progress:  10%
[   75.277968] PM: Image saving progress:  20%
[   75.290927] PM: Image saving progress:  30%
[   75.305186] PM: Image saving progress:  40%
[   75.318252] PM: Image saving progress:  50%
[   75.330310] PM: Image saving progress:  60%
[   75.345906] PM: Image saving progress:  70%
[   75.359054] PM: Image saving progress:  80%
[   75.372176] PM: Image saving progress:  90%
[   75.388411] PM: Image saving progress: 100%
[   75.389775] PM: Image saving done
[   75.390397] PM: hibernation: Wrote 69980 kbytes in 0.14 seconds 
(499.85 MB/s)
[   75.391591] PM: Image size after compression: 28242 kbytes
[   75.393089] PM: S|
[   75.399784] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   75.439170] sd 0:0:0:0: [sda] Stopping disk
[   75.501461] ACPI: PM: Preparing to enter system sleep state S5
[   75.502766] reboot: Power down



Logs(resume):
[    1.063248] PM: hibernation: resume from hibernation
[    1.072868] Freezing user space processes
[    1.073707] Freezing user space processes completed (elapsed 0.000 
seconds)
[    1.075192] OOM killer disabled.
[    1.075837] Freezing remaining freezable tasks
[    1.078010] Freezing remaining freezable tasks completed (elapsed 
0.001 seconds)
[    1.087489] PM: Using 3 thread(s) for lz4 decompression
[    1.088570] PM: Loading and decompressing image data (17495 pages)...
[    1.125549] PM: Image loading progress:   0%
[    1.190380] PM: Image loading progress:  10%
[    1.204963] PM: Image loading progress:  20%
[    1.218988] PM: Image loading progress:  30%
[    1.233697] PM: Image loading progress:  40%
[    1.248658] PM: Image loading progress:  50%
[    1.262910] PM: Image loading progress:  60%
[    1.276966] PM: Image loading progress:  70%
[    1.290517] PM: Image loading progress:  80%
[    1.305427] PM: Image loading progress:  90%
[    1.320666] PM: Image loading progress: 100%
[    1.321866] PM: Image loading done
[    1.322599] PM: hibernation: Read 69980 kbytes in 0.23 seconds 
(304.26 MB/s)
[    1.324795] printk: Suspending console(s) (use no_console_suspend to 
debug)
[   74.943801] ata1.00: Entering standby power mode


Thanks,
Nikhil V
