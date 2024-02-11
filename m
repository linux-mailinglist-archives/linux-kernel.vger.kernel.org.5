Return-Path: <linux-kernel+bounces-61023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A749D850C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605F5282311
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B751A1755B;
	Sun, 11 Feb 2024 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MKFzbiMQ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB529A1
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707695218; cv=none; b=e/wiTPmyvjjMe9wqNGa5pPZZpYHWBFPG6XbfVKbFJa0L8Vkfr5+qvUh7miE6fLd7s8v0AueTLLnq6tRimkDcv8K+IjsbeXt6L4pLpIuuHs3H5I1oSeMzz5WbPYsDRAg9bnNVMWgo9Iuxk0kv1I6OhK09R9AVmUTevzQzWN6ACO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707695218; c=relaxed/simple;
	bh=OoDMMwOXEU85iB24qsi9USqczb962bXVr51fUeVYAsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N498YJjBskhDjGckqJeB8R5oxel+nK6MBQX3qGMdqqokvskwXs+NVT1GVw604qsBVPL0IDJiesm73IUcv6WV9jMxdGSWj88AJsaavADxIWbNLeCx4sfusE0q66dpwHoGUXXysi2+5E2n6TGGT92aolCEG6tSq7/ihjI7PRc+0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MKFzbiMQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso35102551fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707695213; x=1708300013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoDMMwOXEU85iB24qsi9USqczb962bXVr51fUeVYAsQ=;
        b=MKFzbiMQFBKbtQB42v42LjYWQFaJBI91iXa8AnQtzSc1ecxGjnkfV4dn09OiqoMuo5
         wPrRYLBQHBI8L7Q8lossy32Z8tyWf3gMF6KQiLWmnJplrvBwQ9SLT9xk5CNu/WNpQA7J
         PxiLKUm0JfZ9NUX2agCfSl0zBfLOQpCMiyYIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707695213; x=1708300013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoDMMwOXEU85iB24qsi9USqczb962bXVr51fUeVYAsQ=;
        b=mK2qIr7/BLhK1I4VCd+GzCMgWTvpY+i7hzXTGRspHWSM9g251rZMPYLmk7TciSbODS
         +O+45BdsnM+De7E57r4DexU3I94FB69S3/Dr9fejaulHfNRy7ADCX41w8TRT3GwL01fX
         qUye2DWq/lCq3Nq+UfPMupqszFF95BkQIsPttit0FiJMG4MOqcoVUPyOWbKQjZO/a0Qk
         ECfC0BxrSv1RWA6KEr6yWSma32T/Nv2UPY2tqX6sVImNhUe1cGm2xTH91w4yuMajr+yb
         10CUZirKHodliXJK+4BjmXLsh0XBhz7kOvjeIGYn5Q/cSbh1rpOISheAhoeWIBuZ/VbB
         oZtw==
X-Forwarded-Encrypted: i=1; AJvYcCUGivNmFi27WC6PF6D7syuWLgdUTkEX4JNj7dPs3o4EEVP2vSc1gFcUjbcJqcd5yV9QpG9kP7CQxVSKb9yLZERFKhccWQ8xJov5wj9V
X-Gm-Message-State: AOJu0YwcRzg9jQvX/D6Dw8eLUfnZ+EG2OXk1n6oVmZSG9onJdE38Tyog
	fU17RKlASRTjt3woKPB21JY+eiPiYG+atfAbjNZaTwgo4XfY2FOyXX9eJF6CEE9JQAjAjwC4dgS
	sPQ==
X-Google-Smtp-Source: AGHT+IExOSFzHAemX+7gMegZAmobbjXE6NdMriJb4xd1hGFFVJNUy3LYAG3osrkntzphf5cl74wAzg==
X-Received: by 2002:a05:6512:3485:b0:511:62af:c54d with SMTP id v5-20020a056512348500b0051162afc54dmr3016400lfr.38.1707695213181;
        Sun, 11 Feb 2024 15:46:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFi8F+frTarfotLgaKGpB5yLJC6S0v0BDv6fqcCym338cMs4/egBQHOK3C68/2+scOTThWSxE2vYNDmxaaRSk9lxyHV9X6tECwsWop
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id mc12-20020a170906eb4c00b00a38a705121csm3304745ejb.47.2024.02.11.15.46.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 15:46:52 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-410c9f17c9eso12295e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:46:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXB2OdDy6eqe4RTCHaVs0TdhWe8C+68e5fV+uPBLYlxvyk9Zn2A+oNFETbPCbUqiVJwPgDIxgQ2fjrmrRS16sEg86qQVgl0bUjMDRA3
X-Received: by 2002:a05:600c:a385:b0:410:802c:2d43 with SMTP id
 hn5-20020a05600ca38500b00410802c2d43mr214223wmb.4.1707695211966; Sun, 11 Feb
 2024 15:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
 <20240208125426.70511-2-yaoma@linux.alibaba.com> <ZcYqIOR17BHJyHbx@alley>
In-Reply-To: <ZcYqIOR17BHJyHbx@alley>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 11 Feb 2024 15:46:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UYDXjZc6R8p7nzMUGwQ7GWOLAj5Pz2bOQZkd+Pqw8D3A@mail.gmail.com>
Message-ID: <CAD=FV=UYDXjZc6R8p7nzMUGwQ7GWOLAj5Pz2bOQZkd+Pqw8D3A@mail.gmail.com>
Subject: Re: [PATCHv6 1/2] watchdog/softlockup: low-overhead detection of interrupt
To: Petr Mladek <pmladek@suse.com>
Cc: Bitao Hu <yaoma@linux.alibaba.com>, akpm@linux-foundation.org, 
	kernelfans@gmail.com, liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 9, 2024 at 5:35=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> Hi,
>
> I am sorry for jouning this game so late. But honestly, it went
> forward too quickly. A good practice is to wait a week before
> sending new version so that you give a chance more people
> to provide some feedback.
>
> The only exception might be when you know exactly who could
> review it because the area in not interesting for anyone else.
> But this is typicall not the case for kernel core code.

Just for the record, I am not personally a fan of the advice that you
need to unconditionally wait a week between spins.

FWIW, I _am_ totally sold on the idea of waiting a while if there is
still ongoing discussion about how to move forward. You don't want to
fragment the conversation with some replies against the old version
and some against the new. However, in this case there was no ongoing
discussion and I don't see any particular harm that was done with
Bitao spinning as often as he did. I actually find it quite nice not
to need to wait a week (or more) between versions because it means
that patches are still fresh in my mind when I review the next
version.

Is your concern that some of my advice to Bitao took the series in the
wrong direction and you wished you could have put a stop to it sooner?
..or is your concern that Andrew has already landed the current
patches in his "unstable" tree? ...or is there some other problem that
was caused by Biao's quick spins of this series?

In any case, I'm happy that you've found time to jump in and review
the code! My current understanding of Andrew's process is that since
things are only in his "unstable" branch that Bitao can still send new
versions of the series and Andrew can update the patches.

-Doug

