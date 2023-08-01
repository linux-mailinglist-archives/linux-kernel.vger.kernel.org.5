Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC776A597
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjHAAg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHAAgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:36:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC61716;
        Mon, 31 Jul 2023 17:36:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VNkLET024503;
        Tue, 1 Aug 2023 00:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qx/l7XRW2WE2LV4+ZFd7e+pptScEjHgRL0vlR+9OTms=;
 b=FkSwGEzavo+r1QBPMItZ7Nv+dhJYDJy3fxaTs+34HZf/N2Zsn4WCMHbbTxyVOJUufXYG
 Z7WNvAl9WZNWatVm6gwFa2zmoVdIhPmDHkjbwMRPq064b3jDNzBm5PCvVv+k7DycV0bp
 f1e5/DiYOhZTIuxpJosYpEh8Ghp7fQca8boVAee6EoOUmanBmDsoxEiX4WCoJokWVPfE
 9aLEOvuW+7ftYCZFDKX6TsEd6pcl6hhzQjJXt6+2Nqfy3YXqkzphglQecKKpTxxS7gm5
 ATg2N7Muh4hBaN+tIy9FgID7rXSzkgps4TV6ugEo+2JvW4qpN8+S1deZMgvyxc6y37Ts yA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uxsdbdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 00:36:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3710aJwe026506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 00:36:19 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:36:18 -0700
Message-ID: <abcd7ea3-086b-b07c-bb08-63aaf2585040@quicinc.com>
Date:   Mon, 31 Jul 2023 17:36:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: qmi: Signal the txn completion after releasing
 the mutex
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230731130755.2674029-1-quic_ipkumar@quicinc.com>
 <eda306fc-1a92-4a2d-b13f-c3b59a39ef8d@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <eda306fc-1a92-4a2d-b13f-c3b59a39ef8d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6v6_DVTBZSvzx537gDlgEwsF5urJsyGy
X-Proofpoint-GUID: 6v6_DVTBZSvzx537gDlgEwsF5urJsyGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_17,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 impostorscore=0 mlxlogscore=959
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 8:19 AM, Pavan Kondeti wrote:
> On Mon, Jul 31, 2023 at 06:37:55PM +0530, Praveenkumar I wrote:
>> txn is in #1 stack
>>
>> Worker #1                                       Worker #2
>> ********					*********
>>
>> qmi_txn_wait(txn)                               qmi_handle_message
>>     |                                                  |
>>     |                                                  |
>>   wait_for_complete(txn->complete)                    ....
>>     |                                             mutex_lock(txn->lock)
>>     |                                                  |
>>   mutex_lock(txn->lock)                                |
>>     .....                                         complete(txn->lock)
>>     |                                             mutex_unlock(txn->lock)
>>     |
>>   mutex_unlock(txn->lock)
>>
>> In this case above, while #2 is doing the mutex_unlock(txn->lock),
>> in between releasing lock and doing other lock related wakeup, #2 gets
>> scheduled out. As a result #1, acquires the lock, unlocks, also
>> frees the txn also (where the lock resides)
>>
>> Now #2, gets scheduled again and tries to do the rest of the lock
>> related wakeup, but lock itself is invalid because txn itself is gone.
>>
>> Fixing this, by doing the mutex_unlock(txn->lock) first and then
>> complete(txn->lock) in #2
>>
>> Fixes: 3830d0771ef6 ("soc: qcom: Introduce QMI helpers")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   drivers/soc/qcom/qmi_interface.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
>> index 78d7361fdcf2..92e29db97359 100644
>> --- a/drivers/soc/qcom/qmi_interface.c
>> +++ b/drivers/soc/qcom/qmi_interface.c
>> @@ -505,12 +505,13 @@ static void qmi_handle_message(struct qmi_handle *qmi,
>>   				pr_err("failed to decode incoming message\n");
>>   
>>   			txn->result = ret;
>> -			complete(&txn->completion);
>>   		} else  {
>>   			qmi_invoke_handler(qmi, sq, txn, buf, len);
>>   		}
>>   
>>   		mutex_unlock(&txn->lock);
>> +		if (txn->dest && txn->ei)
>> +			complete(&txn->completion);
>>   	} else {
>>   		/* Create a txn based on the txn_id of the incoming message */
>>   		memset(&tmp_txn, 0, sizeof(tmp_txn));
> 
> What happens in a remote scenario where the waiter gets timed out at the
> very same time you are releasing the mutex but before calling
> complete()? The caller might end up freeing txn structure and it results
> in the same issue you are currently facing.
> 
> Thanks,
> Pavan

I think downstream we had various attempts of moving the signal around 
trying to avoid this, but hit scenarios like the one Pavan described.

We eventually settled on removing the txn->lock and treating the 
qmi->txn_lock as a big lock. This remedied the issue where the txn->lock 
goes out of scope since qmi->txn_lock is tied to the qmi handle.

