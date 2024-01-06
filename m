Return-Path: <linux-kernel+bounces-18469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4514825E14
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0411C23BEB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9876117D5;
	Sat,  6 Jan 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYDIp+Mb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2C15B3;
	Sat,  6 Jan 2024 03:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09CDC433C7;
	Sat,  6 Jan 2024 03:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704511831;
	bh=ZZT5W/3OayChCmzDajSxgELxnptLBYGuC7NHIb+7uWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dYDIp+Mby3VrwUNXuc505hhrUlZWX6YnsTAVt4cp6JDLy3Cz/pqLGQN6+dmvKEmUM
	 2bedL6TjTCT6R5Sx4kfi5PQ6E4J7L/vPeDv+H2ZW4FI3RUowD8z3DslbcTqNHNpoNZ
	 ZXNamfRP8ONsklOAVRAkW8fuc+XE39d7oF/R1NHo2RKfHsh0OZWYc6pdBK6uibWJ23
	 +jCooMpqaBF/RbdMPN75AGF+VYJLlOZvW1yoInTFV+TtxrsESTc5LPiL8/RpPfRQBw
	 4OmYf1xM5QVcP/N4S/mSmIq7nx/naIBfHsFaIz/z0QBVzDKrlqebewzFQTGkmiK2Ql
	 r9ZGd6gofQaHQ==
Date: Fri, 5 Jan 2024 19:30:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
 <egallen@redhat.com>, <mschmidt@redhat.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, Veerasenareddy Burru <vburru@marvell.com>, Satananda
 Burla <sburla@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v3 6/8] octeon_ep_vf: add Tx/Rx processing and
 interrupt support
Message-ID: <20240105193029.004ee174@kernel.org>
In-Reply-To: <20240105203823.2953604-7-srasheed@marvell.com>
References: <20240105203823.2953604-1-srasheed@marvell.com>
	<20240105203823.2953604-7-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 12:38:21 -0800 Shinas Rasheed wrote:
> +static int octep_vf_iq_full_check(struct octep_vf_iq *iq)
> +{
> +	if (likely((IQ_INSTR_SPACE(iq)) >
> +		   OCTEP_VF_WAKE_QUEUE_THRESHOLD))
> +		return 0;
> +
> +	/* Stop the queue if unable to send */
> +	netif_stop_subqueue(iq->netdev, iq->q_no);
> +
> +	/* check again and restart the queue, in case NAPI has just freed
> +	 * enough Tx ring entries.
> +	 */
> +	if (unlikely(IQ_INSTR_SPACE(iq) >
> +		     OCTEP_VF_WAKE_QUEUE_THRESHOLD)) {
> +		netif_start_subqueue(iq->netdev, iq->q_no);
> +		iq->stats.restart_cnt++;
> +		return 0;
> +	}

Please use the macros from netdev_queues.h here as well.
Looks like you may be missing a memory barrier here.

And please call this function after queuing an skb to
make sure NETDEV_TX_BUSY is almost never returned.
See Documentation/networking/driver.rst

