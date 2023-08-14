Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526D677BBD5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjHNOiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjHNOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:38:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BBA3;
        Mon, 14 Aug 2023 07:38:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEbmtY020229;
        Mon, 14 Aug 2023 14:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ctgfKqke1KMt4Uad400HWLtBgZPZ0OK4YD9H668D0qg=;
 b=mklUYTm7F6SiPyCEOI5kHC9b+5j8l/4wjAezuMU7TtS+MZgdGiFeOswgSWl+7gg+ZZWU
 oOaq6u0v6Nn5hPeV62su17ZDNsjJYUwqF6aV6cyxL5aOlfxNHvGeTPwhEe05OaDJ/+3j
 fswUuWEza0w169RIlQv5vfEbxgK2weeVX6FbESyB3hb2nOAIzK8EUJCrSaQ/AX2V9Jqd
 d+Yj2e86itY6BkQ5RXLi7FFF6KHbJCrHlPDd1fJwaWO6rw7mhiko3fq/z7wi42HNL2uT
 1KHcL1itCC5naCslqnMmTg+PhX0GUrKT8TKRPHWE2IaIvI4hrjnrtRR8lux2qqlhTyXz /A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfh74gm23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 14:37:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EEblnC019556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 14:37:47 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 07:37:42 -0700
Message-ID: <422d202b-2e2e-b01f-436b-bdf7c7024960@quicinc.com>
Date:   Mon, 14 Aug 2023 20:07:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3] scsi: ufs: qcom: Align programming sequence as per HW
 spec
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <mani@kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_cang@quicinc.com>, <quic_asutoshd@quicinc.com>,
        <avri.altman@wdc.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <jejb@linux.ibm.com>, <linux-arm-msm@vger.kernel.org>,
        <quic_ziqichen@quicinc.com>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230809151243.17531-1-quic_nitirawa@quicinc.com>
 <yw5mgmk5q6vhwmu5oiqpg5kvafhlojzposoiaiy4j7wynov6sg@fgbx3twcsuwd>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <yw5mgmk5q6vhwmu5oiqpg5kvafhlojzposoiaiy4j7wynov6sg@fgbx3twcsuwd>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fzRqCTK1xq_ckIeFbd3wCTfCzdQGoHIV
X-Proofpoint-GUID: fzRqCTK1xq_ckIeFbd3wCTfCzdQGoHIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=649 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140135
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

I've updated the commit message in latest Patchset. Please can you help 
review.

Regards,
Nitin


On 8/10/2023 8:11 PM, Bjorn Andersson wrote:
> On Wed, Aug 09, 2023 at 08:42:43PM +0530, Nitin Rawat wrote:
>> Align clock configuration as per Qualcomm UFS controller
>> hardware specification.
>>
>> This change updates UFS_SYS1CLK_1US, CORE_CLK_1US_CYCLES,
>> PA_VS_CORE_CLK_40NS_CYCLES timer configuration for Qunipro
>> and UTP to align with Qualcomm UFS HW specification.
> 
> "Code is wrong, make code right"
> 
> 
> I find it hard to believe that "the clock configuration is wrong" takes
> 207 lines of code to address.
> 
> Please instead describe the problem you're solving, to ensure that
> current and future readers of this commit message have a chance to
> understand why this change was made.
> 
> The "describing your changes" section in the documentation is good,
> please read it:
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> 
> Regards,
> Bjorn
