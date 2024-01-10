Return-Path: <linux-kernel+bounces-22108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8C829950
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA58285DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57347F57;
	Wed, 10 Jan 2024 11:41:30 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9B481C4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.212])
	by sina.com (172.16.235.25) with ESMTP
	id 659E825600002DBD; Wed, 10 Jan 2024 19:41:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 31099534210304
X-SMAIL-UIID: 96EB86E16263455A8C3FE6FECD19F94C-20240110-194113-1
From: Hillf Danton <hdanton@sina.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Will Deacon <will@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 07/34] gunyah: rsc_mgr: Add resource manager RPC core
Date: Wed, 10 Jan 2024 19:41:01 +0800
Message-Id: <20240110114101.3343-1-hdanton@sina.com>
In-Reply-To: <20240109-gunyah-v16-7-634904bf4ce9@quicinc.com>
References: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Jan 2024 11:37:45 -0800 Elliot Berman <quic_eberman@quicinc.com>
> +
> +static irqreturn_t gunyah_rm_tx(int irq, void *data)
> +{
> +	struct gunyah_rm *rm = data;
> +
> +	complete_all(&rm->send_ready);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gunyah_rm_msgq_send(struct gunyah_rm *rm, size_t size, bool push)
> +	__must_hold(&rm->send_lock)
> +{
> +	const u64 tx_flags = push ? GUNYAH_HYPERCALL_MSGQ_TX_FLAGS_PUSH : 0;
> +	enum gunyah_error gunyah_error;
> +	void *data = &rm->send_msg[0];
> +	bool ready;

	lockdep_assert_held(&rm->send_lock); instead of __must_hold
> +
> +again:
> +	wait_for_completion(&rm->send_ready);
> +	/* reinit completion before hypercall. As soon as hypercall returns, we could get the
> +	 * ready interrupt. This might be before we have time to reinit the completion
> +	 */
> +	reinit_completion(&rm->send_ready);

Given wait_for_completion(&rm->send_ready) with rm->send_lock held,
complete(&rm->send_ready) works for you with the bonus of cutting this
reinit off.

> +	gunyah_error = gunyah_hypercall_msgq_send(rm->tx_ghrsc.capid, size,
> +						  data, tx_flags, &ready);
> +
> +	/* Should never happen because Linux properly tracks the ready-state of the msgq */
> +	if (WARN_ON(gunyah_error == GUNYAH_ERROR_MSGQUEUE_FULL))
> +		goto again;
> +
> +	if (ready)
> +		complete_all(&rm->send_ready);
> +
> +	return gunyah_error_remap(gunyah_error);
> +}

