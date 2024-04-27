Return-Path: <linux-kernel+bounces-160833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5858B4363
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CB8283479
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616112C861;
	Sat, 27 Apr 2024 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7AAPu1Z"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9F63BF
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714179248; cv=none; b=O/3UaYDXpaEyDrvfLqOI34zsJNtw77NIBniRaM1kVfDom2n+MXxWlIr4nBLeQnCoLxEK5+kb6cZLHr1dml6w4I/8HlpgY4V9uvYBscDYyeI5nRd3IIZqEv/DvRNVSbofWIW+JN4miEvQoQkdgjWOE6djhTkhKrkM8Luze6wlbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714179248; c=relaxed/simple;
	bh=XdWP+Ws8G6X0WoLcorahyHKH/OfVVPQHJgQ8LO7nJYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/AmLOCwSAojkD+GMprfovgf/eMIBXqQUD7RCcrGAwjsZVBnnm83Qon4rh8nYRYywJmfzCDTbShsOkHbSHX5Lfgday8rZg9TY3k7F7RqE82iq4qiz5cEps2P6CzzkRNw9imcAthhIUmTXsPgJTppOvGv6xyleezkLLuErfjqLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7AAPu1Z; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso4178746e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714179245; x=1714784045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CEIqz3rmh2iubHOxS8JkJvUfvEGVm+LnxGZutLpHYk=;
        b=x7AAPu1ZGRdlDyocFqCCy+lx1OHJ6eVTStvEVbG/iVzv4S0+ZCOO+5rynVDEEUaaEn
         3qXBuDCQEM2jZZjjKFZwpNoZ9MuSC2gp6WWmfW5m9cuKocGANQS5Z0esNczDJu/H0Vx4
         NXAt3bPiLczoEdeOcdAhCPJfleIGy7acn6vN1ZXR5M0RP3eR/WTGtcKx8u7F5TNrjqI4
         QIIwitYXRLvTfkZ7LEa57vfUwPlF1DnvgVH1rZQSrVOT5hUThufP5qeL/ITiXdrJFL1w
         Zu+j5mLo7n+le0CxSY6eV3sbbw5DgRuUQQjUS7x61D5DCkMnPc2o/CWDl/IJ7DEnilHR
         0Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714179245; x=1714784045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CEIqz3rmh2iubHOxS8JkJvUfvEGVm+LnxGZutLpHYk=;
        b=SBlRU+iRxS2YKF9IDsEs2cvVYpvA2zQaw+E6KoJHsS+IQIl+j8eyu00F1BIDj6yunM
         CxZML4LpWJx2eYudTVHhYyreec+UjrGclc5PmXUG2vSoGsLACLe87s9BXS67+pjySjeh
         olejWKvL0RTuf7fcOrSVdi2Wpg+l0+094F/QxMMKi/Nfr/n7dYSvqrxvbmkfk5CgH7xe
         gXUaPrI0ryXAcXxf6R+dM3fCvU29KNslfPmDicNHf0bsYd1aUiLaHuhC6CRqefI0eXbF
         4Z+M2M9SDE5HzV2EqfDg+5PYqFKKoX2ghg/smbxjU9BmaS6xJ98PBZS9IjotxGM39l64
         fj5A==
X-Forwarded-Encrypted: i=1; AJvYcCU+HsN+iIFgo8Fs7V4XD5MJ5csGWWO7t61X5ef8yBDQgJSnEga9v0FO+jOdzEaXBr452q1063vpZp6fiy1lw2PkpGau8/hyGdk3LS4S
X-Gm-Message-State: AOJu0YyTE/jrcbuWVC39VSj10M0lkeq6ZMDokzIHSTzk6dcmjTikg5rL
	YOZB51HXWa1ntY/CYQxUpGiW5dsRJxVLvb6GbL3aqXsiQhHHkJuLruKflpJ7qsIaHQmZWViMd0E
	pjWJMrQyw8ttRCEWtHRhdd1Jh0MUVaSgXSAkB
X-Google-Smtp-Source: AGHT+IH33jn2znwyrxRHKKv4ph3YkibD90xJSbJ3dZFe7grEgK0acZVtb0LBNdCXJts6dyeDEayeKUfZVGdmUnCBcB4=
X-Received: by 2002:a19:8c1a:0:b0:51b:e707:74dd with SMTP id
 o26-20020a198c1a000000b0051be70774ddmr3117973lfd.33.1714179244845; Fri, 26
 Apr 2024 17:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427003733.3898961-1-shakeel.butt@linux.dev> <20240427003733.3898961-5-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-5-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Apr 2024 17:53:28 -0700
Message-ID: <CAJD7tkbzCMpBeM1hgi6SX4SB7W7e5UZ-Akw6f76PLr4PaR5uWg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] memcg: cleanup __mod_memcg_lruvec_state
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:38=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> There are no memcg specific stats for NR_SHMEM_PMDMAPPED and
> NR_FILE_PMDMAPPED. Let's remove them.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/memcontrol.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c164bc9b8ed6..103e0e53e20a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1009,8 +1009,6 @@ static void __mod_memcg_lruvec_state(struct lruvec =
*lruvec,
>                 case NR_ANON_MAPPED:
>                 case NR_FILE_MAPPED:
>                 case NR_ANON_THPS:
> -               case NR_SHMEM_PMDMAPPED:
> -               case NR_FILE_PMDMAPPED:
>                         if (WARN_ON_ONCE(!in_task()))
>                                 pr_warn("stat item index: %d\n", idx);
>                         break;
> --
> 2.43.0
>
>

