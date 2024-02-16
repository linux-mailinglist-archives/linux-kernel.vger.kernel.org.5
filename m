Return-Path: <linux-kernel+bounces-68084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5778575C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050201C22627
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593AF134B2;
	Fri, 16 Feb 2024 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9Xm2rGI"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432810A14
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708062959; cv=none; b=CZvGQKv9tveUK95FXJKQrPuc6kmyx2lc9aWP1hFJxwiYExzXp51DKojkGzy74Yw1t7xBnLrh/6EEV0HjNVnConws8823fSLG1rhIfvt2JIURD8xmt3o/ogbSe1xAD6AKLVpLKsk64vggaPWWhBf6BMMGnTmXFf+4KwYG//nOW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708062959; c=relaxed/simple;
	bh=2Vjrs5FZz43nTUdRRVI78nsOlBnjfKONB07Jcj9DcH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1bZTuhBaE3BaUZVjsRe4izVEFBWeMVGi7vKszrYGfUz/gmrwRvczsiyHPIt53HdN8FujtBkBijWXyBzl2hdhS5GWr2pP/ua3N97I8ViHTX8NU+1Ch6g46E1h+y2RkEEYzXcHh5Z69LooxC9sK//YveRxXRQScxzXSqCY0g3/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9Xm2rGI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso25465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708062955; x=1708667755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt3nfXVdUDnrjPi6tnq9n89wBe9oLKZaw75kjL4PRyg=;
        b=V9Xm2rGIAXKp+jDA4ULkGGeAhedo9EG/SKYKI7T/rfpTUdbpDORw1oWvazmSTUrb1v
         1qnyJEn4vFz/R6LZVlUJSoMprkwO5TWgV6y7DCdhVSio3vXM7c8pAtzn6stxtJhmsYgE
         ALlBulbuusJEeAM8fBg2FUiaWHO6TIeBZNu1CZtGRP3SHp6AlIYoKdSxrzybFfLte5ze
         /y6ygz1FfRsyn9Isn5pN0mXKtR9Kpa/G6CR5R/+L66l1zWS5Cq6PKrelrQKGVTNPsyrR
         6/SQABNeDGBxEpTLiXfo4JB6K4tW+6zWftyhzoi3CuKRLJhG3Z/mRa2jgSYR4WetCRr+
         RfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708062955; x=1708667755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lt3nfXVdUDnrjPi6tnq9n89wBe9oLKZaw75kjL4PRyg=;
        b=dpLOfFUloU2brsGt5OGPLvq5e29eJe2jW58T7zzyO5EBhKHU2khsEWJZT6Gax5MHlQ
         rEDWShZ+zRfrJ23zXAghwUexxWvLHjakuk+TxniRGm6VAmdiRmWzY0tDsc7idkRZwa4T
         FHuzq6YGTIi9gOwFdElfy6SCKvR8Ai9d4h/s09bG9ALMNcRN4NRYk9cQgJD4DSQxuScu
         8cG6xKFx4oGO21ckGhq2lPLX7NHIRbSpW95gy1SBn6vHH54cj7WJlks+J+7CXb2MjqQ6
         muHMrPoFYBN8OEJC/IDdOysa2H2Mdu3Yfj5qLMQ69Ovjm3UVeh1OeIyEgpRw7WSzvuxm
         VB6w==
X-Forwarded-Encrypted: i=1; AJvYcCXap+rvPa6f/rAUE8Da3Acai6Ihgaln+vQ3p2I+ygw+vNrzNwJri/hSByxMFzvTm2Aa3a1u1HAHJWSm/p13gR36OC82tH1yEtCNLqC/
X-Gm-Message-State: AOJu0YzaTeccrfOi1/izft4AqmrHX7y/UzOpASOClHCEGGpmxdqUjuCg
	o1dbwHM53lb1wJ1bAxMGQT3tJ1fF/q5/2/wtwyxIdV5CJ7TKph9Nj8oV8WgeyR3q88bTY9ApH0B
	vezobUMdVfVoAl+MRHx8ZtaXY+bRav7rwTw5A
X-Google-Smtp-Source: AGHT+IE33prC+j4X7W/r4BxN9/hCYWkPb+uYN6QR+91KbcEXuxHRt7COS48f5exLRZfX2quewY025NFwAlRWhfAZ8BU=
X-Received: by 2002:a05:600c:b91:b0:412:2fe0:35a1 with SMTP id
 fl17-20020a05600c0b9100b004122fe035a1mr123288wmb.6.1708062955326; Thu, 15 Feb
 2024 21:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208061825.36640-1-byungchul@sk.com>
In-Reply-To: <20240208061825.36640-1-byungchul@sk.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 16 Feb 2024 00:55:17 -0500
Message-ID: <CAOUHufYUC-oWePfqbbmm15Ue9QLfPg1G2nhXn6iSX_A460O6Uw@mail.gmail.com>
Subject: Re: [PATCH] mm, vmscan: Don't turn on cache_trim_mode at the highest
 scan priority
To: Byungchul Park <byungchul@sk.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:18=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> pages. However, it should be more careful to turn on the mode because
> it's going to prevent anon pages from reclaimed even if there are huge
> ammount of anon pages that are very cold so should be reclaimed. Even
> worse, that can lead kswapd_failures to be MAX_RECLAIM_RETRIES and stop
> until direct reclaim eventually works to resume kswapd.

Is a theory or something observed in the real world? If it's the
former, would this change risk breaking existing use cases? It's the
latter, where are the performance numbers to show what it looks like
before and after this patch?

> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  mm/vmscan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bba207f41b14..25b55fdc0d41 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2268,7 +2268,8 @@ static void prepare_scan_control(pg_data_t *pgdat, =
struct scan_control *sc)
>          * anonymous pages.
>          */
>         file =3D lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> -       if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FIL=
E))
> +       if (sc->priority !=3D 1 && file >> sc->priority &

Why 1?

> +           !(sc->may_deactivate & DEACTIVATE_FILE))
>                 sc->cache_trim_mode =3D 1;
>         else
>                 sc->cache_trim_mode =3D 0;

