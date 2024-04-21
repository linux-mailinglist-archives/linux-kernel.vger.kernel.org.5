Return-Path: <linux-kernel+bounces-152436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC2F8ABE66
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 04:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D9A1F210A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 02:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97F4A39;
	Sun, 21 Apr 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hj/kS96J"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E771843
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713665540; cv=none; b=fv+RrtKqmUdFmlj02EuWUb5zDrX+Qa7sugpk18NNOmfnud5krQ7ygIB2Aql7P5CPEHO27RlZLAz88Yy4UtTubKyFE/2+gWyIDjSgtPs+GEkONGmBtjqbbpwQjLTcg8cQOLoQHB6pj+IxCgcsaWUA4TP1gAJUe9AEHCwTpQOeQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713665540; c=relaxed/simple;
	bh=2SvaurfvCUkWptX5D26JWd2U4+u08ySTYwZw/YzCXSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEWyC6QQ+QuxNit+5cePVW9DirORcBulegh21I26l8TJ9v9ZXyTU7+L3bvKO0ZhWyldCCVbLqHwwmQQyvNGpSNfweso2Bv8EgkBS994EJ7KmlBX71jh9aNVHDRwjoLj0uHcO65nB1qvo9c9rHZG5cohgzKH8TLgicgLshleqno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hj/kS96J; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de45e596a05so3642634276.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713665538; x=1714270338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SvaurfvCUkWptX5D26JWd2U4+u08ySTYwZw/YzCXSg=;
        b=Hj/kS96J7gnLM5G51md9YukUPDaIKug5Jx4hTtVepEK3intA+14zGLNHtk3fBv1hnN
         EGiseoGHoWnTRlfp5eSefcQhrjWS3cby0/LYdA7KTRCdonSoIMuVbbNEqVwwcYcm2+VH
         Tni1rJl/TBSNlAmOLPVc+P1+YVWkuTgx8m0uTH6wOxu273dHlDLJVYoWuFfadaAK9QQz
         JqQX8tfJBEr7XCPirHG2+YQSMZLDMgzs9wWo5LBrHimT4aoJpNgNyLAol1ONp+rR0eV5
         zZNjS+B9p2nkWSVlmKQe//GubuYzE8D493rzqAC8ARgAGn8HqUWGn1+pLxyIgoXIl59d
         d+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713665538; x=1714270338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SvaurfvCUkWptX5D26JWd2U4+u08ySTYwZw/YzCXSg=;
        b=VWXZj9g6wWec9S29ItNJy06ajzV/qbc3d3wW7NE7WJjAYCn0a5xGb9vvvkxLIE4cAK
         e3B8UBkx/eLLI75pUek5JkijP7FUknA22BlEMQC/PlQFXO2qrjvft2LL6FjqmAO2ke5u
         uSIxrRSxP/7N0MI/qfjdY/kR3uQvafUmKrIczhrSP0BNBced+QwivokNQf8pEb5nUH0l
         TdKmbguMQBr1658OG8P3XcL08+LhdYoEuTDD8OGFUIrt+3w/hyKCLun1vcKORcEb67Jk
         jGyuFo/lfv5O3jpq03Hrz06ve+NU7L8bzmMTKhJubPj27467hOFWINOg7B1z0T6gu6Fi
         u92A==
X-Forwarded-Encrypted: i=1; AJvYcCWmLVyrZN48rLHrCLIfkZiEoIO9OtmnIVqQLh8oYJ4MRZxJlWOjWR5qIKhmLcm81baQ0BdVBSuO0/DRdGhNjii0cg7JH/1GkWTjZLK0
X-Gm-Message-State: AOJu0YxfgqKf3SkJHi0VbocXOpaOBAOoqjtT3uvSLWq9jLua6M/F3YgU
	wIxxfIwAegr/2k3vv8HF2nArWcflH2WNvm/Ikx1AqvYjgcf9fmTFQRBFfKXik/wYoXdRYuEhPwz
	lp4Mnu0AbQl9mbGM6YP2fjVvvsHXrTG+3HYsX
X-Google-Smtp-Source: AGHT+IEpvZ+NCf8VvrJ+IEH0w5jIUJICi8/Vm+cJlsotp2bPq6gZAw3CanYgHMX/e8014KxdM7iCiBiDDuQZF/HV44w=
X-Received: by 2002:a05:690c:6c0c:b0:615:c92:d24f with SMTP id
 ir12-20020a05690c6c0c00b006150c92d24fmr7028962ywb.15.1713665537650; Sat, 20
 Apr 2024 19:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420232505.2768428-1-shakeel.butt@linux.dev>
In-Reply-To: <20240420232505.2768428-1-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Sat, 20 Apr 2024 19:12:05 -0700
Message-ID: <CABdmKX2r14J_OD-0HDgfg6ZqnZwtR0+pi6JYq9sJHrsKBbAxWQ@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: simple cleanup of stats update functions
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 4:25=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> mod_memcg_lruvec_state() is never called from outside of memcontrol.c
> and with always irq disabled. So, replace it with the irq disabled
> version and add an assert that irq is disabled in the caller.
>
> Similarly mod_objcg_state() is not called from outside of memcontrol.c,
> so simply make it static and change it's name to __mod_objcg_state().
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

