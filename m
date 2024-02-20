Return-Path: <linux-kernel+bounces-72369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2085B282
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B961F234B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04AE57320;
	Tue, 20 Feb 2024 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KzEL21Xu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC82030B;
	Tue, 20 Feb 2024 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408638; cv=none; b=jOpBJ8aSYuQAwk8B/FTm6kRrIVTQqNPKOAyNr6DaX8fEIEihCrX9X1D0bEAWlAhJzWGBLIzsujaoiDUf8Mfd0G3fITzl3z8IUSp+GlGm8dXqjOWErja1PxiaJCOSpGZtVO4j/ws145pnO5WPCMDYLwIPt5MT1zrpqmN+XWzK7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408638; c=relaxed/simple;
	bh=cqjaARe1FbdSF96HBwZNb30nAMlFo1CKlR4ykFhjXpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C8IpSrmTTsWtHYK/Ef2pb7FjMzZQ/M1X12E2zLQLFOxcFIEfZga4ajU36mrIrEVJZaTlJSPKeOoRAUipPTzOr1Cb2c3mTRkE8pr/yVI5i2NoEskLQpS/Qq1A4v+e6+fRqt1q0cQi7SXQEWAcxfwyoRVrIYed36BuOo0ehq7bXK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KzEL21Xu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K43xfH025633;
	Tue, 20 Feb 2024 05:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1+w3uW+yuw2yO2IDZLFY2AOl401ceGZI48uk93ArssE=; b=Kz
	EL21XumqkiNHVJI4Z2atx6EDp68cbGCZelp/a6erBWPvmFMQM6AHhCCmYydd3O25
	Wc77/PR0PzRDJeuVz0fSYDW6QW0CadKicjDDNqiGGn1mjtxk20Gn/ghetfeqLiKU
	DfNdo/TzhVuZviqrDxAelZ83AFlsHcelidEFL1ay6T3aZGR1Vtl6fe6R7oo7sCo4
	3Ndqc/e5cuT7SXK/LU/RuTtZHoqftYFmpFDunzS3kmA+gLoMZhGoO8e2jo1UFYHS
	PDY4VE93+O+CTV+UDaza8ycYKHDp1j9jxRVNIpc78Bt0LxbnHI3DfVZpgir111Y3
	kA3Qh0VWAHkWPWpRRGBQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcmqp8583-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 05:57:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K5uuJ2013923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 05:56:56 GMT
Received: from [10.214.197.177] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 19 Feb
 2024 21:56:53 -0800
Message-ID: <0e2c4aff-e5cd-4d83-a46e-120d2ab3d8f1@quicinc.com>
Date: Tue, 20 Feb 2024 11:26:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom_scm: Introduce batching of hyp assign
 calls
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <luzmaximilian@gmail.com>,
        <bartosz.golaszewski@linaro.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_guptap@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_pheragu@quicinc.com>
References: <20240209112536.2262967-1-quic_dibasing@quicinc.com>
 <7fhl7uvhl26whumcl3f5hxflczws67lg3yq4gb5fyrig2ziux6@chft6orl6xne>
 <b65d6328-e7bd-4752-a82f-36323b41ef13@linaro.org>
From: Dibakar Singh <quic_dibasing@quicinc.com>
In-Reply-To: <b65d6328-e7bd-4752-a82f-36323b41ef13@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 18f7_PdPEotdbEg9qe-nI81g-u8THTay
X-Proofpoint-ORIG-GUID: 18f7_PdPEotdbEg9qe-nI81g-u8THTay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_05,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200041



