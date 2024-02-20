Return-Path: <linux-kernel+bounces-72523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFEA85B4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FBA1F21ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562375C60B;
	Tue, 20 Feb 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zH1iL5/T"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA085C8E4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417067; cv=none; b=CuQovR7UPqtWDbQKy7VMiWsllFppQmWzPB6IgKdJ1uGeQFsCHAgKO/tUjOjFpA8WycBa/ohaatXmdXz/1GPfEVIYO3Bqg8V/UKFxCAok4O+mDcwOVi+uWFPPMgLiTQEGA8HN4pxiz1dIxT/e3lZA9XSlUzfDoUb2nhkE5B/loC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417067; c=relaxed/simple;
	bh=Qd2bc9p3BETBeBMkON8EJ73T7BHaExPE2Gw630in5/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1tK4o4XQN9+GzdbvBklCqlYmrjzkua/5biTUJTQhw+2e1mEoC1Lwbk9p8bG5gKJGw/T8NUuESKv9i4bp6Q+pXzqQTs1Mb2gr4ClD4KxozFrkiEltJQphKZ7++P4+EFXxUxB6IwaMwKOcHMaXvtxCFj20I/QXM/IGGskcGsG9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zH1iL5/T; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564d311513bso2076a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708417064; x=1709021864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd2bc9p3BETBeBMkON8EJ73T7BHaExPE2Gw630in5/M=;
        b=zH1iL5/TbJlKxpEXUFdfxrp2JjpkjWQizb4XIeeGXSMxdx4yiVDAilzdi+MlPM3wTY
         tPnq/fWiFAqdTlUN3tA/Zu6OYvap+2fxyp22biIaWV9XVhfnpjVmpXIStFTuUDMXydd3
         7YVmNrr8kiWEZAhigSeoONYKiD3Kh2tVlUGEHiaqTDNcbpRF9MHIGZRjvEySI2ynkqO3
         wspDkAEiKBBK2ZeVSobTS4JiVdonbBpAlk/VRzl6hgmGdPNEwbO5+u4WXxa+Fmg+xzse
         1Bzx7jZnUPJf7qP4kiXbCIyQW0KhYhKRaXchJie085NxUn8MiXpCq5Kj7ZkR4866Z+1z
         Qzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417064; x=1709021864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd2bc9p3BETBeBMkON8EJ73T7BHaExPE2Gw630in5/M=;
        b=VDdchULFBCx2KZprL6WwCD7zxcQyuMirx7XA9In708Dp7IaWktirrOHwyKAKXVEuk9
         YkFdQ64TJ60y3KR8QM7ft6CljkAHX1Q8Zz7aCKvnLH2VZOaBcuFQHWNyhDXAMmhw+8cr
         Ik9tpz00NZWzPcAnURKdKFoz2KoOyIctTP1Y5lH+e89OCdGZKF+6vNd8gMkKPNklJHdG
         rnm8VElvBjvI6i7Fi+7D5HJOm/1NittAsKNpv4uxNPw3CshhiKaQ9ylufT1M8S+XitAi
         5XTSkqyYO8loUT4oKazmSu9a4dyhshDIKltNM28HMWpioz8tmYdJm+dyQ66UYahUq0mR
         Ka5w==
X-Forwarded-Encrypted: i=1; AJvYcCUVJs0MCBhXj58Mf8waMe1SDGqT6prVT/8DjIs0Ey/nC70uKYPOq/jXPH8+MN6SwP933sbcovC3Yehv4K2NBNmrp0SAkG7cuogfiYdG
X-Gm-Message-State: AOJu0YxE5wz+eGndUS956UBvVWrcU7WBbE2h0m0cBEZGqBhs/wo2o43p
	0jFZJCKUdn8Znw+8f/tkfYunKL27thjzJcWDcAjrmwbR9RRjiEsgxymjM2lEWUIhcwKFUYizpOI
	Gg+EW7XhPcHCu6E+B8fJ44KfkpXEtUZpru27I
X-Google-Smtp-Source: AGHT+IF7mcc0zAtM5wQsOXVRxbbUAtJ7J8aj1cbos7ooAnQRgO4HWzdE0dzG+o2uIegVOiiz9LNmx7IsZMeguCmVlis=
X-Received: by 2002:a50:9f8a:0:b0:562:deb:df00 with SMTP id
 c10-20020a509f8a000000b005620debdf00mr359956edf.4.1708417064290; Tue, 20 Feb
 2024 00:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
 <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com> <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
In-Reply-To: <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 09:17:30 +0100
Message-ID: <CANn89i+1uMAL_025rNc3C1Ut-E5S8Nat6KhKEzcFeC1xxcFWaA@mail.gmail.com>
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
	patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
	ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 7:26=E2=80=AFAM Shijie Huang
<shijie@amperemail.onmicrosoft.com> wrote:
>
>
> =E5=9C=A8 2024/2/20 13:32, Eric Dumazet =E5=86=99=E9=81=93:
> > On Tue, Feb 20, 2024 at 3:18=E2=80=AFAM Huang Shijie
> > <shijie@os.amperecomputing.com> wrote:
> >> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
> >> it may creates fclone SKB in remote NUMA node.
> > This is intended (WAI)
>
> Okay. thanks a lot.
>
> It seems I should fix the issue in other code, not the networking.
>
> >
> > What about the NUMA policies of the current thread ?
>
> We use "numactl -m 0" for memcached, the NUMA policy should allocate
> fclone in
>
> node 0, but we can see many fclones were allocated in node 1.
>
> We have enough memory to allocate these fclones in node 0.
>
> >
> > Has NUMA_NO_NODE behavior changed recently?
> I guess not.
> >
> > What means : "it may creates" ? Please be more specific.
>
> When we use the memcached for testing in NUMA, there are maybe 20% ~ 30%
> fclones were allocated in
>
> remote NUMA node.

Interesting, how was it measured exactly ?
Are you using SLUB or SLAB ?

>
> After this patch, all the fclones are allocated correctly.

Note that skbs for TCP have three memory components (or more for large pack=
ets)

sk_buff
skb->head
page frags (see sk_page_frag_refill() for non zero copy payload)

The payload should be following NUMA policy of current thread, that is
really what matters.

