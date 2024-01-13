Return-Path: <linux-kernel+bounces-25327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80F82CD96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D438284099
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB722564;
	Sat, 13 Jan 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB/qdP6B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719B23A3;
	Sat, 13 Jan 2024 15:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0987C433F1;
	Sat, 13 Jan 2024 15:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705160796;
	bh=EwpXUO2qQlx0+NhiF121g0hPSk+y48HTkprp0ywhANc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nB/qdP6BYQwTS+d/rR+LT5AYHEGK7Iy9SSMILJtCusm9O4CQ+qaHAtm3VJzcnRMIf
	 2C6ilutl9SfTMbRvE7gEzi7MpaeMAIYMVbCIhG4jfwukLw6uvAegKMNtNldBtqrPje
	 x4eh0aA1RCtbneTEzoEjzgU16rD1tcw8GG+CHpK2PMVqWKdmyQJKedXe0cHAPNiwTa
	 Kco51N0FkwbuJgUH3AXlMOO5yADhUTR8uV5EV7jjFLyJeQ67I0QmmCFMAdgsjCFuBD
	 lk41c/BurIKLYYI95mHRrp9kVJXr0ZcPylCYTts44HQ8cWxDeCOwf4oFmJQzAeTKrM
	 +8ZXyW2wfS+hA==
Date: Sat, 13 Jan 2024 15:46:32 +0000
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] net: tcp: accept old ack during closing
Message-ID: <20240113154632.GI392144@kernel.org>
References: <20240112094603.23706-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112094603.23706-1-menglong8.dong@gmail.com>

On Fri, Jan 12, 2024 at 05:46:03PM +0800, Menglong Dong wrote:
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
> v2:
> - fix the compiling error
> ---
>  net/ipv4/tcp_input.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index df7b13f0e5e0..70642bb08f3a 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6699,17 +6699,21 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  		return 0;
>  
>  	/* step 5: check the ACK field */
> -	acceptable = tcp_ack(sk, skb, FLAG_SLOWPATH |
> -				      FLAG_UPDATE_TS_RECENT |
> -				      FLAG_NO_CHALLENGE_ACK) > 0;
> +	reason = tcp_ack(sk, skb, FLAG_SLOWPATH |
> +				  FLAG_UPDATE_TS_RECENT |
> +				  FLAG_NO_CHALLENGE_ACK);

Hi Menglong Dong,

Probably I am missing something terribly obvious,
but I am confused about the types used here.

The type of reason is enum skb_drop_reason.
For which, which on my system, the compiler uses an unsigned entity.
i.e. it is an unsigned integer.

But tcp_ack returns a (signed) int. And below reason is checked
for values less than zero, and negated. This doesn't seem right.

>  
> -	if (!acceptable) {
> +	if (reason <= 0) {
>  		if (sk->sk_state == TCP_SYN_RECV)
>  			return 1;	/* send one RST */
> -		tcp_send_challenge_ack(sk);
> -		SKB_DR_SET(reason, TCP_OLD_ACK);
> -		goto discard;
> +		/* accept old ack during closing */
> +		if (reason < 0) {
> +			tcp_send_challenge_ack(sk);
> +			reason = -reason;
> +			goto discard;
> +		}
>  	}
> +	SKB_DR_SET(reason, NOT_SPECIFIED);
>  	switch (sk->sk_state) {
>  	case TCP_SYN_RECV:
>  		tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp_ack */
> -- 
> 2.39.2
> 

