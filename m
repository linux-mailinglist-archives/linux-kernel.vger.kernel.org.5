Return-Path: <linux-kernel+bounces-120022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4097288D062
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7212E1C37803
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7313D89F;
	Tue, 26 Mar 2024 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgk5g0M6"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA623CB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490491; cv=none; b=PBi1maGm9k3XtVotHllDd+WOjkW4FoWn2g/m/UkOpqF031y3DKROUK3R+r8h77w9x2iunHvFrs9jbzG6YsJRFk4t7Cgt8lMDiG71OuSx6c4ACW9rhA7RyVwtoI7jH9n+cA7R3uc7BJEs0OuNjxGoWoHm8puPWo7XSP/ZcOhhVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490491; c=relaxed/simple;
	bh=dZ+6J5Fk+PjeJSblAP3C0JsA4MYpANpWHclKUtRx0OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BB+EzYGpIwCoEUg9ZlUS5DPMa+pWwqx+HOslJ1dYevTpqP0CV3WqgeiyMEi845DbB9YCvQMrTDCdd8GPgUGXn22+uG+OnIb9erBWt6X+XnC6/6Smm1omPI8IeqnszEZjspnLphCtmFlqwmczb2Nwa9Gh7hD2cPnZ2KBbCOHB/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgk5g0M6; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c3ceeb2d04so1370577b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711490489; x=1712095289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ+6J5Fk+PjeJSblAP3C0JsA4MYpANpWHclKUtRx0OA=;
        b=Cgk5g0M62nm4Vb56yHMMiLrtXr2CrJ+oWML7R9nk2GJxpu8ZGk1P82PPBcYMnHjMVE
         ZfWxOVlNuPv4lW8ts4qlVvMlwuQx82mHZirXyViq8G5vrqnlYpsw2KMkSa+msfxTM1Mn
         BR56GPf5Z6UOt1ORiQsR5n78g+OQsTZaUAPLPPAQAqumqNdqTszzRFOcG9nVQJHRf8/B
         YDrCU0sE2npPu5fbi/NKKl+QwR3bKwzgrzw88vDfRKZ2Dd0gbp8tci34v8p1tptxeYhf
         GZ3NBJTK/HoXeovtoUgmx4ifbAPXjgkgbzfxykvdE6vxnKpxMfQVVPrsFheaIh0mpbbs
         hhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711490489; x=1712095289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ+6J5Fk+PjeJSblAP3C0JsA4MYpANpWHclKUtRx0OA=;
        b=VH/HbgPbM3XN/oFVvLlr6cEIbyljQdkZDoM2R4zD/+GNZmKaQYuK8HlX7GGA2IdNdk
         SKiY3YsoQHCC22YBC8OF0SwMgx2EaTsxyvDKo4qHNQLURbwXBNOOAjQY45TNknFjr2eE
         asee5EBZrIRmBcenxfBtoE0Gt/7qmjcmAXh0d/0LjrlDpmR1PMukcS+ErDnB9YQ7Cyxz
         eILDr0chXr471Zx2MLRYE4Qghq4eQjRBvbQMg7Vlkf0mceMeVrjoe4LQT4ubnD2EQ/Tg
         U6b6romCcLsCGgNR23JqhC1qqtxDYDZoEFcnJpHNFBFr6PucT4xUVJLaCkLV8R5XMDkv
         FCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Suq5ip2A9orlV93NngbHi8LD7Fe94axOwOAHu+XssC0txBj+zmiBhrAGNZatLtQ8S4nVeL6uWQRwhDG1ChrOO6bhq2WEd1jFi/xu
X-Gm-Message-State: AOJu0Yxj9fmr/c1l89cg7KEAo3fVCuJwDjdQkO+Xe/JffJnldbZzG2/S
	yE7fo/Ng55sVASQwuJ2DhhdjcTA7TsCmeZBmAKEci6JqxYyGOcUfi70G0Za4c+2kkuEKKtxoKLk
	AAglw/O27U6X+Cz4jinaKi9s0+ME=
X-Google-Smtp-Source: AGHT+IE6u8b177uwBkeuB4r6YdM0F34X/C7ox9GSJxMBCeshyDnY2FG5O60bDE4fwtve563VbEyxNLruaBAVoZAB4B0=
X-Received: by 2002:a05:6808:2109:b0:3c3:8308:c11f with SMTP id
 r9-20020a056808210900b003c38308c11fmr4562683oiw.40.1711490489405; Tue, 26 Mar
 2024 15:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com> <20240325235018.2028408-6-yosryahmed@google.com>
In-Reply-To: <20240325235018.2028408-6-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 26 Mar 2024 15:01:18 -0700
Message-ID: <CAKEwX=N=mbaHFwqgMsc8Zb8tCLfSeowBEPyd1H2nOO2L8Qemgg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:50=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> There is no logical reason to refuse storing same-filled pages more
> efficiently and opt for compression. Remove the userspace knob.
>

Agree. Absolutely no idea why we have this knob in the first place -
if you have cycles to compress, you probably have some extra cycles to
check same-filled page state? And that is the only cost I can think of
- it wins on probably all other aspects: memory usage,
"decompression", no need to write back these pages etc.

Any actual zswap user who has data or counter-use case should chime
in, but FWIW, my vote is:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

