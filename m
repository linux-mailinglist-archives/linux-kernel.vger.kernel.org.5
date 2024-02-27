Return-Path: <linux-kernel+bounces-83982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CB86A0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D071C23FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7544D14DFF5;
	Tue, 27 Feb 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5VHXFd/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8D51C4C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066326; cv=none; b=hct5z0tQ3FBlvmhBnW/NVtFzM37JC0ReBqXycDzvztcl5NCyav0pxULh6zBCI1G+KHxVFo9ixEyZpf9NL5mDNqe6SWRDy1pS8uopylrmnd+pPUvvaOATnH2CFD+ukBeQwik/ERF7Gm4OHiSkfKxkQVmm42/XT3g7y62idpPRL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066326; c=relaxed/simple;
	bh=CkZepzpM/VosvywX+NgP8wDx4GMNVToGsSybSS8jHno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDZJ7RdQYnxADjm14czmlVdlu2reVYfL7xfqhWtgnY/cDTAU7yjp8+xIPPtY6To6IwnKXtUTnsI5lx1ng2c2HJo6DS300skhmKKd06O3veAJ+ym0+J2IsdoRXfOgss6PX89rjh3feZ0HzGR+mr1+AJAadgz+c9RidTLgflsPapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5VHXFd/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso2978a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709066323; x=1709671123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKmzJcorTXGx6YBSA/lEZ9Y4CRB9OUfazxwO3lY1Y2E=;
        b=G5VHXFd/BfW00OZXqfB7fyESd0AgGkasc9NJJQkfIZTHgMIqjDDiFYfxu13tX1J5wR
         zjHGLgVKmHLkhZ9UxpM0338g8+1DWl6JxdHwosfukdYTVR0w/ffKL1uJNTPpBJd8SAgU
         G5JM5/vjv5u34ZfKdZ/b0Cx6PyPO0dFAkXuPXiTMoPgmNgoBC/3Md4+NQdGBryXi7Xd0
         GortOPZxtk7QG4uEpZMYik8nQ8k/bf7Kzfb++1g1URIBodoK0mGNS7wsp00WkvNRHQma
         hBG7xBiRZyZRSsZxSEaPjn+7Z9M7LuigZdgkDPcWxqago8qRsvEM40TfAJjS7kgJo9Cf
         wItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066323; x=1709671123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKmzJcorTXGx6YBSA/lEZ9Y4CRB9OUfazxwO3lY1Y2E=;
        b=m1NCjREPze/MGwZzrwCNAZqaFsyydRji0mHMVbsIJCmQ2hpZ6+fKX+4N1lxmBuQ1aQ
         c2FhT6kpeO3YEbYjbS4Bu8lJ2Utz+iYmfpv2V8MSdG9zLYHuoxsInXvj9FcNQ6eaHJnk
         g84cDcjDZustrzZrS7/DHhAFuSpNlZo3oKTwePUGbdZgEIO1Bs6oFu6C7kc2BEJ63e8V
         vagPQEQswu75zoYPOanF1RjRyVZVimLR2u5BUVnue3N7OeQRRyJhLj8EIM6VMF8A0jGt
         fY2L4GHTsQ/26s1uYqy30jvJDYORCE0L9TZYyO8XKDC0Q0u024gVNmFXRKRVourKiaRc
         z0cw==
X-Forwarded-Encrypted: i=1; AJvYcCXaAYE9HutAw3PqyI9/0lv/nZq/KOi6NxMMUamOjQ1aBC0vbxpldOpU1RBDyDuM0QaFVaJZSqEXWAoaUdG3qQQYvMBN05pfdS+3wCeB
X-Gm-Message-State: AOJu0Yyi+NCim2YIQZ16Ke/dNsEhNbqWm7GbAE/BwVRXWVScviuZz/1v
	akDUaFFn2MmcWLqydUIXDSCx1uXdDXH9q214+HlA90ZTct8EOlnv9jY4bnPYKcjm7PaUNnDnc0E
	5JGd3VmuR1DcwDv9IcQI7QYR0xhqcVyRD0MtV
X-Google-Smtp-Source: AGHT+IGDJH8gnZSClW/CxZ9poeP9c5CGVKgIi1nVGctIXngEUbUoLI/1USJmcsUnG9KZ8K+rqBZefiL7ZjbT0rn04Io=
X-Received: by 2002:a50:8711:0:b0:565:4b98:758c with SMTP id
 i17-20020a508711000000b005654b98758cmr353143edb.4.1709066323359; Tue, 27 Feb
 2024 12:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
In-Reply-To: <20240226022452.20558-1-adamli@os.amperecomputing.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 21:38:29 +0100
Message-ID: <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com>
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
To: Adam Li <adamli@os.amperecomputing.com>
Cc: corbet@lwn.net, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, yangtiezhu@loongson.cn, atenart@kernel.org, 
	kuniyu@amazon.com, wuyun.abel@bytedance.com, leitao@debian.org, 
	alexander@mihalicyn.com, dhowells@redhat.com, paulmck@kernel.org, 
	joel.granados@gmail.com, urezki@gmail.com, joel@joelfernandes.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, patches@amperecomputing.com, 
	cl@os.amperecomputing.com, shijie@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 3:25=E2=80=AFAM Adam Li <adamli@os.amperecomputing.=
com> wrote:
>
> This patch adds /proc/sys/net/core/mem_pcpu_rsv sysctl file,
> to make SK_MEMORY_PCPU_RESERV tunable.
>
> Commit 3cd3399dd7a8 ("net: implement per-cpu reserves for
> memory_allocated") introduced per-cpu forward alloc cache:
>
> "Implement a per-cpu cache of +1/-1 MB, to reduce number
> of changes to sk->sk_prot->memory_allocated, which
> would otherwise be cause of false sharing."
>
> sk_prot->memory_allocated points to global atomic variable:
> atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
>
> If increasing the per-cpu cache size from 1MB to e.g. 16MB,
> changes to sk->sk_prot->memory_allocated can be further reduced.
> Performance may be improved on system with many cores.

This looks good, do you have any performance numbers to share ?

On a host with 384 threads, 384*16 ->  6 GB of memory.

With this kind of use, we might need a shrinker...

