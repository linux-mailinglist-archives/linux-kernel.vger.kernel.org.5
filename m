Return-Path: <linux-kernel+bounces-93776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A4A873464
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945812805FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA2605AD;
	Wed,  6 Mar 2024 10:36:42 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E22604D7;
	Wed,  6 Mar 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721401; cv=none; b=vCeQ9ZY2sjOJe4l+E1R1zn84rr5e/3ARZ8EEZh/Hb7Lp2qK4rYl/haqGPT4yI/iqqzCt7i/xx9i/xfVwWcOf4YEMS+9zcjBRYI+Zoxcseix3VlRNGYgyeFquQou806Mw4NuZLWVd68CJ89t3vA3DDLsMdp6ZSEEfmQxVtpLw+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721401; c=relaxed/simple;
	bh=N6jX8ADXXK5aXnOAfJU8uWTNWIUA6GVIw/zP4wxmiGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvi5KTf9l4mIYsfvkG37vw6JfpysY1raBQgOMe4z6KcH/Ow8VRS40Kixvs7PC8NOQqnfR7CnLL7NlP98Ldh0Ww0/RrjIckBg37ns1FwdOW0DctreJGDjiEHuJxrDZh4awBikJ4cL9gwc15Gxo2NfphUPqLU4AKIC88/6BnshDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rhodU-0005vI-29; Wed, 06 Mar 2024 11:36:32 +0100
Date: Wed, 6 Mar 2024 11:36:32 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: xingwei lee <xrivendell7@gmail.com>, Florian Westphal <fw@strlen.de>,
	pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, ralf@linux-mips.org,
	syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com
Subject: Re: KASAN: slab-use-after-free Read in ip_finish_output
Message-ID: <20240306103632.GC4420@breakpoint.cc>
References: <CABOYnLwtfAxS7WoMw-1_uxVe3EYajXRuzZfwaQEk0+7m6-B+ug@mail.gmail.com>
 <CANn89i+qLwyPLztPt6Mavjimyv0H_UihVVNfJXWLjcwrqOudTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+qLwyPLztPt6Mavjimyv0H_UihVVNfJXWLjcwrqOudTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> On Wed, Mar 6, 2024 at 11:00 AM xingwei lee <xrivendell7@gmail.com> wrote:
> >
> > Hello, I found a new bug titled "KASAN: slab-use-after-free Read in
> > ip_finish_output” or “KASAN: slab-use-after-free in sk_to_full_sk" and
> > confirmed it in the latest net and net-next branch. After my simple
> > analysis, it may be related to the net/rose or AF_PACKET/PF_PACKET
> > socket.
> 
> I already had a syzbot report for this issue, thanks.
> 
> Adding Florian to the discussion.
> The issue is cause by ip defrag layer, which calls skb_orphan()
> These were my notes, I had little time to work on it so far.

> Calling ip_defrag() in output path is also implying skb_orphan(),
> which is buggy because output path relies on sk not disappearing.

Ugh.  Thanks for your annotations and notes, this is very helpful.

ipvlan (and two spots in ip_output.c do):

   err = ip_local_out(net, skb->sk, skb);

so skb->sk gets propagated down to __ip_finish_output(), long
after connrack defrag has called skb_orphan().

No idea yet how to fix it,