On 12-Feb-24 4:39 PM, Konrad Dybcio wrote:
> On 9.02.2024 19:06, Elliot Berman wrote:
>> On Fri, Feb 09, 2024 at 04:55:36PM +0530, Dibakar Singh wrote:
>>> Expose an API qcom_scm_assign_table to allow client drivers to batch
>>> multiple memory regions in a single hyp assign call.
>>>
>>> In the existing situation, if our goal is to process an sg_table and
>>> transfer its ownership from the current VM to a different VM, we have a
>>> couple of strategies. The first strategy involves processing the entire
>>> sg_table at once and then transferring the ownership. However, this
>>> method may have an adverse impact on the system because during an SMC
>>> call, the NS interrupts are disabled, and this delay could be
>>> significant when dealing with large sg_tables. To address this issue, we
>>> can adopt a second strategy, which involves processing each sg_list in
>>> the sg_table individually and reassigning memory ownership. Although
>>> this method is slower and potentially impacts performance, it will not
>>> keep the NS interrupts disabled for an extended period.
>>>
>>> A more efficient strategy is to process the sg_table in batches. This
>>> approach addresses both scenarios by involving memory processing in
>>> batches, thus avoiding prolonged NS interrupt disablement for longer
>>> duration when dealing with large sg_tables. Moreover, since we process
>>> in batches, this method is faster compared to processing each item
>>> individually. The observations on testing both the approaches for
>>> performance is as follows:
>>>
>>> Allocation Size/            256MB            512MB            1024MB
>>> Algorithm Used           ===========      ===========      ============
>>>
>>> Processing each sg_list   73708(us)        149289(us)       266964(us)
>>> in sg_table one by one
>>>
>>> Processing sg_table in    46925(us)         92691(us)       176893(us)
>>> batches
>>>
>>> This implementation serves as a wrapper around the helper function
>>> __qcom_scm_assign_mem, which takes an sg_list and processes it in
>>> batches. We’ve set the limit to a minimum of 32 sg_list in a batch or a
>>> total batch size of 512 pages. The selection of these numbers is
>>> heuristic, based on the test runs conducted. Opting for a smaller number
>>> would compromise performance, while a larger number would result in
>>> non-secure interrupts being disabled for an extended duration.
>>>
>>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>>> Signed-off-by: Dibakar Singh <quic_dibasing@quicinc.com>
>>> ---
>>>   drivers/firmware/qcom/qcom_scm.c       | 211 +++++++++++++++++++++++++
>>>   include/linux/firmware/qcom/qcom_scm.h |   7 +
>>>   2 files changed, 218 insertions(+)
>>>
>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>>> index 520de9b5633a..038b96503d65 100644
>>> --- a/drivers/firmware/qcom/qcom_scm.c
>>> +++ b/drivers/firmware/qcom/qcom_scm.c
>>> @@ -21,6 +21,8 @@
>>>   #include <linux/platform_device.h>
>>>   #include <linux/reset-controller.h>
>>>   #include <linux/types.h>
>>> +#include <linux/scatterlist.h>
>>> +#include <linux/slab.h>
>>>   
>>>   #include "qcom_scm.h"
>>>   
>>> @@ -1048,6 +1050,215 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
>>>   }
>>>   EXPORT_SYMBOL_GPL(qcom_scm_assign_mem);
>>>   
>>> +/**
>>> + * qcom_scm_assign_mem_batch() - Make a secure call to reassign memory
>>> + *				   ownership of several memory regions
>>> + * @mem_regions:    A buffer describing the set of memory regions that need to
>>> + *		    be reassigned
>>> + * @nr_mem_regions: The number of memory regions that need to be reassigned
>>> + * @srcvms:	    A buffer populated with he vmid(s) for the current set of
>>> + *		    owners
>>> + * @src_sz:	    The size of the srcvms buffer (in bytes)
>>> + * @destvms:	    A buffer populated with the new owners and corresponding
>>> + *		    permission flags.
>>> + * @dest_sz:	    The size of the destvms buffer (in bytes)
>>> + *
>>> + * Return negative errno on failure, 0 on success.
>>> + */
>>> +static int qcom_scm_assign_mem_batch(struct qcom_scm_mem_map_info *mem_regions,
>>> +				     size_t nr_mem_regions, u32 *srcvms,
>>> +				     size_t src_sz,
>>> +				     struct qcom_scm_current_perm_info *destvms,
>>> +				     size_t dest_sz)
>>> +{
>>> +	dma_addr_t mem_dma_addr;
>>> +	size_t mem_regions_sz;
>>> +	int ret = 0, i;
>>> +
>>> +	for (i = 0; i < nr_mem_regions; i++) {
>>> +		mem_regions[i].mem_addr = cpu_to_le64(mem_regions[i].mem_addr);
>>> +		mem_regions[i].mem_size = cpu_to_le64(mem_regions[i].mem_size);
>>> +	}
>>> +
>>> +	mem_regions_sz = nr_mem_regions * sizeof(*mem_regions);
>>> +	mem_dma_addr = dma_map_single(__scm->dev, mem_regions, mem_regions_sz,
>>> +				      DMA_TO_DEVICE);
>>> +	if (dma_mapping_error(__scm->dev, mem_dma_addr)) {
>>> +		dev_err(__scm->dev, "mem_dma_addr mapping failed\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	ret = __qcom_scm_assign_mem(__scm->dev, virt_to_phys(mem_regions),
>>> +				    mem_regions_sz, virt_to_phys(srcvms), src_sz,
>>> +				    virt_to_phys(destvms), dest_sz);
>>> +
>>> +	dma_unmap_single(__scm->dev, mem_dma_addr, mem_regions_sz, DMA_TO_DEVICE);
>>> +	return ret;
>>> +}
>>> +
>>> +/**
>>> + * qcom_scm_prepare_mem_batch() - Prepare batches of memory regions
>>> + * @sg_table:       A scatter list whose memory needs to be reassigned
>>> + * @srcvms:	    A buffer populated with he vmid(s) for the current set of
>>> + *		    owners
>>> + * @nr_src:	    The number of the src_vms buffer
>>> + * @destvms:	    A buffer populated with he vmid(s) for the new owners
>>> + * @destvms_perms:  A buffer populated with the permission flags of new owners
>>> + * @nr_dest:	    The number of the destvms
>>> + * @last_sgl:	    Denotes to the last scatter list element. Used in case of rollback
>>> + * @roll_back:	    Identifies whether we are executing rollback in case of failure
>>> + *
>>> + * Return negative errno on failure, 0 on success.
>>> + */
>>> +static int qcom_scm_prepare_mem_batch(struct sg_table *table,
>>> +				      u32 *srcvms, int nr_src,
>>> +				      int *destvms, int *destvms_perms,
>>> +				      int nr_dest,
>>> +				      struct scatterlist *last_sgl, bool roll_back)
>>> +{
>>> +	struct qcom_scm_current_perm_info *destvms_cp;
>>> +	struct qcom_scm_mem_map_info *mem_regions_buf;
>>> +	struct scatterlist *curr_sgl = table->sgl;
>>> +	dma_addr_t source_dma_addr, dest_dma_addr;
>>> +	size_t batch_iterator;
>>> +	size_t batch_start = 0;
>>> +	size_t destvms_cp_sz;
>>> +	size_t srcvms_cp_sz;
>>> +	size_t batch_size;
>>> +	u32 *srcvms_cp;
>>> +	int ret = 0;
>>> +	int i;
>>> +
>>> +	if (!table || !table->sgl || !srcvms || !nr_src ||
>>> +	    !destvms || !destvms_perms || !nr_dest || !table->nents)
>>> +		return -EINVAL;
>>> +
>>> +	srcvms_cp_sz = sizeof(*srcvms_cp) * nr_src;
>>> +	srcvms_cp = kmemdup(srcvms, srcvms_cp_sz, GFP_KERNEL);
>>> +	if (!srcvms_cp)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < nr_src; i++)
>>> +		srcvms_cp[i] = cpu_to_le32(srcvms_cp[i]);
>>> +
>>> +	source_dma_addr = dma_map_single(__scm->dev, srcvms_cp,
>>> +					 srcvms_cp_sz, DMA_TO_DEVICE);
>>
>> Please use the new tzmem allocator:
>>
>> https://lore.kernel.org/all/20240205182810.58382-1-brgl@bgdev.pl/
> 
> And the new __free annotations, please
> 

Noted, I will incorporate these changes in the V2 patch.

> Konrad

Thanks,
Dibakar

