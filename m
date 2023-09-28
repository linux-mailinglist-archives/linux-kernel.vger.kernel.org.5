Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C27B251E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjI1STt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1STs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:19:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402099;
        Thu, 28 Sep 2023 11:19:45 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SHkJBL015485;
        Thu, 28 Sep 2023 18:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jHZvQiOxHYcs4+bL8Soq5nh7GIkaD0yQT0HCRUww26g=;
 b=iF+q9qHSLPhWgIP0M7OaSHObf/wZ4Cl18nr+lG0Qaek8AU2oFlNEiplxMZUBhjlPdXot
 ly2eFBbHwCyi8+9K40ErE6rtFmSWaySJoBNBFw20muEHkjrzzu4GpMn8qBjYq4zU4q0O
 OLqFynJtsckoEcJvzy9MHUvF28KKrL07aCGFNSTEDR0aZ6xF/cmOWFJHXKDjape5jdga
 WU5zKOnfYeH6GIqTAEUTKnkHq8GTrskHSmDs9XFFcMuqXRRcgHrgLinJumrY4aYfj4nY
 2AAzyLwVZXvlfRksnIgLEsw4pG9V3L4KKw+HEcWTOJadOmJ63xHWrJRp6tS14qORbXOH SQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcvg9ae9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 18:19:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SIJcQh018306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 18:19:38 GMT
Received: from [10.111.177.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 11:19:35 -0700
Message-ID: <be27a31c-6c63-43cd-9857-f4b2a9568cf6@quicinc.com>
Date:   Thu, 28 Sep 2023 11:19:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] firmware: qcom: scm: add a dedicated SCM memory
 allocator
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <20230928092040.9420-3-brgl@bgdev.pl>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230928092040.9420-3-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cN2kaxH8Uy7BnjdSVzcQD18GmrkARi9i
X-Proofpoint-GUID: cN2kaxH8Uy7BnjdSVzcQD18GmrkARi9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_17,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=803 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2023 2:20 AM, Bartosz Golaszewski wrote:
> +void *qcom_scm_mem_alloc(size_t size, gfp_t gfp)
> +{
> +	struct qcom_scm_mem_chunk *chunk;
> +	unsigned long vaddr;

there are places below where you unnecessarily typecast this to its 
given type

> +	int ret;
> +
> +	if (!size)
> +		return ZERO_SIZE_PTR;
> +
> +	size = roundup(size, 1 << PAGE_SHIFT);
> +
> +	chunk = kzalloc(sizeof(*chunk), gfp);
> +	if (!chunk)
> +		return NULL;
> +
> +	vaddr = gen_pool_alloc(qcom_scm_mem.pool, size);
> +	if (!vaddr) {
> +		kfree(chunk);
> +		return NULL;
> +	}
> +
> +	chunk->paddr = gen_pool_virt_to_phys(qcom_scm_mem.pool,
> +					     (unsigned long)vaddr);

unnecessary typecast?

> +	chunk->size = size;
> +
> +	scoped_guard(spinlock_irqsave, &qcom_scm_mem.lock) {

my first exposure to this infrastructure..very cool now that I've 
wrapped my head around it! This helped for those also new to this:
https://lwn.net/Articles/934679/

> +		ret = radix_tree_insert(&qcom_scm_mem.chunks, vaddr, chunk);
> +		if (ret) {
> +			gen_pool_free(qcom_scm_mem.pool, (unsigned long)vaddr,

unnecessary typecast?

> +				      chunk->size);
> +			kfree(chunk);
> +			return NULL;
> +		}
> +	}
> +
> +	return (void *)vaddr;
> +}

