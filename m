Return-Path: <linux-kernel+bounces-94256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CF873C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD51C20F69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E59137911;
	Wed,  6 Mar 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IskWZ51L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17AB1EF1C;
	Wed,  6 Mar 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742117; cv=none; b=umsx1CDvBKS6L+Gm5pM5gIxIVQV8h0jufMQW7csT6ehOh5pB4FPboK865PT8ro4dNxa6xH5yVH8VSBnava4+jVRHf88LBkntD37UNbBHv1fCDLizx5zmU8apbPsHe6Ihg93sZI7/jf/qFaqRhVSyMBYLSgyhqebpsDMGTpx5sLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742117; c=relaxed/simple;
	bh=Ivasqh0sVkbR70JBFbaTkZ6cfGL9GzOvyJ4Xkyc8+dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lsX+Y5aWrJdrFg+7nPcl9trLCXwQcOkaSQmIad9T3AudLwEsS/Ezot6sAjeFeNX91ass8rHF6G1RFQ7VL78G7hfJebGT4+YL16hXCXiSeouswBKZT7C5todKy2GJOGYYXFXg3XvW8vOf7ueROGnk124reR2xxGQZo4tAQMqSilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IskWZ51L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426E51Pa018824;
	Wed, 6 Mar 2024 16:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QWFLfWj16qFeY/nCYrLyMJLG6BpWmGjJ0lQF7qVji+Y=; b=Is
	kWZ51L6Ycw8N3a5FFvsMRf+e88D/QFmIHwVNX4wTSeoWILWgwZZPOGV0JL8zPcdp
	bh+hUR6b/Xxl5Cpr5jv5acxnRQL+w3w75k8XH/cRh4c0zr6WfZVqH9rqgWbWV7iP
	gBLMAuIv7X8p3ZS3u/IAA3L6D2hrI+TP3b6JIj+KOWegmHu3bGyB7frIWS78rBGO
	S+ykzxJgfvfVlpqty8OKBhlGI2yrtdOeXqaOQQfiPUa1bYFL3AMjKxoo3Q1KMqIK
	Y//Itu1zxAVSdbbEH1kBTr2hrFq75DEHoLS5qO+E1vv8f2F0So4KgxhI0VuwRyzL
	jBvEAHu3vxjaShpr3y/g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpsxhgbf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:21:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426GLeJ9030403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 16:21:40 GMT
Received: from [10.216.51.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 08:21:34 -0800
Message-ID: <b3d925b8-62b5-4745-8e4b-d94a5b23346a@quicinc.com>
Date: Wed, 6 Mar 2024 21:51:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] USB: dwc3: qcom: Add support for firmware managed
 resources
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <quic_wcheng@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_psodagud@quicinc.com>, <quic_nkela@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <ulf.hansson@linaro.org>,
        <sudeep.holla@arm.com>, <quic_shazhuss@quicinc.com>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-3-git-send-email-quic_sriramd@quicinc.com>
 <ltjrdqxvupzjdqa22fvpzndeh7pc7zfmi5ybqxu2izjnnxjon7@jojqkltzukvv>
From: Sriram Dash <quic_sriramd@quicinc.com>
In-Reply-To: <ltjrdqxvupzjdqa22fvpzndeh7pc7zfmi5ybqxu2izjnnxjon7@jojqkltzukvv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LJ5kl66O_6t4gibEM_oVH9GJdafvjZ0R
X-Proofpoint-ORIG-GUID: LJ5kl66O_6t4gibEM_oVH9GJdafvjZ0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060131

On 3/6/2024 12:52 AM, Bjorn Andersson wrote:
> On Tue, Mar 05, 2024 at 10:27:37PM +0530, Sriram Dash wrote:
>> Some target systems allow multiple resources to be managed by firmware.
>> On these targets, tasks related to clocks, regulators, resets, and
>> interconnects can be delegated to the firmware, while the remaining
>> responsibilities are handled by Linux.
>>
>> The driver is responsible for managing multiple power domains and
>> linking them to consumers as needed. Incase there is only single
>> power domain, it is considered to be a standard GDSC hooked on to
>> the qcom dt node which is read and assigned to device structure
>> (by genpd framework) before the driver probe even begins.
>>
>> This differentiation logic allows the driver to determine whether
>> device resources are managed by Linux or firmware, ensuring
>> backward compatibility.
>>
>> Furthermore, minor cleanup is performed for the private data of
> 
> No "futhermore"s please, separate matters should be proposed as separate
> patches. Perhaps these can be sent separately and merged immediately?
> 

