Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E35779A3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjIKGnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjIKGnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:43:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E5126;
        Sun, 10 Sep 2023 23:42:59 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B6HBSq025874;
        Mon, 11 Sep 2023 06:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mJgaCC6bHfC3tt0UFE/W3pn4k1iUQh7kxD9oPUUTjsg=;
 b=KlEIA3kf/sQl6BA1EfUZN/3zokEdypmWbHJv3SeUGGCaidmXghs0zll6Uzx8Og6HDzI0
 fEIPnTmxDT7vWIojsa4JLvPkq4nGJV3yfcVZPvs2X/yhAORFWtkxiXA+fNEWNF9cU0rr
 fYKtjvs+Uk4qSBzuIq+afuzu5Aq+Tyjdq1GAl9iUx8r3rFxZ67leVubnpTazQQ8Txt8v
 NPlrxZGy/dMFkEgpTC6npqVoOzbZ9CaO7N0nukNCR1pC+kNvH6mWPNDYM+lmEK0X77jV
 Js4JnKpzrDh7nxQdgGgWjc3icCA2oQ27i4HYFiA22Je/wR9U+uHTbptq1opCQ0uifoDt 9w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0h3dtnt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 06:42:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B6gp1o030227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 06:42:51 GMT
Received: from [10.253.14.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 10 Sep
 2023 23:42:48 -0700
Message-ID: <b16aa25f-5cb9-4afa-e884-cb60c0aa1268@quicinc.com>
Date:   Mon, 11 Sep 2023 14:42:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V8 0/5] scsi: ufs: qcom: Align programming sequence as per
 HW spec
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, <mani@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230905052400.13935-1-quic_nitirawa@quicinc.com>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20230905052400.13935-1-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l9KVxlKX2RUg-z-VEGXwihnJMVaWJDOR
X-Proofpoint-ORIG-GUID: l9KVxlKX2RUg-z-VEGXwihnJMVaWJDOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxlogscore=668 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309110060
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2023 1:23 PM, Nitin Rawat wrote:
> This patch series adds programming support for Qualcomm UFS V4 and above
> to align avoid with Hardware Specification. This patch series will address
> stability and performance issues.
>
> In this patch series below changes are taken care.
>
> 1) Register layout for DME_VS_CORE_CLK_CTRL has changed for v4 and above.
> 2) Adds Support to configure PA_VS_CORE_CLK_40NS_CYCLES attibute for UFS V4
>     and above.
> 3) Adds Support to configure multiple unipro frequencies like 403MHz,
>     300MHz, 202MHz, 150 MHz, 75Mhz, 37.5 MHz for Qualcomm UFS Controller V4
>     and above.
> 4) Allow configuration of SYS1CLK_1US_REG for UFS V4 and above.
>
> Changes From v7:
> - Fix the compilation error for kernel doc
>
> Changes from v6:
> - Addressed bjorn comment to optimize the code.
> - Addressed bjorn comment to update commit message
> - removed clean up part related for clk div configuration comapared to v6
>
> changes from v5:
> - Addressed Mani comment to FIELD_PREP and FIELD_FIT.
> - Optimised ufs_qcom_set_core_clk_ctrl API.
> - Updated commit text for few patches to capture more details.
>
> Changes from v4:
> - Addressed bjorn comment to split single patch to multiple patches.
>
> Changes from v3:
> -Addressed bjorn comment to update commit msg to capture change details.
>
> Changes from v2:
> - Addressed bao comment, removed duplicate clock timer cfg API call
>
> Changes from v1:
> - Addressed bao comment, removed wrapper function
> - Tab alignment
>
> Nitin Rawat (5):
>    scsi: ufs: qcom: Update MAX_CORE_CLK_1US_CYCLES for UFS V4 and above
>    scsi: ufs: qcom: Add multiple frequency support for
>      MAX_CORE_CLK_1US_CYCLES
>    scsi: ufs: qcom: Add support to Configure PA_VS_CORE_CLK_40NS_CYCLES
>    scsi: ufs: qcom: Align programing of unipro clk attributes
>    scsi: ufs: qcom: Configure SYS1CLK_1US_REG for UFS V4 and above
>
>   drivers/ufs/host/ufs-qcom.c | 202 ++++++++++++++++++++++++++++--------
>   drivers/ufs/host/ufs-qcom.h |  18 +++-
>   2 files changed, 175 insertions(+), 45 deletions(-)
>
> --
> 2.17.1

To the whole series -

Reviewed-by: Can Guo <quic_cang@quicinc.com>

