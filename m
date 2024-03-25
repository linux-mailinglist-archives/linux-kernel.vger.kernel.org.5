Return-Path: <linux-kernel+bounces-117733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67688AEE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03921FA69B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532A59B6F;
	Mon, 25 Mar 2024 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Nimj4aUM"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC011BF2F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392105; cv=none; b=RVPoQ4LZ8bohoQjYci99T5Ij45PNRK8o2MxCDoN5FzKgdOhj/MP6GOJpC4jGX4X42+AbB0EI5WCT4kfnJgPZp/raiMP2dLxqLkiUOaYL1m+NNb5NxLOst8v0u8BurUiL/vBP4DfS1Ms4W7nKQd5tQh6C0UR+sTDC6/WS+j1mh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392105; c=relaxed/simple;
	bh=PADZhfoWNe7ucPHjarTTNJOD2UnITrDL1AnTL0sLMK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpUTZ0F5bg1laTslAhGZc7jHg7Ck+of6odY18YwyWD/wUGcC8WtI/rRuKMWijkcD5kDnAGHBWyp5SBf8FyKEorB8ZhABJK8THE7PzBRIzFUHmBrwB+dNaRTDERRkif+WysZvO+DKj1cTqNOj0KMClaHZ2CYoPyC7Ur66naR12cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nimj4aUM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c12c73ed8so1653736a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711392102; x=1711996902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKvUlcpLk63ACsjKDDZfWCX8E5d/fciiBf5WKGyFmQs=;
        b=Nimj4aUMyVDSVLZ6gnhT06gm3tlqH+cUqF3OXh07oHVIKSXYr81bnRTfjERY5aTeCN
         XkfOcE1ha57BucIudlbjcN8rgt4dRluN+dP/xetwN2EPy6pLnAoztkLVHRvueqlx7H1a
         tHMBQCMkJFPzCEqdB53p9EPSxbMhJrjOsOQUcjO5jfvZPOF9i3E/GcmLmsQOGduWwfXq
         kj0+K/Jy6mxuaC9QW4HsB9ASJ2qEZTz8e7po420DGogS2a/bIjl1M8xUPHN8aAiOZM/I
         WE5ffL3QauGyz/9CkAyhsMYe1XFsvDDLUnlLPAwLkWWQTUWhXgKIz6rFyr7HPM9gta4t
         zKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711392102; x=1711996902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKvUlcpLk63ACsjKDDZfWCX8E5d/fciiBf5WKGyFmQs=;
        b=SmQ/vDrFuiJDnl6cDTmavgUu1zY5z71+IrXHPNLHFPKrdz8qLK/ITagZhjFYJuVM07
         TltxwoNG0l7Y9bpm3MYSBG/5ibDRPhN2Z26h9TPMDrKg5k3EcT9luSJNCbsxkaAI7flo
         KGwg9NUVsqZp86tQtAC7GBaXAbplGF4eU+qtGjRJox+IgzW+0jB+CbC/VlH2eBjl4fzG
         xnbt9cJvNDJFOAiH1VfjUYIkhqvg2FVDYM47oG4RLPaM41xjUjzO8jYeuR6ktrpQznc9
         ucQNvMT+FxXrTLCt7c/GBSiWP1MEDtUQLHyx9Wa/EwFcschbO5/gV8XvHNR0N3mmae4w
         vg/A==
X-Forwarded-Encrypted: i=1; AJvYcCWwFsxbSOCzQcA0sa3t/VYAKZocAakNqQwAsjf8D08F+NNWmcbbBsf0PxgvhaSs81brNjuVhMp7XfU0DQfT6GYVyou0qbR+wxoLNP0Y
X-Gm-Message-State: AOJu0YzAl5wLWIphs2/b7JJCRNo1nkijYbcGhx12had40Sgm3GlzzMd5
	5aMZspUg1eoLb/8JqV+8MdI7yKUWT5a7FMHU32M3vZwUEL41OfPCdhOjXiAAPjN8JeMRobmKUnc
	ZAqCjdJl8AtE6oWoMPN2vZO2nGZ5plZDoNa2C
X-Google-Smtp-Source: AGHT+IH7U9MjyZWBEh4R0acUddTJ1Je9zTxp/hmSsCVvU8DHvMTrz/lloebRfL6eyCoYpamLylTm3XvKe8aG84lVarU=
X-Received: by 2002:a17:906:3993:b0:a46:8c9f:f783 with SMTP id
 h19-20020a170906399300b00a468c9ff783mr5661833eje.67.1711392101766; Mon, 25
 Mar 2024 11:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324210447.956973-1-hannes@cmpxchg.org> <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
 <20240325163003.GA42450@cmpxchg.org>
In-Reply-To: <20240325163003.GA42450@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 25 Mar 2024 11:41:05 -0700
Message-ID: <CAJD7tkakaLzB7TU9kDRLGTCUJ-WdkSTSt1z4eZR5vUfS3-n+ew@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zhongkun He <hezhongkun.hzk@bytedance.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:30=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Sun, Mar 24, 2024 at 02:22:46PM -0700, Yosry Ahmed wrote:
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
> >
> > Do we also want to mention somewhere (commit log or comment) that
> > keeping the entry in the tree is fine because we are still protected
> > from concurrent loads/invalidations/writeback by swapcache_prepare()
> > setting SWAP_HAS_CACHE or so?
>
> I don't think it's necessary, as zswap isn't doing anything special
> here. It's up to the caller to follow the generic swap exclusion
> protocol that zswap also adheres to. So IMO the relevant comment
> should be, and is, above that swapcache_prepare() in do_swap_page().

From the perspective of someone looking at the zswap code, it isn't
immediately clear what protects the zswap entry in the non-exclusive
load case from being freed from under us. At some point we had a
refcount, then we used to remove it from the tree under lock so others
wouldn't have access to it. Now it's less clear because we rely on
protection outside of zswap code.

We also document other places where we rely on the swapcache for
synchronization, so I think it may be worth briefly mentioning this
here as well, especially that in this code we explicitly check for the
folio not being in the swapcache. That said, I don't feel strongly
about it. Tracking down the SWP_SYNCHRONOUS_IO code should eventually
make it clear. Also, the commit log will end up having a link to this
thread anyway so the details are not completely unfindable :)

