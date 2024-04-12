Return-Path: <linux-kernel+bounces-142803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5CA8A304D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B801F20C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D786AE6;
	Fri, 12 Apr 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N9zsLIpo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60C85939;
	Fri, 12 Apr 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931420; cv=none; b=sZj9mlpfvMv5fA9shaem8gz6ZktypebFqomhiHnW9IldjOkmEZcndZo0G1t9igk0XYX0zZaeF+IoUDDnRs1+OtVA6OYl1idIzzw0YjjUxPn4t81H/ge3NKxMJl5OBMulzwhASu1veyyY6PrIC7ZyYJpMzCzxrZz4Mp6APyuwpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931420; c=relaxed/simple;
	bh=WhpCUGI96ps9cF34rrRPTs7C3wi5FHut3sWV/vIx2tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HVMMSjFKMaMgxA4y9L6VCyGPXoEn+EHiIsvA1CZ0ySjMuZJLurZiIcwX76POFGzjW4EBTTq+jJP3t57++VFzsZeGpRam1RZ6cC72N0ZTjYlMjuZz0A/q3LhtNH6Gfooxz7H/k1nHqL5+n4/kn+lpgqmTOwLaD6YxkM+pj55/htc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N9zsLIpo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CECtZ3029912;
	Fri, 12 Apr 2024 14:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8B4BRcwsnkqtLmK60tynQcbM45nbLBlll4ohJ8zthI8=; b=N9
	zsLIpoXT/fjtE13LsgcU40h1bIFktnH43cH32dnfRR/Di+BMCfpsyzSYq18L5IEF
	v09tyThgsG56zWhXvrnNwplYzVU7LmSJGcvQP+evwJUThDgltHCEg65wqwUbDt7V
	6HV9FbZ5copjSSt/3bQuWGNiy9Qxgp/xdEMZwPcm+GpJsomEci4oYk7HD+eh1eZ2
	PM7RBjx4pA2lQv2DWz39WHjIafCZ+O1xwjNIhJumFCWmk9FMWjr9QqoIyUvFlfbf
	9nuAY4yrpwLkIbVr1Dev6+vmhawgQvjcjIFJL4K9Is+LRQNVSJdSZLNDphiLc6ZF
	e/ww/K9PJIGYfu1/J+AQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xf6h6r07x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:16:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CEGrKY008238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:16:53 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 07:16:52 -0700
Message-ID: <95ee53a5-e261-9106-1104-09077e348a99@quicinc.com>
Date: Fri, 12 Apr 2024 08:16:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/2] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
 <1712805329-46158-3-git-send-email-quic_qianyu@quicinc.com>
 <78de32be-7e3b-e7e9-61f3-9679993dbe71@quicinc.com>
 <a901549e-c3ec-47b5-9523-a6342eca455f@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <a901549e-c3ec-47b5-9523-a6342eca455f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L-ZCnEf-_dsOi4i7LMByTFTmFKl4032Y
X-Proofpoint-GUID: L-ZCnEf-_dsOi4i7LMByTFTmFKl4032Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120103

On 4/12/2024 1:13 AM, Qiang Yu wrote:
> 
> On 4/11/2024 10:46 PM, Jeffrey Hugo wrote:
>> On 4/10/2024 9:15 PM, Qiang Yu wrote:
>>> Add mhi_pci_generic_edl_trigger as edl_trigger for some devices (eg. 
>>> SDX65)
>>> to enter EDL mode by writing the 0xEDEDEDED cookie to the channel 91
>>> doorbell register and forcing an SOC reset afterwards.
>>>
>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>> ---
>>>   drivers/bus/mhi/host/pci_generic.c | 50 
>>> ++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/bus/mhi/host/pci_generic.c 
>>> b/drivers/bus/mhi/host/pci_generic.c
>>> index 51639bf..a529815 100644
>>> --- a/drivers/bus/mhi/host/pci_generic.c
>>> +++ b/drivers/bus/mhi/host/pci_generic.c
>>> @@ -27,12 +27,23 @@
>>>   #define PCI_VENDOR_ID_THALES    0x1269
>>>   #define PCI_VENDOR_ID_QUECTEL    0x1eac
>>>   +#define MHI_EDL_DB            91
>>> +#define MHI_EDL_COOKIE            0xEDEDEDED
>>> +
>>> +/* Device can enter EDL by first setting edl cookie then issuing 
>>> inband reset*/
>>> +#define MHI_PCI_GENERIC_EDL_TRIGGER    BIT(0)
>>> +
>>> +#define CHDBOFF            0x18
>>
>> This is already in drivers/bus/mhi/common.h why duplicate it here?
> 
> I only see common.h be included in ep/internal.h host/internal.h and
> host/trace.h. So I thought it can only be used by MHI stack. Can we
> include common.h in pci_generic.c?

Up to Mani, but duplicating the definition seems like it would result in 
maintence overhead over time.  An alternative to including the header 
might be a new API between MHI and controller which allow the setting of 
a CHDB to a specific value.

