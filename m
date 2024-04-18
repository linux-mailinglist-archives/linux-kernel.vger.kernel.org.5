Return-Path: <linux-kernel+bounces-149653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096888A9408
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1314B1C20B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0179754BED;
	Thu, 18 Apr 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p4YvVT9O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507773E493;
	Thu, 18 Apr 2024 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425537; cv=none; b=bPdCbiHQLhpr/FDwDRSmEv2Hkg7/14IykT0PtIXjS4T91Qhkm5Rqh/fl1FgGAU1YH/a1A+x/68zgcH49GOyJWSiXUE93rOb+GgxrfJE6U6kYl0yPfweXx4FUKhWyLLOt3NPlr7vM8YY26XcydWBBw5da3OW7LL47NwY2unURW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425537; c=relaxed/simple;
	bh=YIIn3GexzOhBh4JKi9/Epy5W5DGPN6zWRxWWHoPKomc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RBp09f710qm+fdvKnSj8Wl1UVxvIDinCNUuZSUXZOcjAWVT4tFol6FKBjqphWOpyJxozWD4AKprCJ6XaS5HN9o28xBTkLPWoimxWn2C1SiGDs41AQg/EWj9Xmuwx6zJcW+OxC6Lxr5S45cvlG3D4EfzvWlU1oEno+F2SpFk+Z9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p4YvVT9O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I3RW4c012923;
	Thu, 18 Apr 2024 07:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BHc/SirrXPfZUKq3KUlUpV4IvidkkotvzqmaqgLbQBQ=; b=p4
	YvVT9OIsxQIdMtyg5GwulQ/NNTRSwq8893k394dvJZfTdw1JOGAK1ziRmD54MM7i
	SbR399DiEw2EdYFE8P3y4pDvK3jwJa9Q9qk18+O0liqDHz8eVL02cgte6I0m4N0J
	435WZpYel3t2GmwCBqx3cyYRxgiJ+XYAze6hZbmfdXgfs0anBSnd8mD/BKhJQPf/
	zKh7Z1MXasnnTtVgCN+b84JSRWTHm+QuhKUBeeOps5WUhnJijH042wNfVppw0IcZ
	9sw8elykl4AegmHue+omtr6kfYqkpZcZXvhEQiJjK7gO2oaG/cv8hNsrqQXtQH7j
	alyVcmaSVJ7GtBliRv/Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjr92h4qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:32:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I7W0gg024671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:32:00 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 00:31:54 -0700
Message-ID: <b8ba5179-cb36-6b13-4244-6da1ff96c2d3@quicinc.com>
Date: Thu, 18 Apr 2024 13:01:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 2/5] mailbox: Add support for QTI CPUCP mailbox
 controller
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
References: <20240417132856.1106250-1-quic_sibis@quicinc.com>
 <20240417132856.1106250-3-quic_sibis@quicinc.com>
 <ZiA+mE3QduLxc+a5@hu-bjorande-lv.qualcomm.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZiA+mE3QduLxc+a5@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wh0NIDlcT5Y4HLXfGDTABwPVZVfR2opT
X-Proofpoint-ORIG-GUID: Wh0NIDlcT5Y4HLXfGDTABwPVZVfR2opT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180052



On 4/18/24 02:56, Bjorn Andersson wrote:
> On Wed, Apr 17, 2024 at 06:58:53PM +0530, Sibi Sankar wrote:
>> diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
>> new file mode 100644
>> index 000000000000..059eb25f217c
>> --- /dev/null
>> +++ b/drivers/mailbox/qcom-cpucp-mbox.c
>> @@ -0,0 +1,188 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*

Hey Bjorn,

Thanks for taking time to review the series :)

>> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
> 
> Nope.

