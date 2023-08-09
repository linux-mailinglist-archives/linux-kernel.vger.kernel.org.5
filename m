Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C836E776BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHIWMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjHIWL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:11:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B043FE;
        Wed,  9 Aug 2023 15:11:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379LGPEQ007338;
        Wed, 9 Aug 2023 22:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jQlTOVhoAlsUv+sIX6BAvnsZfsGmAq6GCgb5EX7v4F4=;
 b=mwIMturxGsxRj4yzorpj9fU3Rzl5jDdCE3BZ9ThzpsyRZO2iW9uLLip9favkbqLUF63N
 ecRVgk2g86p19wHRvEIpZGSuejeVTdtKkwp5dkpDBvh5DHas9/REMMf5NS9aXhqxA998
 rYtERRMB3SYNfRFSoDoN9j479uxRX5414Cp7+zzaSGoVvl41kwpJyPoYVwqAn24QSo3+
 fEoGV3xexXa7K8PYklGU9Vama2cTUhKLbxCVPLIugoWo2nJhWUwXrqMPY3YtnL5KQF8e
 FbmN48RmTcUAdy0SsjpueBYJn5OsReWX/tjqy4EQQPPH2F5gskPDNY6fqvLLFJ3/+xOn DQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scbcgh1nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 22:11:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379MBghS027580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 22:11:42 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 15:11:40 -0700
Message-ID: <bdeedd8a-c417-4265-374d-09747e60d1d0@quicinc.com>
Date:   Wed, 9 Aug 2023 15:11:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] scsi: ufs: host: convert to dev_err_probe() in
 pltfrm_init
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hugo@hugovil.com>
References: <20230809191054.2197963-1-bmasney@redhat.com>
 <20230809191054.2197963-3-bmasney@redhat.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <20230809191054.2197963-3-bmasney@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HDN95-r0SIug4zXLL5k4nx_ukD_1YRXv
X-Proofpoint-ORIG-GUID: HDN95-r0SIug4zXLL5k4nx_ukD_1YRXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_19,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090191
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2023 12:10 PM, Brian Masney wrote:
> Convert ufshcd_pltfrm_init() over to use dev_err_probe() to avoid
> the following log message on bootup due to an -EPROBE_DEFER return
> code:
> 
>      ufshcd-qcom 1d84000.ufs: Initialization failed
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
> No changes since v1
> 
>   drivers/ufs/host/ufshcd-pltfrm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
> index 0b7430033047..f2c50b78efbf 100644
> --- a/drivers/ufs/host/ufshcd-pltfrm.c
> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
> @@ -373,7 +373,7 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>   
>   	err = ufshcd_init(hba, mmio_base, irq);
>   	if (err) {
> -		dev_err(dev, "Initialization failed\n");
> +		dev_err_probe(dev, err, "Initialization failed\n");
Hi Brian,
Can you pls add the error code to the print?

>   		goto dealloc_host;
>   	}
>   

