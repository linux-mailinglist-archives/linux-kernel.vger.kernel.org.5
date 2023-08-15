Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE10077C676
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjHODmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjHODib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:38:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB12219A0;
        Mon, 14 Aug 2023 20:25:40 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F3BHtO003137;
        Tue, 15 Aug 2023 03:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+zCrjmWnfcSzNXhXeWpn2EQHEUnw8keVkQ9d4Kzll+s=;
 b=fk90RC+tht4I3GuD+Q0WC4l4l7tM6ovE4/ohDFyIjUGjqq3UJ89OIj9VLvuTEiEduCkj
 6Glmei9zayIQh84F6YKFFP+rTwhb7/6tlWxDuLyE/fbMaHHoGYSmPtkdiO7gzYy00EqO
 umAwEbic6D9sLD8Qo6MGV3qDQC26OwnX7BOscS8x8RbzdCDDlAUYBWIzTeSIOB1RcMYf
 AXPI1d1n9lwu07DSY36eA10pz9Z5sDinboJ5RqD9Z7vVjSGGWM6cB3u6g0JTQWaoRcZX
 gDgb8UPoqaPuQn+2ninCnlhQrjxrbqEabE8VDs9g4Dj38RoOjXkHomqZSPUvnwklcjM4 Xw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfqp1gyt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 03:25:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37F3PShs021935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 03:25:28 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 20:25:27 -0700
Message-ID: <8f980d14-64bd-5fcf-b6ac-231b3172c9a9@quicinc.com>
Date:   Mon, 14 Aug 2023 20:25:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] scsi: ufs: host: convert to dev_err_probe() in
 pltfrm_init
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hugo@hugovil.com>
References: <20230814184352.200531-1-bmasney@redhat.com>
 <20230814184352.200531-3-bmasney@redhat.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <20230814184352.200531-3-bmasney@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nCLONgwnzzOXYSanSr9W8C-vPxhNYkXp
X-Proofpoint-ORIG-GUID: nCLONgwnzzOXYSanSr9W8C-vPxhNYkXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150030
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
> index 0b7430033047..c81a14f9eaf5 100644
> --- a/drivers/ufs/host/ufshcd-pltfrm.c
> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
> @@ -373,7 +373,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>   
>   	err = ufshcd_init(hba, mmio_base, irq);
>   	if (err) {
> -		dev_err(dev, "Initialization failed\n");
> +		dev_err_probe(dev, err, "Initialization failed with error %d\n",
> +			      err);
>   		goto dealloc_host;
>   	}
>   

Reviewed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
