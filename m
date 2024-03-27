Return-Path: <linux-kernel+bounces-122042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6245E88F11F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9AB29999F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BD915357A;
	Wed, 27 Mar 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqyQhvyH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697A314D45E;
	Wed, 27 Mar 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575794; cv=none; b=myBeQO7rx6IVSMcrXIaCesT17km0cfGHR8kwc49FIuj+Kj6j8JSy4006xSBPJaPVDZ0pNAMugKgrrJjn66hF6b0oYw3Yne2SUSGQWbrrXa5q0ZCY/0LN9pyhk/mHEYCa9u2e3WsnSlcSlgGYwrNCJhda70cHlJqGMT6Lr3Sjq5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575794; c=relaxed/simple;
	bh=00RSzlRyuBe4f7ztg1Qngdt5TLEXANj7s00f5N+CVlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppuYo2Oe4ZvkmJVbBJacCQVgxRnNNbU93lxLSuYipodn72nhELrUuyGBwElwKD+DG6j+MCuifSMGw1v7KBLjK6i5r2Uzz03MlMmHEFSm0NZSHgCRbcQ8LA7Iv0UtAwFmA2J+gYVxqACZ1EMKuCONDC/MTqEnp1BGQ1ryS8rnGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqyQhvyH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-414978a4a64so2030545e9.2;
        Wed, 27 Mar 2024 14:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711575792; x=1712180592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00RSzlRyuBe4f7ztg1Qngdt5TLEXANj7s00f5N+CVlI=;
        b=YqyQhvyHTr1+/6dThwtMKQQdZeT5j2PyGo72Gx1QqH0R2o6SCRQe2pKCFINOW1flJ6
         LLUqvyZ2UAZXbqVzWnI4ZD6ephmERbxqLe421NiW73ehQMXN5fIn4OV9hbidvtSLBql9
         b7bR8nBjpz5jE8oyaAhOWxY11OgGiUNfNmpdQA8c8NAEgq4kUS3eOapD0/EfUExfE4tC
         Kzxcf6EjUzOoJsNHYWjgCPx6H+Kcd+uipOfs8nw9rboVy5LOgupNxmJAbzPgoxYVjRtO
         v6n5UpeIXU9hm2udL66StrQpu+q6L0vReB8gRUNtQEXWZJ4cLY8vetx0vpzitm/PnTT3
         qtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575792; x=1712180592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00RSzlRyuBe4f7ztg1Qngdt5TLEXANj7s00f5N+CVlI=;
        b=Wn3MurqV27Y9KZm3zEMPnr4x8o27D0ERic/XjbJTwtEWfXNRLiLYWy5K0Emxdsn0Df
         F7O4NCkn1k/fh//ZHMC9iY46DfEnw1GR9PLXZgiY1wqdF5EzHJEgDGdSWZWg6qDS0vfC
         vU4xHkwmu/zPV69Fp80pNvdHOCY9+FexOctGFNBeScJAT90Bsw+d4bDFsH/68h00z9qx
         r2aYQnnbPI+KLRxDnFIqXakOC7/Ry62gAFo++mAQZl6m4nXm+O0FUEH9iX2QgmeQiyL1
         XjAsX3T4rLKlEoFYu0sWnBBkLBGsZVXohpoj/Q4eVlNlCbyIbnQ7polQz4wvxvWIrdLX
         AKDA==
X-Forwarded-Encrypted: i=1; AJvYcCWmrTJhhQFcdcCMkOoQuWgseYBcjvjymqn2HiLH3MuXZbqB7e7Te2PNQAZdKEFg1O+il1jeB3Yc2gzkZi+tmJc6PGNF8onL6SWXLl8/UdmaUgfBU3k+rOuSigKiyOx0dPpc6KWrSQJ7SPcNeSZ8Hl7NUBM+kAJzg3uK
X-Gm-Message-State: AOJu0Yw0hq3+mS1wkSDlb9Xwe5i/R+H1zjnYwmh1uW12bX23cM4VEvP7
	gzZ2TDa9zeY/CUntgRb+p/OZ71Wi8GpCQPh8DpIuKHXpQKLsqacMf1HCpsqFG/4CPin7lTrK2qJ
	H0GDjhEcqkN69edaOYQgqKXO/IcY=
X-Google-Smtp-Source: AGHT+IFPz+gCdLSVgV+lge1GoS3D+048rCxF3gyiZcTy8wrV7pmSAsfHFAsGdLwWTCyYEbKwvQL5548/KMw352SiynQ=
X-Received: by 2002:a05:600c:3b22:b0:414:102f:27b8 with SMTP id
 m34-20020a05600c3b2200b00414102f27b8mr827259wms.32.1711575791609; Wed, 27 Mar
 2024 14:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000090fe770614a1ab17@google.com> <0000000000007a208d0614a9a9e0@google.com>
 <87le63bfuf.fsf@cloudflare.com>
In-Reply-To: <87le63bfuf.fsf@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 14:43:00 -0700
Message-ID: <CAADnVQK7rpbNbo4XQRfX2G6v7Mx=2rZNu6D9my9KCi+jRpTUJw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 1:05=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git mast=
er
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c

Great. Please submit it officially. Hopefully bpf CI also will be happy.

