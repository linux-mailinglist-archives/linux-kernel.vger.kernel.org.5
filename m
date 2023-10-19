Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53297D0055
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbjJSROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjJSROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:14:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF4C106;
        Thu, 19 Oct 2023 10:14:42 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JGM1t2018904;
        Thu, 19 Oct 2023 17:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zvoS9bMPhzzMF3tou0VZrB8JXEoraLA843fYSqg5hws=;
 b=jvo6izvlWGta4R14+0jzMk3QcM0AUxLPrP0kUP4EyxxVm13Uv+W99wWjVbvWt+BqdoO9
 huyg8EvjYX5TNeRqz6gqdbvOXQOGy2ktT24YkSGeqsYHq3As8xY166uge2p0+17MBOtA
 QpM7sBXyPkafBMpuKVXvEySp0F3MHNAOpP76++7c+BFkxV+3SWmKcHglD+FjoTEfa/rJ
 W3n8cNfultTVuzXq+8v2njE43MnMQz7pfuCAfmp04VFOymi7Vhdx5Kn5QPumGGuNDv8i
 FhKbT9Xfkp55TS9kP/IuNoMMC6mfcDLU0CQrTdkEU337TUZJjOpuQHg0S7hp3pEWJPxR uA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tu1t6s24m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 17:14:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JHEbDI021346
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 17:14:37 GMT
Received: from [10.48.241.70] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 19 Oct
 2023 10:14:36 -0700
Message-ID: <acc17669-2023-4658-a0d7-a3317aaf93ad@quicinc.com>
Date:   Thu, 19 Oct 2023 10:14:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath11k: fix temperature event locking
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20231019153115.26401-1-johan+linaro@kernel.org>
 <20231019153115.26401-2-johan+linaro@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231019153115.26401-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TM-SAViKT_2mnuqUy9NfHbbhKBcv8E3r
X-Proofpoint-ORIG-GUID: TM-SAViKT_2mnuqUy9NfHbbhKBcv8E3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=503 phishscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310190146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2023 8:31 AM, Johan Hovold wrote:
> The ath11k active pdevs are protected by RCU but the temperature event
> handling code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
> read-side critical section as reported by RCU lockdep:
> 
> 	=============================
> 	WARNING: suspicious RCU usage
> 	6.6.0-rc6 #7 Not tainted
> 	-----------------------------
> 	drivers/net/wireless/ath/ath11k/mac.c:638 suspicious rcu_dereference_check() usage!
> 
> 	other info that might help us debug this:
> 
> 	rcu_scheduler_active = 2, debug_locks = 1
> 	no locks held by swapper/0/0.
> 	...
> 	Call trace:
> 	...
> 	 lockdep_rcu_suspicious+0x16c/0x22c
> 	 ath11k_mac_get_ar_by_pdev_id+0x194/0x1b0 [ath11k]
> 	 ath11k_wmi_tlv_op_rx+0xa84/0x2c1c [ath11k]
> 	 ath11k_htc_rx_completion_handler+0x388/0x510 [ath11k]
> 
> Mark the code in question as an RCU read-side critical section to avoid
> any potential use-after-free issues.
> 
> Fixes: a41d10348b01 ("ath11k: add thermal sensor device support")
> Cc: stable@vger.kernel.org      # 5.7
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

