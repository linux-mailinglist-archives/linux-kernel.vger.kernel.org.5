Return-Path: <linux-kernel+bounces-76594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5BE85F9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696B8288F06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C40134721;
	Thu, 22 Feb 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1SNH+KaY"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B512E1CE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608457; cv=none; b=qR9q28JUEnSACmet+sllUvp6Q8liCWRKKjn6awW8ax6N2WYzRFfigDzxIplM14YmQv7PUv6cq4th1tm7Au49n29WIt/dEDvdDvUwWBfA/q0/7Q1YCpyOX+KrSScJ5jnvJVkw2tzhQyz97jI4RwNaWt3T1gVWUN/HcsqmiN5Qh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608457; c=relaxed/simple;
	bh=Yv01f3SU14zyK7JMwHNf68+qOoZzkeRjV2RwRMZwhIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=My+x+weFambxErXFBFcbf2DPTP3RtSnfSKFCYBNFHYylFteP3r3VrK459iSjchdia53rnfjqQgbw/KpEV0BcKOYpIiRLNxcYu1LixTK0dM0+pU8Z7RIp31QkTRLJLwzxVhKkxXTaOEzE5pTTZYwCL8ZwqbvAPpPIQq7vMtjnXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1SNH+KaY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso10065a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708608454; x=1709213254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ6eOr+atEO3HsCU6zkySvIsF2Yw194pNlnhirXBpW8=;
        b=1SNH+KaYzXYGxcuZRI+V4r+O4l/vpvl09W9q+6EqLVqnsc+zcGswuH3jNOE9PhgJzk
         3/ww0eqGyvzacVKpiCijeXGaBaBpvEzZYMTaXdrfb129FUfKC/dcvSj7VuAGSuo2eFia
         WsO6xiQYNF0P/lN9dkQKIL9wTib/XWMW2UO5K99yhGPW/SqagcuiFayAvJrZx3FJCQgA
         HSs8PBL44I/KMVZdY6rHf/mPuHvfqatoDHAeGBFeWntfzLVM5+3xJc3UIPuNG/OkXqZ5
         w0cyelRA7lR3vL5kw51qDetESl3Wl4Yf8mSNW/QI+1YuHBnEM7pJ598tPQA5QB/2Sy2y
         8bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608454; x=1709213254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ6eOr+atEO3HsCU6zkySvIsF2Yw194pNlnhirXBpW8=;
        b=t4d3Tub3S00FVahuRfwYJlo3LFw2c1VfOXcMNE+lp1vt/9ZmFYzYqZoC5/54UVZiEm
         HK+qFiYCb8/i/P1LhTiDtWMtg5jWnHq3Ag+rCXKICMJRmbPbtVlD9MuLxdSLu32EMqml
         9aXYnnAdVn87zVNAr5RvuPfz3t72e2ONpH0NfwoEmONBKOPHz3G8MeHZjWcXlrKrzfuN
         H+T0H9HTZkXlrG9Kqfc1LUJNo5k/mVeYGi9Rh8bMPmNXKSdxz66dLSkwJ/xAic3hkhu2
         bEHzoy+e39+E9A07Aemt22mef6+sLcuNf/BJuxXVX+o6IT/ZClBipp+KlHvx3ouc2bPP
         bYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLvutNnAL8u47JBBZ1QC2D+JqtC7cE5F0MrpV1kVB+eMmksjZplhVZBLHz+5t/t0pn/Q7ssATBpzQVBgfhelI2x70pfzLJ+44MxZOX
X-Gm-Message-State: AOJu0YxzmzkwPAhMjwF+tvYU5cVZf098klM3zlNn2R6+KZoIOpOsnzEv
	ZkTd4j00EUY816oOYotAuqezQ7bpZeEmfHYeINIb0v7SReJmRfgZzU+Z6ETDhDRcoQYW2xRYChN
	ARyuznDdcRfZUuGy78FtarJx1rHIV6caZztQW
X-Google-Smtp-Source: AGHT+IF9XT3dxwl5KOU4qzGawHUEMNYBukWn5CBBjWpLuGiljfbxAt4H6SflE6Efg8FKXAd6gBrvGToH32uPBP3C7o0=
X-Received: by 2002:aa7:c1c7:0:b0:565:4edb:7449 with SMTP id
 d7-20020aa7c1c7000000b005654edb7449mr35828edp.2.1708608453685; Thu, 22 Feb
 2024 05:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000043b1310611e388aa@google.com> <20240221131546.GE15988@breakpoint.cc>
 <CANn89iK_D+v2J7Ftg1W6-zn7KSZajwWVzfetSdrBPM6f_Zg80A@mail.gmail.com>
 <20240222122324.GB28098@breakpoint.cc> <CANn89iJ6UxRPRJeat==LXQS7B7rYpUN3BvBJv3w1_v5y53cfSg@mail.gmail.com>
 <20240222125738.GC28098@breakpoint.cc>
In-Reply-To: <20240222125738.GC28098@breakpoint.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 14:27:18 +0100
Message-ID: <CANn89iJZnY_0iM8Ft9cAOA7twCb8iQ4jf5FJP8fubg9_Z0EZkg@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in mpls_gso_segment
To: Florian Westphal <fw@strlen.de>
Cc: syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>, 
	davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 1:57=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > I was thinking about adding a debug check in skb_inner_network_header(s=
kb)
> > if inner_network_header is zero (that would mean it is not 'set' yet),
> > but this would trigger even after your patch.
>
> What about adding:
>
> static inline bool skb_inner_network_header_was_set(const struct sk_buff =
*skb)
> {
>         return skb->inner_network_header > 0;
> }
>
> ... and using that instead of checking for negative header length
> post-subtraction?

SGTM

