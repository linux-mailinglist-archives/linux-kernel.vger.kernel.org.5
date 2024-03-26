Return-Path: <linux-kernel+bounces-119691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146F888CC19
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8BC1C64F55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DCF127B7E;
	Tue, 26 Mar 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy5M6izP"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2541798A;
	Tue, 26 Mar 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478114; cv=none; b=iF2+1Ryg5ARsmQ+VX+vzDeSKvjgMc01oDIHvHGJn0+7u85+4AnjRBnGI6NGtdR0K7P/cp29SzaWyBj40Hs8nEucTRI599Z5o4iW5rViA67LD90kQQGmlG16Rdu7XUcaosZS+GGLxppQfH9wpPf2zp5oEcywpdKGoR0EVAt/fAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478114; c=relaxed/simple;
	bh=6/pic9Jbejd2aRlnAlxzqdsMS/JB+QhzFMOjyyFXwpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAW0fs0OMUo6VE+q9L4ag0lYOH+9ExXNe2h/rKTrwCm7zcvCDCr7o1wngALpefY4MOF4e8c1oS67MGPi/h0hhTEl4pg7jMVsrRmAMYxiyeAsUSzkYODdMMBtjTE9tJwuG99IHWRuDoMuwSbtXSaBHUUzBRhNxuWkoDyd0vVpCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy5M6izP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29dedcd244dso4161270a91.0;
        Tue, 26 Mar 2024 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478113; x=1712082913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/pic9Jbejd2aRlnAlxzqdsMS/JB+QhzFMOjyyFXwpo=;
        b=cy5M6izPnvYov/Y7MdPWXhn0gbxEAI1x52VAe+hUcWEluxoXpNJj25+vwNGf+r5uhR
         9jjx5LnSTBLKsRFcUV1yBXhP2dqpD412VScyQXgyN3ClGuXhPdY69NQtZlUH2NUwR3ix
         ZjQsB/HrHRLbMEABawPw4533QL6C4cEqPtPGcnFIncYpsXcFvvVILrer1UmW8NnLzV0O
         dn5dcleyFTaTSJnBXVxTDwRZFRV/4BM6D0q6Ee9t9+8v33qLpKvZcSpTfR4cWSwxnHDS
         H0tZQkVdhJ3IYHlKN5YQk0taMBecB4+b7hSJVzMpm+P9GG6I5AJOJbmE7EuplPo98zeE
         yrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478113; x=1712082913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/pic9Jbejd2aRlnAlxzqdsMS/JB+QhzFMOjyyFXwpo=;
        b=P+AfkEPPqKK0Vvci9gaqnB00/mM1CmgnFEZMALic0dUhIKTJUw0mkMMeq2H1aVusoi
         Oc3SKy0tyjtDXAR5W7jgYSD8Q1rUNyZAfrjcgqOaocD3AIo2NAQsvQWO+8TxuhCyLizX
         IJbdnkYu3NjQcrwc+a4KC0DgzUAGwn4e9HhuqUK15mFb8TwPO9sw4wKZ+5QiOA2PNTEC
         JtAP44pbAPVwmPT0AUnOtlelKfLV/8h7iFrVuUKdTuPMnaCzwDLYC39w9EP/GQpsKlI5
         U5vmdDNtV8G7sjHYffUiXOyLuJEl6A0LCYwObmbCNAjHh4AivZOIVnKkvLSrUTblBD/Y
         Jipg==
X-Forwarded-Encrypted: i=1; AJvYcCXHztWtdVDT/kebbd8siSq7K9VQdh1jgnfQ18Th07jnkJ8Elt99lUzBKSKej3mqMy3Ezo0K3hIK4t+JNJ0LdodOgXC5wdCtkXZ/4nVtbR7xC2tYjZsinvLLAM5o1k3GdN6eXI/1l0cbwmUOXw==
X-Gm-Message-State: AOJu0YwZaWy9USf0Rhb9dpm3LNgrswRB4o+OlKZt5iCY021BBY2x0QQw
	QpFR2vibCdpsKgNIdB0o8JEDp5bHm5bnwTEX3lYxs3maLZ3qlJENcJtMdv50uxYMwX4qU0rTgWb
	fSDZulFA3M0ZzHRVUQ5w9oVjNQiU=
X-Google-Smtp-Source: AGHT+IHyAWSU9D8qNbpxhyoJd3DnoClvQEJ6RppgIiF5EAvu3Z5BE4Ql/668JUaxPx7e0+ORaFJGPCuvpJUe5Zqbe7U=
X-Received: by 2002:a17:90a:6c96:b0:2a0:95e2:1f8c with SMTP id
 y22-20020a17090a6c9600b002a095e21f8cmr619354pjj.17.1711478112938; Tue, 26 Mar
 2024 11:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHEnc3qApu2Q@mail.gmail.com>
 <CAA8EJprTNFgKJ_3cdZz4f_LCkYFghi-cfaj3bZmYh3oA63my6A@mail.gmail.com> <85204b78-7b24-61cd-4bae-3e7abc6e4fd3@quicinc.com>
In-Reply-To: <85204b78-7b24-61cd-4bae-3e7abc6e4fd3@quicinc.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Mar 2024 19:34:45 +0100
Message-ID: <CANiq72k1euaoqudjKy7jKCeA49JtYN6qH1m8080QGsBfKf89Lw@mail.gmail.com>
Subject: Re: drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error:
 variable 'out' set but not used
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	freedreno@lists.freedesktop.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:31=E2=80=AFPM Abhinav Kumar <quic_abhinavk@quicin=
c.com> wrote:
>
> This should be fixed with https://patchwork.freedesktop.org/patch/581853/=
.

Ah, so in that case the `CRASHDUMP_READ` target should really be
constant, unlike in other cases in that file?

> We can pickup that one with a Fixes tag applied.

Thanks!

Cheers,
Miguel

