Return-Path: <linux-kernel+bounces-100283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A1B8794FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB5AB237A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456F67A700;
	Tue, 12 Mar 2024 13:21:19 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D568978298;
	Tue, 12 Mar 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249678; cv=none; b=BE/4ELeI8hoBFILnLYOwIrsMsZVzkJGznBUSS0wPLK28PFG1jxCnLF3S5ISoXHmTi54gSnFTBIMIDbVo5MxZIXP39PTuqXmkfNdcPeu+VS46MDMc2sFERTGx96D2eYZaeW7+mW/1meNuRPcLA+ohO6tAODlf9G7X9df4FyaHE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249678; c=relaxed/simple;
	bh=tjDje4SaiRrTQc6DecP8S8++V0lhjuccYXfYjHPoXJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuyC212idw5D8h1B3UrFb+RQuHz9n4TpiOntvkEivL2GcrxZ20mM7kKKal6cp7my0JNfdkpOrOD9rg6oB8oHWediZ2gDRjxShdBzgayQS+dUw8pRGeq1bzUynXDEoM1SGl6/C/v+jt+7SNYT0PT98xxhCBeyoVqUb4Bx2XLSInk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rk243-00010Z-Qy; Tue, 12 Mar 2024 14:21:07 +0100
Date: Tue, 12 Mar 2024 14:21:07 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>, xingwei lee <xrivendell7@gmail.com>,
	pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, ralf@linux-mips.org,
	syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com
Subject: Re: KASAN: slab-use-after-free Read in ip_finish_output
Message-ID: <20240312132107.GA1529@breakpoint.cc>
References: <CABOYnLwtfAxS7WoMw-1_uxVe3EYajXRuzZfwaQEk0+7m6-B+ug@mail.gmail.com>
 <CANn89i+qLwyPLztPt6Mavjimyv0H_UihVVNfJXWLjcwrqOudTw@mail.gmail.com>
 <20240306103632.GC4420@breakpoint.cc>
 <CANn89iLe0KGjbSim5Qxxr6o0AjJVs7-h79UvMMXKOgGKQUosiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLe0KGjbSim5Qxxr6o0AjJVs7-h79UvMMXKOgGKQUosiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> > so skb->sk gets propagated down to __ip_finish_output(), long
> > after connrack defrag has called skb_orphan().
> >
> > No idea yet how to fix it,
> 
> My plan was to refine "inet: frag: Always orphan skbs inside
> ip_defrag()" and only do the skb_orphan()
> for skb added to a frag_list.
> 
> The head skb would keep a reference to the socket.

I tried to follow this but its beyond my abilities.

Defrag messes with skb->truesize, and I do not know how to
fix that up safely so later calls to destructor won't underflow sk
accouting.

Furthermore, depending on delivery order, the skb that gets
passed to rest of stack might not be the head skb (the one with
full l4 header and sk reference), its always the last one that arrived.

Existing code skb_morphs() this, see inet_frag_reasm_prepare() and also
the ->truesize munging (which is fine only because all skbs are
orphans...).

So in order to not pass already-released sk to inet output somehow
the skb->sk reference needs to be stolen and moved from one sk
to another.

No idea how to do this, let alone do regression testing for this.
see e.g. 48cac18ecf1de82f76259a54402c3adb7839ad01 which added
unconditional orphaning in ipv6 netfilter defrag.

ATM the only "solution" I see is to completely remove netfilter defrag
support for outgoing packets.

