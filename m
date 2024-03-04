Return-Path: <linux-kernel+bounces-90172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C986FB65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B9A1F22B36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956BE171BC;
	Mon,  4 Mar 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0qt9aiB"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49917171B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540002; cv=none; b=lKK/dWGKRh6XK6CNA7FJoV+t3iuXYkpT05BKGq21DUBLpKGWgAvkSI8N1OYB33gFKWx35rY++EV8zLBYYPfQXl18OiQiWFEfe1ZMH7WC2p1gd7AuT9eGgETCH7ijqoMkIoiZIyQSRHC8zahFto7bYFoTX7kPNX6zlq7rXzq2Oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540002; c=relaxed/simple;
	bh=4t0p8fRfEFH8AtnVja0S+UMsbXd66Z0IS78pE3ll0oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mCir5jZ0VXuH34SgN5CmrQ5ftXQWLl2+Qop65FKK3O/7NZ+kBNDYKXk/pXKgX2KmPF9lgcmIaH1czBoZEGnektGxMtyFWE4FXhcAARyFXcEU3N3y2qsqkbYfHmmdbLaTktSC7RvfJcRDrPgmvfXfGlobDdFV5p1Yt3bmsGveCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0qt9aiB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso21722a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709539999; x=1710144799; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4t0p8fRfEFH8AtnVja0S+UMsbXd66Z0IS78pE3ll0oY=;
        b=w0qt9aiBR9tUq81QkwVtLbFS/NfedDF3dFMR9g4YqLjU7+x/C1u0My3Pxn9fUUTrTA
         9UyIeDmzDv31u/jKiv1TTDSAgvG8N4jYr08xtPMsZdq2BL3ob6g+cCJ7ijNaH4CtCnSC
         eyeZ7Jh3jlburXwO146WARBnRmL7bEhp/Ul4rXZd9kNSPiEYk+NCkFqO1OWQ9NAVFtmj
         1XHV05ybPq5ik69tndpGm8jPpX5XZlGDjDljK6Vrj9LNrj8v/YELOu2bz/VVU5utPJn6
         0lwKmefMnPrh7qhNJ0p5Ro/etJb0favMsd/LyYawi7jReO8BJxyF6VGSi72n+TNwkhX8
         JYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539999; x=1710144799;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4t0p8fRfEFH8AtnVja0S+UMsbXd66Z0IS78pE3ll0oY=;
        b=rz3cdsaTIFcJPao78vzQfRngkNQydFJeJjIM7FCjHS+TR0L+NbqF0tLhli3E9FP78r
         pV+4xFdlMLKsZBV3f7k8qF9Y0QyZkZCNUu1Ue3bxZnHrUIrfxC8RJLndku1yw2j+v2RM
         I1eRLW4BDoALzwq4RKY4QguQjyaxnT5FzYw5BdVv/YWnBb6F2yj4ROTuzuI7mypINSip
         VUYMBnvhnpJHV8PI0XXQh5HvLZ1I8BwbW9nx45iNwWVB1JlvOTgeJCxWygm80WpV+IHh
         XnWCplfPsiuE/ZaxrIV769p1EyB43qRoPrMOuZG+HYBPN6L/T0aIzbBnyYpvWk9wiymi
         cK3w==
X-Forwarded-Encrypted: i=1; AJvYcCUyUPeteuZQBRgy7a5MMLMHF8qEsVLmWg3Df0dihCBX0fd5YKLkmZAyjWYc0uZg3Mahc3DiI+Pni2T/biZ0QghjuswJKLj2vxpw1rw6
X-Gm-Message-State: AOJu0YwiSn3+fQ5xNpU28fne0vONeuCgwSHBl1wpGsev8XivAQRZ3TTR
	EI2GfxnAmPk5bYxAK8BqR7mhF6QpWdu4N0OhnyD4Xhlys69dl30MzvVEHJ0zgmsJHYm+iXgCQJJ
	3FIthGrs5q+fd96RBvAdFz875V3g4bvJTRK3J
X-Google-Smtp-Source: AGHT+IFURhXGlP23AfBP73eeZ3jVdVKOw/QcQFPi4UL3YUIEMqBJf9SDBOsSV9UvqLTiivjkUj1SkyMyY3MCNRbV+Ko=
X-Received: by 2002:a50:cb8c:0:b0:566:306:22b7 with SMTP id
 k12-20020a50cb8c000000b00566030622b7mr287915edi.1.1709539999391; Mon, 04 Mar
 2024 00:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304034632.GA21357@didi-ThinkCentre-M920t-N000>
In-Reply-To: <20240304034632.GA21357@didi-ThinkCentre-M920t-N000>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 09:13:06 +0100
Message-ID: <CANn89iJ0yBH3HskjzFUANeTxso5PpihxZcQ4VudzmfsKC-8kDw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Add skb addr and sock addr to arguments
 of tracepoint tcp_probe.
To: edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:46=E2=80=AFAM fuyuanli <fuyuanli@didiglobal.com> w=
rote:
>
> It is useful to expose skb addr and sock addr to user in tracepoint
> tcp_probe, so that we can get more information while monitoring
> receiving of tcp data, by ebpf or other ways.
>
> For example, we need to identify a packet by seq and end_seq when
> calculate transmit latency between lay 2 and lay 4 by ebpf, but which is

Please use "layer 2 and layer 4".

> not available in tcp_probe, so we can only use kprobe hooking
> tcp_rcv_esatblised to get them. But we can use tcp_probe directly if skb
> addr and sock addr are available, which is more efficient.

Okay, but please fix the typo. Correct function name is tcp_rcv_established

>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> Link: https://lore.kernel.org/netdev/20240229052813.GA23899@didi-ThinkCen=
tre-M920t-N000/
>

