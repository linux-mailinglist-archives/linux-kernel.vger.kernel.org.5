Return-Path: <linux-kernel+bounces-135077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364BA89BAD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C281C21AE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C544373;
	Mon,  8 Apr 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlTKG20M"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F339FEF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566053; cv=none; b=olYZQqS7YROSt54LSHzMB1y22QZpOHmdFQvivDVMlWc25w6bC3KaFTHIHap9pmQBGyLZ9Rb9/MLZHPffA9pyDLv90JNM5uB4ngxV5MjH4fTuV2ToygLrplXsV/PGNY3oTaUt1A39/vjIYf//HkflaRDyWgx4tmb/oLT+cIZgWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566053; c=relaxed/simple;
	bh=QzcxQPI3IyP/jUjuwQ0bVrXwj/ZU/uIBvO/P66ZK9IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VODAeOsTj7ZFZ5ZwWRDK5EeKToLPIWxMa3sLxaCnDju67ucCqLcRqE98MguGeFJACs9h4lcVD/dC2Gd0GPFGgR2RE5KcROM+ilk6G8f2+Jta6EC/yAw0t3fFFqfWTuZiRmfSS/iC7xpye2h6/1bdw8/3+67U4oT/omPRehi+Oug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SlTKG20M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso102105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712566049; x=1713170849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzcxQPI3IyP/jUjuwQ0bVrXwj/ZU/uIBvO/P66ZK9IY=;
        b=SlTKG20MmRipn3yEruDhbdhy1n/3GByixoWO09RhWkfRazZJ2fPKPSvuX2UA0ZRVm8
         SqlCdMrAnaNpZMcPqADxpA8dUHMyd/bsJpy9Lq9z586T0B3g+xYfj6iuUyj0XqsASTO3
         3kt3BGzdTpSXqDuB1kMaixXkl19wxk6qWmGoO+i/qRS5zvNHUcdeXA2hONs35VDceNtn
         VubifBcL7nC0fwpRPFuu148hQsY96uK2Ya79bbylLqsotLcIdT4Mgs+Sx5j5RsJsGKoS
         nAxSGd0yd+kmFimwGqhHMqqrPHqpwN2VqEzbZ4DbpYy/jVnadeuqM5yQLeXaNJA9qdzf
         a4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566049; x=1713170849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzcxQPI3IyP/jUjuwQ0bVrXwj/ZU/uIBvO/P66ZK9IY=;
        b=JvAWUCx+PWd7kXjS4SKjsACPO3PPSydOrebwj53rtri37dYRbO6YcwPTOKmlp9DYeO
         gfeOTk71n6t9G1oisDrOwR0hOCLr95gNUu2HGl/gy9bxv3Hq2jbaDbGSxuA1sc3UveTH
         efxQVPuqUAzT8jRbeksmHh75jbYi/eiSWzvkmZWP5u1eDvwDQ+ZDvl8FNNZ33ClRK6c7
         c+cAeUV/vk9B5drqvtsKxwaX8fLT+RKe+qX9+ni3Bx6+GZ5yQcFOYN4kJDGx6AgbE28h
         7DprTixTtjihRHg97agklLqqOx+1EytiWFcn7Ad7qlBxspa82qzg2GlObRN3pTXzsTFI
         t0rA==
X-Forwarded-Encrypted: i=1; AJvYcCUJyh4Bqtl/VEoGwjJU+2C61SqGvLt8WzvmhixlKXa6EDme0WC8onvW8dNhiWQHqJLZSTqlUfz/qU3WBdL8n5l8V0EJZOZoW9E8b2hJ
X-Gm-Message-State: AOJu0Yz62Vk/qfdSj8tSUiwf6EK75b1Vj7YwV7i+P80melmjvMky6Vqf
	xTcWEV6ysPo8ehJTv52iJuhteVEcJGC5vo8WBA5+Vg9Rk6/tsoXlVibksDd64wM0iC4SWCawSSv
	lMjrxMUKu9G7i5fYxuq+h+ao2uWpmIKRFUXXV
X-Google-Smtp-Source: AGHT+IGBU3W5b6Bbf2trBZ0RVAaeYUlTSMt5FGnz2wT1laELbiUMJrvAcX+Wn64szbd4/ezZ2w6YZ6LqT0zMbPg+TJU=
X-Received: by 2002:a05:600c:1f88:b0:415:4436:2a12 with SMTP id
 je8-20020a05600c1f8800b0041544362a12mr274354wmb.3.1712566049128; Mon, 08 Apr
 2024 01:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408074219.3030256-1-arnd@kernel.org> <20240408074219.3030256-2-arnd@kernel.org>
In-Reply-To: <20240408074219.3030256-2-arnd@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 10:47:15 +0200
Message-ID: <CANn89iJnBYSOU4QroWPNoo2eTt8R_2MtHJ+thWm-oz01O7TgKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ipv4/route: avoid unused-but-set-variable warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Kunwu Chan <chentao@kylinos.cn>, Zhengchao Shao <shaozhengchao@huawei.com>, 
	Sriram Yagnaraman <sriram.yagnaraman@est.tech>, Maxime Bizon <mbizon@freebox.fr>, 
	Joel Granados <joel.granados@gmail.com>, Kyle Zeng <zengyhkyle@gmail.com>, 
	Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:42=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The log_martians variable is only used in an #ifdef, causing a 'make W=3D=
1'
> warning with gcc:
>
> net/ipv4/route.c: In function 'ip_rt_send_redirect':
> net/ipv4/route.c:880:13: error: variable 'log_martians' set but not used =
[-Werror=3Dunused-but-set-variable]
>
> Change the #ifdef to an equivalent IS_ENABLED() to let the compiler
> see where the variable is used.
>
> Fixes: 30038fc61adf ("net: ip_rt_send_redirect() optimization")
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

A Fixes: tag like this seems overkill, I doubt W=3D1 was the norm for
old kernels...

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

