Return-Path: <linux-kernel+bounces-111973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6C887381
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54667B23269
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2498768F2;
	Fri, 22 Mar 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uspQTaSd"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD4762F1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133931; cv=none; b=gpepg0YlHvO7lbKq7Yt1dxxdRf8qf2Zyt3dzn3sITYKTlLI9r2md1Rtaf9Ym3U8vOnJOtVdsebVGK2frAliyyb89hViLssEIH1DMODdHw7N02wLPL9xxvPgQiSefwtDUDR7FpUcKepb8Pym7uGhtXb5wln4TPtuwoREF0SSdNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133931; c=relaxed/simple;
	bh=2zmoavQwnUkySX1On4e3iFUXEz7P4YdtMJWnbUJFcws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDHN1SBJw991oi1hd0c+3vWYbd92npfqQtgM5ss8PZ8HrLpmHwNNr/Wby9u+o/sXL5ep/7i3E6RqHKg+9scJ8OitGKB3mEjHbys5giNxxfPvjHfISHx3Rb7qhuizK259VYfAOJ1/+EEBE4HUBFheX5ndGk1u0isyBXbHIlHTl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uspQTaSd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46cc947929so346494766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711133928; x=1711738728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kn5VB94BUw/eWqkLaBFyi/LkgXiPUXB/jc3eN2ucVQY=;
        b=uspQTaSdU/vtyRgn/iz68TBqci5cr2bCVhXf9icVogBrndF3SBXfqDTAqxhsqI+ufB
         oCHm53PcJnm8yLgDyyz2zGEvTOzSAVZq1E7EyrzT6g6jy6XIRzH/HVZJ2vvBZ9FtkiTz
         jJpIh1vPfcBNMD6RxRlBLBIgHyoPP66RZWucS2XbahafXyRXGWEMaaP8tX97dCZ27CXV
         n8TJXR2lGr0AWUvMvtAl3qU6y99T3snWIPr0+FTlp23luipoy1U1KdGJXBdVMaosPsJs
         /Jd5OGKCOJ4sb2XQMTCMcW7DHWZHKM6YKx4GnXJSjpMmr6y2S1HqS07EVb7qwUeHaP+d
         sM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711133928; x=1711738728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kn5VB94BUw/eWqkLaBFyi/LkgXiPUXB/jc3eN2ucVQY=;
        b=fxEnWMzN9L61H+QTGSnGXshHbtGcjlkhIlAyVUZXhrCFBRebfZkrQpxwpYdsdEihij
         mid4qrkRFEcIKwBG1OL+jHuLuM/QYPxLBFOaZxyfgwXbbhwgVwQVPsLNwpdjN1x+b5B3
         i8q/Ej5f4PG+zipZk43RXBZAF5KERwCrVgmSgmtgO7+0kJgng1aJI0o0ZOhs5avID0VI
         pHWlk++gXjENPcjGNpFwTas03RGuo/uKL+uRFrvoGGUVbkSsuV7r2vDoRioPe9LCR+1C
         Xz5NmM+v6lwXmnE/6Kse9slYulGatDxwAg+3zOz4abRFiYXFZ/lIp/u4rfGowl2KsjTI
         Vwdg==
X-Forwarded-Encrypted: i=1; AJvYcCVa23ESTfI/40Mhlwwlygb8WwbZanqUUxBUM5QNtwOsHwJpGdIWtBfCiJ0maQ3wFfgsluyA6aF/khPPDq3DlPDazkNzMdf0fatHeWkS
X-Gm-Message-State: AOJu0Yzw+TuOC7vqM5sjjSGeWtimlV7cVlGBjgDm/+THnctMC9icbAd+
	peC5LacXHOrSJINrTJgtPbLjZU5lTAL6hh8e1Mz8yuqxo3ZR4mVYsWhJcpioXC0i24G05xsUHaA
	oNgH/Tr4+2MQSbEcm3XomYJaUNZs9Ken6syjCeY8Fqqmi4xckPQ==
X-Google-Smtp-Source: AGHT+IFrALHdZOSKj5aMn/uzQgQdUN6Pqoan+ErPCLYOdPIRvipej8qj1s6jFNcN9s7yZXOVAoYdlrQhCGb3EUEUXDQ=
X-Received: by 2002:a17:906:f2d9:b0:a46:fd41:4bb8 with SMTP id
 gz25-20020a170906f2d900b00a46fd414bb8mr415771ejb.25.1711133928342; Fri, 22
 Mar 2024 11:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-zswap-fill-v1-1-b6180dbf7c27@kernel.org>
 <CAJD7tkY8os3yvYLiotaiRuYa1jdEGiPHQsZEU6E52zRBQ34kQQ@mail.gmail.com>
 <20240322031907.GA237176@cmpxchg.org> <CAF8kJuNe5xXVp00Ogk2AL_zXFK6pN0u7=0avjyPPkagB3FWy8Q@mail.gmail.com>
 <20240322171156.GC237176@cmpxchg.org>
In-Reply-To: <20240322171156.GC237176@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 22 Mar 2024 11:58:12 -0700
Message-ID: <CAJD7tkZk=Febdoa-fXVw2n21KtEH=y8n6LD6akxc_cHvfEZ=3g@mail.gmail.com>
Subject: Re: [PATCH] zswap: initialize entry->pool on same filled entry
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> > > What would actually be safer is to make the two subtypes explicit, and
> > > not have unused/ambiguous/overloaded members at all:
> > >
> > > struct zswap_entry {
> > >         unsigned int length;
> > >         struct obj_cgroup *objcg;
> > > };
> > >
> > > struct zswap_compressed_entry {
> > >         struct zswap_entry entry;
> > >         struct zswap_pool *pool;
> > >         unsigned long handle;
> > >         struct list_head lru;
> > >         swp_entry_t swpentry;
> > > };
> > >
> > > struct zswap_samefilled_entry {
> > >         struct zswap_entry entry;
> > >         unsigned long value;
> > > };
> >
> > I think the 3 struct with embedded and container of is a bit complex,
> > because the state breaks into different struct members
>
> That's kind of the point. They're different types that have their own
> rules and code paths. The code as it is right now makes it seem like
> they're almost the same. From the above you can see that they have
> actually almost nothing in common (the bits in struct zswap_entry).
>
> This would force the code to show the difference as well.
>
> Depending on how Yosry's patches work out, this may or may not be
> worth doing. It's just an idea that could help make it easier.

I initially wanted to do something similar to splitting the structs
before not allocating an entry at all for same-filled pages, but I
ended up dropping it as the direct conversion was simple enough.

Anyway, I will post the patches some time next week (or today if I can
get around to test them). The discussion should be easier with code.