ack, artefact from the v1 of legacy driver :(

> 
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mailbox_controller.h>
>> +#include <linux/module.h>
>> +
>> +#define APSS_CPUCP_IPC_CHAN_SUPPORTED		3
>> +#define APSS_CPUCP_MBOX_CMD_OFF			0x4
>> +
>> +/* Tx Registers */
>> +#define APSS_CPUCP_TX_MBOX_IDR			0
>> +#define APSS_CPUCP_TX_MBOX_CMD(i)		(0x100 + ((i) * 8))
>> +
>> +/* Rx Registers */
>> +#define APSS_CPUCP_RX_MBOX_IDR			0
>> +#define APSS_CPUCP_RX_MBOX_CMD(i)		(0x100 + ((i) * 8))
>> +#define APSS_CPUCP_RX_MBOX_MAP			0x4000
>> +#define APSS_CPUCP_RX_MBOX_STAT			0x4400
>> +#define APSS_CPUCP_RX_MBOX_CLEAR		0x4800
>> +#define APSS_CPUCP_RX_MBOX_EN			0x4C00
> 
> Can we have lower case hex digits, plz?

Sure

> 
>> +#define APSS_CPUCP_RX_MBOX_CMD_MASK		0xFFFFFFFFFFFFFFFF
>> +
>> +/**
>> + * struct qcom_cpucp_mbox - Holder for the mailbox driver
>> + * @chans:			The mailbox channel
>> + * @mbox:			The mailbox controller
>> + * @tx_base:			Base address of the CPUCP tx registers
>> + * @rx_base:			Base address of the CPUCP rx registers
>> + * @dev:			Device associated with this instance
>> + * @irq:			CPUCP to AP irq
> 
> @dev and @irq can be a local variables in qcom_cpucp_mbox_probe().

Ack

> 
>> + */
>> +struct qcom_cpucp_mbox {
>> +	struct mbox_chan chans[APSS_CPUCP_IPC_CHAN_SUPPORTED];
>> +	struct mbox_controller mbox;
>> +	void __iomem *tx_base;
>> +	void __iomem *rx_base;
>> +	struct device *dev;
>> +	int irq;
>> +};
>> +
>> +static inline int channel_number(struct mbox_chan *chan)
>> +{
>> +	return chan - chan->mbox->chans;
>> +}
>> +
>> +static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, void *data)
>> +{
>> +	struct qcom_cpucp_mbox *cpucp = data;
>> +	struct mbox_chan *chan;
>> +	unsigned long flags;
>> +	u64 status;
>> +	u32 val;
>> +	int i;
>> +
>> +	status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
>> +
>> +	for (i = 0; i < APSS_CPUCP_IPC_CHAN_SUPPORTED; i++) {
>> +		val = 0;
> 
> This value is immediately overwritten (or unused).

Ack

> 
>> +		if (status & BIT(i)) {
> 
> Can't you combine the for loop and this conditional into a
> for_each_bit_set()?

The only drawback I see here is if the number of channels increase to
it's full capacity of 64 since for_each_set_bit expects unsigned long.

> 
>> +			val = readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD(i) + APSS_CPUCP_MBOX_CMD_OFF);
>> +			chan = &cpucp->chans[i];
>> +			spin_lock_irqsave(&chan->lock, flags);
> 
> Can you please add a comment here to document that the lock is taken
> here to deal with races against client registration? (It wasn't obvious
> to me...)

This is was put in to handle irqs after channel closure. Meaning we
don't want to send data on a closed/empty channel.

> 
>> +			if (chan->cl)
>> +				mbox_chan_received_data(chan, &val);
>> +			writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
>> +			spin_unlock_irqrestore(&chan->lock, flags);
>> +		}
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int qcom_cpucp_mbox_startup(struct mbox_chan *chan)
>> +{
>> +	struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
>> +	unsigned long chan_id = channel_number(chan);
>> +	u64 val;
>> +
>> +	val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +	val |= BIT(chan_id);
>> +	writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +
>> +	return 0;
>> +}
>> +
>> +static void qcom_cpucp_mbox_shutdown(struct mbox_chan *chan)
>> +{
>> +	struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
>> +	unsigned long chan_id = channel_number(chan);
>> +	u64 val;
>> +
>> +	val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +	val &= ~BIT(chan_id);
>> +	writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +}
>> +
>> +static int qcom_cpucp_mbox_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +	struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
>> +	unsigned long chan_id = channel_number(chan);
>> +	u32 *val = data;
>> +
>> +	writel(*val, cpucp->tx_base + APSS_CPUCP_TX_MBOX_CMD(chan_id) + APSS_CPUCP_MBOX_CMD_OFF);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mbox_chan_ops qcom_cpucp_mbox_chan_ops = {
>> +	.startup = qcom_cpucp_mbox_startup,
>> +	.send_data = qcom_cpucp_mbox_send_data,
>> +	.shutdown = qcom_cpucp_mbox_shutdown
>> +};
>> +
>> +static int qcom_cpucp_mbox_probe(struct platform_device *pdev)
>> +{
>> +	struct qcom_cpucp_mbox *cpucp;
>> +	struct mbox_controller *mbox;
>> +	int ret;
>> +
>> +	cpucp = devm_kzalloc(&pdev->dev, sizeof(*cpucp), GFP_KERNEL);
>> +	if (!cpucp)
>> +		return -ENOMEM;
>> +
>> +	cpucp->dev = &pdev->dev;
>> +
>> +	cpucp->rx_base = devm_of_iomap(cpucp->dev, cpucp->dev->of_node, 0, NULL);
>> +	if (IS_ERR(cpucp->rx_base))
>> +		return PTR_ERR(cpucp->rx_base);
>> +
>> +	cpucp->tx_base = devm_of_iomap(cpucp->dev, cpucp->dev->of_node, 1, NULL);
>> +	if (IS_ERR(cpucp->tx_base))
>> +		return PTR_ERR(cpucp->tx_base);
>> +
>> +	writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +	writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
>> +	writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_MAP);
>> +
>> +	cpucp->irq = platform_get_irq(pdev, 0);
>> +	if (cpucp->irq < 0)
>> +		return cpucp->irq;
>> +
>> +	ret = devm_request_irq(cpucp->dev, cpucp->irq, qcom_cpucp_mbox_irq_fn,
>> +			       IRQF_TRIGGER_HIGH, "apss_cpucp_mbox", cpucp);
>> +	if (ret < 0)
>> +		return dev_err_probe(cpucp->dev, ret, "Failed to register irq: %d\n", cpucp->irq);
>> +
>> +	writeq(APSS_CPUCP_RX_MBOX_CMD_MASK, cpucp->rx_base + APSS_CPUCP_RX_MBOX_MAP);
>> +
>> +	mbox = &cpucp->mbox;
>> +	mbox->dev = cpucp->dev;
>> +	mbox->num_chans = APSS_CPUCP_IPC_CHAN_SUPPORTED;
>> +	mbox->chans = cpucp->chans;
>> +	mbox->ops = &qcom_cpucp_mbox_chan_ops;
>> +	mbox->txdone_irq = false;
>> +	mbox->txdone_poll = false;
>> +
>> +	ret = devm_mbox_controller_register(cpucp->dev, mbox);
>> +	if (ret)
>> +		return dev_err_probe(cpucp->dev, ret, "Failed to create mailbox\n");
>> +
>> +	platform_set_drvdata(pdev, cpucp);
> 
> I don't see you using the drvdata anywhere, can we drop this?

Yeash I'll drop this in the next re-spin.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id qcom_cpucp_mbox_of_match[] = {
>> +	{ .compatible = "qcom,x1e80100-cpucp-mbox"},
> 
> A space after the final '"' would be good for aesthetics.

Not sure how I missed it :(

-Sibi

> 
> Regards,
> Bjorn
> 
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_cpucp_mbox_of_match);
>> +
>> +static struct platform_driver qcom_cpucp_mbox_driver = {
>> +	.probe = qcom_cpucp_mbox_probe,
>> +	.driver = {
>> +		.name = "qcom_cpucp_mbox",
>> +		.of_match_table = qcom_cpucp_mbox_of_match,
>> +	},
>> +};
>> +module_platform_driver(qcom_cpucp_mbox_driver);
>> +
>> +MODULE_DESCRIPTION("QTI CPUCP MBOX Driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.34.1
>>

