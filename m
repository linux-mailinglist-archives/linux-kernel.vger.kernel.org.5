Return-Path: <linux-kernel+bounces-61235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7C850F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64F31F22714
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43F10795;
	Mon, 12 Feb 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DniD6MP/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92116F51F;
	Mon, 12 Feb 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729287; cv=none; b=mGpgyktfcj3POU06y94TOUuc2NTNkTtDu6AIUa6a3zN1niZ1Msyv3F2+GF5A/4yPPjSxXmDSHzRc1uNQIcTd86SvswpWi8jZHYVppsHpVSanPOZ6+55weZ4faniLNdLATHkRtj1Oe4HT5kqHSr4L7eIeGxiXqiYtOawfRVggHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729287; c=relaxed/simple;
	bh=mqBjwcdggk7KMrtyKppldYG4v4/Rk/ISycJb1OdOS8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WyhKulUpNlEyTxItMYtFu+swqEw+Slkw2pTDU5V4llNiC6tPpwwMAsxcM5bYMRievZDZXXC1qwnxb6fLqb/YwxL8PYDQuTVFF2knJZdpt5XwT18I4ufBeZVkhuPmI3NRD5uBsxizLebFe5JcBIOO7heuWmvj6ZlzOKUcsw6qAOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DniD6MP/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C8ms6x009721;
	Mon, 12 Feb 2024 09:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OU5LC9ro5XnCzs3/2ne/mzqvDS+MuBqxMJ32iSfO9p4=; b=Dn
	iD6MP/WhDiTKFsruz9ECGLvdeg2nzAWqxY+/fqBMvqxH1rZtom7DML2qSy1d7gcL
	JOKMkwxf05fpSxQCF1T7Pc+DUZ4grGRqpZRClYwmt7xeuK9MKonyMslNAWhUwTH8
	UvsGk083qTjkw+sQhEvulvdDtiAtATCIndGgyXki1CpjUPDVBIuh7OGE/nYjqrb9
	6MywPp/ZGM+kpkAREOONmTPwG69cOcb2aP7//qOviEHSoecji65mkxJsMGMw+/Ia
	pSjm0kiJKygg/t/9mq6nGpJmAbH/1LqEbW2sJJcye/cL8xs8MzbxmDQHWp24fcTg
	97sjweLujGBsHWrNkDYQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62n02uvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:14:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C9EbPo003966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:14:37 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 01:14:32 -0800
Message-ID: <b8343f62-ce6d-b10d-9d5d-845eea14cd4c@quicinc.com>
Date: Mon, 12 Feb 2024 14:44:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 3/7] firmware: arm_scmi: Add QCOM vendor protocol
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        Amir Vajid <avajid@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-4-quic_sibis@quicinc.com> <ZaleTVhYlUj6iufT@bogus>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZaleTVhYlUj6iufT@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oCTeDu4KHpLNTHBb6cpoWQ_Z7h-34OZ0
X-Proofpoint-ORIG-GUID: oCTeDu4KHpLNTHBb6cpoWQ_Z7h-34OZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_06,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120069



On 1/18/24 22:52, Sudeep Holla wrote:
> On Wed, Jan 17, 2024 at 11:04:54PM +0530, Sibi Sankar wrote:
>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>
>> SCMI QCOM vendor protocol provides interface to communicate with SCMI
>> controller and enable vendor specific features like bus scaling capable
>> of running on it.

Hey Sudeep,

Thanks for taking time to review the series!

>>
>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Co-developed-by: Amir Vajid <avajid@quicinc.com>
>> Signed-off-by: Amir Vajid <avajid@quicinc.com>
>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/Kconfig            |  11 ++
>>   drivers/firmware/arm_scmi/Makefile           |   1 +
>>   drivers/firmware/arm_scmi/qcom_scmi_vendor.c | 160 +++++++++++++++++++
>>   include/linux/qcom_scmi_vendor.h             |  36 +++++
>>   4 files changed, 208 insertions(+)
>>   create mode 100644 drivers/firmware/arm_scmi/qcom_scmi_vendor.c
>>   create mode 100644 include/linux/qcom_scmi_vendor.h
>>
>> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
>> index aa5842be19b2..86b5d6c18ec4 100644
>> --- a/drivers/firmware/arm_scmi/Kconfig
>> +++ b/drivers/firmware/arm_scmi/Kconfig
>> @@ -180,4 +180,15 @@ config ARM_SCMI_POWER_CONTROL
>>   	  called scmi_power_control. Note this may needed early in boot to catch
>>   	  early shutdown/reboot SCMI requests.
>>
>> +config QCOM_SCMI_VENDOR_PROTOCOL
>> +	tristate "Qualcomm Technologies, Inc. Qcom SCMI vendor Protocol"
>> +	depends on ARM || ARM64 || COMPILE_TEST
>> +	depends on ARM_SCMI_PROTOCOL
>> +	help
>> +	  The SCMI QCOM vendor protocol provides interface to communicate with SCMI
>> +	  controller and enable vendor specific features like bus scaling.
>> +
> 
> I assume it will include all the Qualcomm specific vendor protocol
> handling here. Not sure how it it implemented across different platforms
> and but I already assume different platforms will use same protocol id
> for different things and this implementation will abstract all those
> details.

