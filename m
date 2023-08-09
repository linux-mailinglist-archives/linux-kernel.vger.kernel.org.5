Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17877661D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHIRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjHIRGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:06:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BA11718;
        Wed,  9 Aug 2023 10:06:17 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379GPOJ0022857;
        Wed, 9 Aug 2023 17:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=25KMdSV6JRQELSQISvTMDLzpIj4o4cC2d5iH5BsjijQ=;
 b=pKE6WQNnosATXWccNgNmXBM8a1r/zromxyfkdftXTQZzOLrzK49hvCiNjRlKFR9Y+v8v
 XAyxX2X7M11ExK/dUnpwWRza6HhP3fc6mEIBmzQhrtxHbRiEaJphZ/ErmR1HCsD6Pi6a
 chk+uBEi2baApEgVRTzd/1f8jV8VgUMC0gUR2dAoWj5m3Cz3xhhRqzr/onpTFxYXCiXW
 EAWcfXUutU9HBiHNZDKU/NzJdMfrJ212D3WpTNT8mJilq+jCV69Gq5Q4Nn9akJvT5OLg
 hHux1esn25BO5si/4m8HAio7sMpnpDFPhihW3j6A9pVNssEoWWhpiT6cBvL03XNBRN5/ /Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scbd4gjqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 17:06:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379H611k026543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 17:06:02 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 10:06:01 -0700
Message-ID: <32d1a742-a984-bead-ef60-d5edac6b5fd9@quicinc.com>
Date:   Wed, 9 Aug 2023 10:06:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V3] scsi: ufs: qcom: Align programming sequence as per HW
 spec
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, <mani@kernel.org>,
        <quic_cang@quicinc.com>, <quic_asutoshd@quicinc.com>,
        <avri.altman@wdc.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>
CC:     <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <jejb@linux.ibm.com>, <linux-arm-msm@vger.kernel.org>,
        <quic_ziqichen@quicinc.com>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230809151243.17531-1-quic_nitirawa@quicinc.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <20230809151243.17531-1-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y2MeWIgInB7BxS2rrDf-V1OONSNqLJKN
X-Proofpoint-ORIG-GUID: Y2MeWIgInB7BxS2rrDf-V1OONSNqLJKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=862 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090149
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2023 8:12 AM, Nitin Rawat wrote:
> Align clock configuration as per Qualcomm UFS controller
> hardware specification.
> 
> This change updates UFS_SYS1CLK_1US, CORE_CLK_1US_CYCLES,
> PA_VS_CORE_CLK_40NS_CYCLES timer configuration for Qunipro
> and UTP to align with Qualcomm UFS HW specification.
> 
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
> 

Reviewed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
