Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B797B3CBD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjI2WtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2WtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:49:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2CADD;
        Fri, 29 Sep 2023 15:48:57 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TMiTxx008549;
        Fri, 29 Sep 2023 22:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BnqnE9sx58lVFF8ddtf7RZSYPc60sTXgurUPgCmPSXY=;
 b=eCpk53Dgt5CuBemvxjgADQfn1TQCNkMtvFUf/0RZuM1DcQ6YpBskpRdE5vrRnm+aeItW
 H6zByP0CHWPVa3MkYcApK1NzuRL6OOfoQQBefDEahAC6y6H0Mv17UgWpeGy++H/zl9si
 SvZDku+tI/GpdDBfmzEn0O0dIQTdg9qIbZXUvGVk7yNQPYp+oLOjpO2HMoBLDfPlAXZD
 gMM54MYdBj0DajKSQmmqzptodu2h9SZOm9jUwucdbIG55eV5rEQojhIz4lHMaPEFz1lI
 sSESZg+LS4BKOFchDmaOjYRIpKdXPJG0qqNWJWLEXJ1SbttXDJy562zWVxHutJBfTyNE Tg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3te0avs62h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 22:48:41 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38TMmeiO014992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 22:48:40 GMT
Received: from [10.110.100.38] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 29 Sep
 2023 15:48:37 -0700
Message-ID: <2539186e-e0ec-4eba-9d6a-d966e00f0eb9@quicinc.com>
Date:   Fri, 29 Sep 2023 15:48:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] firmware: qcom: scm: make
 qcom_scm_pas_init_image() use the SCM allocator
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <20230928092040.9420-7-brgl@bgdev.pl>
 <gwflmag5pq7osprj25l7i4tgyln2nauuqcwdhth2eomareooag@4dw4lwk4vr36>
 <CAMRc=Mfxt1DLinxMcKivQqqnHvFv5P8WXNnfAwnfrHgoz+q-5w@mail.gmail.com>
 <20230929204404.enzsjanohdqqpmk4@halaney-x13s>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230929204404.enzsjanohdqqpmk4@halaney-x13s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c1nAAMqdIiZO0eGu-_iA1_Hgro0d8AaI
X-Proofpoint-ORIG-GUID: c1nAAMqdIiZO0eGu-_iA1_Hgro0d8AaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_19,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 9/29/2023 1:44 PM, Andrew Halaney wrote:
> On Fri, Sep 29, 2023 at 12:22:16PM -0700, Bartosz Golaszewski wrote:
>> On Fri, 29 Sep 2023 21:16:51 +0200, Andrew Halaney <ahalaney@redhat.com> said:
>>> On Thu, Sep 28, 2023 at 11:20:35AM +0200, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> Let's use the new SCM memory allocator to obtain a buffer for this call
>>>> instead of using dma_alloc_coherent().
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>> ---
>>>>  drivers/firmware/qcom/qcom_scm.c | 16 +++++-----------
>>>>  1 file changed, 5 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>>>> index 02a773ba1383..c0eb81069847 100644
>>>> --- a/drivers/firmware/qcom/qcom_scm.c
>>>> +++ b/drivers/firmware/qcom/qcom_scm.c
>>>> @@ -532,7 +532,7 @@ static void qcom_scm_set_download_mode(bool enable)
>>>>  int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>>>>  			    struct qcom_scm_pas_metadata *ctx)
>>>>  {
>>>> -	dma_addr_t mdata_phys;
>>>> +	phys_addr_t mdata_phys;
>>>
>>>>  	void *mdata_buf;
>>>>  	int ret;
>>>>  	struct qcom_scm_desc desc = {
>>>> @@ -544,13 +544,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>>>>  	};
>>>>  	struct qcom_scm_res res;
>>>>
>>>> -	/*
>>>> -	 * During the scm call memory protection will be enabled for the meta
>>>> -	 * data blob, so make sure it's physically contiguous, 4K aligned and
>>>> -	 * non-cachable to avoid XPU violations.
>>>> -	 */
>>>> -	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
>>>> -				       GFP_KERNEL);
>>>> +	mdata_buf = qcom_scm_mem_alloc(size, GFP_KERNEL);
>>>
>>> mdata_phys is never initialized now, and its what's being shoved into
>>> desc.args[1] later, which I believe is what triggered the -EINVAL
>>> with qcom_scm_call() that I reported in my cover letter reply this
>>> morning.
>>>
>>> Prior with the DMA API that would have been the device view of the buffer.
>>>
>>
>> Gah! Thanks for finding this.
>>
>> Can you try the following diff?
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 794388c3212f..b0d4ea237034 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -556,6 +556,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const
>> void *metadata, size_t size,
>>  		dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
>>  		return -ENOMEM;
>>  	}
>> +	mdata_phys = qcom_scm_mem_to_phys(mdata_buf);
>>  	memcpy(mdata_buf, metadata, size);
>>
>>  	ret = qcom_scm_clk_enable();
>> @@ -578,7 +579,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const
>> void *metadata, size_t size,
>>  		qcom_scm_mem_free(mdata_buf);
>>  	} else if (ctx) {
>>  		ctx->ptr = mdata_buf;
>> -		ctx->phys = qcom_scm_mem_to_phys(mdata_buf);
>> +		ctx->phys = mdata_phys;
>>  		ctx->size = size;
>>  	}
>>
>> Bart
>>
> 
> For some reason that I can't explain that is still not working. It seems
> the SMC call is returning !0 and then we return -EINVAL from there
> with qcom_scm_remap_error().
> 
> Here's a really crummy diff of what I hacked in during lunch to debug (don't
> judge my primitive debug skills):
> 

