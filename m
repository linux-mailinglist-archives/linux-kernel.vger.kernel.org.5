Return-Path: <linux-kernel+bounces-76503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60F85F808
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2621F248AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D6E60B8F;
	Thu, 22 Feb 2024 12:23:40 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986C42078;
	Thu, 22 Feb 2024 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604619; cv=none; b=Prbo7c2t6tcmSb5WVzmn71tS0NshT+DvYPcZDyzT0lYaZuqjj2SW/OH3q0MFp/qz7eus2kuOpC2B+O3GstTj0ycs/TKCdQM0ypWGzW4EDEVDiT7N9y531RPcXqrlgk1VnXRERnVJUNZGnlmGmyO/qGUOaq25hoZc2w4UMT4r3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604619; c=relaxed/simple;
	bh=C0iGDiSKm0ByGpcZYHuUMuTk1uqfOg/gu4wVjipraFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaDyQbcCCBJetycSbPalPMbC5GF9B3XgXaFagnTsDpOqSWE0rcUmbdQ3oFpAJED419MnZV9oLR/AfskJ74ucIJ3BeRy5l559XVA4afGq+U/s9DPOsm3wqNUXAX/JxUhPEZuXC+hjvNwam3sa6WxW/pOwJDjgGFCn8RRsSa5AXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rd86n-0004gm-0F; Thu, 22 Feb 2024 13:23:25 +0100
Date: Thu, 22 Feb 2024 13:23:24 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>,
	syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>,
	davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in mpls_gso_segment
Message-ID: <20240222122324.GB28098@breakpoint.cc>
References: <00000000000043b1310611e388aa@google.com>
 <20240221131546.GE15988@breakpoint.cc>
 <CANn89iK_D+v2J7Ftg1W6-zn7KSZajwWVzfetSdrBPM6f_Zg80A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iK_D+v2J7Ftg1W6-zn7KSZajwWVzfetSdrBPM6f_Zg80A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> I guess we should try this, or perhaps understand why
> skb->encapsulation might not be set,
> or why skb_inner_network_header(skb) is not set at this point.

syz repro injects data via packet socket, skb passed down stack
has ->protocol set to NSH (0x894f), gso type is SKB_GSO_UDP | SKB_GSO_DODGY.

This gets passed down to skb_mac_gso_segment(), which sees NSH as ptype
callback.

nsh_gso_segment() retrieves next type:

        proto = tun_p_to_eth_p(nsh_hdr(skb)->np);

.. which is mpls (TUN_P_MPLS_UC), it then updates
skb->protocol.  This calls back into skb_mac_gso_segment() which
sees MPLS as ptype callback, we then end up in mpls_gso_segment()
without any inner headers set (skb->encapsulation is not set,
inner header offsets are 0) and mpls_gso_segment() attempts to pull
negative header size off the skb.

I don't see anything that could be done earlier in the stack about this.

As far as I understand NSH assumes its only called from openvswitch
and MPLS GSO code only via Openvswitch or mpls_iptunnel, but its
reachable by other means.

But skb_mac_gso_segment() doesn't have any info on the originator
to know if it can call into nsh or mpls 'as intended'.

So I'd guess best solution is to explicitly check for negative
header size, plus a comment that explains how this could happen.

