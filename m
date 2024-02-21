Return-Path: <linux-kernel+bounces-74119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6236B85D02B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935AC1C22270
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BDD39FEE;
	Wed, 21 Feb 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/CIH7sr"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB422F0C;
	Wed, 21 Feb 2024 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494972; cv=none; b=ukkl9RD8kKCfgHRg12DtQ5xvFf7N/3VW8ClniwPn8Fn7SaDugQcba144/SSEG9ieFZ+CGLfbIa2vdZ+Ayg2ln2LA/wHExILz8aporVE3bk54tQ1CtqCAaRuR1zN9z0X/aJClA0n4TnSugbMYSbjoaJcNGa4pwAP3Vp1FojK8MY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494972; c=relaxed/simple;
	bh=Er1/Yj4kRgMptDsxOgX/0Vy7mF20U42aXndemGfp5ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioQ+9MQn6jzvnDEBWeOhzzZDU6rA91V9IP809ajTu9uNWIXoD7yYcunGg3U2vKyi6iJ2wv20YdiF1tDdyoWjhZrxVymnRGHnbopvtE4Sxrl2R339HT3Zhk04a5dlwamTwepVpydYLFz+kjUZCh6nhUhbzi0rpxjPmqabr5f2hKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/CIH7sr; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so4078885241.3;
        Tue, 20 Feb 2024 21:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708494968; x=1709099768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JPZf13eMNKV2HgJw8wLpT4e+c9bTblM2W9ZqbP/8zw=;
        b=N/CIH7srumS8guEAu4UeuEXh13nXZN3jfGQ4kIZfiz2AOI24/PEvb7K6YfS2Q1Tkn4
         ry9aoA8r+S2oms2pT/EQkUgyC6B37yT7aHSv7X9aWcV/IE6E6WC1CUkbTHM1D4bN3IwG
         D1G2bAnZ5FzzkgNfeYYAf3XNMoi4qnZjZkC5HpP/0Kour+6hHzeWfUB9yXySgFapprXH
         qP7DZvSiI2CzTNO6NcnNdE4lVadW18ln4EnHLBWDBb4s9f05PL1T8PuOljAwH6CX0lF0
         NeUnj837+o/F1UJtHdfuWpFRbxf7ToRS8QFqGeC9Qns20PCoZs6cCaMIwzuMMgyxmUot
         lHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708494968; x=1709099768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JPZf13eMNKV2HgJw8wLpT4e+c9bTblM2W9ZqbP/8zw=;
        b=WDmh5srRlh5+bXEuRiIVUBguyOArRTh/TpAO4wrbMO5k2/qaR8gHs9b+TrVixS2kXB
         ghRLMIgG63N9AvzXxe8D8W6Q10XEqhdSVzEtTQnYXskT/tvUGV3I+1/11/Wlas9bC0Ar
         l3BqXPYZ+mIkTOk3J/OSb0XUnfrZJB1/MdrEEPoETvifq+3BpOUuIimnpMpy6aEwQmnp
         ckkD0O3kHx5A9juHoNlbj0K2l4UFnSIOXXF6xF1EKThcsw24MEvl1yypMif7uIBJNTMB
         3IqDE8YLQbo9tCmztVKt7SWsavWlhH3YqVR3AewiJ67vyh3wK4xBZu09rVFNmsuWETLP
         1tDg==
X-Forwarded-Encrypted: i=1; AJvYcCUpOQqrYDwNz695tfIHXEztJBoYpRZwuN2xvSGxfaNFe8YzxBTK/sM6Xyo+dDtfMNxAQHZUZuh40cV4xCr6st9I1OEpEUjm8hRFiKXyVzV062IMN/zMrftpcjz8j/n89kaFQe5P95YMUKhV
X-Gm-Message-State: AOJu0YynNM4LrmT+OSZF9suP3aU/tuUjuc85QxFAcOri9DtYSwb3K5MA
	bGX/5LwbJzsrGdSIaLUJANvehTlbnpQbbq6FBmMlGPi/TzFmz5oOLXOU+vN+4mlIxD+GziP3/tv
	vqqzSMNvh2a+E3Y+hzlGzew/TCXs=
X-Google-Smtp-Source: AGHT+IFJKXuQPgeCmSZfa92njMzsI7UxYqgU+C5kkq1CIGhMWo2YHImStBQqYJJR/vrn+2yzJLA8Q6RPW/Tv/EyWaN8=
X-Received: by 2002:a67:ee90:0:b0:470:5540:67f3 with SMTP id
 n16-20020a67ee90000000b00470554067f3mr6657588vsp.32.1708494968626; Tue, 20
 Feb 2024 21:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220064414.262582-1-21cnbao@gmail.com> <20240220064414.262582-4-21cnbao@gmail.com>
 <ZdWLim6zYSl/x1Bk@gondor.apana.org.au>
In-Reply-To: <ZdWLim6zYSl/x1Bk@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 21 Feb 2024 18:55:57 +1300
Message-ID: <CAGsJ_4xCgSWz832N8+RsE=5StWwuc1zu3KpeCGxq7LdyVLY+Sg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] crypto: scompress: remove memcpy if sg_nents is 1
To: Herbert Xu <herbert@gondor.apana.org.au>, akpm@linux-foundation.org
Cc: davem@davemloft.net, hannes@cmpxchg.org, linux-crypto@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, yosryahmed@google.com, 
	zhouchengming@bytedance.com, chriscli@google.com, chrisl@kernel.org, 
	ddstreet@ieee.org, linux-kernel@vger.kernel.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 6:35=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Tue, Feb 20, 2024 at 07:44:14PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > while sg_nents is 1 which is always true for the current kernel
> > as the only user - zswap is the case, we should remove two big
> > memcpy.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> > ---
> >  crypto/scompress.c | 36 +++++++++++++++++++++++++++++-------
> >  1 file changed, 29 insertions(+), 7 deletions(-)
>
> This patch is independent of the other two.  Please split it
> out so I can apply it directly.

Ok. OTOH, patch 3/3 has no dependency with other patches. so patch
3/3 should be perfectly applicable to crypto :-)

Hi Andrew,
Would you please handle patch 1/3 and 2/3 in mm-tree given Herbert's ack on
1/3?

>
> > @@ -134,13 +135,25 @@ static int scomp_acomp_comp_decomp(struct acomp_r=
eq *req, int dir)
> >       scratch =3D raw_cpu_ptr(&scomp_scratch);
> >       spin_lock(&scratch->lock);
> >
> > -     scatterwalk_map_and_copy(scratch->src, req->src, 0, req->slen, 0)=
;
> > +     if (sg_nents(req->src) =3D=3D 1) {
> > +             src =3D kmap_local_page(sg_page(req->src)) + req->src->of=
fset;
>
> What if the SG entry is longer than PAGE_SIZE (or indeed crosses a
> page boundary)? I think the test needs to be strengthened.

I don't understand what is the problem for a nents to cross two pages
as anyway they are contiguous in both physical and virtual addresses.
if they are not contiguous, they will be two nents.

>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks
Barry

