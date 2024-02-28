Return-Path: <linux-kernel+bounces-85238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1C86B2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E8B1C2358B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9F15B113;
	Wed, 28 Feb 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dvz4rBB0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957915B98E;
	Wed, 28 Feb 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132930; cv=none; b=lUGAdyMH9yGTXHBq3eWwNR0O54sIz2LmsOPKVxN9dcm8TzgGPhBCd3T4692LLr1H1/Q1v8LgwtQ4E854wBjszK8+RkiogKnlggnx9NhwZ6WFyT6wAADGB+6ZYVk2t9zsiBedou3WLAaqOQjWuWq7SIY2usg5L6iDBVR+BJ1T1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132930; c=relaxed/simple;
	bh=hC0hZUzddUnZkJKtGKjbrkSXgGl2pTxPGRuIOwGTbXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DQIdWds9lGHpNm9i6rgHl2a88hpasFeAPIdj1qimtG2XqbIEi3HO5DSaF7cbMYYQcaH/wGlwHB3VO1UA/ZMUH1rQAahs8HvhDlq6H7iyPklMfMRP0kIvkZGwDaBVo+KbDOJPlLIKG4iBkLvmz1vBLZ5mh0ZGDD46Q6WFeHDzYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dvz4rBB0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SASuXw014538;
	Wed, 28 Feb 2024 15:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uBGYZjXZ08exoNBo4t5gFS1uBUVDM2Va3XWrZMFyw+U=; b=Dv
	z4rBB0EqLVmNRZx4LxH47R+XjZaYgKZ/bpydxUDrEwZFaHndSluOI6ISNCZtYeq8
	iXg2VGj5mWqu9oZxK87znAVBEYdL9CHo1FLU6WEIl7pQ79mOpzfKovkDS8Vj7nKu
	8cK+SmZjrw3apHIulLrEWZXNuFAPjh5EFAffCFA8i5QSDMHdEiRa1bIAm5kwY0eD
	hbqKrV0tmB1F5gyoIPSNqd091qFNXCEy8248v1UUrM6++pbbdGGVv7NpHCh9g7Yt
	x3aZGmIXoUAS3HNd6w2RCIzX1brJ8fkSNhziZL6b2/2BVnJBT2/sw8rioX/mZNQM
	+xw7jCTMANREHM97TqTA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whtbw9qrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:08:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SF8d9G018903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:08:39 GMT
Received: from [10.216.40.135] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 07:08:37 -0800
Message-ID: <145beef9-75e0-f8ed-7ad1-39b3aadbf4a6@quicinc.com>
Date: Wed, 28 Feb 2024 20:38:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 8/9] firmware: qcom: scm: Add check to prevent Null
 pointer dereference
Content-Language: en-US
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-9-quic_mojha@quicinc.com>
 <20240227085215204-0800.eberman@hu-eberman-lv.qualcomm.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240227085215204-0800.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fZGIB62MZLTmg8E__kCHUGlwAYQDFkXs
X-Proofpoint-ORIG-GUID: fZGIB62MZLTmg8E__kCHUGlwAYQDFkXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280119



On 2/27/2024 10:26 PM, Elliot Berman wrote:
> On Tue, Feb 27, 2024 at 09:23:07PM +0530, Mukesh Ojha wrote:
>> There are multiple place in SCM driver __scm->dev is being
>> accessed without checking if it is valid or not and all
>> not all of function needs the device but it is needed
>> for some cases when the number of argument passed is more
>> and dma_map_single () api is used.
>>
>> Add a NULL check for the cases when it is fine even to pass
>> device as NULL and add qcom_scm_is_available() check for
>> cases when it is needed for DMA api's.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/firmware/qcom/qcom_scm.c | 88 ++++++++++++++++++++++++--------
>>   1 file changed, 66 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 6f14254c0c10..a1dce417e6ec 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -465,7 +465,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>>   	struct qcom_scm_res res;
>>   	int ret;
>>   
>> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
> 
> We're doing this ternary a lot. Maybe an macro would help with
> readability?
> 
> static inline struct device *scm_dev()
> {
> 	return __scm ? __scm->dev : NULL;
> }
> 
> and then we can do
> 
> ret = qcom_scm_call(scm_dev(), &desc, &res);
> 

Sure, will apply.

-Mukesh

