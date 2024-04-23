Return-Path: <linux-kernel+bounces-154847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC748AE1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3782B2196A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118560ED3;
	Tue, 23 Apr 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Od7jFFq3"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44B60279
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867370; cv=none; b=gmP56XZ2CNzYFcMtnqljs041RwlHTUGVdRYIbmR/oiCfmoyVhhWnvAXx4MheEktKZKixVQVDVmD4FVNCaAePqA1SFEc1pLjStREqEMp5fVdbVfM33xLZfLh86q3ek5oKF+Ou5UePSw6V+/dUWxyNaQjnLvDcLTJP8XxwA5Tb7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867370; c=relaxed/simple;
	bh=jy5arJm1forKrmneoXB2SHX8PNwRuIx0u7xPry8cZsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcN0Vq71hBNMEns8db1wp/W9DbuvOOpiFmv04QMfPJ8Z7+XJ17Dh3phYdIzuvW1pwREwvsPthMFA4lcokaIp4egGkUzLB3a7v6HNCA7x5v8WtvXvf+qO9GT8S1r0bZnUNhViiI5aoKoLxtzGSp9iHOLJfL2anevTz8yno7+xqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Od7jFFq3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5720583df54so8698a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713867367; x=1714472167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3NXpsdHuYBobJGGyVWsy5SU7aCIFWQG4b8AIKli8P0=;
        b=Od7jFFq3mqrPpd6LeZRscG0mYmp8d1sW0jlQA1P8HTZeNt0jtOhYN2LudVgKLjB6AX
         jtH96KI0VyI5WnpVyzCwvrftcwDB/vb0qS00HbkqXH0OCMTCQu0wFQ+GGsIbkXz7/sa2
         /8XtUG3o8m70RUN5j1JmdCWtP0/EqhGrsuVsEbHiK/RVm5AkbDj65CC9CG6VCXczeg4y
         4OXfn3kP0l5pSJY9+0SBKTeVP1sisHMvFxbtJWPKBe2DqvYksUa9hBNEyYM3ZVLIxGly
         CJUAEuOm2p1cVU2TGa/XPcXIlMzOINxTo8pFQlP8DVZSMx40Kgs2psAsLWzsA5+cbI0h
         RUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867367; x=1714472167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3NXpsdHuYBobJGGyVWsy5SU7aCIFWQG4b8AIKli8P0=;
        b=D5emsFxPl7dC8bCfmGJ5D3HzEI+tHuH2AjuT6zPIqyowXcjDw5EeGiBuigMx4e68Gb
         hekLqKyxM2i6WCTmT6yIXNIStPnJXd2dazOMiGind6zwF4dXspvWvX8DKXHwfAos2nM+
         CVWaiTS73fveB3LQpdoWwa9ti1L1hT9MWBvtHTVdj5HV6SL/LR1e/FFqvqAD8X0JEINY
         ge5pgptusMfH2E4MdvFwsqFxdVQFi91Ycm1/3jiQBWhqdXFjirOo2Cux9cm+YUhsHiZA
         ujTRqmcl23xstlrvDzAoP3mdX9G+Hz5LS/mjvqh7eY3C/HEY7FjPvWtBppSYWol01q6+
         HeQg==
X-Forwarded-Encrypted: i=1; AJvYcCWy5ZsbL6rrwDY6PXj4i1bktQC293a3o0Jx/nPC/d/qda99SoqpBCMsz6p3hoS5ZkyFFxXuNYgsKoC21wJGioBARg1z4EVWiJbh1mH9
X-Gm-Message-State: AOJu0YwZtomPvjj4xcdA1DFV53J61kew5eq2ryVhvpx0U+SbMPK6khfG
	oInw6msdm4QrGJTEUjcMNop7MyLPtkqq1nhfQCB4raztSzetk6RiuQK/ng80UcmNdrOjq9yfTS6
	tQxGqXe08735TAUOWNu5a005UUosYF00bckLN
X-Google-Smtp-Source: AGHT+IFIa/gpuCj2TMGZXBVHlclRlxTnGu9zd7qdxOMxi3vxfztcbE20f7CqYCAjND4a530cK1sVU/pdfE762+OAhVU=
X-Received: by 2002:aa7:c147:0:b0:572:ca7:989d with SMTP id
 r7-20020aa7c147000000b005720ca7989dmr105916edp.3.1713867366480; Tue, 23 Apr
 2024 03:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423094117.93206-1-nbd@nbd.name>
In-Reply-To: <20240423094117.93206-1-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 12:15:55 +0200
Message-ID: <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:41=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote=
:
>
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
>
> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
> 1Gbps.
>
> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> rx-gro-list on:  770 Mbit/s, CPU 40% idle

Hi Felix

changelog is a bit terse, and patch complex.

Could you elaborate why this issue
seems to be related to a specific driver ?

I think we should push hard to not use frag_list in drivers :/

And GRO itself could avoid building frag_list skbs
in hosts where forwarding is enabled.

(Note that we also can increase MAX_SKB_FRAGS to 45 these days)

