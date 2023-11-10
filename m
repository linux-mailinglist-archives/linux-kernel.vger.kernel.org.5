Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D837E80E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344903AbjKJSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbjKJSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877033F354
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:36:45 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAEkk0W009514;
        Fri, 10 Nov 2023 16:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ru3MXs85V0TkBtzH6XUT5hSoA+maK9Vla4p+oxu1MjQ=;
 b=mO2uYd9E4x9fwSDDz7pNXhLU/yOaAdAi10V6MUk1nfrw387RwdsUsu89meYxgqxzfL1Q
 4uiUUnOtrpU4vwYiYHF9tF2gQ7ZDPzjcQU4AC+GPrjHV0QOLRA4wIdF2msdIM9UFh5+C
 sCXB07Sac79CezCxBKsNAUL7nVkBq3jGzYqbfYC96avDxS+oXk5B6lXTx5ilKrUik1pM
 ZNKptu0cuPABXbGCbWof2gkPrAIYagLBM5brZePprqCf95DtnDQd8vsQq817W9VTRTIF
 rr/mHv7pqdRndLoaO8RG05BdEWJf5eMfh6+z8yQ3YD8HmOeB8IG6rPHY2igpmIkT7mev Fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9h9v8xwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 16:36:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AAGaSS4023378
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 16:36:28 GMT
Received: from [10.216.59.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 08:36:25 -0800
Message-ID: <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
Date:   Fri, 10 Nov 2023 22:06:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <david@redhat.com>, <vbabka@suse.cz>, <hannes@cmpxchg.org>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka>
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <ZUy1dNvbvHc6gquo@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kTKagX7y4wucFs2tiqPbsNo4sbIeU6ji
X-Proofpoint-ORIG-GUID: kTKagX7y4wucFs2tiqPbsNo4sbIeU6ji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_13,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 malwarescore=0
 mlxlogscore=214 adultscore=0 lowpriorityscore=0 spamscore=1 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100138
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal!!

On 11/9/2023 4:03 PM, Michal Hocko wrote:
>> VM system running with ~50MB of memory shown the below stats during OOM
>> kill:
>> Normal free:760kB boost:0kB min:768kB low:960kB high:1152kB
>> reserved_highatomic:0KB managed:49152kB free_pcp:460kB
>>
>> Though in such system state OOM kill is imminent, but the current kill
>> could have been delayed if the pcp is drained as pcp + free is even
>> above the high watermark.
> TBH I am not sure this is really worth it. Does it really reduce the
> risk of the OOM in any practical situation?

At least in my particular stress test case it just delayed the OOM as i
can see that at the time of OOM kill, there are no free pcp pages. My
understanding of the OOM is that it should be the last resort and only
after doing the enough reclaim retries. CMIW here.

This patch just aims to not miss the corner case where we hit the OOM
without draining the pcp lists. And after draining, some systems may not
need the oom and some may still need the oom. My case is the later here
so I am really not sure If we ever encountered/noticed the former case here.

> 
