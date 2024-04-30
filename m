Return-Path: <linux-kernel+bounces-163776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815208B6FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6A9284D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0012C46D;
	Tue, 30 Apr 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r36se5dJ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DD12BF17
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473242; cv=none; b=sEARfFl10ZTZASYAKaFxA9EadtRTGbCrP+lQaeOvSAwfKuK7fWClGSpu6How0s2V/tynfFG3XnJx6MUh1M03BTROFPCqDCveOLGBlTuS0iYq8SLepHWbS76VMpS3kSypix19f/D7iU9ueInL+JaeL7DDwKl/NneOrD9KruHf/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473242; c=relaxed/simple;
	bh=uFm8Qgi91vGI3dt8K6sPdGExsyb2lsag5x2vqkD5m0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1lHHOGhQfbpdEMAZqYmwdU4aHSt9t7FpdIkZ3V6x/noTGduJ1KR9czHPR919cKzgCTHXxwFHLWwSYZeBinPag2NQUDnsLeBxZ3swSZN6fudrnYA9YY3UrI6soQMop64S72mJaqB3vQKT/mnJiYyR1N85h7ifcAngSLsDHvQ3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r36se5dJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso8435a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714473239; x=1715078039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMlLVgBu7y+Z1UA7TogJJjdkdi56Sm40tXjGRA7ggLo=;
        b=r36se5dJQCKGcfsiBB0KPc2qk55NDdx4AomEXEz65ZfuiGL7KOqwsyGy4d0l7bpWHZ
         KMF/XxGGXsq2Sp23VFet/2II3wMcf2+aW2wDlQDoxNES2itHGeaHmpu4UyRZnlOfs/hr
         b9UW2W3Slatz9A+Tg0m4xxieq3k+dDgYjwcgxN60OmVOm9aH2ohbkATvhHR7qLGYdhsZ
         BXTM5/gmahUf1BQb0mwK8hpGjmFC68ZZ0R+BqAzEoICQoO3c2TgaT6c5Tyt80tNgAojB
         w8qad0Ip9OLmBGitCify/6AIO1lNYptdp4+gjACkXIFgPxHAzk7yzIDd+r2M1Z4iuAp1
         //dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714473239; x=1715078039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMlLVgBu7y+Z1UA7TogJJjdkdi56Sm40tXjGRA7ggLo=;
        b=EsUqYwhZjumEL8bpwqBYMwN8EFolJgVNQ9QbL0SUEY4Ub+l/ZX6A/ugCVwIZewChRr
         Dva5+ScM5r0m6IwFd6flNUPcQkV9bZuWfimXwqsB0UM41otgREtjK/qJQcjROYKMSgCA
         xjNDtpOcb1LcnaSqugGBLDDKV4D1Yki8GFKpb4nXuR0+yTzZANrs6yISh+AWTeJmc1SX
         /fkAWwnxo3pXdyzQznHxgXBoesx0E038TjrvSaHFV+jcPsZHO4Ugp0MjyKAQAf44wkMN
         nCCFGZwtyXgDJF5TV/5KK8d3E6xyI3MJjgXs6oo+YtYqyhxPqdxCtezwzM12hU9bSZzq
         2N3w==
X-Forwarded-Encrypted: i=1; AJvYcCVJs6/BsHpb1PklJ+6hUsKQGB6jstmQQd3bdV7D+KfBaHLyLTCqhOs8KxiKcp3f1b/WMje6l5Ss6Az2qbAS8QfQA0ooxFH7jMFd+4AS
X-Gm-Message-State: AOJu0YwjLaVm0KeVVRXXsLs0Pl/9OqtlbPSNBpJZYgzX6s8NekH13J6b
	Wkf0tEhy2RxnsdRY4S6c28InS4pHwbMuDUND2KsXQ8atHL/ct7mxqm/2FoJJedYNafNv+ldUzTv
	iRVXVs50AOWKfN2n/G3l+1b6yGZtnLBgyVtBi
X-Google-Smtp-Source: AGHT+IEGoRSj77pAj1+8/T/SwwEZLP17Tgv8sozjKtTH7NkK88VClopgrecRadcPE+UqROtC1ej8ioxHLFgLfyHUHms=
X-Received: by 2002:a05:6402:1cb9:b0:572:a1b1:1f99 with SMTP id
 cz25-20020a0564021cb900b00572a1b11f99mr12520edb.1.1714473239040; Tue, 30 Apr
 2024 03:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427182305.24461-1-nbd@nbd.name> <20240427182305.24461-7-nbd@nbd.name>
In-Reply-To: <20240427182305.24461-7-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 12:33:47 +0200
Message-ID: <CANn89iKPrTktMF8EGV=o34ePe1vWcKHhBs71E0vOaymkhLy6dA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next v4 6/6] net: add heuristic for enabling TCP
 fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 8:23=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
>
> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
> socket in the same netns as the receiving device. While this may not
> cover all relevant use cases in multi-netns configurations, it should be
> good enough for most configurations that need this.
>
> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
> 1Gbps.
>
> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> rx-gro-list on:  770 Mbit/s, CPU 40% idle
>
> Signe-off-by: Felix Fietkau <nbd@nbd.name>


Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks

