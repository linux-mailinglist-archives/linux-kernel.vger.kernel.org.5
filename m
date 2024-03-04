Return-Path: <linux-kernel+bounces-90205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285D886FBE5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12261F22B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D917BA9;
	Mon,  4 Mar 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTJvRAmZ"
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88418657;
	Mon,  4 Mar 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541031; cv=none; b=irLI16wca7JDbmE4FCHyWB6dU+ikssh/S1yfBB31aNvo+MVOKQoZenUUtlFCakeAHI+chh7nJnnnIYC8vPhcFfpclBr0uJZESE0diMwk+JdF7J3BCixU4VNP7l6dmf9s9pMjyQWRDMsSA/yS5gmhSwhyeJ8vcqtsJV33wVKfLAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541031; c=relaxed/simple;
	bh=COjzYZytZzogQjpL44Dma0WCaVOUhQ30atrZWud4MLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gICVnLC05gsSNyQSzpiNzN+ZIHVogz1TEOrTiehXykUNQylReOw5CtlNQrfQtBXoah+KulhhfhVJlRJu7hsLRK7qI3yC9kpBke3Rxj3aKIbixuelkutoi2sLodfQ+hWQzakQUKeFPET729Ej8btljlkItQuJ4F+iH4QyxG7IZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTJvRAmZ; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-59fb0b5b47eso1870030eaf.3;
        Mon, 04 Mar 2024 00:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709541029; x=1710145829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COjzYZytZzogQjpL44Dma0WCaVOUhQ30atrZWud4MLo=;
        b=LTJvRAmZxZUT7OL5XELSP4PQbjZvp16DsfC/b/ibD+v3IhIFfuOOU8ZhKCeNyTDJkI
         eII1Rn0hKiKKuQF2xWQ0w/mgV87hpz+PmkGlQhnvQ2acW4sA9lKlU6atNy/5Xz3NqG6w
         u9C7Lvzsv/IQxpEiWqxpg20nDFG/NkFxe2mNpIHQdiB+vn0GHWinO5GLYQxXsSmg7V3M
         G5we6sITw2kXnk3pij6MatuV2wXAbTHFlV7BzrTCbCuyRyyBhRN8S3JTc7WQv6S8feli
         MG5Tcprlp/jg1OdganaPA70JEW9OyuME9zzArrGV+S0b+r6a1Ctojlx66pZ2Sel5wbgl
         gO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709541029; x=1710145829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COjzYZytZzogQjpL44Dma0WCaVOUhQ30atrZWud4MLo=;
        b=ptUFnJHZoniW0s7092duUN7xP1FM/z6ZsIHJofSSZz2pJX2rk6ai0AD0uswcF3Yvgc
         5UvsWqABDYS01eWuWr5+ASinjaj/P5tzxIiOIzspd95VTnlIV+O3cz+9ezWR216FV7xn
         dZr6o6TINqx4Tf4uMczQurxHBdimTy1uQGjccIeATNu/MuvdpUGgBN1vOeqbdPKvmhxu
         g8ySPH3W8WBanfUu1l2ssEriD2bjqtCikenAuVQEd39tIzs7wjsweIPy4LEzRkB16bPA
         7Ay4ehks0RYuZcktanqvGoAlcFpy3Da/tMOaBq7Bq6e7eljtOJTtJ8M21N+rfHoPkSdM
         xE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgfT9c2Os7ls1MjQ4K4Ij/LumwuWhuc3Ll8HYreOatnb0pYI6h7lzRKiEELXKaJh3Ux3WdUfg5re4BC+UnA4ABTfK3Ws9Gr8W9Yko1FMEbV0jEr25uJKOkW+LkUrNf/R4HYw8xUz2OHqFgUqZ+KM39UE/c+9Zyjl8YKGKOwV9wTp9lX3E4tlsy
X-Gm-Message-State: AOJu0Yx7a+b4GEka3QmPeeZMiFH2BBWRWzWEVSv2jMGX8SK/Qozp8fDK
	u7/ODhFGF0APLVWb9mENrzlnpWX+l5/pY9m/bzwie3+QUMbj8brwRpLImZWR2aNjnhuwE0uMHmW
	fBQe4X+RmuNbd8tPFQx71gFrqSg==
X-Google-Smtp-Source: AGHT+IECsylHATJ4cx/6X0FI3iJsSYZ7flxxlHaIvpmNc1q0nzKSEUjUCAC4PhqkLq3BO+APndYde2eXQYyQRw+/zIQ=
X-Received: by 2002:a05:6358:78b:b0:17c:9a3:7813 with SMTP id
 n11-20020a056358078b00b0017c09a37813mr7634600rwj.27.1709541029382; Mon, 04
 Mar 2024 00:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304034632.GA21357@didi-ThinkCentre-M920t-N000> <CANn89iJ0yBH3HskjzFUANeTxso5PpihxZcQ4VudzmfsKC-8kDw@mail.gmail.com>
In-Reply-To: <CANn89iJ0yBH3HskjzFUANeTxso5PpihxZcQ4VudzmfsKC-8kDw@mail.gmail.com>
From: yuanli fu <fuyuanli0722@gmail.com>
Date: Mon, 4 Mar 2024 16:30:16 +0800
Message-ID: <CABbqxmc43sfNz0c=CLbYFtHy6zdMMJuKWLbCm3n1OMYE6fxjwg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Add skb addr and sock addr to arguments
 of tracepoint tcp_probe.
To: Eric Dumazet <edumazet@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=B8=80 16:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Mar 4, 2024 at 4:46=E2=80=AFAM fuyuanli <fuyuanli@didiglobal.com>=
 wrote:
> >
> > It is useful to expose skb addr and sock addr to user in tracepoint
> > tcp_probe, so that we can get more information while monitoring
> > receiving of tcp data, by ebpf or other ways.
> >
> > For example, we need to identify a packet by seq and end_seq when
> > calculate transmit latency between lay 2 and lay 4 by ebpf, but which i=
s
>
> Please use "layer 2 and layer 4".
>
> > not available in tcp_probe, so we can only use kprobe hooking
> > tcp_rcv_esatblised to get them. But we can use tcp_probe directly if sk=
b
> > addr and sock addr are available, which is more efficient.
>
> Okay, but please fix the typo. Correct function name is tcp_rcv_establish=
ed
>
> >
> > Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> > Link: https://lore.kernel.org/netdev/20240229052813.GA23899@didi-ThinkC=
entre-M920t-N000/
> >
>
OK, I will submit a v3 patch, thanks for your review :)
fuyuanli