I don't know what you're talking about :-)

> diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> index 0d5554df1321..56eab0ae5f3a 100644
> --- a/drivers/firmware/qcom/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> @@ -162,6 +162,8 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>         struct arm_smccc_res smc_res;
>         struct arm_smccc_args smc = {0};
>  
> +       dev_err(dev, "%s: %d: We are in this function\n", __func__, __LINE__);
> +
>         smc.args[0] = ARM_SMCCC_CALL_VAL(
>                 smccc_call_type,
>                 qcom_smccc_convention,
> @@ -174,6 +176,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>         if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
>                 alloc_len = SCM_SMC_N_EXT_ARGS * sizeof(u64);
>                 args_virt = qcom_scm_mem_alloc(PAGE_ALIGN(alloc_len), flag);
> +               dev_err(dev, "%s: %d: Hit the unlikely case!\n", __func__, __LINE__);
>  
>                 if (!args_virt)
>                         return -ENOMEM;
> @@ -197,6 +200,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>  
>         /* ret error check follows after args_virt cleanup*/
>         ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
> +       dev_err(dev, "%s: %d: ret: %d\n", __func__, __LINE__, ret);
>  
>         if (ret)
>                 return ret;
> @@ -205,8 +209,10 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>                 res->result[0] = smc_res.a1;
>                 res->result[1] = smc_res.a2;
>                 res->result[2] = smc_res.a3;
> +               dev_err(dev, "%s: %d: 0: %llu, 1: %llu: 2: %llu\n", __func__, __LINE__, res->result[0], res->result[1], res->result[2]);
>         }
>  
> +       dev_err(dev, "%s: %d: smc_res.a0: %lu\n", __func__, __LINE__, smc_res.a0);
>         return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
> 
> 
> And that all spams dmesg successfully for most cases, but the
> pas_init_image calls log this out:
> 
> [   16.362965] remoteproc remoteproc1: powering up 1b300000.remoteproc
> [   16.364897] remoteproc remoteproc1: Booting fw image qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn, size 3575808
> [   16.365009] qcom_scm firmware:scm: __scm_smc_call: 165: We are in this function
> [   16.365251] qcom_scm firmware:scm: __scm_smc_call: 203: ret: 0
> [   16.365256] qcom_scm firmware:scm: __scm_smc_call: 212: 0: 0, 1: 0: 2: 0
> [   16.365261] qcom_scm firmware:scm: __scm_smc_call: 215: smc_res.a0: 4291821558
> 
> At the moment I am unsure why...
> 
Does the issue appear right after taking patch 6 or does it only appear after taking
the whole series? If it's just to this patch, then maybe something wrong with
the refactor: shm bridge isn't enabled at this point in the series.
