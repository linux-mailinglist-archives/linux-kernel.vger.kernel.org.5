Return-Path: <linux-kernel+bounces-84699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66686AA64
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1722836F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389A2D61A;
	Wed, 28 Feb 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dg0LetI4"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09162D052
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110104; cv=none; b=FxNYAmOjzZX9QfNCswvz3/cinJQ+zrImVUzD9LJZYj5vYscvSaGCFm3s021Qu3P6k7bW+2uh9Xp0/H3nA6xquenLWQ1tye9N+G6mG5995Ev2tZQtoVU2nr5OrftiC/FVxMtlLhcxTj4neKQNQ5ij8o6dPH1YvOoNI+dIogfnKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110104; c=relaxed/simple;
	bh=c/lbvKiivAPjD0Mp3kf9YnP5KkMypKY04lHuqLtbkUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMUlMlXlZTznzp7gQTCbhmf1AqxDzXMxbS1tSLeoOgSVE7wCVig8USK97iFmY1Kv08G7rrjuUglQHu045lYAEY3epesMByeNZBaJKErxU4hqnOHSHqudBoOQbMDqm7TTuF439YiOnpzS8rXSIIYif1lDgArH8QTvmefOVM5pUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dg0LetI4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so7109a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709110101; x=1709714901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOHdb4gC52VDJXjDwJCJAgGjMtqm1gMwO+f40BDHTaw=;
        b=dg0LetI4GImURkBNInhf7UKI4sbJF0LZqyrf5Scl5y3B8dWIghsoBmvvh3QxR7Pvqc
         pRN3vJL2bLXT6bDKpN7s7j50rqnTMgo2J9DVOzwApVT2QYlR+Q7n7iG2kRpGC0zDP8fU
         jWKUZ87U4vjc2x87d46GbpTfeIc+navgVcc09LSsW900dhKnjENgeBo31An85tDx2s+Y
         qbRoy/JqLSPp6iDx9THFCqAkN8lcHydWZR3UXYbpxk5R8a+orbMPsmT7WX/CoxgU8Ley
         3aEBheZA3s25BNHj9iqL18WFSIWd8qWKrpzrMXFJsESx14Wf08MBriCiFp7Ac5wTUwqf
         gbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709110101; x=1709714901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOHdb4gC52VDJXjDwJCJAgGjMtqm1gMwO+f40BDHTaw=;
        b=p35ESCIHt8ploR0dUFajRSaQuDYbiPTVbUQNwxdrPZyEByx/eEcE1v3WtWy0t6Uucd
         AOVqeIntAysJy9AdV5YktcLBKPXlfgmTx/ZLpYKfo6U7s3N84ezr3nEWOk6f4PO5v6ds
         GM7nbKdWn4NoT4X9LxoDzW5B7veZ0rOFyKKibIcAyLnKlMolHvba+bHROGWQCc42j3Qt
         +Wl8DQFjgXo0/tLl2hHMWka0Q8odsdRnhWfsReVEFR9I8xxCJcC0yXxSgJUS5ZKh4TNF
         wXmNi+apBrPXdFIrdKpBa0RQw2gCCWJqw3CS0PM3PSeVF0QW2q+j8/+IzupOL9Plq70q
         ZPgA==
X-Forwarded-Encrypted: i=1; AJvYcCU/AYFc7Q7QtxX3mcp64rCijt7hUESH/LorAzNL81SdeOu4RGITeZyhWjDwHmBtP/yoRSpBo66FGednOk4+CvUmSGSsjWlMcthocIz3
X-Gm-Message-State: AOJu0YwzaUwvpS7gorDG+1FWbU2c5TLaFPVRKZRqn4AGJVB4/FFbOSyR
	9J3dGK1HCnMISM6tsGCraJc8KkW7Z5J6XZB8MAJAHT8ajZR9cx2xSZQFbBWPzcHB9nvxU7aShME
	dm3aH6+cyKCaERyQXeV0EKDilw2vKFEWw65h1
