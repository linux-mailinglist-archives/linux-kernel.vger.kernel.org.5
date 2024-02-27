Return-Path: <linux-kernel+bounces-84020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52686A170
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0101C2179F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692C651C4C;
	Tue, 27 Feb 2024 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FaIciahU"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E614EFF8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068688; cv=none; b=ljPD+CGYCE2CZ9qj11T4asKgFVU/VHlJBCc4GpopWp72x0dOMS24pFAx+bVG8kSmraxjQ8d/wxQd9PN1WuQCEg6XAD4XXouQOnXzXvRB7EudUO8PJl7MEs8Kbw5QN9GIjrTe7XIIWrmrv5+iccZz/n9jGkuejpEgOKMdGz8OB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068688; c=relaxed/simple;
	bh=GM2IpfEXJUSW2VkMqcfLau6RAfFop+hHmlbXoHh2q2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DS5vCEUlGFLL5iwem1NzAnlBB1ZK9hTivP2T57OcSsYauXxKeI7xqG/9Y2RIg+EBWmcP1tpwGCyxg3592yIJQSTZ+CblPrAbpRPvq0iFzulBKmOZVOL5BqrIUxWOTKRU62WNR6dWB6Haj8QyiKEitGqDwMdBEDvAb2PkilaylEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FaIciahU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513173e8191so704741e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709068685; x=1709673485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w1c/wPzzC00qVzHrWYxBARFDO3pJ4orEr+vFkg8bak=;
        b=FaIciahUxu695FYaKfbzdNFa+5S7d7DVOywOVofsV3muYJSRB76A1kCJJ1uXgtGwAN
         JAeq8SxfHlVtVCcGFq6s0bCja+zNTWLdRHqlQQ8W5Kha1OcsmiiAN415hQLuxGendYQc
         D655tEO03RBPhJ0TwkvWN+kO86rX/tbq0o575FOpqs6SuOCJMjzwWVYawdawycbkxtuJ
         FwAqJYdWhqyuyHd+DsFaJ6sLtt4QwLZ6HSGjESC0oEwVktRRGdo621nYXT/snIUCuGAa
         eICvx2HjgRsJqbjVFwWvwkwJwaAIxCpxlUpTCrO10IzYVtL79umBAbLHA3y/Yfkbz9Ip
         0hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068685; x=1709673485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9w1c/wPzzC00qVzHrWYxBARFDO3pJ4orEr+vFkg8bak=;
        b=SerLGgVKQcWDiXuPl+9qyU7JFj9L4UQ+JjzY8/YrmcBS5bXNmiYH4KN1xoq1laKLUh
         C8J0spzLPf5BDyBVEW/WYf5pcfjcV4mK+2+IPhX9Soa4SJV8AGOqBP/bJgsYdmd6NNuA
         teZ3GnaKhvtObMlasTYJ4qSBqnbit2D1QQe4hPuBmTLsHqEp0POy3hpquSlym9mXRfXM
         /CvJM4OZlOAoeCzal0sv2oPXhY7zuos3joDz370FdPnZALlvYRaEtGpJ2wsNH7nhGdj5
         ku+B6QMZmzkVuVcJ0ZS67QkJgrCH0OEMpW4FApyhHr3ri+YSSdD1jK7nh8DNolpWLwc+
         dRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS6joyh5iokTob21OzeT+ACyhlwFqTwKYpXWj6KdRmBgfWGWPmYfRc3JdR2UFvW5unibOK683WXq+uSaJWQ9LAO8Cs1wD+o79WdwwI
X-Gm-Message-State: AOJu0Yw/ejE8NQaItuuf7ihumy/IUyoKGpuvVWLCQDEVz1SgDr37K6ym
	3Lo5lag+fGaivKwMLqv/wOe0UpXgvZmMqg1oe0qRogvc9H1z4ISuwA5IYWiPM1tr6Z3rLn5NY+K
	V4lcLmOdpYUtcEllx/QRA1WE6nyEmFzqf7LlQKg==
X-Google-Smtp-Source: AGHT+IHMZYDrlxvgtUhH8+R7/d2FNSTdzt9nbLZWLir6PhRBrOD/kryo5DdrPJpwQVpZCpVIgWiY6gZgPiLj6hFZ0bY=
X-Received: by 2002:a05:6512:1114:b0:512:cba9:c5e with SMTP id
 l20-20020a056512111400b00512cba90c5emr8178182lfg.61.1709068685183; Tue, 27
 Feb 2024 13:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
In-Reply-To: <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 27 Feb 2024 15:17:54 -0600
Message-ID: <CAO3-Pbpy7V+ZesnG7vTmV4msHW3M-sMa2Pfim2yU8jL=hbYq3A@mail.gmail.com>
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

On Tue, Feb 27, 2024 at 10:44=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Hmm....
> Why napi_busy_loop() does not have a similar problem ?
>
That's a good question. Let me try if I can repro this on a busy loop
as well, since the structure seems very alike.

> It is unclear why rcu_all_qs() in __cond_resched() is guarded by
>
> #ifndef CONFIG_PREEMPT_RCU
>      rcu_all_qs();
> #endif
>
>
> Thanks.

