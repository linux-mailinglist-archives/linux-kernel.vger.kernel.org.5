Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2580D778747
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjHKGEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKGEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:04:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB922D4F;
        Thu, 10 Aug 2023 23:04:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B5GfSE030555;
        Fri, 11 Aug 2023 06:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f/ghIMOazCobGrlT1ZS50jOz4Y52QYAc4AdvQM2Odx8=;
 b=lswwBh+goOnuNMPG1Pblw4wgRiTm4fu9VlW3jAtdC0QADeSasdPbTlaik3fGliItPb5a
 HOpOIk5K0cpx5M+2REpaZPw9ouTTJePDn4pxHL68RwGxXjytQhqBXS30Asa197KCdYEx
 B+ZzbIqlsRjk3QyP9S0znDvHPaU8Qk8q4wLJFfuk5VjwYyv4t2J51I76AIHFy6tu8+zN
 opkm9XOr+2TLBtI3z93g6oBlAL9qWiNy7B10FHOJEuHEvvzXkoucQfNhCW1dGHaQ8o80
 CQjEMa6vMuWoi1MnOJdQGMeZiUH3Hg/V1YeYuPSc/8oC9Soiox/QlZK2FzEUIIHWHJfO 2w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8ywgkpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 06:04:45 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B64iK8000566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 06:04:44 GMT
Received: from [10.50.43.50] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 23:04:41 -0700
Message-ID: <2214c31b-eca2-012e-a100-21252a724e7c@quicinc.com>
Date:   Fri, 11 Aug 2023 11:34:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of
 codecs within range
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
 <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: agWiA0a3dxyd4JzphILx47cE-CrR_3Ue
X-Proofpoint-GUID: agWiA0a3dxyd4JzphILx47cE-CrR_3Ue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=709 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110055
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2023 5:03 PM, Bryan O'Donoghue wrote:
> On 10/08/2023 03:25, Vikash Garodia wrote:
>> +    if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) >
>> MAX_CODEC_NUM)
>> +        return;
>> +
> 
> Shouldn't this be >= ?
Not needed. Lets take a hypothetical case when core->dec_codecs has initial 16
(0-15) bits set and core->enc_codecs has next 16 bits (16-31) set. The bit count
would be 32. The codec loop after this check would run on caps array index 0-31.
I do not see a possibility for OOB access in this case.

> 
> struct hfi_plat_caps caps[MAX_CODEC_NUM];
> 
> ---
> bod
> 
