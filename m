Return-Path: <linux-kernel+bounces-107592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C577087FEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656E91F23F14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33C480634;
	Tue, 19 Mar 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wId3HKGk"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1680020
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855110; cv=none; b=VkCUdkP233C+CTuII+bsy9Xc/zRPuJraZQtjhe4cIZe9rQhsv++Yp5hE7KvttBJGCKUnuwwuQnUJbdZYkRxbCE1CGLAd7hK/FTsEGNpy3O75b0q9hHWF/EPEQ75K0hVq2PUS/xBWC2Y7dshbCYZTEE2454zNIHE/1VQbysmTEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855110; c=relaxed/simple;
	bh=oTq3CZN4Zju7qN7EjbzOvd+N3X+RLzsgzvo99LiFzLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsRnjBzZ265KVn8psnHrEZJ9721eeEwkQNd1u6UoqdE8/ZaSmSdgpUMPqOzOr3hlZlcVMV/ufJLHdnHYLepJ39X2vWUZKt1D0KxmDkbSFvLyDtdXFP62y1uHW2yYI2zjLw2MrkdTVYsjl5sLMihIKbvvCfV6RWHnldXYfUUmM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wId3HKGk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dee917abd5so152185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710855108; x=1711459908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
        b=wId3HKGk+TuOB9R/FZKVEozItzgiRAWvqLYFoEG4rLg6g/rw0ixG7SuMeWOlF/NHpu
         8un6w5OueU8Lmekt+2otFr4Ik9Utl/DTzUvesjDgHpuXd4BoaDJPewBMM6J3iNFjH9pc
         RMw0yjvf2VROYUcDhDrhD8NQOj2HgAluzh6fxxyTvvtKBoVTLkt50uf8z58N+aEXwCd+
         0cGSayFDHlL78VSmpwIIVM6x+sKv6gu+c1/+JobT5UqcPcv+y7RpE0cNjZ6TQe0fYJPq
         bDSA8Ie8ibQtWRa9wTOkP8zGwjjY8IsXGrlBRJWP1Bw8s/7XRu3KfYXlNKx+Sj8Skk9U
         4XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855108; x=1711459908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
        b=ARxIbdtyxzs4ezmPFxRqtN68riv9g7Lhx6KKzXGw2m4FcgPlD4kxL9e1lLB2AOrbJd
         s345Me0R9BDLSfPnDe9p61DNBct7jDfU5HSNM38Rin2Si688SCXnS9xQNCy4ecls8Giu
         E1K1D7XIgi95DLdICtjVL6iflLURYZ63UsOCHxZ7IjudbF2h5mMLXfgylGZ2fT2wA8ui
         fL3DxOZdT5i/qgLVLQ37UJN6GKRnE8+gzj2/VOjBZar58O5fmwm0784WKH4hO+gGihvt
         i0imkZGfDEmdncZiArGlvkNefdib+RUab/UkWbCPhQfoeXI2G9rfakfQRMYxIyl3IqK6
         SivA==
X-Forwarded-Encrypted: i=1; AJvYcCVXTpF98uljM23sy2N/X+LvfQ0FyQ3e5QH6czhDZ5L9QQQ7KhKdAso+MlEQtGe8zGl1PIzOcnxxvfC3ghvsuqx406LWTIP7GHYRsUvI
X-Gm-Message-State: AOJu0Yx4Ri79iJrRWReNhA6ZDUGumkAlix2gaguqNkPYryNHgedcFhlk
	5wgNaW1s4B+AYII670ReTbokOcYq22l8G2N6TCZuNps9jfXezOIc8OV/lNja8O9K/ffbO+Oqm9O
	OVE0QY3icKidq/P4Y4FclWA1E+06UhUVxmtmF
X-Google-Smtp-Source: AGHT+IFNmXcGYu+lNSQ2iexTWqZe47HUoTeYhNiE93aW579mIfvRqJBheAkUJL1ix5bvm3wn2zyeJjyY46GinXgiC30=
X-Received: by 2002:a17:903:2303:b0:1dd:65bd:69ec with SMTP id
 d3-20020a170903230300b001dd65bd69ecmr240302plh.20.1710855107477; Tue, 19 Mar
 2024 06:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000901b1c0614010091@google.com> <2615678.iZASKD2KPV@ripper>
In-Reply-To: <2615678.iZASKD2KPV@ripper>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 19 Mar 2024 14:31:35 +0100
Message-ID: <CANp29Y7SuK8P8xHa6JzAzs_NxPUN9AvFTiKfMhgLy1POGBodwA@mail.gmail.com>
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
To: Sven Eckelmann <sven@narfation.org>
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, christian@brauner.io, 
	daniel@iogearbox.net, dvyukov@google.com, edumazet@google.com, 
	elver@google.com, glider@google.com, hdanton@sina.com, jakub@cloudflare.com, 
	jannh@google.com, john.fastabend@gmail.com, kasan-dev@googlegroups.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mareklindner@neomailbox.ch, mark.rutland@arm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, shakeelb@google.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sven,

On Tue, Mar 19, 2024 at 2:19=E2=80=AFPM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Tuesday, 19 March 2024 11:33:17 CET syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
< ... >
>
> Sorry, this is a little bit off-topic. But how does sysbot figure out the
> subsystems (like "[batman?]"). Because neither the reproducer nor the
> backtrace nor the console output mention anything batman-adv related.

Syzbot looks at several crash reports to determine the bug subsystems
and in this case one of those crashes was pointing to
net/batman-adv/multicast.c:

https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D15afccb3280000

--=20
Aleksandr

>
> Kind regards,
>         Sven
>
> --

