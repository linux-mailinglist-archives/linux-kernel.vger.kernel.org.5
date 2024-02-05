Return-Path: <linux-kernel+bounces-52371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8BD84973C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356B128EB30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FB817582;
	Mon,  5 Feb 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtZXS3I4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51417591;
	Mon,  5 Feb 2024 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127290; cv=none; b=X/nwpfkE2XJHNLHf236nMoJdzm1z8wk1KCv9+v1DgSFuoK+KWxboRzfmU7uk83ELSP67IVZx2UWSWKgxR7EenbsUQRRO7TPOfX6iuk9y6gqav85ANdKIeyb7Zmh9QTEMwDzysnKYwm1rfAIAGjZD+qBYLQ3apeZthxqbBAFx8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127290; c=relaxed/simple;
	bh=eJRA+3ncVCN99vSdsXxNf3NPv3pDH15qHWZrw59/uno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WE0SKseD1EVIxukdGNXPRRwLOcTEHWptSxunrG4ypykOI5/BToCJ7s3PBseFDTd9/gp6TkWDaCHxUU+HjfeTqsyYpS3TQ+dD7lBkjMqvCtPXKE8t0keaVcd347leHCbaEevn7xE7RhLIUtNtny+3OI2GvQQl5H68AS1tNBSRpAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtZXS3I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2BDC433F1;
	Mon,  5 Feb 2024 10:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707127289;
	bh=eJRA+3ncVCN99vSdsXxNf3NPv3pDH15qHWZrw59/uno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jtZXS3I4ULM2OVUHLxQdXQvf1+WVJZW4OnH7bKzkSA2l2WYZlz66Wu0Si62vKLQdk
	 eeyCxh1qJG6ZfU5Y/d/aXi/Ffw8IVloTn2dZxc5ufgQTcw0oHT2nlhs59wEdxkNPr8
	 58ZCwlnHyzjlVgL28zLV1pJNunpjSbkxbbe6EUVObTRpPsU9fJ3VWf0wpT+cQsqoo4
	 ANmi18kNyPNsFP4sE4HdfiXMpQbXxx/9y1GffI2ZhPlA0GeLJPuLp8tBPRmwFHlq3T
	 Rrf75M9xUZtpGWHuYgmOgytCFPzPXhDPk4yxdyjBKgORRNTG1qSEWEC8+jbwJdw3Mo
	 6SyVUTrJIovIA==
Message-ID: <72efe6e1-88e0-4b22-b7b2-00dc6903aef0@kernel.org>
Date: Mon, 5 Feb 2024 12:01:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: cdns3: fix memory double free when handle
 zero packet
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>
Cc: felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, pawell@cadence.com, peter.chen@kernel.org
References: <20240202154217.661867-1-Frank.Li@nxp.com>
 <20240202154217.661867-2-Frank.Li@nxp.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240202154217.661867-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/02/2024 17:42, Frank Li wrote:
> 829  if (request->complete) {
> 830          spin_unlock(&priv_dev->lock);
> 831          usb_gadget_giveback_request(&priv_ep->endpoint,
> 832                                    request);
> 833          spin_lock(&priv_dev->lock);
> 834  }
> 835
> 836  if (request->buf == priv_dev->zlp_buf)
> 837      cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
> 
> Driver append an additional zero packet request when queue a packet, which
> length mod max packet size is 0. When transfer complete, run to line 831,
> usb_gadget_giveback_request() will free this requestion. 836 condition is
> true, so cdns3_gadget_ep_free_request() free this request again.
> 
> Log:
> 
> [ 1920.140696][  T150] BUG: KFENCE: use-after-free read in cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
> [ 1920.140696][  T150]
> [ 1920.151837][  T150] Use-after-free read at 0x000000003d1cd10b (in kfence-#36):
> [ 1920.159082][  T150]  cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
> [ 1920.164988][  T150]  cdns3_transfer_completed+0x438/0x5f8 [cdns3]
> 
> Add check at line 829, skip call usb_gadget_giveback_request() if it is
> additional zero length packet request. Needn't call
> usb_gadget_giveback_request() because it is allocated in this driver.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