Yes, that's what we are going for.

> 
>> diff --git a/drivers/firmware/arm_scmi/qcom_scmi_vendor.c b/drivers/firmware/arm_scmi/qcom_scmi_vendor.c
>> new file mode 100644
>> index 000000000000..878b99f0d1ef
>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/qcom_scmi_vendor.c
>> @@ -0,0 +1,160 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/qcom_scmi_vendor.h>
>> +
>> +#include "common.h"
>> +
>> +#define	EXTENDED_MSG_ID			0
> 
> This gives me no clue what this means ?
> 
>> +#define	SCMI_MAX_TX_RX_SIZE		128
>> +#define	PROTOCOL_PAYLOAD_SIZE		16
>> +#define	SET_PARAM			0x10
> 
> I assume these are the actual message IDs ? Any idea why 0x0-0xF is skipped ?
> I assume atleast the required 0x0-0x2 are implemented.

Yup 0x0-0x2 should be implemented. I'll have to get info on why the rest
were skipped. Will add comments detailing the extended msg id as well.

> 
>> +#define	GET_PARAM			0x11
>> +#define	START_ACTIVITY			0x12
>> +#define	STOP_ACTIVITY			0x13
> 
> In general, good to add description of these in the implementation here
> or under Documentation or a pointer to the url where I can get the info.
> If documenting within the kernel, please use SCMI spec format as it may
> be easy to follow the same pattern even in the vendor protocols.
> 

ack

>> +
>> +static int qcom_scmi_set_param(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +			       u32 param_id, size_t size)
>> +{
>> +	int ret = -EINVAL;
>> +	struct scmi_xfer *t;
>> +	u32 *msg;
>> +
>> +	if (!ph || !ph->xops)
>> +		return ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SET_PARAM, size + PROTOCOL_PAYLOAD_SIZE,
>> +				      SCMI_MAX_TX_RX_SIZE, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msg = t->tx.buf;
>> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
>> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
>> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
>> +	*msg++ = cpu_to_le32(param_id);
>> +	memcpy(msg, buf, size);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_scmi_get_param(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +			       u32 param_id, size_t tx_size, size_t rx_size)
>> +{
>> +	int ret = -EINVAL;
>> +	struct scmi_xfer *t;
>> +	u32 *msg;
>> +
>> +	if (!ph || !ph->xops || !buf)
>> +		return ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, GET_PARAM, tx_size + PROTOCOL_PAYLOAD_SIZE,
>> +				      SCMI_MAX_TX_RX_SIZE, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msg = t->tx.buf;
>> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
>> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
>> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
>> +	*msg++ = cpu_to_le32(param_id);
>> +	memcpy(msg, buf, tx_size);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	if (t->rx.len > rx_size) {
>> +		pr_err("SCMI received buffer size %zu is more than expected size %zu\n",
>> +		       t->rx.len, rx_size);
>> +		return -EMSGSIZE;
>> +	}
>> +	memcpy(buf, t->rx.buf, t->rx.len);
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_scmi_start_activity(const struct scmi_protocol_handle *ph,
>> +				    void *buf, u64 algo_str, u32 param_id, size_t size)
>> +{
>> +	int ret = -EINVAL;
>> +	struct scmi_xfer *t;
>> +	u32 *msg;
>> +
>> +	if (!ph || !ph->xops)
>> +		return ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, START_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
>> +				      SCMI_MAX_TX_RX_SIZE, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msg = t->tx.buf;
>> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
>> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
>> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
>> +	*msg++ = cpu_to_le32(param_id);
>> +	memcpy(msg, buf, size);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_scmi_stop_activity(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +				   u32 param_id, size_t size)
>> +{
>> +	int ret = -EINVAL;
>> +	struct scmi_xfer *t;
>> +	u32 *msg;
>> +
>> +	if (!ph || !ph->xops)
>> +		return ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, STOP_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
>> +				      SCMI_MAX_TX_RX_SIZE, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msg = t->tx.buf;
>> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
>> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
>> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
>> +	*msg++ = cpu_to_le32(param_id);
>> +	memcpy(msg, buf, size);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static struct qcom_scmi_vendor_ops qcom_proto_ops = {
>> +	.set_param = qcom_scmi_set_param,
>> +	.get_param = qcom_scmi_get_param,
>> +	.start_activity = qcom_scmi_start_activity,
>> +	.stop_activity = qcom_scmi_stop_activity,
>> +};
>> +
>> +static int qcom_scmi_vendor_protocol_init(const struct scmi_protocol_handle *ph)
>> +{
>> +	u32 version;
>> +
>> +	ph->xops->version_get(ph, &version);
>> +
>> +	dev_info(ph->dev, "qcom scmi version %d.%d\n",
>> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct scmi_protocol qcom_scmi_vendor = {
>> +	.id = QCOM_SCMI_VENDOR_PROTOCOL,
> 
> As Cristian might have pointed out, this will conflict and we need better
> matching to ensure each vendor and protocols with each implementation has
> unique matching mechanism so that only one match occurs per protocol on
> any platform.

Ack.

Also as mentioned in another thread this will be the only implementation
of the 0x80 vendor protocol upstream given that no other SoC actually
shipped with it enabled (expect for sc7180 which already has an
alternative dvfs solution upstream).

-Sibi

> 

