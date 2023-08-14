Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB26B77C0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjHNTWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjHNTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:21:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25556E5F;
        Mon, 14 Aug 2023 12:21:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EIua5P006916;
        Mon, 14 Aug 2023 19:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CgIvWMJHVukO8bVx05LIaSj7W/2gGRSNf/Fs/cPeWek=;
 b=ZP+shFgkaRN2O8qsVfdtTal9ZdvBCJXnE02rzhxyaFwhnP9QU6unv6TrPjZ3TLKJ9ATd
 /HjBj2Icrs480PTJI7OtNKw9WweSuZAfUyqZjWKhyayDfmiIds7WHV5DL8Drb+3JlxRq
 Vvnw2IOB8jCy28BXluqY94XlTxl1NJUCTbMskf2eC4gzNC9O4NBgOX2aXIM8UuQHjc7E
 LLE4b8M3f0XERexT8DjmQoNF6yab/QWKS6e7OfEGxqDI2STHaH9HPsOrOjaLURDA8//j
 brzge0SGwVj7Ekt3W7e79p9vh3cCyJpDimW3DLcB5ZEJVmh+iyGk9vQ9f/59XUNPk+MG gQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3mt4mcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:21:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJLTgM019622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:21:29 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:21:26 -0700
Message-ID: <38c1b0ba-c460-aa2b-5a97-6cb4dc24dce5@quicinc.com>
Date:   Tue, 15 Aug 2023 00:51:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 31/33] iris: variant: iris: implement the logic to compute
 bus bandwidth
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-32-git-send-email-quic_vgarodia@quicinc.com>
 <76420973-1036-3adf-9c0b-94eaf8b5ceff@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <76420973-1036-3adf-9c0b-94eaf8b5ceff@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C9a2MNWuVXUcM8RR7lciGwjTZ2rMmPvT
X-Proofpoint-ORIG-GUID: C9a2MNWuVXUcM8RR7lciGwjTZ2rMmPvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308140179
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 11:39 PM, Konrad Dybcio wrote:
> On 28.07.2023 15:23, Vikash Garodia wrote:
>> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>
>> This implements the logic to compute bus bandwidth required by encoder
>> or decoder for a specific usecase. It takes input as various video
>> usecase parameters as configured by clients.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
> [...]
> 
>> +/* 100x */
>> +static u32 dpbopb_ubwc30_cr_table_cratio_iris3[7][12] = {
> const?
> 
> [...]
> 
>> +
>> +	llc_enabled_ref_y_rd = (codec_input.status_llc_onoff) ? 1 : 0;
>> +	llc_enable_ref_crcb_rd = (codec_input.status_llc_onoff) ? 1 : 0;
>> +	/* H265D BSE tlb in LLC will be pored in Kailua */
> ?
> 
>> +	llc_enabled_bse_tlb = (codec_input.status_llc_onoff) ? 1 : 0;
> "? 1 : 0" is fancy bool conversion (!!x)
> 
Hi Konrad,

we will remove this bus calculation logic and move to static bus bandwidth
table in next version so this file will be removed.

Thanks,
Dikshita
> Konrad
