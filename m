Return-Path: <linux-kernel+bounces-103172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B987BBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B627FB2376C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E926EB6D;
	Thu, 14 Mar 2024 11:27:02 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA86CDD7;
	Thu, 14 Mar 2024 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415622; cv=none; b=os1C0NkHzNlZD9wv8TGK4Eebzaq/5JEJVNk+h5pW5H/yp+K3bTOO/JPljDpGtN+jjOQArr9Hdligy6oI+kZHliaKTDPBfxQavb7Bfk8jowwLr9h/RgomdZFA+2RgQeLCjGdnOWtsogOBP6DxDcCzsxPib85J9yhpp5ACm5sRPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415622; c=relaxed/simple;
	bh=Pfd2z0WcwpHP46x04wMSW5dBhXIY/2MfqS+g3TP/9Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0yTYRQjtnfHshBti3p29+hm67Q7rnfREn8V0Ng3wLYNOe0l5pTvTyKlFJdi8ZIBzpolVeKLwX1G8aRa0VRth8yUT3mmejFUug8GtoKq5TfmfSzwbAUGNqApoR4m5uU184SG18jOIprov+aQyyQbEdNhUWQg2qkttSdFhd/WpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rkjEZ-0006nC-0U; Thu, 14 Mar 2024 12:26:51 +0100
Date: Thu, 14 Mar 2024 12:26:50 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>, xingwei lee <xrivendell7@gmail.com>,
	pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, ralf@linux-mips.org,
	syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com
Subject: Re: KASAN: slab-use-after-free Read in ip_finish_output
Message-ID: <20240314112650.GE1038@breakpoint.cc>
References: <CABOYnLwtfAxS7WoMw-1_uxVe3EYajXRuzZfwaQEk0+7m6-B+ug@mail.gmail.com>
 <CANn89i+qLwyPLztPt6Mavjimyv0H_UihVVNfJXWLjcwrqOudTw@mail.gmail.com>
 <20240306103632.GC4420@breakpoint.cc>
 <CANn89iLe0KGjbSim5Qxxr6o0AjJVs7-h79UvMMXKOgGKQUosiA@mail.gmail.com>
 <20240312132107.GA1529@breakpoint.cc>
 <CANn89iLkDwnZdBY8CwkrQwCk2o7EAM9J1sv+uxU1tjKb=VB=Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLkDwnZdBY8CwkrQwCk2o7EAM9J1sv+uxU1tjKb=VB=Ag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> Thanks for taking a look Florian.
> 
> Perhaps not messing with truesize at all would help ?
>
> Something based on this POC :
> 
>                 spin_lock(&qp->q.lock);
> +               if (!qp->q.sk) {
> +                       struct sock *sk = skb->sk;
> 
> +                       if (sk && refcount_inc_not_zero(&sk->sk_refcnt))
> +                               qp->q.sk = sk;

Unfortunetely I did not get this to work.

sk_refcnt is 0.  sk is kept alive by sock_wfree destructor.

I don't know how to recover from this, refcnt cannot be "repaired"
anymore.

I could artificially inflate sk_wmem counter by 1, to prevent release,
but that needs yet another sock_wfree-like destructor.

I'm already not sure how this existing scheme works, there are
multiple places that check for skb->destructor == sock_wfree,
yet we have is_skb_wmem helper that checks __sock_wfree and tcp_wfree.

Removing defrag from output seems like best option, but it will
surely break some scenarios.

Or, I could just fail reasm if sk refcount is already 0, that would
likely work too?

