Return-Path: <linux-kernel+bounces-74764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A04D785D93E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F17B1F21AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92378B7A;
	Wed, 21 Feb 2024 13:15:55 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6878B60;
	Wed, 21 Feb 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521355; cv=none; b=LZ6eCFlO+9SdULiFQAzN/dyiKqb+ZWb4cJ7wag5Gp76JGexSTEH+QNgBOQbfmCrfgDECS6cgVmxZ7IDxeR3kzWBmoLGcNS3tk4NnrKh8/dDR7TzpeldSeMxuARNwiOsw+liZwm7yO36wLGD0QGVQ8a7rabgTcH2xwNk5ir2m2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521355; c=relaxed/simple;
	bh=csrTnXvV6MEZd5krHl41/o+frbx1m3T+Us2ZFrByfR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flWWgFq0um5TMYOU8B8HH8NoZqu/iKuXNt5VQU63MSnubljHQoiaqWTYaJIX8/nCqtW7mNJcqCemdHXlLRDxWt2Y0pamPeSqFxYudFr3fGVepwyOp+/PQTYrIlUBgSpXI+mHuSJPjvcVc4NFiL7/u2Uw5lxdTC/Z17WY5vSSLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rcmRu-0004dD-P4; Wed, 21 Feb 2024 14:15:46 +0100
Date: Wed, 21 Feb 2024 14:15:46 +0100
From: Florian Westphal <fw@strlen.de>
To: syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	fw@strlen.de, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in mpls_gso_segment
Message-ID: <20240221131546.GE15988@breakpoint.cc>
References: <00000000000043b1310611e388aa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000043b1310611e388aa@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com> wrote:
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1536462c180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/adbf5d8e38d7/disk-49344462.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0f8e3fb78410/vmlinux-49344462.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/682f4814bf23/bzImage-49344462.xz
> 
> The issue was bisected to:
> 
> commit 219eee9c0d16f1b754a8b85275854ab17df0850a
> Author: Florian Westphal <fw@strlen.de>
> Date:   Fri Feb 16 11:36:57 2024 +0000
> 
>     net: skbuff: add overflow debug check to pull/push helpers
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13262752180000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a62752180000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17262752180000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com
> Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 pskb_may_pull_reason include/linux/skbuff.h:2723 [inline]
> WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 pskb_may_pull include/linux/skbuff.h:2739 [inline]
> WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 mpls_gso_segment+0x773/0xaa0 net/mpls/mpls_gso.c:34

Two possible solutions:

1.)

diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
index 533d082f0701..43801b78dd64 100644
--- a/net/mpls/mpls_gso.c
+++ b/net/mpls/mpls_gso.c
@@ -25,12 +25,13 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
        netdev_features_t mpls_features;
        u16 mac_len = skb->mac_len;
        __be16 mpls_protocol;
-       unsigned int mpls_hlen;
+       int mpls_hlen;
 
        skb_reset_network_header(skb);
        mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
-       if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
+       if (unlikely(mpls_hlen <= 0 || mpls_hlen % MPLS_HLEN))
                goto out;
+
        if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
                goto out;

(or a variation thereof).

2) revert the pskb_may_pull_reason change added in 219eee9c0d16f1b754a8 to
make it tolerant to "negative" (huge) may-pull requests again.

With above repro, skb_inner_network_header() yields 0, skb_network_header()
returns 108, so we "pskb_may_pull(skb, -108)))" which now triggers
DEBUG_NET_WARN_ON_ONCE() check.

Before blamed commit, this would make pskb_may_pull hit:

        if (unlikely(len > skb->len))
                return SKB_DROP_REASON_PKT_TOO_SMALL;

and mpls_gso_segment takes the 'goto out' label.

So question is really if we should fix this in mpls_gso (and possible others
that try to pull negative numbers...) or if we should legalize this, either by
adding explicit if (unlikely(len > INT_MAX)) test to pskb_may_pull_reason or
by adding a comment that negative 'len' numbers are expected to be caught by
the check vs. skb->len.

Opinions?

