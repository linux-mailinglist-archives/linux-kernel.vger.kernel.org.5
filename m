Return-Path: <linux-kernel+bounces-68759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0EA857FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3BE1F26BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA16012EBE6;
	Fri, 16 Feb 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLIJr1KR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFA12EBE9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094795; cv=none; b=l/OUNMzcCpvybpL+FRWb7ro3+6TWxGjANd9R3oVl0NLhqcVVXCqkZMF2NcTrabltzp3h/rrbKtWFGCkY+EDqVJQiYgcFEXkK4V32iVZWS2zSaL0iK91ZURHnGISUF6oEsVv0SPJM7qQ8aynyW8C0qZALnuagLbBdmrn+4/biJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094795; c=relaxed/simple;
	bh=kQgCQV2ejZAgL1RDEszT7XD1VAdbi09GHQNIRR3CH2Q=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCAEd3sipr2T8FnN5sxrZjkBV47MJSOVAU4srkBWvsTTF7XsJAdpv2l2A23KmGNBV+NgNNQQd3pIeyNwFtznzYYgB1F7fp92jJmv18R7Ekzm2iluhZwOi4eHdAxAf2owdym4aK7XGMvxfeI7NTIWaR9zU9YvEyqhwqiXbVNknLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLIJr1KR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708094792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQgCQV2ejZAgL1RDEszT7XD1VAdbi09GHQNIRR3CH2Q=;
	b=LLIJr1KRU4/Cj5vi/mXAw/1u8s0a1tNMd1A0eUF98tvnsFycf4jc9abcBLJmk0pVxIBhm+
	TiBdxeIodPwkppA8pYjXv/5ssqU6kqaiPV9zHvV2Y6MlRf4U2YBY1eN5jzHsDlBXkoYSYC
	rpBHVdvlljtJ4jBVv1r6kZwKAYRxnWc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-D98pZApUNg-B7XzCfL6qLA-1; Fri, 16 Feb 2024 09:46:30 -0500
X-MC-Unique: D98pZApUNg-B7XzCfL6qLA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56261857d31so1170327a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708094789; x=1708699589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kQgCQV2ejZAgL1RDEszT7XD1VAdbi09GHQNIRR3CH2Q=;
        b=fHxod7zW86+06cWMzvSH7+rglgmqcUEK29Z2+Z2Ivjgp9FR94qle+rBfxveqKI7ni6
         s+yBZ8PM+qrShxN4TN6oTs1bQgKK8ztupfjMEIyth5MkdRyGX/v/86ZUbrwEhr5DFEcG
         Jm3oB49ljyZpqed7rgYR0vIvVmgiSItBbUSGoLyfAf1qSJhkqpAh3WqfFSgi09+CoFtb
         f2tTSWMB47zG4p7ObdPINrM11h198VDeTI/vwsqK0sSJeDTXIiXo5+SyTToAhuwimCsi
         pXleFJTL6434aPJVDpV3D6l40Z3ULeVZkoluuq1lFahBE7lqXUGbOQ+mHZR16CqAWgTc
         la4w==
X-Forwarded-Encrypted: i=1; AJvYcCU6pM+sOmuke/xNL9gsuiuoqqLqduBYKgpkET4N3ZTWE1TVino2SLKiFUWZTqTxS6s+DtqYzi441Qywc1DoSGbn+8K3asE09cwYiuez
X-Gm-Message-State: AOJu0YwrQv9TfDDk6VJBgvAAUTN1vdE6aGXB0Zjs1BOyJ8pEt/CtyGF9
	DtA3xrKwXgbbB/3jDumwK8bSqScDspr0F8CsW69ZI1ICkOESJubxiQG6uoDoWEqCzot0nJG55Ju
	/mAhMibBoKiQIp8pbkJNh41i32vjLQ74qGpY/2+6ttK/tm6Kxm5cx40x5XihFU06KDbu0HCuKo/
	yg4ZIRaAGIPMME1fM3X8bKFQuqin/QE8exq5gYap8cGfod
X-Received: by 2002:aa7:c253:0:b0:562:12bf:eb04 with SMTP id y19-20020aa7c253000000b0056212bfeb04mr3657583edo.33.1708094789173;
        Fri, 16 Feb 2024 06:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtK6bnEwYShnAs2Wl18PE46X0x60j4EBbLcBRxntyiGnk+nOVjkJMoo4M9O7EbXMwbiHFJNWEF2kJQPYbA++A=
X-Received: by 2002:aa7:c253:0:b0:562:12bf:eb04 with SMTP id
 y19-20020aa7c253000000b0056212bfeb04mr3657567edo.33.1708094788806; Fri, 16
 Feb 2024 06:46:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Feb 2024 06:46:27 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240215160458.1727237-1-ast@fiberby.net> <CALnP8ZZYftDYCVFQ18a8+GN8-n_YsWkXOWeCVAoVZFfjLezK2Q@mail.gmail.com>
 <110f8523-4d61-4a1d-ae18-480d89e3c930@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <110f8523-4d61-4a1d-ae18-480d89e3c930@fiberby.net>
