Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D573791C09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbjIDR1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIDR1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:27:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B9BCF6;
        Mon,  4 Sep 2023 10:27:47 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384HReHE020038;
        Mon, 4 Sep 2023 17:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UoZi2/Mb8NtipTFO2Sz5ZO5fWPKNmFQc/ZL4I3EGII4=;
 b=le+wGYGapJ2v6KekyQF0+9GSs/dzon3QcAlbiwe2RJZelDOfUlIPmQJ8URQIXrboALuz
 dMnXzEi+9rm0Lw6F/D+qcePYiAK7mwc/lXmMPiGughAAJVUB9qAdFBTnkURYuuy57cLS
 RIrDWbVd/sQw4EZX4kWocPm2qDsYzu9SA9Q4XOdMXBxhFIgwP4i4uR14ac73TYoV/5uT
 /K/ejQG4HSLxHc3cB0oBCU8QeKk7SkmytQtjYq4TUdfWh7YdT1cTFw+7cNfpbdEpWwKW
 QIqt+MJXaZo4PaDwmt4YDx7bcJMW2bxBtdwfpXmJITYRNR/16CvAZ+DtBGwjSgGIjmN1 Pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suwedbwq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 17:27:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384HRdCt025331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 17:27:39 GMT
Received: from [10.50.40.93] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 4 Sep
 2023 10:27:34 -0700
Message-ID: <6ba49071-c97a-4657-af67-0abf93cfa0d7@quicinc.com>
Date:   Mon, 4 Sep 2023 22:57:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix tcsr_mutex register for IPQ6018
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ohad@wizery.com>,
        <baolin.wang@linux.alibaba.com>, <linux-remoteproc@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20230904055010.4118982-1-quic_viswanat@quicinc.com>
 <9492bc16-2d8f-44a1-b2d6-d5f8353f30fa@linaro.org>
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
In-Reply-To: <9492bc16-2d8f-44a1-b2d6-d5f8353f30fa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bRmhfoI2Ouf4wOGM6Bd-7yGOG__91IzA
X-Proofpoint-GUID: bRmhfoI2Ouf4wOGM6Bd-7yGOG__91IzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=912 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2023 9:28 PM, Konrad Dybcio wrote:
> On 4.09.2023 07:50, Vignesh Viswanathan wrote:
>> IPQ6018 has 32 tcsr_mutext hwlock registers of 0x1000 size each.
>> The compatible string qcom,ipq6018-tcsr-mutex is mapped to
>> of_msm8226_tcsr_mutex which has 32 locks configured with stride of 0x80
>> and doesn't match the HW present in IPQ6018.
>>
>> This series fixes the following:
>> 1. Fix the tcsr_mutex hwlock register size to 0x20000 in ipq6018.dtsi.
>> 2. Remove qcom,ipq6018-tcsr-mutex compatible string for tcsr_mutex in
>> ipq6018.dtsi.
>> 3. Drop unused qcom,ipq6018-tcsr-mutex compatible string from
>> qcom_hwspinlock driver and dt-bindings.
>>
> Sounds like 20230904063344.4144086-1-quic_viswanat@quicinc.com can't
> go in without this then?
> 

They can independently go in as the current max size and stride set for
IPQ6018 still has 32 locks and moving the index 3 shouldn't cause any 
issues.

However, functionally IPQ6018's HW lock is broken and will be fixed once 
this series goes in.

Thanks,
Vignesh
> Konrad
