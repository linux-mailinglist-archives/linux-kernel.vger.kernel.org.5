Return-Path: <linux-kernel+bounces-68231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 746238577A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FA71C2100A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665B0182D8;
	Fri, 16 Feb 2024 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKTiPsEA"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7479175A9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071797; cv=none; b=sGU38INnmZmOYrZEYIFp0Yuve95k8L+jY2IdEEdvIE9iEv6mAKtAMLejWtYxtUMoFodaBLYxj5YWw+jvBQmAEn3K2A7DGp6bZG2g1FHlLD00ezHA2DuzBG24Z+sIOsSH+5W0G8R7SITlNSszsgJ+4DUx63c6pzlr3KRDoSJeb9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071797; c=relaxed/simple;
	bh=fUUn6AnMvlCd1xQgv5EKb346fzCDc72nsHuZzfqrAhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akpl7OYqm2Zl/15jvnHw3M9LEl4fCjN5ECRobuuCumFwmansvzgPXyC/68JvTOFZsU4TK6tHuiFE/rAzaR3GLBvY6i2ohwDTl+OWWrjKS76AyuTHE84RHNbTC6OY7jOhvJ2i/mDd2dBcmE3Z5U5D3VbEnUQRAuruIwwbzkHa/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKTiPsEA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563dfa4ccdcso5203a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708071794; x=1708676594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUUn6AnMvlCd1xQgv5EKb346fzCDc72nsHuZzfqrAhM=;
        b=vKTiPsEAlEEw4fx+SzsjM3g6IsBM/1Dvs4UsDCpkRF18Ya+AN++4NpvYqVEo9MVZ/Q
         hFJ9aqj5tne7p3wjSfLkWnP4GzTYu2Z+TnfCj+DXZYnxDj8lO8uDACvlrIs0593IQDCU
         9W3/K/Qs5dV3G6oBq4Ns2yD+eQDQ5b3WRPh9eX+NVoe+wdlakA5HwJE3tTjxj/uqA32L
         paFtZ+1TrL5zr4Irb9m1x58n0OMIdULt7+/EZDKmtLWGFe+ntw+SX3NiI8NcAwUc4zrw
         qSBCAqOSE6b8BooFKMz6y1jwLj2/bl/xbhIdG8vI2CRbWjm+hA9wZLD4eW1i0tUvsQkI
         pTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071794; x=1708676594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUUn6AnMvlCd1xQgv5EKb346fzCDc72nsHuZzfqrAhM=;
        b=gTBnBN12QIBP+ycbe1lqTrlPN718HRea7MMuVUJdh8zfF/6wysQWDMBgIksBsuJDMv
         fyzXbr1dnDfh2fUBdOSoBsPd1LomW1pn9+Im1I7YSYlAn7TdlFRYBWIHe8qwbWTLiH2v
         ZitVurKyAfzUDp43OMZHynZXRXt3o4TZlfRdgnbwab8aQbPxzcb0891fYtHyVgFTyLKy
         UKPqka5TXUjq2ITQ1V8unQwS9If96fkwL2BG2jIOgSiE62d4B250Dqo2HbvD1Mjg5AIj
         OPqQKfPzslQfsM3EYhawA9KWSZN9C5Dg4g8j/HpYfAstuu+tT4ZwWfnDA5XsTv2mVcF5
         eqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaZWHwx4VNLKYRPo9eXW6P81mz+ETi4c6l3dPFHTnxsKOiWlEtauaUK5XvsS/MHmanN0tux4ZCLKolpQP7D/r9j6tByUNzlS+CC12j
X-Gm-Message-State: AOJu0YwTY5H1ufXG1y4hlu/CvblErGD8fog585QKIpQ9YhA2t8pBN1ta
	VXB+X7qJ1iBeaLO+QixDtJF9g5k75YUr9CJaR4OFIg5BdNXckM/B1ywJ+fPtmqJfSBWKasrijth
	Xi/J8nWeMKs5jxQL/8afPbDJfEBM7nHQMV5GY
X-Google-Smtp-Source: AGHT+IG1QaSo/SWZpMQwRSx5xsZV5+mFf4z/pSJbIJII2nQ9E44C3wuuDXCC6XbcQpq3b9IZr10OXvVAvpJ8usiMmIk=
X-Received: by 2002:a50:cd8c:0:b0:562:70d:758 with SMTP id p12-20020a50cd8c000000b00562070d0758mr130337edi.2.1708071793909;
 Fri, 16 Feb 2024 00:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-7-tj@kernel.org>
 <Zc7zLsEhDzGkCH9m@slm.duckdns.org>
In-Reply-To: <Zc7zLsEhDzGkCH9m@slm.duckdns.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 09:23:00 +0100
Message-ID: <CANn89iKDsJPY=QQrTHK0Jw=s=A_G_GzcOA0WsqXaytWAVV3R4Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] net: tcp: tsq: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, allen.lkml@gmail.com, kernel-team@meta.com, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Wei <davidhwei@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 6:31=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Jan 29, 2024 at 11:11:53PM -1000, Tejun Heo wrote:
> > The only generic interface to execute asynchronously in the BH context =
is
> > tasklet; however, it's marked deprecated and has some design flaws. To
> > replace tasklets, BH workqueue support was recently added. A BH workque=
ue
> > behaves similarly to regular workqueues except that the queued work ite=
ms
> > are executed in the BH context.
> >
> > This patch converts TCP Small Queues implementation from tasklet to BH
> > workqueue.
> >
> > Semantically, this is an equivalent conversion and there shouldn't be a=
ny
> > user-visible behavior changes. While workqueue's queueing and execution
> > paths are a bit heavier than tasklet's, unless the work item is being q=
ueued
> > every packet, the difference hopefully shouldn't matter.
> >
> > My experience with the networking stack is very limited and this patch
> > definitely needs attention from someone who actually understands networ=
king.
>
> On Jakub's recommendation, I asked David Wei to perform production memcac=
he
> benchmark on the backported conversion patch. There was no discernible
> difference before and after. Given that this is likely as hot as it gets =
for
> the path on a real workloal, the conversions shouldn't hopefully be
> noticeable in terms of performance impact.
>
> Jakub, I'd really appreciate if you could ack. David, would it be okay if=
 I
> add your Tested-by?

I presume memcache benchmark is using small RPC ?

TSQ matters for high BDP, and is very time sensitive.

Things like slow TX completions (firing from napi poll, BH context)
can hurt TSQ.

If we add on top of these slow TX completions, an additional work
queue overhead, I really am not sure...

I would recommend tests with pfifo_fast qdisc (not FQ which has a
special override for TSQ limits)

Eventually we could add in TCP a measure of the time lost because of
TSQ, regardless of the kick implementation (tasklet or workqueue).
Measuring the delay between when a tcp socket got tcp_wfree approval
to deliver more packets, and time it finally delivered these packets
could be implemented with a bpftrace program.

