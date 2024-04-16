Return-Path: <linux-kernel+bounces-146111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EDF8A60D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BFE282BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5410A0A;
	Tue, 16 Apr 2024 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I3jTKg0J"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF76AB9;
	Tue, 16 Apr 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233739; cv=none; b=Ja/NvWke/CxnU1JQbAuviw2p3ZwmWjZMKsuznpJW4yxrEU/g89zwyY9788IybnjYBU6GGJkdU/eDOhRgafto9dnNXtd4NIHkC9P93p5Ox3fvMcFPYA1/AezGravgJwtJoSAFlwfxnyhGC/4Rn731Y9xXSDFj9RaYPR77GDfEZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233739; c=relaxed/simple;
	bh=M+wwQmoj9wuZNZd03g/cTlUpWrAdQP5uv73jgzPsryo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMjlVrkuvMZmcVigLhCgzUj+aRuu2NDTGYy+50jhv7KapicWMlwTIXbUnFZamGhLNu1jIveemFzIaVC4Vfr1VVi10rOeEIMkNQZT5tsggQXBzrr9un1gHiBR0BVt7xnvHSzTIDy4LzvwQv1XpKImCgAfhCWLt7RGAfeLxGBlX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I3jTKg0J; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713233733; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=EESeKY/2yO7IjB+fY3Jic74ae6X1hFCE6UgR8Wk3Mn8=;
	b=I3jTKg0JrPWi/mGe7J0GFxpOYA6UPpxf4jQDHlHh3s6OrF8zYCUVrFHRZTaPuqXBySQm42C0Js5j7fIOOcAzBkYUiX/2Af67Q42D5x39xZknBkxRM/H//4W4jNl/sM3w1gaZbo0UTgN99RR2iORcu19+5FCHwUdsBkK7p1QKT8g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W4fjcQS_1713233731;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0W4fjcQS_1713233731)
          by smtp.aliyun-inc.com;
          Tue, 16 Apr 2024 10:15:32 +0800
Date: Tue, 16 Apr 2024 10:15:29 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Yewon Choi <woni9911@gmail.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dae R. Jeong" <threeearcat@gmail.com>
Subject: Re: net/smc: Buggy reordering scenario in smc socket
Message-ID: <Zh3fQUstAYV5UGrz@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <Zh0JLYHtd0i416XO@libra05>
 <CAFgxCDwA8Lv8LLwEpJur3FKs=Gkkc0KE=bx7Q1Do2+iwdAzoCw@mail.gmail.com>
 <Zh0Mpr5fZqFUGzkb@libra05>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh0Mpr5fZqFUGzkb@libra05>

On Mon, Apr 15, 2024 at 08:16:54PM +0900, Yewon Choi wrote:
> 
> On Mon, Apr 15, 2024 at 8:02 PM Yewon Choi <woni9911@gmail.com> wrote:
> > Hello,
> > we suspect some buggy scenario due to memory reordering in concurrent
> > execution
> > of setsockopt() and sendmmsg().
> >
> > (CPU 1) setsockopt():
> >     case TCP_FASTOPEN_NO_COOKIE:
> >         ...
> >         smc_switch_to_fallback():
> >             clcsock->file = sk.sk_socket->file; // (1)
> >             clcsock->file->private_data = clcsock; // (2)
> >
> > (CPU 2) __sys_sendmmsg():
> >     sockfd_lookup_light():
> >         sock_from_file():
> >             sock = file->private_data; // (3)
> >     ...
> >     fput_light(sock->file, fput_needed): // (4)
> >         fput():
> >             refcount_dec_and_test(sock->file->f_count) // null-ptr-deref
> >
> > There is no memory barrier between (1) and (2), so (1) might be reordered
> > after
> > (2) is written to memory. Then, execution order can be (2)->(3)->(4)->(1)
> > and (4) will read uninitialized value which may cause system crash.
> >
> >
> > This kind of reordering may happen in smc_ulp_init():
> >
> > (CPU 1) smc_ulp_init():
> >     ...
> >     smcsock->file = tcp->file; // (5)
> >         smcsock->file->private_data = smcsock; // (6)
> >
> > Execution order can be (6)->(3)->(4)->(5), showing same symptom as above.
> >
> >
> > One possible solution seems to be adding release semantic in (2) and (6).
> >
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index 4b52b3b159c0..37c23ef3e2d5 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -921,7 +921,7 @@ static int smc_switch_to_fallback(struct smc_sock
> > *smc, int reason_code)
> >         trace_smc_switch_to_fallback(smc, reason_code);
> >         if (smc->sk.sk_socket && smc->sk.sk_socket->file) {
> >                 smc->clcsock->file = smc->sk.sk_socket->file;
> > -               smc->clcsock->file->private_data = smc->clcsock;
> > +               smp_store_release(&smc->clcsock->file->private_data,
> > smc->clcsock);
> >                 smc->clcsock->wq.fasync_list =
> >                         smc->sk.sk_socket->wq.fasync_list;
> >                 smc->sk.sk_socket->wq.fasync_list = NULL;
> > @@ -3410,7 +3410,7 @@ static int smc_ulp_init(struct sock *sk)
> >
> >         /* replace tcp socket to smc */
> >         smcsock->file = tcp->file;
> > -       smcsock->file->private_data = smcsock;
> > +       smp_store_release(&smcsock->file->private_data, smcsock);
> >         smcsock->file->f_inode = SOCK_INODE(smcsock); /* replace inode
> > when sock_close */
> >         smcsock->file->f_path.dentry->d_inode = SOCK_INODE(smcsock); /*
> > dput() in __fput */
> >         tcp->file = NULL;
> >
> > I think we don't need memory barrier between (3) and (4) because there are
> > critical section between (3) and (4), so lock(lock_sock/release_sock) will
> > do this.
> >
> >
> > Could you check these? If confirmed to be a bug, we will send a patch.
> >
> > Best Regards,
> > Yewon Choi
> >
> 
> Additionally, we found that below line (1) in smc_ulp_init() triggers 
> kernel panic even when normaly executed. 
> 
> smc_ulp_init():
>     ...
>     tcp->file = NULL; // (1)
> 
> It can be triggered by simple system calls: 
>     int sk = socket(0xa, 0x1, 0)
>     setsockopt(sk, 0x6, 0x1f, "smc", sizeof("smc"))
> 

SMC ULP isn't as widely used as we had hoped, because it has some
potential race conditions when interacting with files. Thanks for your
findings, and I will remove this ULP once its alternative solution,
eBPF with IPROTO_SMC proposal, is sent out. For now, it should be
considered as deprecated.

For the two scenarios above, I'll go over them.

Thanks,
Tony Lu

