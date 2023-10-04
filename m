Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046687B98A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbjJDXSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbjJDXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:18:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9ABC9;
        Wed,  4 Oct 2023 16:18:15 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394NGkYd008609;
        Wed, 4 Oct 2023 23:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=qvABwaAy+Y1UTbmCtxFfRiTJHoXy4PGIFOgTsT8IeEs=;
 b=VYb6xDeAErY7d92+ABtZ+ooMiHRwAbwxSftrfV/kR9QCbYbx01ZKuaU7olFYr+n5NnOB
 lIlfyUGI3SroTDFb0zM04HNzv2EZk7THnnFvpdRK7dq9bKN3JZa9PRZZHVXGlSCKt5v9
 zzPiJfk8QhJdwuK7iBLXcndVTapXrHHPXIcCOEkhIt65sUhVvp91wWJXsAyeeqhtv/b7
 SQNvpW13cyqOAZU3ZQMmIthxLNZceG0GQHBUHDFhr6zjlVm/FOa/CSxNB5N9bbpKW0h1
 pmqkMwCdZnN6FszyWybBprt3d3BRxWgHKIvSnP5kzfgdxvVVoy3+05+y3Yo1iga6UzqZ Ow== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th8e1sd76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 23:18:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394NI4Xf003415
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 23:18:04 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 4 Oct 2023 16:18:04 -0700
Date:   Wed, 4 Oct 2023 16:18:02 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Shubh <shubhisroking@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: refactor deprecated strncpy
Message-ID: <20231004231802.GD3553829@hu-bjorande-lv.qualcomm.com>
References: <20231004044017.37027-1-shubhisroking@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231004044017.37027-1-shubhisroking@gmail.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 34sa03ZUgSpOC2wHkhu5--ckOkOvyc4C
X-Proofpoint-ORIG-GUID: 34sa03ZUgSpOC2wHkhu5--ckOkOvyc4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 10:10:17AM +0530, Shubh wrote:
> Prefer `strscpy_pad` to `strncpy`.
> 
> Signed-off-by: Shubh <shubhisroking@gmail.com>

Please spell out your name on future patches.

> ---
>  drivers/soc/qcom/cmd-db.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index 34c40368d..dc42704d7 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -152,7 +152,7 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
>  	 * query string is not necessarily '\0' terminated if it bumps up
>  	 * against the max size. That's OK and expected.
>  	 */
> -	strncpy(query, id, sizeof(query));
> +	strscpy_pad(query, id, sizeof(query));

Please read the comment above, and please read fe72f9bce137 ("soc: qcom:
cmd-db: replace strscpy_pad() with strncpy()")

Thanks,
Bjorn

>  
>  	for (i = 0; i < MAX_SLV_ID; i++) {
>  		rsc_hdr = &cmd_db_header->header[i];
> -- 
> 2.42.0
> 
