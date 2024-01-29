Return-Path: <linux-kernel+bounces-42577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EE684035F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470121C21D17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B745B1F8;
	Mon, 29 Jan 2024 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv+EfBzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70455A792;
	Mon, 29 Jan 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526073; cv=none; b=bAuy24BrDfLNyTFxyhWSEaxyLZbElSk18ndwfqRL9Fn0D0axVaSdMrF7gTyX/U0jr7+ysacM9VfCs6HnmjbgFARIRljNRCL9aEP3KLjpBLRcmltVp9cbwdBTi4l+th7llAZ7UCR10eJOPlKTYjPIIPQjWt9bRzXzfEpjx5Op4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526073; c=relaxed/simple;
	bh=y2gZ1pFjwZMfHT2DM9ePqD76RdI1dp+bE3hGJianwFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmdSQu9OSYiL04TlgkHWXELlZXPB27YEssekV6CAdVBEKXrTZ515vPmK1aWHzB4g1nfeVcYitmh6mkp/lROF3AdYClz6NabnZ5fKpIikt2T/Ijwd//lSOmJXQn+ACzbgQgyUA/EOGinTfPcPW7YtNl7PMzqMBxTsMGIAL9C/vBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pv+EfBzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B6BC433F1;
	Mon, 29 Jan 2024 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706526072;
	bh=y2gZ1pFjwZMfHT2DM9ePqD76RdI1dp+bE3hGJianwFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pv+EfBzILKr/7rpgeEGVdXZxFMbD2amPqlizepDr8hyT6DvYOxgiEt4IN71t3RLf3
	 QxcvbEVggICbsdUZBdnymbtB5BNDG/LE5sGLeHgH8gOWQAllDiT31cf5Od5agZhWOk
	 kh5PdePV6fz1L95kfBbAykd+UtIf+yRAMCrPhUrPGenyccnNnP/fL/LlWanv4nFIk5
	 LT6DHkNQXTxRfBgqyCxvw+VCjlbyDiTuhmqUIHFty6hKtTtnXP1Uok2drevpT3MuGT
	 WYltzgjis2j12sXMTw6nYAllKRlvp2OCQOFQ11CxgAuUUqMyJUvn2jeGMSbPWFQjGW
	 3p8LbN/o2BkhQ==
Date: Mon, 29 Jan 2024 11:01:08 +0000
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: tcp: accept old ack during closing
Message-ID: <20240129110108.GK401354@kernel.org>
References: <20240126040519.1846345-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126040519.1846345-1-menglong8.dong@gmail.com>

On Fri, Jan 26, 2024 at 12:05:19PM +0800, Menglong Dong wrote:
> For now, the packet with an old ack is not accepted if we are in
> FIN_WAIT1 state, which can cause retransmission. Taking the following
> case as an example:
> 
>     Client                               Server
>       |                                    |
>   FIN_WAIT1(Send FIN, seq=10)          FIN_WAIT1(Send FIN, seq=20, ack=10)
>       |                                    |
>       |                                Send ACK(seq=21, ack=11)
>    Recv ACK(seq=21, ack=11)
>       |
>    Recv FIN(seq=20, ack=10)
> 
> In the case above, simultaneous close is happening, and the FIN and ACK
> packet that send from the server is out of order. Then, the FIN will be
> dropped by the client, as it has an old ack. Then, the server has to
> retransmit the FIN, which can cause delay if the server has set the
> SO_LINGER on the socket.
> 
> Old ack is accepted in the ESTABLISHED and TIME_WAIT state, and I think
> it should be better to keep the same logic.
> 
> In this commit, we accept old ack in FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_ACK
> states. Maybe we should limit it to FIN_WAIT1 for now?
> 
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
> v3:
> - fix unsigned/signed compare error

Thanks for the update.

I wish this could be done without a cast.
But I do see that what you have done is
consistent with at least one other use of tcp_ack().

So from that point of view:

Reviewed-by: Simon Horman <horms@kernel.org>

..