>>   
>>   	return ret ? : res.result[0];
>>   }
>> @@ -591,6 +591,9 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>>   	};
>>   	struct qcom_scm_res res;
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	/*
>>   	 * During the scm call memory protection will be enabled for the meta
>>   	 * data blob, so make sure it's physically contiguous, 4K aligned and
>> @@ -637,6 +640,9 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
>>    */
>>   void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
>>   {
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	if (!ctx->ptr)
>>   		return;
>>   
>> @@ -671,6 +677,9 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
>>   	};
>>   	struct qcom_scm_res res;
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	ret = qcom_scm_clk_enable();
>>   	if (ret)
>>   		return ret;
>> @@ -706,6 +715,9 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
>>   	};
>>   	struct qcom_scm_res res;
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	ret = qcom_scm_clk_enable();
>>   	if (ret)
>>   		return ret;
>> @@ -740,6 +752,9 @@ int qcom_scm_pas_shutdown(u32 peripheral)
>>   	};
>>   	struct qcom_scm_res res;
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	ret = qcom_scm_clk_enable();
>>   	if (ret)
>>   		return ret;
>> @@ -776,11 +791,11 @@ bool qcom_scm_pas_supported(u32 peripheral)
>>   	};
>>   	struct qcom_scm_res res;
>>   
>> -	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
>> +	if (!__qcom_scm_is_call_available(__scm ? __scm->dev : NULL, QCOM_SCM_SVC_PIL,
>>   					  QCOM_SCM_PIL_PAS_IS_SUPPORTED))
>>   		return false;
>>   
>> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
>>   
>>   	return ret ? false : !!res.result[0];
>>   }
>> @@ -840,7 +855,7 @@ int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val)
>>   	int ret;
>>   
>>   
>> -	ret = qcom_scm_call_atomic(__scm->dev, &desc, &res);
>> +	ret = qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, &res);
>>   	if (ret >= 0)
>>   		*val = res.result[0];
>>   
>> @@ -859,7 +874,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
>>   		.owner = ARM_SMCCC_OWNER_SIP,
>>   	};
>>   
>> -	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>> +	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_io_writel);
>>   
>> @@ -871,7 +886,8 @@ EXPORT_SYMBOL_GPL(qcom_scm_io_writel);
>>    */
>>   bool qcom_scm_restore_sec_cfg_available(void)
>>   {
>> -	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_MP,
>> +	return __qcom_scm_is_call_available(__scm ? __scm->dev : NULL,
>> +					    QCOM_SCM_SVC_MP,
>>   					    QCOM_SCM_MP_RESTORE_SEC_CFG);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg_available);
>> @@ -889,7 +905,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
>>   	struct qcom_scm_res res;
>>   	int ret;
>>   
>> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
>>   
>>   	return ret ? : res.result[0];
>>   }
>> @@ -907,7 +923,7 @@ int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
>>   	struct qcom_scm_res res;
>>   	int ret;
>>   
>> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
>>   
>>   	if (size)
>>   		*size = res.result[0];
>> @@ -930,7 +946,7 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
>>   	};
>>   	int ret;
>>   
>> -	ret = qcom_scm_call(__scm->dev, &desc, NULL);
>> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>>   
>>   	/* the pg table has been initialized already, ignore the error */
>>   	if (ret == -EPERM)
>> @@ -951,7 +967,7 @@ int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size)
>>   		.owner = ARM_SMCCC_OWNER_SIP,
>>   	};
>>   
>> -	return qcom_scm_call(__scm->dev, &desc, NULL);
>> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_iommu_set_cp_pool_size);
>>   
>> @@ -973,7 +989,7 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>>   	};
>>   	struct qcom_scm_res res;
>>   
>> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
>>   
>>   	return ret ? : res.result[0];
>>   }
>> @@ -1038,6 +1054,9 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
>>   	int ret, i, b;
>>   	u64 srcvm_bits = *srcvm;
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	src_sz = hweight64(srcvm_bits) * sizeof(*src);
>>   	mem_to_map_sz = sizeof(*mem_to_map);
>>   	dest_sz = dest_cnt * sizeof(*destvm);
>> @@ -1093,7 +1112,8 @@ EXPORT_SYMBOL_GPL(qcom_scm_assign_mem);
>>    */
>>   bool qcom_scm_ocmem_lock_available(void)
>>   {
>> -	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_OCMEM,
>> +	return __qcom_scm_is_call_available(__scm ? __scm->dev : NULL,
>> +					    QCOM_SCM_SVC_OCMEM,
>>   					    QCOM_SCM_OCMEM_LOCK_CMD);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_ocmem_lock_available);
>> @@ -1120,7 +1140,7 @@ int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset, u32 size,
>>   		.arginfo = QCOM_SCM_ARGS(4),
>>   	};
>>   
>> -	return qcom_scm_call(__scm->dev, &desc, NULL);
>> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_ocmem_lock);
>>   
>> @@ -1143,7 +1163,7 @@ int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset, u32 size)
>>   		.arginfo = QCOM_SCM_ARGS(3),
>>   	};
>>   
>> -	return qcom_scm_call(__scm->dev, &desc, NULL);
>> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_ocmem_unlock);
>>   
>> @@ -1155,9 +1175,11 @@ EXPORT_SYMBOL_GPL(qcom_scm_ocmem_unlock);
>>    */
>>   bool qcom_scm_ice_available(void)
>>   {
>> -	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_ES,
>> +	return __qcom_scm_is_call_available(__scm ? __scm->dev : NULL,
>> +					    QCOM_SCM_SVC_ES,
>>   					    QCOM_SCM_ES_INVALIDATE_ICE_KEY) &&
>> -		__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_ES,
>> +		__qcom_scm_is_call_available(__scm ?__scm->dev : NULL,
>> +					     QCOM_SCM_SVC_ES,
>>   					     QCOM_SCM_ES_CONFIG_SET_ICE_KEY);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_ice_available);
>> @@ -1184,7 +1206,7 @@ int qcom_scm_ice_invalidate_key(u32 index)
>>   		.owner = ARM_SMCCC_OWNER_SIP,
>>   	};
>>   
>> -	return qcom_scm_call(__scm->dev, &desc, NULL);
>> +	return qcom_scm_call(__scm ?__scm->dev : NULL, &desc, NULL);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_ice_invalidate_key);
>>   
>> @@ -1228,6 +1250,9 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
>>   	dma_addr_t key_phys;
>>   	int ret;
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	/*
>>   	 * 'key' may point to vmalloc()'ed memory, but we need to pass a
>>   	 * physical address that's been properly flushed.  The sanctioned way to
>> @@ -1262,7 +1287,12 @@ EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
>>   bool qcom_scm_hdcp_available(void)
>>   {
>>   	bool avail;
>> -	int ret = qcom_scm_clk_enable();
>> +	int ret;
>> +
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>> +	ret = qcom_scm_clk_enable();
>>   
>>   	if (ret)
>>   		return ret;
>> @@ -1307,6 +1337,9 @@ int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
>>   	};
>>   	struct qcom_scm_res res;
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
>>   		return -ERANGE;
>>   
>> @@ -1335,7 +1368,7 @@ int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt)
>>   		.owner = ARM_SMCCC_OWNER_SIP,
>>   	};
>>   
>> -	return qcom_scm_call(__scm->dev, &desc, NULL);
>> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_iommu_set_pt_format);
>>   
>> @@ -1351,13 +1384,15 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
>>   	};
>>   
>>   
>> -	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>> +	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_qsmmu500_wait_safe_toggle);
>>   
>>   bool qcom_scm_lmh_dcvsh_available(void)
>>   {
>> -	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_LMH, QCOM_SCM_LMH_LIMIT_DCVSH);
>> +	return __qcom_scm_is_call_available(__scm ? __scm->dev : NULL,
>> +					    QCOM_SCM_SVC_LMH,
>> +					    QCOM_SCM_LMH_LIMIT_DCVSH);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
>>   
>> @@ -1371,7 +1406,7 @@ int qcom_scm_lmh_profile_change(u32 profile_id)
>>   		.owner = ARM_SMCCC_OWNER_SIP,
>>   	};
>>   
>> -	return qcom_scm_call(__scm->dev, &desc, NULL);
>> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
>>   
>> @@ -1394,6 +1429,9 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>>   		.owner = ARM_SMCCC_OWNER_SIP,
>>   	};
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
>>   	if (!payload_buf)
>>   		return -ENOMEM;
>> @@ -1568,6 +1606,9 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
>>   	char *name_buf;
>>   	int status;
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	if (app_name_len >= name_buf_size)
>>   		return -EINVAL;
>>   
>> @@ -1638,6 +1679,9 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
>>   	dma_addr_t rsp_phys;
>>   	int status;
>>   
>> +	if (!qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>>   	/* Map request buffer */
>>   	req_phys = dma_map_single(__scm->dev, req, req_size, DMA_TO_DEVICE);
>>   	status = dma_mapping_error(__scm->dev, req_phys);
>> -- 
>> 2.43.0.254.ga26002b62827
>>
>>

