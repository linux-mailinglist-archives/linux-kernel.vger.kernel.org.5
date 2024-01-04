Return-Path: <linux-kernel+bounces-16542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48E823FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609EA1F251DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC86320DF0;
	Thu,  4 Jan 2024 10:55:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE020DDE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.178])
	by sina.com (172.16.235.24) with ESMTP
	id 65968E7A00004E93; Thu, 4 Jan 2024 18:54:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 67516645089256
X-SMAIL-UIID: 53E238DDBF6C488EB38F1311581F63D6-20240104-185453-1
From: Hillf Danton <hdanton@sina.com>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v12 02/41] xhci: add helper to stop endpoint and wait for completion
Date: Thu,  4 Jan 2024 18:54:42 +0800
Message-Id: <20240104105442.2820-1-hdanton@sina.com>
In-Reply-To: <20240102214549.22498-3-quic_wcheng@quicinc.com>
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2 Jan 2024 13:45:10 -0800
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> +/*
> + * Synchronous XHCI stop endpoint helper.  Issues the stop endpoint command and
> + * waits for the command completion before returning.
> + */
> +int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep, int suspend,
> +			    gfp_t gfp_flags)
> +{
> +	struct xhci_command *command;
> +	unsigned long flags;
> +	int ret;
> +
> +	command = xhci_alloc_command(xhci, true, GFP_KERNEL);

Given unused gfp_flags, s/GFP_KERNEL/gfp_flags/ ?

> +	if (!command)
> +		return -ENOMEM;
> +
> +	spin_lock_irqsave(&xhci->lock, flags);
> +	ret = xhci_queue_stop_endpoint(xhci, command, ep->vdev->slot_id,
> +				       ep->ep_index, suspend);
> +	if (ret < 0) {
> +		spin_unlock_irqrestore(&xhci->lock, flags);
> +		goto out;
> +	}
> +
> +	xhci_ring_cmd_db(xhci);
> +	spin_unlock_irqrestore(&xhci->lock, flags);
> +
> +	ret = wait_for_completion_timeout(command->completion, msecs_to_jiffies(3000));
> +	if (!ret)
> +		xhci_warn(xhci, "%s: Unable to stop endpoint.\n",
> +				__func__);
> +
> +	if (command->status == COMP_COMMAND_ABORTED ||
> +	    command->status == COMP_COMMAND_RING_STOPPED) {
> +		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
> +		ret = -ETIME;
> +	}
> +out:
> +	xhci_free_command(xhci, command);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xhci_stop_endpoint_sync);