>>
>>> +#define CHDBOFF_CHDBOFF_MASK 0xFFFFFFFF
>>> +#define CHDBOFF_CHDBOFF_SHIFT    0
>>> +
>>>   /**
>>>    * struct mhi_pci_dev_info - MHI PCI device specific information
>>>    * @config: MHI controller configuration
>>>    * @name: name of the PCI module
>>>    * @fw: firmware path (if any)
>>>    * @edl: emergency download mode firmware path (if any)
>>> + * @edl_trigger: each bit represents a different way to enter EDL
>>>    * @bar_num: PCI base address register to use for MHI MMIO register 
>>> space
>>>    * @dma_data_width: DMA transfer word size (32 or 64 bits)
>>>    * @mru_default: default MRU size for MBIM network packets
>>> @@ -44,6 +55,7 @@ struct mhi_pci_dev_info {
>>>       const char *name;
>>>       const char *fw;
>>>       const char *edl;
>>> +    unsigned int edl_trigger;
>>>       unsigned int bar_num;
>>>       unsigned int dma_data_width;
>>>       unsigned int mru_default;
>>> @@ -292,6 +304,7 @@ static const struct mhi_pci_dev_info 
>>> mhi_qcom_sdx75_info = {
>>>       .name = "qcom-sdx75m",
>>>       .fw = "qcom/sdx75m/xbl.elf",
>>>       .edl = "qcom/sdx75m/edl.mbn",
>>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>>       .config = &modem_qcom_v2_mhiv_config,
>>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>       .dma_data_width = 32,
>>> @@ -302,6 +315,7 @@ static const struct mhi_pci_dev_info 
>>> mhi_qcom_sdx65_info = {
>>>       .name = "qcom-sdx65m",
>>>       .fw = "qcom/sdx65m/xbl.elf",
>>>       .edl = "qcom/sdx65m/edl.mbn",
>>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>>       .config = &modem_qcom_v1_mhiv_config,
>>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>       .dma_data_width = 32,
>>> @@ -312,6 +326,7 @@ static const struct mhi_pci_dev_info 
>>> mhi_qcom_sdx55_info = {
>>>       .name = "qcom-sdx55m",
>>>       .fw = "qcom/sdx55m/sbl1.mbn",
>>>       .edl = "qcom/sdx55m/edl.mbn",
>>> +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>>>       .config = &modem_qcom_v1_mhiv_config,
>>>       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>>>       .dma_data_width = 32,
>>> @@ -928,6 +943,38 @@ static void health_check(struct timer_list *t)
>>>       mod_timer(&mhi_pdev->health_check_timer, jiffies + 
>>> HEALTH_CHECK_PERIOD);
>>>   }
>>>   +static int mhi_pci_generic_edl_trigger(struct mhi_controller 
>>> *mhi_cntrl)
>>> +{
>>> +    int ret;
>>> +    u32 val;
>>> +    void __iomem *edl_db;
>>> +    void __iomem *base = mhi_cntrl->regs;
>>
>> It looks like this file follows reverse christmas tree, but this 
>> function does not. you should fix it.
> 
> Will fix it in next version patch.
>>
>>> +
>>> +    ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
>>> +    if (ret) {
>>> +        dev_err(mhi_cntrl->cntrl_dev, "Wake up device fail before 
>>> trigger EDL\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
>>> +    mhi_cntrl->runtime_get(mhi_cntrl);
>>> +
>>> +    mhi_cntrl->read_reg(mhi_cntrl, base + CHDBOFF, &val);
>>> +    val = (val & CHDBOFF_CHDBOFF_MASK) >> CHDBOFF_CHDBOFF_SHIFT;
>>> +
>>> +    edl_db = base + val + (8 * MHI_EDL_DB);
>>> +
>>> +    mhi_cntrl->write_reg(mhi_cntrl, edl_db + 4, 
>>> upper_32_bits(MHI_EDL_COOKIE));
>>> +    mhi_cntrl->write_reg(mhi_cntrl, edl_db, 
>>> lower_32_bits(MHI_EDL_COOKIE));
>>> +
>>> +    mhi_soc_reset(mhi_cntrl);
>>> +
>>> +    mhi_cntrl->runtime_put(mhi_cntrl);
>>> +    mhi_device_put(mhi_cntrl->mhi_dev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int mhi_pci_probe(struct pci_dev *pdev, const struct 
>>> pci_device_id *id)
>>>   {
>>>       const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info 
>>> *) id->driver_data;
>>> @@ -962,6 +1009,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, 
>>> const struct pci_device_id *id)
>>>       mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>>>       mhi_cntrl->mru = info->mru_default;
>>>   +    if (info->edl_trigger & MHI_PCI_GENERIC_EDL_TRIGGER)
>>> +        mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
>>> +
>>>       if (info->sideband_wake) {
>>>           mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
>>>           mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
>>


