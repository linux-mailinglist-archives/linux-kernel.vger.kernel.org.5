Return-Path: <linux-kernel+bounces-164793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1318B82F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECA61C228FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C301C0DD1;
	Tue, 30 Apr 2024 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JYRCyzsV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D529A2;
	Tue, 30 Apr 2024 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519117; cv=none; b=Ml+3JDv2Nmkq7pmpDDJwEVmqtpBdDmNt7ASEC/MSxeiTEfYCehOb4X/lassQ37wE3RZqzJZlgf6mAnWNRtpebbJK/0wR/Tueybitz2IKS1VT5GcW+yLo2sA/WjTr9UMFu18y4yPagk7SBzgQc3dTa/4LXamhiHgtlj8QyJEnBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519117; c=relaxed/simple;
	bh=oFjvU2St6BfKnmi9TYObMAzCNbHryiv8r8qxZQHdaHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m5G2MEiZ4DwsUbjGCtVPudDxHBXwaupNseMjNWbef6Lsr7DnxLej6T6RXf6PWrv7XpfccpVTbvEiALfBb1I32rTWwabbXb0jWf1fMORagv/5FvOjRHzJ0j2rOZnC1/T379TaHXs/98r9lq3KhLSVIQZmU/NJ+ADV0gNrRHhlZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JYRCyzsV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UMeXDu020995;
	Tue, 30 Apr 2024 23:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=M2DfN/umz6WZ9H7G0RG+9oLTt4u+Pvx1ZqJX6AjiFlg=; b=JY
	RCyzsV09nf1UtKfQlAuGxYbFrbFQVYR9FIanF6DJ5RQH92T4alyeGfz6UYfEbQaP
	/Tfj3v2Q1u8g/Nt3BkZ+0yCTUiFuZzapoPJvV9wWWEG80WmD60Vcss+ieuSxsbQs
	JU2qprplx6WuPeP5bCkjYWKSO+rbyzY5UrG/bx3SyipAsN6Ooke87T9HE+Y39SV8
	RXyQz3MUzHp5SbEb/TmrtyPPFz7e/Jw7eFAl5isnmr1emK+XPxFWbakYH7Z8xiyF
	1qXrBtdFsYIHlJvOTK0yDxeb0cIJtPN7TIyWtnQgGVKzVdQMPiUR2ARwTGpMGqoW
	ehExxYa8bCR6NDz3q40Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xttw3jcr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 23:18:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UNISHO022691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 23:18:28 GMT
Received: from [10.110.59.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 16:18:27 -0700
Message-ID: <172ab19b-4643-6ac0-53ab-d2d1e217171c@quicinc.com>
Date: Tue, 30 Apr 2024 16:18:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V1] soc: qcom: smp2p: Introduce tracepoint support
To: Sudeepgoud Patil <quic_sudeepgo@quicinc.com>, <quic_bjorande@quicinc.com>,
        <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <quic_deesin@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>
References: <20240429075528.1723133-1-quic_sudeepgo@quicinc.com>
Content-Language: en-US
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240429075528.1723133-1-quic_sudeepgo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4128fbrGdGInk7_zkltSriGwJvKIaQCZ
X-Proofpoint-ORIG-GUID: 4128fbrGdGInk7_zkltSriGwJvKIaQCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_14,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300165



On 4/29/2024 12:55 AM, Sudeepgoud Patil wrote:
> Introduce tracepoint support for smp2p providing useful logging
> for communication between clients.
> 

Let's add some more description as to why these tracepoint are useful. 
Do they help us track latency? debugging information for us? for clients?

> Signed-off-by: Sudeepgoud Patil <quic_sudeepgo@quicinc.com>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>

As Elliot mentioned in the internal review, your Signed-off-by should be 
last. I would suggest removing Deepak's Signed-off-by and letting him 
reply with Reviewed-by since he was the main reviewer internally.

