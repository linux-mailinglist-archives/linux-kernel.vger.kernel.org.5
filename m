Return-Path: <linux-kernel+bounces-25180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8608782C928
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83B6282A9D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84266CA62;
	Sat, 13 Jan 2024 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feGcgba9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC21C2E;
	Sat, 13 Jan 2024 02:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF57C433F1;
	Sat, 13 Jan 2024 02:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705113898;
	bh=BzT25cXi1cMZyRyCto2mcPnNVmM/UVdj5o9CdlbbAbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=feGcgba9BKLJGGc2npBabHiVmw5NHLR+0ul8vA9DpZsrY2ffhdB6AqWvuY8Po5jYs
	 jT08umgtShrLTuyZvY7YHOJWb5si/wW6LrYy5/ZmTG+54gFnwn+GKvWXLxI9zjluYZ
	 1fbRkccoaRqv6oAetob/q3Jg+1wAEB8ABngOqL3AwtSVrW5AVem4nIacVNkNs8Gvek
	 wztUGMGp7xeU9i+tW6u9cog9iysUb8+FPLeo0FcEMtCDBaMReJcBd4OdI6kYTXtbXr
	 JZO5hUWIpg8IixFGnjoQaB5GNqBMchYcEJyh6oLGpUZpSLPQyXwVPP1+rXI+UBwihz
	 Y3avb2F4/Zy2A==
Date: Fri, 12 Jan 2024 18:44:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, kernel@pengutronix.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netdev_queue: netdev_txq_completed_mb(): fix wake
 condition
Message-ID: <20240112184456.107a3756@kernel.org>
In-Reply-To: <20240112-netdev_queue-v1-1-102c2d57e20a@pengutronix.de>
References: <20240112-netdev_queue-v1-1-102c2d57e20a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 17:13:14 +0100 Marc Kleine-Budde wrote:
> netif_txq_try_stop() uses "get_desc >= start_thrs" as the check for
> the call to netif_tx_start_queue().
> 
> Use ">=" i netdev_txq_completed_mb(), too.
> 
> Fixes: c91c46de6bbc ("net: provide macros for commonly copied lockless queue stop/wake code")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> I'm currently converting a networking driver with a TX-FIFO depth of
> 1 (CAN device with lots of errata :/) to the netdev_queue.h helpers
> and stumbled over an off-by-one error on __netif_txq_completed_wake().

Makes sense, could be copy'n'paste from one of the drivers this is
based on. A bit unsure if it deserves the Fixes tag and net as we don't
know of any current user that would be suffering. start_thrs == ring size
is a bit of an extreme use case indeed :) Either way:

Acked-by: Jakub Kicinski <kuba@kernel.org>

