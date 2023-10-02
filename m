Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94847B5A68
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjJBSgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJBSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:36:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6416BAB;
        Mon,  2 Oct 2023 11:36:39 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392ILkAg015794;
        Mon, 2 Oct 2023 18:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=luVZOuFEDAuHKP2TvHHHlNuyDeSqZdneQoSyF7czdUk=;
 b=ngkqdt6imNw7nA+GUyiQ/9A8i9LKiYiiGwAHnqBiyvYzTuwDD3aHMtTGRfXoov1tFM0Y
 1i9jk58mniMar7Ou+BYCqgIXb+sS5gZUPtsqFVWN5Zjfyj5+oV3DnGBEdjkcX+CjPaLl
 TCmr5/NzRWvNbzgy/hxWNG5Blvdv/r1PmjLOWgV0CJs1/LDGp7iuHVKo8Z2w0uyc0Ce3
 GelY3P9RoJUd75k2MURQdLd9CzibR+Qj2ykn0gKsx3y3oFRkYtA3LNfBoH4YsLggdIdH
 1hECfZseIJqPYvQED5HQBkRv/Hl2q8WTzdmVe6XVHvo4cKog5jbH7V0KFRMB8uSi+urh 2w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3te9cmmnpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 18:36:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 392IaA2F028964
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Oct 2023 18:36:10 GMT
Received: from [10.110.71.113] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 2 Oct
 2023 11:36:10 -0700
Message-ID: <8d5af4d7-23fc-a03e-bad8-760209b537a0@quicinc.com>
Date:   Mon, 2 Oct 2023 11:36:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/4] firmware: arm_scmi: Add polling support for
 completion in smc
To:     Brian Masney <bmasney@redhat.com>
CC:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-2-quic_nkela@quicinc.com> <ZRsJWdZVMc+F5ZgF@brian-x1>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <ZRsJWdZVMc+F5ZgF@brian-x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AyPeROoQvaxvd8njlrW4LG-36WoauSg9
X-Proofpoint-ORIG-GUID: AyPeROoQvaxvd8njlrW4LG-36WoauSg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020144
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/2023 11:18 AM, Brian Masney wrote:
> On Mon, Sep 11, 2023 at 12:43:56PM -0700, Nikunj Kela wrote:
>> Currently, the return from the smc call assumes the completion of
>> the scmi request. However this may not be true in virtual platforms
>> that are using hvc doorbell.
>>
>> This change adds a Kconfig to enable the polling for the request
>> completion.
>>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/Kconfig | 14 ++++++++++++++
>>   drivers/firmware/arm_scmi/smc.c   | 15 ++++++++++++++-
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
>> index ea0f5083ac47..771d60f8319f 100644
>> --- a/drivers/firmware/arm_scmi/Kconfig
>> +++ b/drivers/firmware/arm_scmi/Kconfig
>> @@ -125,6 +125,20 @@ config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
>>   	  in atomic context too, at the price of using a number of busy-waiting
>>   	  primitives all over instead. If unsure say N.
>>   
>> +config ARM_SCMI_TRANSPORT_SMC_POLL_COMPLETION
>> +	bool "Enable polling support for SCMI SMC transport"
>> +	depends on ARM_SCMI_TRANSPORT_SMC
>> +	help
>> +	  Enable completion polling support for SCMI SMC based transport.
>> +
>> +	  If you want the SCMI SMC based transport to poll for the completion,
>> +	  answer Y.
>> +	  Enabling completion polling might be desired in the absence of the a2p
>> +	  irq when the return from smc/hvc call doesn't indicate the completion
>> +	  of the SCMI requests. This might be useful for instances used in
>> +	  virtual platforms.
>> +	  If unsure say N.
>> +
>>   config ARM_SCMI_TRANSPORT_VIRTIO
>>   	bool "SCMI transport based on VirtIO"
>>   	depends on VIRTIO=y || VIRTIO=ARM_SCMI_PROTOCOL
>> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
>> index c193516a254d..0a0b7e401159 100644
>> --- a/drivers/firmware/arm_scmi/smc.c
>> +++ b/drivers/firmware/arm_scmi/smc.c
>> @@ -250,6 +250,16 @@ static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
>>   	smc_channel_lock_release(scmi_info);
>>   }
>>   
>> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC_POLL_COMPLETION
>> +static bool
>> +smc_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
>> +{
>> +	struct scmi_smc *scmi_info = cinfo->transport_info;
>> +
>> +	return shmem_poll_done(scmi_info->shmem, xfer);
>> +}
>> +#endif
>> +
>>   static const struct scmi_transport_ops scmi_smc_ops = {
>>   	.chan_available = smc_chan_available,
>>   	.chan_setup = smc_chan_setup,
>> @@ -257,6 +267,9 @@ static const struct scmi_transport_ops scmi_smc_ops = {
>>   	.send_message = smc_send_message,
>>   	.mark_txdone = smc_mark_txdone,
>>   	.fetch_response = smc_fetch_response,
>> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC_POLL_COMPLETION
>> +	.poll_done = smc_poll_done,
>> +#endif
>>   };
>>   
>>   const struct scmi_desc scmi_smc_desc = {
>> @@ -272,6 +285,6 @@ const struct scmi_desc scmi_smc_desc = {
>>   	 * for the issued command will be immmediately ready to be fetched
>>   	 * from the shared memory area.
>>   	 */
>> -	.sync_cmds_completed_on_ret = true,
>> +	.sync_cmds_completed_on_ret = !IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_POLL_COMPLETION),
>>   	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
>  From a Linux distributor viewpoint, it would be nice if this was
> determined at runtime, rather than at compile time. We generate a single
> kernel binary that's used on systems from multiple hardware
> manufacturers. We'd run into an issue if one company required this, but
> another one didn't. We may potentially run into this same type of issue
> with the upstream arm64 defconfig.
>
> Brian
This is a transport dependent property. Either the transport supports 
"completion on return of the smc call" or not. For a given platform, 
this will be fixed for all channels. This is similar to

CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE which is also a Kconfig.

