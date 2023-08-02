Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D380D76CBEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjHBLmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjHBLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:42:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE8213D;
        Wed,  2 Aug 2023 04:42:48 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372A4vrJ024218;
        Wed, 2 Aug 2023 11:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=guJ37QtxG3DruOPStXclgXIZhZya9NYk/GyruzfWmAI=;
 b=jGV80U9YdS9bZXgflbUXpSYPJWzA+z5lrlg7c33gz4aRov3T/A0YFAZsa8na1LRUyLzW
 s7/8FnucO3QJlkdvxdfmhzCytyW7z0rva737tldPWdvAMLyKDzrRGmdNcIcTZUsvIbC4
 Eedh2m3l2m8Ypm71y7s6BRFab81DZ9I+voWA2Q84JAlMPFA8ONWzf+NPQHcR4aZKnCmo
 eEjNvpX4ktoG1g7puAK4C2TNwB7nhPC2CzHO08u2eenqLZK6v2gHpHjidJVIyFyXYJKE
 DqXE9bYkDuNQN71nIiOa8+nv6U8fHZ41lxCEogTyl4NDu8tPJ0/TffJylxjIpb1tGH2m LA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7bp69gdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 11:41:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372BfuTr005620
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 11:41:56 GMT
Received: from [10.216.58.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 04:41:50 -0700
Message-ID: <447aa786-b7c5-807e-1a6e-fb8369fc8a97@quicinc.com>
Date:   Wed, 2 Aug 2023 17:11:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] mm-unstable: Multi-gen LRU: Fix per-zone reclaim
Content-Language: en-US
To:     Kalesh Singh <kaleshsingh@google.com>, <yuzhao@google.com>,
        <akpm@linux-foundation.org>
CC:     <surenb@google.com>, <android-mm@google.com>,
        <kernel-team@android.com>, <stable@vger.kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Barry Song <baohua@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20230802025606.346758-1-kaleshsingh@google.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20230802025606.346758-1-kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4XUYOAFIT1jf5-1o0YBu2i45mHyWOX_D
X-Proofpoint-ORIG-GUID: 4XUYOAFIT1jf5-1o0YBu2i45mHyWOX_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1011 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020103
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Kalesh for taking this to upstream.

On 8/2/2023 8:26 AM, Kalesh Singh wrote:
> MGLRU has a LRU list for each zone for each type (anon/file) in each
> generation:
> 
> 	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> The min_seq (oldest generation) can progress independently for each
> type but the max_seq (youngest generation) is shared for both anon and
> file. This is to maintain a common frame of reference.
> 
> In order for eviction to advance the min_seq of a type, all the per-zone
> lists in the oldest generation of that type must be empty.
> 
> The eviction logic only considers pages from eligible zones for
> eviction or promotion.
> 
>     scan_folios() {
> 	...
> 	for (zone = sc->reclaim_idx; zone >= 0; zone--)  {
> 	    ...
> 	    sort_folio(); 	// Promote
> 	    ...
> 	    isolate_folio(); 	// Evict
> 	}
> 	...
>     }
> 
> Consider the system has the movable zone configured and default 4
> generations. The current state of the system is as shown below
> (only illustrating one type for simplicity):
> 
> Type: ANON
> 
> 	Zone    DMA32     Normal    Movable    Device
> 
> 	Gen 0       0          0        4GB         0
> 
> 	Gen 1       0        1GB        1MB         0
> 
> 	Gen 2     1MB        4GB        1MB         0
> 
> 	Gen 3     1MB        1MB        1MB         0
> 
> Now consider there is a GFP_KERNEL allocation request (eligible zone
> index <= Normal), evict_folios() will return without doing any work
> since there are no pages to scan in the eligible zones of the oldest
> generation. Reclaim won't make progress until triggered from a ZONE_MOVABLE
> allocation request; which may not happen soon if there is a lot of free
> memory in the movable zone. This can lead to OOM kills, although there
> is 1GB pages in the Normal zone of Gen 1 that we have not yet tried to
> reclaim.
> 
> This issue is not seen in the conventional active/inactive LRU since
> there are no per-zone lists.
> 
> If there are no (not enough) folios to scan in the eligible zones, move
> folios from ineligible zone (zone_index > reclaim_index) to the next
> generation. This allows for the progression of min_seq and reclaiming
> from the next generation (Gen 1).
> 
As discussing offline, I think this can make system to spend too much
time in scan_folios() in moving the pages from Gen-0 to Gen-1 of the
other zone which can result into OOM is not active when necessary.

> Qualcomm, Mediatek and raspberrypi [1] discovered this issue independently.
> 
> [1] https://github.com/raspberrypi/linux/issues/5395
> 
> Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
> Cc: stable@vger.kernel.org
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Reported-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

We tested this patch on our systems for couple of weeks and aggressive
OOM is not observed which otherwise is easily reproducible.

Tested-by: Charan Teja Kalla <quic_charante@quicinc.com>

