Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AE3769AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjGaPTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGaPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:19:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623210E3;
        Mon, 31 Jul 2023 08:19:29 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VE1ZVK022849;
        Mon, 31 Jul 2023 15:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=SSJT7kcV4Rhk+b8oB624C63i7adQDSXb+42Vq0rGPV4=;
 b=lZyo/dBOJSIUuLNjlX2KKBG0COPHpB9jJhXUlJF8EDZypGuwwS5Ky8d3ReWN6tfVFeHN
 TEJMzZawdDZRkO+Hn/hwqqvP1EbZF4hSC4nGVzIXn6fxGoEPt+5hG2PFRYCv5j/7xr6r
 kAS49aZs0pF8IFU2MepZ9v8xlsSbQ4wNEUZ5Sy+4StKMHasuAwppbt3mFwnVcDLQKnJA
 oqtFQuDI3MgKsHtbwWmwZbknzggzY7BqRJjjnReAwZQYWEJGWG3OFPdOeLGPlLIhxPFB
 KpwiYMihKrY0+MGS3FTDloCsW8iijOLudP6RhsSSdwyGK8QYM2ThhSEOMXZ97oB3FXXd vA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ueumej5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 15:19:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VFJHaI006207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 15:19:17 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 08:19:14 -0700
Date:   Mon, 31 Jul 2023 20:49:09 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <quic_clew@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
Subject: Re: [PATCH] soc: qcom: qmi: Signal the txn completion after
 releasing the mutex
Message-ID: <eda306fc-1a92-4a2d-b13f-c3b59a39ef8d@quicinc.com>
References: <20230731130755.2674029-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731130755.2674029-1-quic_ipkumar@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ceaKZoqUrcyNOngtoWhI0poymE5SYdV0
X-Proofpoint-ORIG-GUID: ceaKZoqUrcyNOngtoWhI0poymE5SYdV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_07,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=837
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310137
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:37:55PM +0530, Praveenkumar I wrote:
> txn is in #1 stack
> 
> Worker #1                                       Worker #2
> ********					*********
> 
> qmi_txn_wait(txn)                               qmi_handle_message
>    |                                                  |
>    |                                                  |
>  wait_for_complete(txn->complete)                    ....
>    |                                             mutex_lock(txn->lock)
>    |                                                  |
>  mutex_lock(txn->lock)                                |
>    .....                                         complete(txn->lock)
>    |                                             mutex_unlock(txn->lock)
>    |
>  mutex_unlock(txn->lock)
> 
> In this case above, while #2 is doing the mutex_unlock(txn->lock),
> in between releasing lock and doing other lock related wakeup, #2 gets
> scheduled out. As a result #1, acquires the lock, unlocks, also
> frees the txn also (where the lock resides)
> 
> Now #2, gets scheduled again and tries to do the rest of the lock
> related wakeup, but lock itself is invalid because txn itself is gone.
> 
> Fixing this, by doing the mutex_unlock(txn->lock) first and then
> complete(txn->lock) in #2
> 
> Fixes: 3830d0771ef6 ("soc: qcom: Introduce QMI helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>  drivers/soc/qcom/qmi_interface.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
> index 78d7361fdcf2..92e29db97359 100644
> --- a/drivers/soc/qcom/qmi_interface.c
> +++ b/drivers/soc/qcom/qmi_interface.c
> @@ -505,12 +505,13 @@ static void qmi_handle_message(struct qmi_handle *qmi,
>  				pr_err("failed to decode incoming message\n");
>  
>  			txn->result = ret;
> -			complete(&txn->completion);
>  		} else  {
>  			qmi_invoke_handler(qmi, sq, txn, buf, len);
>  		}
>  
>  		mutex_unlock(&txn->lock);
> +		if (txn->dest && txn->ei)
> +			complete(&txn->completion);
>  	} else {
>  		/* Create a txn based on the txn_id of the incoming message */
>  		memset(&tmp_txn, 0, sizeof(tmp_txn));

What happens in a remote scenario where the waiter gets timed out at the
very same time you are releasing the mutex but before calling
complete()? The caller might end up freeing txn structure and it results
in the same issue you are currently facing. 

Thanks,
Pavan
