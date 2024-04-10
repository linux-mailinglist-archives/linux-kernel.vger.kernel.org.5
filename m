Return-Path: <linux-kernel+bounces-138358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EDD89F01A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A8F1F22CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264BA159218;
	Wed, 10 Apr 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4qWInpE"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087D155385;
	Wed, 10 Apr 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745835; cv=none; b=sCwg2RNkR+0cwO39tLWXHMcj153lLmvpsjk8VZOtBDMX315BClZP7wg6vlb+o2pc/6C9+ul7HCoD2HY4ObHHUuaw2rDqYMYyuQ+Z7lWy11zp9yPcw1PkXaIp+YQ0fKm+OFNVp0I+PdFuI9s2jpS6U9YFDuA2wAwcvm27HR2P3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745835; c=relaxed/simple;
	bh=CMXlteTKOwFAuVMW0aMjJuXqhJP5cUNUL11/P+b21/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1Mhy+FomU48vR8aq8pXg+Jw2j+HvDovNfdv7nkG/rryE2LG+mxWLkvhGQC+q6PuuaiXdiOOruwcHw7p58ppQQfCQ6L364qOzfwN6FQ2VCUVq/pK4w3lM8tHkDsMgRSELQEUKabXrAR3XBWDBDP9V67UkFO9/Y2CdyP4fGlNdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4qWInpE; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23333dddd8aso54356fac.1;
        Wed, 10 Apr 2024 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712745833; x=1713350633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1Sp7n1FvxcNzxiV/M3Whh5xnznJqzGBI91xq3AgOsc=;
        b=m4qWInpEPQTK9n7pQpzT31t1omK0K8TSleOPXKDBI9LQh4tZv1MdhH/O0xKDlfEAxX
         sOVehc+QaG8mTxlJ5SAwJwKc7xLTN94ACvbBPeebkNPTbo0utQrxomxDYMCKA6aaMme4
         eAs7IuKkfwHjtk6tZg9WRN2lsURdmSdx9uXIxRmeHKxcN2Fq7fWZW5GqJFhqz3vCjSg7
         hS0h0Gsa70YtMnaSGPWugFNEyC1RnINpfgiVk5s3UkGFVRiOERwWD9Gxdtqy/tJauToV
         /zuzlqzzsRj1h1SbP7LB9PSa7EMDJiVlaw5btP76zwWH2XfCkwQOtH2ShzyCfmm3Y/oI
         2psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712745833; x=1713350633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1Sp7n1FvxcNzxiV/M3Whh5xnznJqzGBI91xq3AgOsc=;
        b=RQIzXWGNQJ93L/h222WePSASPA2GBawxW28OEYsG9+GWs9PcmkxxbVHt8Rc2+zrCv4
         /X2U9viCXqb7wqQ/+F1I9aGmnlmOiYnK6M/+PWPqVaMD8Bvobym6WdyKrsLICy21MjN6
         SGPulGSdSycgzEptLAcARUhJudBIBHLLXiX9sT/kB2qlofFIMGr3VTWg5VB+R6xwmUok
         jnUV2gE5xbeHWfAFlk/Kv0JYh5d6Ys/jqJNL9wOtFm9aq7ye8YABu8WfmJU8t5x6DFpU
         Z3tpZdTaMWL6zGhS6mBcnDEsfVNHZYiVDCBnbB93UbbMnYkjtKjFZoiZ/AmpSavgGMPu
         UJ1g==
X-Forwarded-Encrypted: i=1; AJvYcCWDVFe6HWN8xn0QKceaE4KS161a5x/O9YtVvwdeODJWCYqOU7gMoJDRXrlToY84LEFGDuG4jUB+6ChnsdfpNeSK38NsZKzYKKi7i36Zqk0e4c56HlR8lMHdg8TM/sDfC1SDgxS5wuFRjw==
X-Gm-Message-State: AOJu0YyA40LI0MMM1vjQb3FIITmLXObFuI11eGsyFDslpMpOUEK5ouoq
	LvQ8ypj7lQ0EUYXlB664FmIxSeO3VONImfouV7iVV7/YWOyi8Yvclahrm3Yu2YGcTfEJbU20080
	lAd9VLiZdvUfOygBiefBQlmjpCY8=
X-Google-Smtp-Source: AGHT+IEGPf5fgJ+Ji13oItqw8ThUKQ2lo5EoXR03Lt9sU+JG4aSaJBKXhCfpCYKEoA5qiJCcmGLynCsasGEkZeYqbCg=
X-Received: by 2002:a05:6870:1682:b0:22e:bd35:d3fb with SMTP id
 j2-20020a056870168200b0022ebd35d3fbmr2593686oae.22.1712745833092; Wed, 10 Apr
 2024 03:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409153519.291205-2-thorsten.blum@toblux.com>
In-Reply-To: <20240409153519.291205-2-thorsten.blum@toblux.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Wed, 10 Apr 2024 12:43:41 +0200
Message-ID: <CAMhs-H8EByNhBAkhDvtHL_ZUgLnMFQcR1zeYhaKQSg-13uFnVQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: Use min() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: John Crispin <john@phrozen.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Tue, Apr 9, 2024 at 5:36=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux.=
com> wrote:
>
> Fixes the following Coccinelle/coccicheck warning reported by
> minmax.cocci:
>
>         WARNING opportunity for min()
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  arch/mips/ralink/timer.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
> index 54094f6e033e..d271ac98312a 100644
> --- a/arch/mips/ralink/timer.c
> +++ b/arch/mips/ralink/timer.c
> @@ -75,11 +75,7 @@ static int rt_timer_request(struct rt_timer *rt)
>
>  static int rt_timer_config(struct rt_timer *rt, unsigned long divisor)
>  {
> -       if (rt->timer_freq < divisor)
> -               rt->timer_div =3D rt->timer_freq;
> -       else
> -               rt->timer_div =3D divisor;
> -
> +       rt->timer_div =3D min(rt->timer_freq, divisor);

I do find the original code more readable.

Best regards,
    Sergio Paracuellos

>         rt_timer_w32(rt, TIMER_REG_TMR0LOAD, rt->timer_freq / rt->timer_d=
iv);
>
>         return 0;
> --
> 2.44.0
>

