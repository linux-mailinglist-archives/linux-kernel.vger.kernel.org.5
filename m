Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445DA7D7D83
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjJZHTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:19:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFC4129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:19:06 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q5HbOC020867;
        Thu, 26 Oct 2023 07:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AkgclXoJC5nScVKorMc/cc/2ufO5cwYlf1IiCx4FsRc=;
 b=Y0IBJ7b1UjDLy7y8wEV57/LcpsN+Zslccz+KeIBxb0cPfpfahgMdHYnIXC++wyGCwfa1
 phdICq15lObK4sVYlfCrc8EaLr/gulHEKzquiLHsDDfMv5pzqvfrMciUIleSA12uMpzt
 EMNN9tK7cIZWecIKdw/VdIdXd0/5zCAoKfjsT4aGfICyNayBHfCQA7FSzEs+HIF0/84O
 IrFhTwiLBQlvValpjH9iZW3YXRaqk2iKd89BPeFEKOVnyoiq4ZtWbbl5A57NjJmxbswd
 qVfHZ+8zVq3egUjIzbcoeWIbaqTdLm1pqaqAtvT5ryp7qZSNgX2HanS41YZpahusnWwK xQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ty5wdsq1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 07:18:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q7IesL009404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 07:18:40 GMT
Received: from [10.216.23.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 26 Oct
 2023 00:18:37 -0700
Message-ID: <c4ba3946-0e7f-334f-bc6d-bfcff21f10ab@quicinc.com>
Date:   Thu, 26 Oct 2023 12:48:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <e1102c1b-1773-4e59-8a70-00a7deff2bde@quicinc.com>
 <b4a2bbe8-4181-68ad-1a6c-463fbe64d8f8@quicinc.com>
 <20231025143541.e7cf114239b84105711a5f70@linux-foundation.org>
 <2a7b5e72-604a-48e1-9c0e-3b9ad15e7f78@redhat.com>
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <2a7b5e72-604a-48e1-9c0e-3b9ad15e7f78@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e1jzaWrCDQInR2VpowxsGx1SQdaP1nC_
X-Proofpoint-ORIG-GUID: e1jzaWrCDQInR2VpowxsGx1SQdaP1nC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=918 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310260060
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew/David,

On 10/26/2023 12:30 PM, David Hildenbrand wrote:
>>
>> How's it coming along?
>>

I was in vacation... Will send V2 by Monday IST.
>> Given that we're at 6.6-rc7 and given that this issue is causing
>> daily crashes in your device farm, I'm thinking that we use the current
>> version of your patch for 6.6 and for -stable.  We can look at the
>> kfree_rcu() optimization for later kernel releases?
> 
> Any particular reason we have to rush this in? It's been seen by one
> company in a testing farm; there were no other reports, especially not
> from production systems. ... and the issue seems to be quite old.

I think we can work on to merge the final solution here rather than an
incremental one. At least internally we are unblocked with V1.

Thanks,
Charan