Thanks Bjorn.
Will take this separately.

>> the SNPS Femto PHY. However, ACPI handling is omitted due to the
>> absence of clients on the ACPI side.
>>
>> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 290 ++++++++++++++++++++------
>>   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 213 +++++++++++++++----
>>   drivers/usb/dwc3/dwc3-qcom.c                  | 259 +++++++++++++++++------
> 
> You're making independent changes across three different drivers across
> two different subsystems, with different maintainers, this is not
> acceptable as a single patch.
> 

Sure. will split the patches in next version.

>>   3 files changed, 594 insertions(+), 168 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> index 8525393..1ac1b50 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> @@ -21,6 +21,9 @@
>>   
>>   #include "phy-qcom-qmp-common.h"
>>   
>> +#include <linux/pm_opp.h>
>> +#include <linux/pm_domain.h>
> 
> Why are these includes alone here? Integrate your changes with the
> driver properly.
> 

Sure. will take care in the next version.

>> +
>>   #include "phy-qcom-qmp.h"
>>   #include "phy-qcom-qmp-pcs-misc-v3.h"
>>   #include "phy-qcom-qmp-pcs-misc-v4.h"
>> @@ -1212,6 +1215,9 @@ struct qmp_phy_cfg {
>>   	unsigned int pcs_usb_offset;
>>   };
>>   
>> +#define DOMAIN_GENPD_TRANSFER			0
>> +#define DOMAIN_GENPD_CORE			1
> 
> Does this really represent the hardware? What hardware constructs does
> "transfer" and "core" maps to?
> 

The idea was to club the resources in 2 buckets.
Which are essential for the IP core to be active
(ex : regulators, gdsc ) form the part or genpd core
and the resources which are controlled from Clock cluster
in another bucket, used for transfers.


>> +
>>   struct qmp_usb {
>>   	struct device *dev;
>>   
>> @@ -1236,6 +1242,19 @@ struct qmp_usb {
>>   	struct phy *phy;
>>   
>>   	struct clk_fixed_rate pipe_clk_fixed;
>> +
>> +	struct dev_pm_domain_list *pd_list;
>> +	struct device *genpd_core;
>> +	struct device *genpd_transfer;
>> +
>> +	bool fw_managed;
>> +	/* separate resource management for fw_managed vs locally managed devices */
>> +	struct qmp_usb_device_ops {
>> +		int (*bus_resume_resource)(struct qmp_usb *qmp);
> 
> Not only does these function pointers make the drivers much harder to
> follow, your naming of these seems chosen to maximize the confusion.
> 
> In your managed case this doesn't seem to relate to any "bus", in the
> "local" case, this doesn't relate to a "bus", and these callbacks are
> decoupled from the actual runtime resume and suspend cycle of the QMP
> device itself...
> 

Understood. Will make the decision to use fw managed
method or local management of resources based on the
fw_managed property rather than fixing it to function
pointer.

>> +		int (*runtime_resume_resource)(struct qmp_usb *qmp);
>> +		int (*bus_suspend_resource)(struct qmp_usb *qmp);
>> +		int (*runtime_suspend_resource)(struct qmp_usb *qmp);
>> +	} qmp_usb_device_ops;
>>   };
>>   
>>   static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
>> @@ -1598,6 +1617,41 @@ static const struct qmp_phy_cfg x1e80100_usb3_uniphy_cfg = {
>>   	.regs			= qmp_v7_usb3phy_regs_layout,
>>   };
>>   
>> +static void qmp_fw_managed_domain_remove(struct qmp_usb *qmp)
>> +{
>> +	dev_pm_domain_detach_list(qmp->pd_list);
>> +}
>> +
>> +static int qmp_fw_managed_domain_init(struct qmp_usb *qmp)
>> +{
>> +	struct device *dev = qmp->dev;
>> +	struct dev_pm_domain_attach_data pd_data = {
>> +		.pd_flags	= PD_FLAG_NO_DEV_LINK,
> 
> Iiuc, you attach the two power-domains with NO_DEV_LINK, such that the
> pm runtime state of the device itself won't reflect on the power
> domains, and then you hand-code all the involved logic yourself?
> > Why can't you integrate with the device and use its runtime state?
> Please clearly explain why you're doing it like this in your commit
> messages.
> 

OK.
Got suggestion from Dmitry to either pass empty list or
dev_pm_domain_attach twice. I will use the later.

> Regards,
> Bjorn