X-Google-Smtp-Source: AGHT+IF/5h+WUoGX3+I8PwNwD6dhZfIcRNEEBiiSwHrJF/F4geD/nGTDRoUtYBissdQeflMfQZ00OnScf+6jsdjEcv8=
X-Received: by 2002:a50:9f89:0:b0:55f:8851:d03b with SMTP id
 c9-20020a509f89000000b0055f8851d03bmr35131edf.5.1709110101052; Wed, 28 Feb
 2024 00:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALkn8kLOozs5UO52SQa9PR-CiKx_mqW8VF9US94qN+ixyqnkdQ@mail.gmail.com>
In-Reply-To: <CALkn8kLOozs5UO52SQa9PR-CiKx_mqW8VF9US94qN+ixyqnkdQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Feb 2024 09:48:09 +0100
Message-ID: <CANn89iLH5+KryWa3GMs-Fz+sdy9Qs7kJqfBwf0229iwgW65Hxg@mail.gmail.com>
Subject: Re: Network performance regression in Linux kernel 6.6 for small
 socket size test cases
To: Abdul Anshad Azeez <abdul-anshad.azeez@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	dsahern@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boon Ang <boon.ang@broadcom.com>, John Savanyo <john.savanyo@broadcom.com>, 
	Peter Jonasson <peter.jonasson@broadcom.com>, Rajender M <rajender.m@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:43=E2=80=AFAM Abdul Anshad Azeez
<abdul-anshad.azeez@broadcom.com> wrote:
>
> During performance regression workload execution of the Linux
> kernel we observed up to 30% performance decrease in a specific networkin=
g
> workload on the 6.6 kernel compared to 6.5 (details below). The regressio=
n is
> reproducible in both Linux VMs running on ESXi and bare metal Linux.
>
> Workload details:
>
> Benchmark - Netperf TCP_STREAM
> Socket buffer size - 8K
> Message size - 256B
> MTU - 1500B
> Socket option - TCP_NODELAY
> # of STREAMs - 32
> Direction - Uni-Directional Receive
> Duration - 60 Seconds
> NIC - Mellanox Technologies ConnectX-6 Dx EN 100G
> Server Config - Intel(R) Xeon(R) Gold 6348 CPU @ 2.60GHz & 512G Memory
>
> Bisect between 6.5 and 6.6 kernel concluded that this regression originat=
ed
> from the below commit:
>
> commit - dfa2f0483360d4d6f2324405464c9f281156bd87 (tcp: get rid of
> sysctl_tcp_adv_win_scale)
> Author - Eric Dumazet <edumazet@google.com>
> Link -
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D
> dfa2f0483360d4d6f2324405464c9f281156bd87
>
> Performance data for (Linux VM on ESXi):
> Test case - TCP_STREAM_RECV Throughput in Gbps
> (for different socket buffer sizes and with constant message size - 256B)=
:
>
> Socket buffer size - [LK6.5 vs LK6.6]
> 8K - [8.4 vs 5.9 Gbps]
> 16K - [13.4 vs 10.6 Gbps]
> 32K - [19.1 vs 16.3 Gbps]
> 64K - [19.6 vs 19.7 Gbps]
> Autotune - [19.7 vs 19.6 Gbps]
>
> From the above performance data, we can infer that:
> * Regression is specific to lower fixed socket buffer sizes (8K, 16K & 32=
K).
> * Increasing the socket buffer size gradually decreases the throughput im=
pact.
> * Performance is equal for higher fixed socket size (64K) and Autotune so=
cket
> tests.
>
> We would like to know if there are any opportunities for optimization in
> the test cases with small socket sizes.
>

Sure, I would suggest not setting small SO_RCVBUF values in 2024,
or you get what you ask for (going back to old TCP performance of year 2010=
 )

Back in 2018, we set tcp_rmem[1] to 131072 for a good reason.

commit a337531b942bd8a03e7052444d7e36972aac2d92
Author: Yuchung Cheng <ycheng@google.com>
Date:   Thu Sep 27 11:21:19 2018 -0700

    tcp: up initial rmem to 128KB and SYN rwin to around 64KB


I can not enforce a minimum in SO_RCVBUF (other than the small one added in
commit eea86af6b1e18d6fa8dc959e3ddc0100f27aff9f     ("net: sock: adapt
SOCK_MIN_RCVBUF and SOCK_MIN_SNDBUF"))
otherwise many test programs will break, expecting to set a low value.

