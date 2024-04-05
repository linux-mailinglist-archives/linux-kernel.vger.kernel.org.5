Return-Path: <linux-kernel+bounces-133542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAEA89A54B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3BF1F230E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D417333A;
	Fri,  5 Apr 2024 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/CzELmz"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A55D734
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347100; cv=none; b=IVEvoh1+IEroHwtf6lYHxd4KnMmcTyLcw5S3az4p09CJHdDhA8wI9ODV04lvLkTHq8rh2qlSLQ6A+tNdg4Bly8iA2Pxpq+Q+prdrBVhaAGtuW2lEgwF6w12CqU5dSSc5jzcZGnZZCoMNxFtS3z7M+6OZ+mDEaqPnlDRUeVedb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347100; c=relaxed/simple;
	bh=+mL082QxeIJSEgTMx+s0vW50/VBKne3hRMLli5pG5H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAjqH+g+hGan7w6v+9qw3VvYzKU2mmQD4W+FbtjT/QDGIcnKqkEEuxrfr9l8PgfK1NviSvFWbWeaNZdoYso9IWwkQNhCwo8Oi1foce2Ik2+x7cSqp2jiiAcBmAO73SA7tAq+LdlTbQl+NRn+kyqSF3kbP3EbhMl855GIRkhoAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/CzELmz; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6992f97ec8eso14923666d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712347098; x=1712951898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mL082QxeIJSEgTMx+s0vW50/VBKne3hRMLli5pG5H0=;
        b=j/CzELmzd+1JnMx8gjNM+UaqsPW/30HaIwbrStCY02CLMV+t4swdKX7Q7TkZiWzpeO
         gpryeMNZV5MEkIE1BRodr76gAhn5iC7/oCPNnEjLTo7MyLCDOuQfYKuUq5BAcDSaq9og
         mibio2e3eEGOy9xuHtDWFjLHOVlNAV78RJe6iFOShXGxjYxvD/nbnmZK3J8q3r8yUus7
         1RyE4MjE3YWzr0E2e0h4K2lFMpJmayGjdt4OwgjePBYqWMC/KRcU3/TtLImi4hER5fpa
         MqjIvyZuZnyQsTfxo14smlB/50Z/L8cQvhT29Pj87rDmindslMPSX6Fk920ozC+8JSWX
         RuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347098; x=1712951898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mL082QxeIJSEgTMx+s0vW50/VBKne3hRMLli5pG5H0=;
        b=m1HpeB2sgRdE42rfOk23gAkpDTn1cOJ9IDrKem+i96vElQn/v/C44s4LeZAe/r6AhJ
         mdCHYJr+eh1XHVzasnes6zUfRgbwnVV+Y+10WmUALR/a06xnw66gsI8x811+4pO00RDt
         zqlj/kxkoaRhpcna6TO/0jUHnjUbD6+8+sfTW1W07dCf6PBFjE3U8WbIHI76pgJeuYTi
         ehwaHt677COB8xdnsszqjMF5MRF/TiJmQ25Z0OUir50SJyF1nQ7IC2GATVKxV1X+UkhZ
         jJB8yCM4I/ArWAajI5lUZhZ3e5/B3pQcnnoW/klKkHr+CpO1AX3olejzqdBY7xs4V/nr
         yNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEL+PTlkw189vE5JaLBKIfCMpuzRvf0riw2zorsmm7GvEwXCiK9Eq3AN3YrxAQT9bsRTy5NRX/vjWLimhawWhAF+spzORi4VEMgqy4
X-Gm-Message-State: AOJu0Yyh865NXrxFA6xduJL9m2PLSI1n/1DxtJF4I9cag0l80UyZhPcl
	iyjzpXQ+50O119XOMkt1SsQxc04OvnlzqNjp740tNMT1lS2hQK3XQLLjfm37SGh1NPS3z6n3VV7
	Mkiej3faiY6PYJ+7a1N4F726LOdY=
X-Google-Smtp-Source: AGHT+IGJeOvjs6Df+ilLIgIedVl5rv7IXLuE2FaU8iUPq07W+8Gyfq8ucFQn104YkKFK6J4jZTyQ/g/2ytKuAYDqLoQ=
X-Received: by 2002:a05:6214:194f:b0:699:2274:b229 with SMTP id
 q15-20020a056214194f00b006992274b229mr2673929qvk.14.1712347097699; Fri, 05
 Apr 2024 12:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com> <20240405053510.1948982-6-yosryahmed@google.com>
In-Reply-To: <20240405053510.1948982-6-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 5 Apr 2024 12:58:04 -0700
Message-ID: <CAKEwX=NDKLSge_3M9DOBsSo7zNkvwdkE6aNE0sLAYZ2GZzn+vQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm: zswap: remove same_filled module params
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 10:35=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> These knobs offer more fine-grained control to userspace than needed and
> directly expose/influence kernel implementation; remove them.
>
> For disabling same_filled handling, there is no logical reason to refuse
> storing same-filled pages more efficiently and opt for compression.
> Scanning pages for patterns may be an argument, but the page contents
> will be read into the CPU cache anyway during compression. Also,
> removing the same_filled handling code does not move the needle
> significantly in terms of performance anyway [1].
>
> For disabling non_same_filled handling, it was added when the compressed
> pages in zswap were not being properly charged to memcgs, as workloads
> could escape the accounting with compression [2]. This is no longer the
> case after commit f4840ccfca25 ("zswap: memcg accounting"), and using
> zswap without compression does not make much sense.
>
> [1]https://lore.kernel.org/lkml/CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=
=3Dkhn1_TXvA@mail.gmail.com/
> [2]https://lore.kernel.org/lkml/19d5cdee-2868-41bd-83d5-6da75d72e940@maci=
ej.szmigiero.name/
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I see fewer code to maintain, I like :)
The code LGTM, and we already discuss the justifications in the
original series, so:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