Date: Fri, 16 Feb 2024 06:46:27 -0800
Message-ID: <CALnP8ZbxQUiz5VuC29250fnfEjiurUTW9oezy1MDB9vrPZbwmw@mail.gmail.com>
Subject: Re: Re: [PATCH net-next 0/3] make skip_sw actually skip software
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llu@fiberby.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:17:28PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen =
wrote:
> Hi Marcelo,
>
> On 2/15/24 18:00, Marcelo Ricardo Leitner wrote:
> > On Thu, Feb 15, 2024 at 04:04:41PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nne=
sen wrote:
> > ...
> > > Since we use TC flower offload for the hottest
> > > prefixes, and leave the long tail to Linux / the CPU.
> > > we therefore need both the hardware and software
> > > datapath to perform well.
> > >
> > > I found that skip_sw rules, are quite expensive
> > > in the kernel datapath, sice they must be evaluated
> > > and matched upon, before the kernel checks the
> > > skip_sw flag.
> > >
> > > This patchset optimizes the case where all rules
> > > are skip_sw.
> >
> > The talk is interesting. Yet, I don't get how it is set up.
> > How do you use a dedicated block for skip_sw, and then have a
> > catch-all on sw again please?
>
> Bird installs the DFZ Internet routing table into the main kernel table
> for the software datapath.
>
> Bird also installs a subset of routing table into an aux. kernel table.
>
> flower-route then picks up the routes from the aux. kernel table, and
> installs them as TC skip_sw filters.
>
> On these machines we don't have any non-skip_sw TC filters.
>
> Since 2021, we have statically offloaded all inbound traffic, since
> nexthop for our IP space is always the switch next to it, which does
> interior L3 routing. Thereby we could offload ~50% of the packets.
>
> I have put an example of the static script here:
> https://files.fiberby.net/ast/2024/tc_skip_sw/mlx5_static_offload.sh
>
> And `tc filter show dev enp5s0f0np0 ingress` after running the script:
> https://files.fiberby.net/ast/2024/tc_skip_sw/mlx_offload_demo_tc_dump.tx=
t

Ahh ok. So from tc/flower perspective, you actually offload
everything. :-)

The part that was confusing to me is that what you need done in sw,
you don't do it in tc sw, but rather with the IP the stack itself. So
you actually offload a flower filter with these, lets say, exceptions.

It seems to me a better fix for this is to have action trap to "resume
to sw" to itself. Then even if you have traffic that triggers a miss
in hw, you could add a catch-all filter to trigger the trap.

With the catch-all idea, you may also instead of using trap directly,
use a goto chain X. I just don't remember if you need to have a flow
in chain X that is not offloaded, or an inexistant chain is enough.

These ideas are rooted on the fact that now the offloading can resume
processing at a given chain, or even at a given action that triggered
the miss. With this, it should skip all the filtering that is
unnecessary in your case. IOW, instead of trying to make the filtering
smarter, which current proposal would be limited to this use case
pretty much (instead of using a dedicated list for skip_sw), it
resumes the processing at a better spot, and with what we already
have.

One caveat with this approach is that it will cause an skb_extension
to be allocated for all this traffic that is handled in sw. There's a
small performance penalty on it.

WDYT? Or maybe I missed something?

>
>
> > I'm missing which traffic is being matched against the sw datapath. In
> > theory, you have all the heavy duty filters offloaded, so the sw
> > datapath should be seeing only a few packets, right?
>
> We are an residential ISP, our traffic is therefore residential Internet
> traffic, we run the BGP routers as a router on a stick, the filters there=
fore
> see both inbound and outbound traffic.
>
> ~50% of packets are inbound traffic, our own prefixes are therefore the
> hottest prefixes. Most streaming traffic is handled internally, and is
> therefore not seen on our core routers. We regularly have 5%-10% of all
> outbound traffic going towards the same prefix, and have 50% of outbound
> traffic distributed across just a few prefixes.
>
> We currently only offload our own prefixes, and a select few other known
> high-traffic prefixes.
>
> The goal is to offload the majority of the trafic, but it is still early
> days for flower-route, and I need to implement some smarter chain layout
> first and dynamic filter placement based on hardware counters.

Cool. Btw, be aware that after a few chain jumps, performance may drop
considerably even if offloaded.

>
> Even when I get flower-route to offload almost all traffic, there will st=
ill
> be a long tail of prefixes not in hardware, so the kernel still needs
> to not be pulled down by the offloaded filters.
>
> --
> Best regards
> Asbj=C3=B8rn Sloth T=C3=B8nnesen
> Network Engineer
> Fiberby - AS42541
>


