Return-Path: <linux-kernel+bounces-116613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0F88A114
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E41F1F39CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F96171662;
	Mon, 25 Mar 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cHaNVP1l"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12C7319A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350408; cv=none; b=SND2HFQlu9wnounA5WsekeWQ1//uxzxNWBiT8IPU5KgvloVORP3dA+j4km25oTx/h24xBY7rQw4i0pcR7u3FumdCoNriZ/WfxBtPa+sYZVo3Y74w4OjfLawDcXY+Xd55Nw8gY/fe3FosB3UejXYYB4cNwypyaV622xRAg5+elKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350408; c=relaxed/simple;
	bh=tYrE2VriucY8nPiNXG/tOjiZPFifK9utBHez1C3xS9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSfdVaeClHiLLfPl5MmmkPu5rB9VFRF+L9Ye9Ibf0WasyzIA5ANFSMjOtQEedy0t5cGrgbaop77eotYoqz080q8c9HQycOs3/4JSMvZWuIm3kkxlGn5vwz4iXH8ajMlFOWAeZfeuWKIMNltrFVNdrLq/wenPnTHTyLwybnXPZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHaNVP1l; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56bb22ff7baso4622049a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711350405; x=1711955205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWEJsPySa8D1x2bmugQHj3Wlfs+F7dNk4IRWtijp9Bc=;
        b=cHaNVP1lEV5e826S6tniwuNQO4Y+21n4eFmatyOp7T5DUEkVyPhdE3jmvCCL0HnEdy
         DMNrIOfSeRRzAj5iRzmWoteQD/vmfEYdd/mnx2Q+RjPP7i7Lcc2vQB0OvP+XJn2wm6LR
         aDLKDSFkBMDU4CdPdOad2FWyjB8WwMdEpF8Kq/+A4DyCYKotmeJH4gYQB17duQAP657J
         Nyj4WOWIbOIEiVZEIrVZjHSonuhCAQk0aWeLy6dfb1f2neuM7ipc3u9KA+b0X7Inv+U/
         rTlMWZ9Nr3faps7PfTNy9OlK2Lo82y518j9alVso5Sej4SaC5eLzOtbTM30KyecI7Hfc
         55NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711350405; x=1711955205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWEJsPySa8D1x2bmugQHj3Wlfs+F7dNk4IRWtijp9Bc=;
        b=n7L1/YLANTUUlVGCbbR10JwJubBSpHKaPBIGDN7JiCH0kw7wCtjh/qNyjRLTX/QVYL
         0LQigVAD9x5u4QQBDJa1Ro7KK5qXVXAqzvaseFKEeHw1vzwbA+OV5C9opjb6H5EGW7AX
         e+XrJ+UKNPhBJxgJ5oO/n1ZbtdCewSJJ7p33avlaV3US2jve3Mrd7g1rbOcOO5ADWLYB
         QzNHL1vhISU+1gAODH8TFeuv51xItZ74vfpIKcth6m8kYo11v1TEOfYVYfInOSbeUfgK
         RnXhRU3rcVTSp0m2EVHiJlhNn2MpjA5nR6bB1HW1ljRzh5d3vyoMTu9+1wtRuzQ8g3f2
         WgUA==
X-Forwarded-Encrypted: i=1; AJvYcCWc+dTTBxqftvoMdJSAAxkWoW4rFoDIgwZ+zqQgGMMVjTp1t5FjZmECsSUGziWUR4MQq5uuHo3QzBkEcyqSb/FnTJvgCm+lYfpJ/q0y
X-Gm-Message-State: AOJu0YxEtww1LIAbadcF/qdPi9LJxPyUW8lGzMxikBlXZmixpXlf5IMn
	B9kuYd7fMpe9HNYvP/U6C4CyPC8MGH/KdDfAv0TvP2LcqWwwuGJJsu2IRLbqjDxxmJVfWIZlu1m
	aofwiqqubDC5OaTGM3Ij/F1toudYtxRsz7mEP
X-Google-Smtp-Source: AGHT+IGeh6p7jRrQ5NLQb+ctZ5obvIhMI8r68jI7hSlB3NPaFsjdKNg4oeq+9aK/HqJcrcULfjZpMJ53P8teGIVWNa4=
X-Received: by 2002:a17:907:1002:b0:a47:35d9:2efc with SMTP id
 ox2-20020a170907100200b00a4735d92efcmr3804422ejb.56.1711350405144; Mon, 25
 Mar 2024 00:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324210447.956973-1-hannes@cmpxchg.org> <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
 <CAGsJ_4yeBmNsMGXEWwC+1Hs5zJUP+becq4wG+6CpU7V1=EOvhg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yeBmNsMGXEWwC+1Hs5zJUP+becq4wG+6CpU7V1=EOvhg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 25 Mar 2024 00:06:06 -0700
Message-ID: <CAJD7tka5K69q20bxTsBk38JC7mdPr3UsxXpsnggDO_iQA=qxug@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Barry Song <21cnbao@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 9:54=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Mar 25, 2024 at 10:23=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Sun, Mar 24, 2024 at 2:04=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
org> wrote:
> > >
> > > Zhongkun He reports data corruption when combining zswap with zram.
> > >
> > > The issue is the exclusive loads we're doing in zswap. They assume
> > > that all reads are going into the swapcache, which can assume
> > > authoritative ownership of the data and so the zswap copy can go.
> > >
> > > However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will tr=
y
> > > to bypass the swapcache. This results in an optimistic read of the
> > > swap data into a page that will be dismissed if the fault fails due t=
o
> > > races. In this case, zswap mustn't drop its authoritative copy.
> > >
> > > Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=3DzV9P691B9bVq33erw=
OXNTmEaUbi9DrDeJzw@mail.gmail.com/
> > > Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > > Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> > > Cc: stable@vger.kernel.org      [6.5+]
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
>
> Acked-by: Barry Song <baohua@kernel.org>
>
> >
> > Do we also want to mention somewhere (commit log or comment) that
> > keeping the entry in the tree is fine because we are still protected
> > from concurrent loads/invalidations/writeback by swapcache_prepare()
> > setting SWAP_HAS_CACHE or so?
>
> It seems that Kairui's patch comprehensively addresses the issue at hand.
> Johannes's solution, on the other hand, appears to align zswap behavior
> more closely with that of a traditional swap device, only releasing an en=
try
> when the corresponding swap slot is freed, particularly in the sync-io ca=
se.

It actually worked out quite well that Kairui's fix landed shortly
before this bug was reported, as this fix wouldn't have been possible
without it as far as I can tell.

>
> Johannes' patch has inspired me to consider whether zRAM could achieve
> a comparable outcome by immediately releasing objects in swap cache
> scenarios.  When I have the opportunity, I plan to experiment with zRAM.

That would be interesting. I am curious if it would be as
straightforward in zram to just mark the folio as dirty in this case
like zswap does, given its implementation as a block device.

