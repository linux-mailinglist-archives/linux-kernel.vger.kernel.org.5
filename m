Return-Path: <linux-kernel+bounces-167653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FF8BACCC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E881C215E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4785C153BD4;
	Fri,  3 May 2024 12:49:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE83153835;
	Fri,  3 May 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740546; cv=none; b=pFLLPk5UaY3IpGH+DoMsiH1uor64N4ZboUdnjymxvLp+dx0G1eMlk1pEOkeHPpj7GHtUnzwJHsqWfvpMXhD05aL5N0+cAIIhRbAIVeLXMXqaV3UqMI5ITQ76kXhql9lIrzx//UqHEbBrv9cL0ZukKeF12/kz+VF4v4z112BSP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740546; c=relaxed/simple;
	bh=PVowgn9PL8FaNm5k8xze9uzrhTDvsboHD8ZlIoi88FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XerZ2XzMrc6yuOxKT4cK8yiIL9rBPHBXTRy3L4DNLV99K3yF7cA+T6/7hOcX4qQ1Cuhjzt/+lOAkfgbINejDc0bkjsYlli+p6Rr6NciPgIWGZbrzl850Gd28ZyizUYO+7ERoTR5A72mYD8WEps6q1EfikAelcm1uu3v3WSj8hVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D82913D5;
	Fri,  3 May 2024 05:49:29 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B18293F793;
	Fri,  3 May 2024 05:49:01 -0700 (PDT)
Date: Fri, 3 May 2024 13:48:55 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, andersson@kernel.org, konrad.dybcio@linaro.org,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, quic_rgottimu@quicinc.com,
	quic_kshivnan@quicinc.com, conor+dt@kernel.org,
	quic_gkohli@quicinc.com, quic_nkela@quicinc.com,
	quic_psodagud@quicinc.com, abel.vesa@linaro.org
Subject: Re: [PATCH V4 2/5] mailbox: Add support for QTI CPUCP mailbox
 controller
Message-ID: <ZjTdNwzA4F-GxYY5@pluto>
References: <20240422164035.1045501-1-quic_sibis@quicinc.com>
 <20240422164035.1045501-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422164035.1045501-3-quic_sibis@quicinc.com>

On Mon, Apr 22, 2024 at 10:10:32PM +0530, Sibi Sankar wrote:
> Add support for CPUSS Control Processor (CPUCP) mailbox controller,
> this driver enables communication between AP and CPUCP by acting as
> a doorbell between them.
> 

Hi Sibi,

one small reflection about locking on the RX path down below...

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>

[snip]

> +struct qcom_cpucp_mbox {
> +	struct mbox_chan chans[APSS_CPUCP_IPC_CHAN_SUPPORTED];
> +	struct mbox_controller mbox;
> +	void __iomem *tx_base;
> +	void __iomem *rx_base;
> +};
> +
> +static inline int channel_number(struct mbox_chan *chan)
> +{
> +	return chan - chan->mbox->chans;
> +}
> +
> +static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, void *data)
> +{
> +	struct qcom_cpucp_mbox *cpucp = data;
> +	struct mbox_chan *chan;
> +	unsigned long flags;
> +	u64 status;
> +	u32 val;
> +	int i;
> +
> +	status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
> +
> +	for_each_set_bit(i, (unsigned long *)&status, APSS_CPUCP_IPC_CHAN_SUPPORTED) {
> +		val = readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD(i) + APSS_CPUCP_MBOX_CMD_OFF);
> +		chan = &cpucp->chans[i];
> +		/* Provide mutual exclusion with changes to chan->cl */
> +		spin_lock_irqsave(&chan->lock, flags);
> +		if (chan->cl)

So the spinlock here is needed to properly check for races on chan->cl
being NULLified by concurrent calls to mbox_channel_free()...the end
result, though, is that you disable IRQs here on each single data
processed on the RX path, while calling mbox_chan_received_data(), in order
to avoid the remote (but real) possibility that the mbox users could free
the channel while some traffic is still in-flight and processed by this ISR.

Note that, though, that mbox_channel_free() calls straight away at start
your controller provided qcom_cpucp_mbox_shutdown() method, where you disable
the IRQ at the HW level in the chip: this means that the only race which could
then happen between the call to .shutdown and chan->cl = NULL, would happen in
any already executing qcom_cpucp_mbox_irq_fn() ISR...

So, I was thinking, what if you add a

	sincronize_irq(cpucp->irq);

in your shutdown right after having disabled the HW IRQs.

This would mean waiting for the termination of any IRQ handlers pending on your
cpucp->irq (field that does not exist as of now :D), right after having
disabled such irq and so just before NULLifying chan->cl...in this way you
should be able to safely drop this spinlock call from the host RX path,
because once you chan->cl = NULL is executed, the IRQs are disabled and
any ongoing ISR would have been terminated.

syncronize_irq() is blocking of course, potentially, but the shutdown
method in mbox_chan_ops is allowed to be blocking looking at the comments.

..not sure if all of this is worth to avoid this small section of code to be
run with IRQs disabled....note though that the mbox_chan_received_data() calls
straight away into the client provided cl->callback....so the real lenght of this
code path is uncertain ....

..just an idea to reason about...

Thanks,
Cristian

