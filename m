Return-Path: <linux-kernel+bounces-85859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3686BC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDAD1C223DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F5476EE6;
	Wed, 28 Feb 2024 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b/WtlF+/"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EFE72921
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164427; cv=none; b=ISkIXE2nRh2BLa12d3B8ULK/LUwd9DejUi3Ydwebv/lXeL9+trtwgaBUs0NQYfewMKQiITCBxbVnl6P1/y7MihU/25IL86mgGssnWDOWvOk9mTEgMClK6eNC+nKey3IVZMdR+GFyKIsB4k/FbB6bKyTnkl0sIUI17RlCh3PhVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164427; c=relaxed/simple;
	bh=226C5h/Y1VCHHH/6rHYwB8j04u2Bj9Ng00Ye5vrzpe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtjobTTusCylTWEzEvq9uAEspC20J/tCEdlhZ6kPIKadqL/wBSOiQj9X4gmszQvWKmxna+Snc2AHA3WabZp2RNxzgXMRyfW69DtSbMt+VFrU/wA84SbLTC4ACfAzsr70nRY0rPEOO1bOmjF5nQIFTZO9tSNczzJHehEKm+BHlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b/WtlF+/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so487681a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709164424; x=1709769224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyTb/9u8Fut3XJA7s5sTKjASpumq9GMF8lzH2f5O968=;
        b=b/WtlF+/cAuvq6M20JXmWz8A2nkQptPjwcnBQLZkV9kPBbnAW24f9bgh5o9TXc7veb
         a3eOi5yMNeZ0hOuCQ3ljUOEqMjHWtp6/ScFlSp1ToC/hhPIiGktWzjz7Pdv3WAnYcinj
         eCck83VpNb35lad8kW5Mqhr9VE5ZFzNOGWHUFbs76XLAQrQEScmGNMXDAz+j8u5YGIHO
         R56D/9Cp+0iznOPm3kXRtfJh9YHYZhdss1n9vCIoVe4M5ivBNkgV0HDZyaRPF1N6UCFS
         E9MKOTH213WGU0/R421/tyAuYheLu49B136cC2wpkd/ARaWY9L02tzb2vCoR9xRlVYaa
         4uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164424; x=1709769224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyTb/9u8Fut3XJA7s5sTKjASpumq9GMF8lzH2f5O968=;
        b=OY9EeuBOSB7G+msaIUoICABH0vp+6H448nA1x9JSIRPJVePJTphYowpjZ5v4u43b6N
         ebGKiHF8yIZop4xmfE/hFHKTP0H26g7ZLWO737iGA4nDHXqBB51wp8a4dqcnZTNqWo97
         U6WVcnrIrwOETiiG9YfDLocB9MPwGsx1Sd986ehd7v0RCF1ePQNp1Lu53V1EcvNl04Bg
         wrQ2bdUYDxgfWx1pu6Xf78vIZYR/NdroloYcubY1vVYAD8v+BXC0OjgfYt32GgSG/fM7
         QhRcSttELBcQ0rwZHS4C6g2GuY2VCkk0niZ8sLpa7VGVrhL/JKlScKWlhV5wgdjgdasP
         4Srg==
X-Forwarded-Encrypted: i=1; AJvYcCXjI5eElIRhPxDO5S2CcgkyPfTcAv8XX3AUvuUQnLX9lQuQAsIVtqm6NzelaunLB7tTDbMvhjmp83khqWDa5SqTwuEAAC19mt+QmncE
X-Gm-Message-State: AOJu0YyPyZ4Vt3G+eMlrdKLhXqixqHLpbm6q5AeL6aSUFJC/VJp27/vx
	5e0oHmxektayyHzuOMNriDyLKPfKALlW5yOikU9ywG8r76+Fo4J3PxWc8GDWJzoWctj0CnrlX5z
	bAEDtfRAnVK7tHUnYZtWyqYd3nHbfrWCEoX4i5Q==
X-Google-Smtp-Source: AGHT+IFWoAzwjRhf4ZRQtooisu3O7UmB386nUInSxafRbB0jMnEpyJq60SxptGuNyafKn0Mhr6ixAk9Zq1h7yoTNCaY=
X-Received: by 2002:a05:6402:b57:b0:566:414d:d724 with SMTP id
 bx23-20020a0564020b5700b00566414dd724mr253144edb.35.1709164424445; Wed, 28
 Feb 2024 15:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
In-Reply-To: <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 28 Feb 2024 17:53:33 -0600
Message-ID: <CAO3-Pbq4Fybyhodv5-36U=-rgttkjxFj6cRvAGcapvE8pZyWSQ@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Feb 27, 2024 at 10:44=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Hmm....
> Why napi_busy_loop() does not have a similar problem ?
>
I just tried and can reproduce similar behavior on sk busy poll.
However, the interesting thing is, this can happen if I set a super
high polling interval but just send rare packets. In my case I had a 5
sec polling interval (unlikely to be realistic in prod but just for
demonstration), then used nc to send a few packets. Here is what
bpftrace react:

Normal:
time sudo bpftrace -e 'kfunc:napi_busy_loop{@=3Dcount();}
interval:s:1{exit();} kfunc:udp_recvmsg {printf("%ld\n",
args->sk->sk_ll_usec);}'
Attaching 3 probes...

@: 0

real    0m1.527s
user    0m0.073s
sys     0m0.128s


Extra wait when polling:
time sudo bpftrace -e 'kfunc:napi_busy_loop{@=3Dcount();}
interval:s:1{exit();} kfunc:udp_recvmsg {printf("%ld\n",
args->sk->sk_ll_usec);}'
Attaching 3 probes...
5000000


@: 16

real    0m11.167s
user    0m0.070s
sys     0m0.120s

So the symptoms are the same, bpftrace cannot exit despite having an
1sec timeout. But the execution pattern for these two are probably
different: NAPI threads would keep polling by itself, whereas sk poll
program might only poll when there is no immediate data. When there
are packets, it switches to process packets instead of polling any
more.


Yan

