Return-Path: <linux-kernel+bounces-29694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680F8311EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892121C20DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0580579D4;
	Thu, 18 Jan 2024 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ahZuDEh"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25ED7481
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705549940; cv=none; b=M+Shxr0pCjjEF7VVDo2bWWkp4vABYxpjF3Wl3e6oAbb2Jgj5ghduqDmBz3K1oN+rGqP1+E57nOnhAi6Ujya/xkzuxzqbYuTwxjILVGx9ja/F5DwUb4qzxwcm96xf3Cw2TwzW771OagSVxyZjtjhkY4W0clydFqrmvBM9TlqLGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705549940; c=relaxed/simple;
	bh=umpH5I9vuDUFUcryaQXwsv/ekrk0pN6e3w90EBD/FLE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=gF6N/pvTIthccBkWdqfWVuTm6VfYleQ2IDl0HQkrwJ91qgI88qzJAXOoj17oIp6vYF5jEwUHSDmMleZdBhcc2qR7RhXw5a4huyMsMNY34Q60jKeV+xXgKxHNF9hdMfUuyBKsH0J1aRqsA7XCXOz4SVo1vwmytPdfyriF8F3SUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ahZuDEh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28a6cef709so1296333066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705549937; x=1706154737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umpH5I9vuDUFUcryaQXwsv/ekrk0pN6e3w90EBD/FLE=;
        b=1ahZuDEhSys6r/iCf1EwZP8d93NB4SIG09z2kd9pOp9zojZH2ZOOxyl0qAF07+1J+x
         h8jjOP/kzs4atCWhoINafznBWVv+QLgh7dzzfea5Hfiv1gEpixw8fDK4rD66sc0j7kbC
         oN7PhjSdzQQIxUbVFrSz8AT8NxNG53QoKA/yHuPQ4ZcZZtR6lM78L3VE1fh03BAELJ+w
         Asl3xDz2Xlip/bvk0FIakCzMEkjCgHlogNj8OxBaB3gzz8dxOY75kwmCKGEol0CevFxg
         JtUn0ABgvghHGIaun6bY1cYVGFTx+skmnrL83zNjavuC0U4ZEd8s7ejYqEMZlfOsXskv
         p5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705549937; x=1706154737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umpH5I9vuDUFUcryaQXwsv/ekrk0pN6e3w90EBD/FLE=;
        b=RXgA14tKk+d43/MRJsI3zEOxivvKX+0+R8d1FRenaiyzmKt1/qeOla+/VROX0d8pFX
         Mz7oBSKZhrh7TtdqXR5zyDBXYRXkpqkMyrEKMRd43G0NUvy2hlmxzsNOIaH6LOIvtpIF
         OHXfnsPxs1F6nSQtgEP6w25OymhA2pJDt0AExmQ77+VSlq9x2F62sc0O/AxMkIXRo8f9
         k77fq10okIvUJdJYx38DkUPtHbcgb9lHgPPD0m0Mz9OK884+UOlbedgnrmErxrFM01Qz
         L5mA43vamlQ2qQiLqCAXZZTqa1hbRDW+1V1B2AXrIOrjdlj+Wmh0F6YRAiaEXDoBGm/y
         DmOA==
X-Gm-Message-State: AOJu0YwO6DpOZxxZnU6cMLlt8wKWBXxbrXxECY3auz/GZ8Z1h14zs63O
	2HDXWa8gCADY5YTz9X037QuWfGPt2IA7nZnOLadOW1GLus2b6ob2+VbRF4c4HBNaxbMVJpPnw5A
	ucBg3+maGrcvgdQXUUFKtKOHnNFZsC796famv
X-Google-Smtp-Source: AGHT+IEIyLQZF4y7si+hAmyLqfsDvA4EP8+Utf0zvt3Y9+gsJM57GxBzUwijVvTqsTxK9UWTNYcxnaZAY3y6+nn+AUk=
X-Received: by 2002:a17:907:8e08:b0:a27:7959:a5a6 with SMTP id
 th8-20020a1709078e0800b00a277959a5a6mr94231ejc.89.1705549936982; Wed, 17 Jan
 2024 19:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
 <CAF8kJuP4o3Ebg-aYKF9=ftbdu97RnkXnYL-8RuVjYAeXd+ng3A@mail.gmail.com>
 <CAJD7tkYfo6mNjHQJt4yfVuh55tMyVMRnbeq5ki42tYHBEgP_eA@mail.gmail.com>
 <CAF8kJuO=3-DMV-rXBZE-hVUXzQcV5B1HPFGzpzL99_5WggqF9Q@mail.gmail.com>
 <CAJD7tkadpOmERPzUyYUX=8=POan=Pm1zSae81zyRhYLXDHo_7g@mail.gmail.com> <CAF8kJuMRWDuY5hbAzbA9bQ5=4RztvD3tLB-W+6besGBk11+pPQ@mail.gmail.com>
In-Reply-To: <CAF8kJuMRWDuY5hbAzbA9bQ5=4RztvD3tLB-W+6besGBk11+pPQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 19:51:41 -0800
Message-ID: <CAJD7tkaaPKbCF_0D2vGs3GwE2dHaueNw6z_uv-Gqg-MQneOmqw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Chris Li <chrisl@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:03=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Yosry,
>
> On Wed, Jan 17, 2024 at 4:35=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> > Hmm I don't understand. What's the point of keeping the rbtree if we
> > have the xarray? Doesn't it end up being more expensive and bug-prone
> > to maintain both trees?
>
> Patch 2/2 remove the rb tree code. Just keeping the tree spinlock.
>
> >
> > When you say "eventual goal", do you mean what the patch would morph
> > into in later versions (as in v1 is just a proof of concept without
> > removing the rbtree), or follow up patches?
>
> V1 will remove the rb tree, but does not merge the rb tree lock with
> the xarray lock.

I see you already posted the patches, let's move the discussion there.
I will take a look at them as soon as I get the chance to.

