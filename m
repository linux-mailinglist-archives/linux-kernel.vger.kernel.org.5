Return-Path: <linux-kernel+bounces-25944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85B82D8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8D5282A29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7D72C69B;
	Mon, 15 Jan 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgbiphD0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5C1E865;
	Mon, 15 Jan 2024 11:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F2EC433C7;
	Mon, 15 Jan 2024 11:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705319925;
	bh=rAzO/EbAjp/RyapW0byiwCjRX0nFnY82gnHGAzPPPos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgbiphD0IcbgJG+qVE73R65/MPGiT5oH4pY9nHEdFNrJ/B1YENiz50WUwj82bcC8Q
	 m+d3vkxXpDemGgesnLkobL4u7XZlmBHFsHFsc0WQRKm1PWZ/GdZ6S6n2rAOYkN8txk
	 ADYyqM+Ujw9kY8bWk/w0ha/GTdG/BAg5eNnbKFMZNf9e9pk1c/UWMelLT3h0HKr9Pi
	 YGItqc6m+w3BhuPv67siyXW+25KV6LTNw/ycldehMxW3FF5IQWm14WCcNtAzkTkmPA
	 rPAd2h/bO2zIVxeIvXLTjoNtaYq1/dzr7qJT9Xg1eaJ9rkVsrHA5QZuXKKopnGS1i6
	 CbSzqREnrhokA==
Date: Mon, 15 Jan 2024 11:58:41 +0000
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] net: tcp: accept old ack during closing
Message-ID: <20240115115841.GS392144@kernel.org>
References: <20240112094603.23706-1-menglong8.dong@gmail.com>
 <20240113154632.GI392144@kernel.org>
 <CADxym3a6qNcb47R_DfXMsac9Ou_zkz5hR3bGY9tr7Jhsdw3y-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADxym3a6qNcb47R_DfXMsac9Ou_zkz5hR3bGY9tr7Jhsdw3y-Q@mail.gmail.com>

On Mon, Jan 15, 2024 at 10:40:56AM +0800, Menglong Dong wrote:
> On Sat, Jan 13, 2024 at 11:46 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Jan 12, 2024 at 05:46:03PM +0800, Menglong Dong wrote:
> > > For now, the packet with an old ack is not accepted if we are in
> > > FIN_WAIT1 state, which can cause retransmission. Taking the following
> > > case as an example:
> > >
> > >     Client                               Server
> > >       |                                    |
> > >   FIN_WAIT1(Send FIN, seq=10)          FIN_WAIT1(Send FIN, seq=20, ack=10)
> > >       |                                    |
> > >       |                                Send ACK(seq=21, ack=11)
> > >    Recv ACK(seq=21, ack=11)
> > >       |
> > >    Recv FIN(seq=20, ack=10)
> > >
> > > In the case above, simultaneous close is happening, and the FIN and ACK
> > > packet that send from the server is out of order. Then, the FIN will be
> > > dropped by the client, as it has an old ack. Then, the server has to
> > > retransmit the FIN, which can cause delay if the server has set the
> > > SO_LINGER on the socket.
> > >
> > > Old ack is accepted in the ESTABLISHED and TIME_WAIT state, and I think
> > > it should be better to keep the same logic.
> > >
> > > In this commit, we accept old ack in FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_ACK
> > > states. Maybe we should limit it to FIN_WAIT1 for now?
> > >
> > > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > > ---
> > > v2:
> > > - fix the compiling error
> > > ---
> > >  net/ipv4/tcp_input.c | 18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index df7b13f0e5e0..70642bb08f3a 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -6699,17 +6699,21 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
> > >               return 0;
> > >
> > >       /* step 5: check the ACK field */
> > > -     acceptable = tcp_ack(sk, skb, FLAG_SLOWPATH |
> > > -                                   FLAG_UPDATE_TS_RECENT |
> > > -                                   FLAG_NO_CHALLENGE_ACK) > 0;
> > > +     reason = tcp_ack(sk, skb, FLAG_SLOWPATH |
> > > +                               FLAG_UPDATE_TS_RECENT |
> > > +                               FLAG_NO_CHALLENGE_ACK);
> >
> > Hi Menglong Dong,
> >
> > Probably I am missing something terribly obvious,
> > but I am confused about the types used here.
> >
> > The type of reason is enum skb_drop_reason.
> > For which, which on my system, the compiler uses an unsigned entity.
> > i.e. it is an unsigned integer.
> >
> > But tcp_ack returns a (signed) int. And below reason is checked
> > for values less than zero, and negated. This doesn't seem right.
> >
> 
> Hello! You are right, and it seems that I make the same
> mistake with Eric in this commit:
> 
> 843f77407eeb ("tcp: fix signed/unsigned comparison")
> 
> I should convert it to signed int before comparing it
> like this:
> 
>   if ((int)reason <= 0) {
>       ......
>       if ((int)reason < 0) {
>           ....
>       }
>   }

Thanks. FWIIW, I would probably assign the unsigned value to an unsigned
local variable.

..

