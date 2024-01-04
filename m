Return-Path: <linux-kernel+bounces-17208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D68249D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738E71F23417
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF728E13;
	Thu,  4 Jan 2024 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+Yw54e4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281E1E522;
	Thu,  4 Jan 2024 20:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A828C433C7;
	Thu,  4 Jan 2024 20:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704401633;
	bh=WQUcwzl/vxYHZ/Je6gxMisKytkD5CEuFBGa/DgIPVk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+Yw54e42bwdbSPrFfu926iUAs8OuojxUWF0kq93+8rsGOsuPxyRTVg9LYYXkFKN8
	 s5GXBBpfizyQ7wdjSR4kga3YnydJKydZ3y2axkySh+cE5QP3tRFAnBnzhbccbYjGKH
	 oi4GIDPU8hvzqS2hHFAra9MRf4I1HaZ7gecXrh/bj49UemLXvey/86JCMJXkvLKWnO
	 JaLpnIwUJ/9Ngsnm6JR2Z3aaj2aoFGqVjZnET/7/wEfv+cQLOt33c3S60+rRRlcgGb
	 edNcbMzVXXdj8TMo5RsR+lpc9bg8kq4bkF9+nO9u5tueB0mXcF8mMSx19gPyBelEgm
	 yQwvThKMlbN8w==
Date: Thu, 4 Jan 2024 12:53:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
 <egallen@redhat.com>, <mschmidt@redhat.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, Veerasenareddy Burru <vburru@marvell.com>, Satananda
 Burla <sburla@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 7/8] octeon_ep_vf: add ethtool support
Message-ID: <20240104125352.5f8ef6ce@kernel.org>
In-Reply-To: <20231223134000.2906144-8-srasheed@marvell.com>
References: <20231223134000.2906144-1-srasheed@marvell.com>
	<20231223134000.2906144-8-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Dec 2023 05:39:59 -0800 Shinas Rasheed wrote:
> +	rx_packets = 0;
> +	rx_bytes = 0;
> +	tx_packets = 0;
> +	tx_bytes = 0;
> +	rx_alloc_errors = 0;
> +	tx_busy_errors = 0;
> +	tx_packets = 0;
> +	tx_bytes = 0;
> +	rx_packets = 0;
> +	rx_bytes = 0;
> +
> +	octep_vf_get_if_stats(oct);
> +	iface_tx_stats = &oct->iface_tx_stats;
> +	iface_rx_stats = &oct->iface_rx_stats;
> +
> +	for (q = 0; q < oct->num_oqs; q++) {
> +		struct octep_vf_iq *iq = oct->iq[q];
> +		struct octep_vf_oq *oq = oct->oq[q];
> +
> +		tx_packets += iq->stats.instr_completed;
> +		tx_bytes += iq->stats.bytes_sent;
> +		tx_busy_errors += iq->stats.tx_busy;
> +
> +		rx_packets += oq->stats.packets;
> +		rx_bytes += oq->stats.bytes;
> +		rx_alloc_errors += oq->stats.alloc_failures;
> +	}
> +	i = 0;
> +	data[i++] = rx_packets;
> +	data[i++] = tx_packets;
> +	data[i++] = rx_bytes;
> +	data[i++] = tx_bytes;
> +	data[i++] = rx_alloc_errors;
> +	data[i++] = tx_busy_errors;

Don't duplicate stats you're already reporting via ndo_get_stats64,
please.

