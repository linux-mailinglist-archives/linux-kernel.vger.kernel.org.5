Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AC763D85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjGZRTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGZRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:19:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F3212A;
        Wed, 26 Jul 2023 10:19:12 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QGxOYf001592;
        Wed, 26 Jul 2023 17:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9MWBK1NC2zhTmT1q3xAb4U0A/N1NJf2ai0XUED6P/cs=;
 b=Jr3Iw8YCoHBhNMW8Otch8v6Lzgv3X8gRh2S//tVnVBdMrgA7z3OOvB8m0SIooVz6+FJ4
 tBWwMJrsLNZwq1wPCEe4m+Ay4rfq2CvfuWk9jAmTjgBVB5vuDVOsc008pyg2viEnicrM
 9K7twfvH+/LMPBQwRITJ0AjINY79dG3cnz6tQ+6ofJV5PaNI4rMI8SnbKlEHJHBy7p2V
 vNBCPI7OvHntfvx/JGLcbyxbo7pljzt5VxweqPzwKBhebaSu3ePRsZdwfky3yg4y/3nl
 GuVymL7zOoMOijqsaI36oJXLcvD3/swwCH195NgYuwD2BX9aNBoxl4tqCoqxIlUQc0hU Tw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s37g0g1et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 17:19:04 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QHJ3Fl031069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 17:19:03 GMT
Received: from [10.71.109.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 10:19:02 -0700
Message-ID: <6a0ea31d-814b-6745-d301-c1f6dadf9718@quicinc.com>
Date:   Wed, 26 Jul 2023 10:19:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 4/4] power: reset: Implement a PSCI SYSTEM_RESET2
 reboot-mode driver
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
 <20230724223057.1208122-5-quic_eberman@quicinc.com>
 <46744a2e-139c-4e4e-89b2-66346f64c3f2@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <46744a2e-139c-4e4e-89b2-66346f64c3f2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FdSHAzmfzVkbA0bTZGWj0JRqvGXOoubk
X-Proofpoint-ORIG-GUID: FdSHAzmfzVkbA0bTZGWj0JRqvGXOoubk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=911 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260154
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2023 3:41 AM, Pavan Kondeti wrote:
> On Mon, Jul 24, 2023 at 03:30:54PM -0700, Elliot Berman wrote:
>> PSCI implements a restart notifier for architectural defined resets.
>> The SYSTEM_RESET2 allows vendor firmware to define additional reset
>> types which could be mapped to the reboot reason.
>>
>> Implement a driver to wire the reboot-mode framework to make vendor
>> SYSTEM_RESET2 calls on reboot.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Do we need to skip the PSCI call from the existing PSCI restart notifier
> which gets called after your newly introduced callback from reboot mode
> notifier?
> 

No need, the vendor SYSTEM_RESET2 call shouldn't return if the call worked.

> Thanks,
> Pavan
