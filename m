Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9497376927A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjGaJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjGaJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:56:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB74213D;
        Mon, 31 Jul 2023 02:55:30 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V9R6d3012689;
        Mon, 31 Jul 2023 09:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZAMrhQIC9XVRayN88yy4TVfX4lfN3CyJU16rNgO9jGY=;
 b=pmdZ9SdcNjg6ihmNiXTnrwbkiJNhjjxXLc1NnmDrq20InrhXd4QDIzRU0NWvwZEXtvBS
 uLJYy7otSrBDaTl5mLnn+2Sy/hyAp8HGcCQKLR99OPXeqRJxsZVe8RiSgo1YgxMYts92
 fgKeySqjDyOfYioIYzHgZumi+e8gcHWif72rhROQf8Pki3agwqH958tTsPs+l6dJD503
 2nYPHnHaGV2moWbYgQAod5TZDu1YoY86tVtW/WuuEkcDOF0aBmL9tiY9C29nVIZj0luv
 rREpDfgSfkIa0b4WKT94WxxFOB+N/eBFjEYMxRCMgrvq1PeDGRYzWcBxDw6I4GLSNcwR 3Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uanu7cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:55:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V9tQ7L017798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:55:26 GMT
Received: from [10.216.47.206] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 02:55:23 -0700
Message-ID: <6920de01-2c32-eae8-2ca8-f04ae3a3bed8@quicinc.com>
Date:   Mon, 31 Jul 2023 15:25:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] soc: qcom: qmi_encdec: Restrict string length in decode
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_clew@quicinc.com>
References: <20230731091408.2458199-1-quic_ipkumar@quicinc.com>
 <4377ba5a-deab-1f24-c785-c90965991af1@linaro.org>
Content-Language: en-US
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <4377ba5a-deab-1f24-c785-c90965991af1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W0jzt3GP2b7JXJQVIcSgwGPokQFsr8x6
X-Proofpoint-ORIG-GUID: W0jzt3GP2b7JXJQVIcSgwGPokQFsr8x6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_03,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=670
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310089
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/31/2023 2:48 PM, Konrad Dybcio wrote:
> On 31.07.2023 11:14, Praveenkumar I wrote:
>> The QMI TLV value for strings in a lot of qmi element info structures
>> account for null terminated strings with MAX_LEN + 1. If a string is
>> actually MAX_LEN + 1 length, this will cause an out of bounds access
>> when the NULL character is appended in decoding.
>>
>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
> Fixes + Cc: stable?
Sure, will add.
>
> Konrad
--
Thanks,
Praveenkumar