> ---
>   drivers/soc/qcom/Makefile      |  1 +
>   drivers/soc/qcom/smp2p.c       | 10 ++++
>   drivers/soc/qcom/trace-smp2p.h | 99 ++++++++++++++++++++++++++++++++++
>   3 files changed, 110 insertions(+)
>   create mode 100644 drivers/soc/qcom/trace-smp2p.h
> 
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index ca0bece0dfff..30c1bf645501 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -23,6 +23,7 @@ qcom_rpmh-y			+= rpmh.o
>   obj-$(CONFIG_QCOM_SMD_RPM)	+= rpm-proc.o smd-rpm.o
>   obj-$(CONFIG_QCOM_SMEM) +=	smem.o
>   obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
> +CFLAGS_smp2p.o := -I$(src)
>   obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
>   obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
>   obj-$(CONFIG_QCOM_SOCINFO)	+= socinfo.o
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index a21241cbeec7..dde8513641ae 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -20,6 +20,9 @@
>   #include <linux/soc/qcom/smem_state.h>
>   #include <linux/spinlock.h>
>   
> +#define CREATE_TRACE_POINTS
> +#include "trace-smp2p.h"
> +
>   /*
>    * The Shared Memory Point to Point (SMP2P) protocol facilitates communication
>    * of a single 32-bit value between two processors.  Each value has a single
> @@ -191,6 +194,7 @@ static void qcom_smp2p_do_ssr_ack(struct qcom_smp2p *smp2p)
>   	struct smp2p_smem_item *out = smp2p->out;
>   	u32 val;
>   
> +	trace_smp2p_ssr_ack(smp2p->remote_pid);
>   	smp2p->ssr_ack = !smp2p->ssr_ack;
>   
>   	val = out->flags & ~BIT(SMP2P_FLAGS_RESTART_ACK_BIT);
> @@ -213,6 +217,7 @@ static void qcom_smp2p_negotiate(struct qcom_smp2p *smp2p)
>   			smp2p->ssr_ack_enabled = true;
>   
>   		smp2p->negotiation_done = true;
> +		trace_smp2p_negotiate(smp2p->remote_pid, smp2p->ssr_ack_enabled);

since this tracepoint is for negotiating, maybe we should capture all of 
the features (out->features) instead of just the ssr_ack feature.

>   	}
>   }
>   
> @@ -251,6 +256,8 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
>   		status = val ^ entry->last_value;
>   		entry->last_value = val;
>   
> +		trace_smp2p_notify_in(smp2p->remote_pid, entry->name, status, val);
> +
>   		/* No changes of this entry? */
>   		if (!status)
>   			continue;
> @@ -406,6 +413,9 @@ static int smp2p_update_bits(void *data, u32 mask, u32 value)
>   	writel(val, entry->value);
>   	spin_unlock_irqrestore(&entry->lock, flags);
>   
> +	trace_smp2p_update_bits(entry->smp2p->remote_pid,
> +		entry->name, orig, val);
> +
>   	if (val != orig)
>   		qcom_smp2p_kick(entry->smp2p);
>   
> diff --git a/drivers/soc/qcom/trace-smp2p.h b/drivers/soc/qcom/trace-smp2p.h
> new file mode 100644
> index 000000000000..c61afab23f0c
> --- /dev/null
> +++ b/drivers/soc/qcom/trace-smp2p.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM qcom_smp2p
> +
> +#if !defined(__QCOM_SMP2P_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
> +#define __QCOM_SMP2P_TRACE_H__
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(smp2p_ssr_ack,
> +	TP_PROTO(unsigned int remote_pid),

Is there any way we can map the remote pid's to a string? I feel like 
the tracepoints would be more useful if they called out modem, adsp, etc 
instead of an integer value.

> +	TP_ARGS(remote_pid),
> +	TP_STRUCT__entry(
> +		__field(u32, remote_pid)
> +	),
> +	TP_fast_assign(
> +		__entry->remote_pid = remote_pid;
> +	),
> +	TP_printk("%d: SSR detected, doing SSR Handshake",
> +		__entry->remote_pid
> +	)
> +);
> +
> +TRACE_EVENT(smp2p_negotiate,
> +	TP_PROTO(unsigned int remote_pid, bool ssr_ack_enabled),
> +	TP_ARGS(remote_pid, ssr_ack_enabled),
> +	TP_STRUCT__entry(
> +		__field(u32, remote_pid)
> +		__field(bool, ssr_ack_enabled)
> +	),
> +	TP_fast_assign(
> +		__entry->remote_pid = remote_pid;
> +		__entry->ssr_ack_enabled = ssr_ack_enabled;
> +	),
> +	TP_printk("%d: state=open ssr_ack=%d",
> +		__entry->remote_pid,
> +		__entry->ssr_ack_enabled
> +	)
> +);
> +
> +TRACE_EVENT(smp2p_notify_in,
> +	TP_PROTO(unsigned int remote_pid, const char *name, unsigned long status, u32 val),
> +	TP_ARGS(remote_pid, name, status, val),
> +	TP_STRUCT__entry(
> +		__field(u32, remote_pid)
> +		__string(name, name)
> +		__field(unsigned long, status)
> +		__field(u32, val)
> +	),
> +	TP_fast_assign(
> +		__entry->remote_pid = remote_pid;
> +		__assign_str(name, name);
> +		__entry->status = status;
> +		__entry->val = val;
> +	),
> +	TP_printk("%d: %s: status:0x%0lx val:0x%0x",
> +		__entry->remote_pid,
> +		__get_str(name),
> +		__entry->status,
> +		__entry->val
> +	)
> +);
> +
> +TRACE_EVENT(smp2p_update_bits,
> +	TP_PROTO(unsigned int remote_pid, const char *name, u32 orig, u32 val),
> +	TP_ARGS(remote_pid, name, orig, val),
> +	TP_STRUCT__entry(
> +		__field(u32, remote_pid)
> +		__string(name, name)
> +		__field(u32, orig)
> +		__field(u32, val)
> +	),
> +	TP_fast_assign(
> +		__entry->remote_pid = remote_pid;
> +		__assign_str(name, name);
> +		__entry->orig = orig;
> +		__entry->val = val;
> +	),
> +	TP_printk("%d: %s: orig:0x%0x new:0x%0x",
> +		__entry->remote_pid,
> +		__get_str(name),
> +		__entry->orig,
> +		__entry->val
> +	)
> +);
> +
> +#endif /* __QCOM_SMP2P_TRACE_H__ */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE trace-smp2p
> +
> +#include <trace/define_trace.h>

