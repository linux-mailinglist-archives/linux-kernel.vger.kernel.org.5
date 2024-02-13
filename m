Return-Path: <linux-kernel+bounces-63110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B26852B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410762843CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698E82134F;
	Tue, 13 Feb 2024 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="x1xv54YP"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BAA20B2C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812718; cv=none; b=lIg7ju5OTqEOYZQpylBL7RRjjnxMnD1b35sfI/H065+PHKqzobnAT5KhrmemwxQHRPGcJFVMuBQoRoGVO3iLfyEMGeBK7ZuLvVEAfz8XyruB7fQJj5//McGY3NrYU7nfgEjRHxtLaETBQTlkTD7U6L45mXAwFnGvEBaKqupiIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812718; c=relaxed/simple;
	bh=DK6mlQkynMPzOyZm3n/CXJ9ZPl09j2J6eJlH3PufCCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E01/qyjaDRRovCVts4FxTrYjUFFBnRpZi3hu9mDsVIxrbCY7HBDkOUAmPCNwLgNdeXkgChW+LoTxP2J04ggTmDR42Dx0dh7UCtZYyjmGMyIy31VsnlIfpkkNty2qKop3oDq5YS1LlwzalO+UOYsx6qt9CiOLxeFn43J6OYAJL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1xv54YP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26fa294e56so547428266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707812715; x=1708417515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B05LEYyR3ICjwHDeiWKyMo5pzjYfYHSKORFyqZMjQsw=;
        b=x1xv54YP95vma4V6igUvg9Jsnf9pJ9DScD9ZGP/rY5NgGc8NILvME0r2RUFM8T3JmZ
         IcN0fC3VdOmCBMxtaPrVRP4WJfek/OiNymCmJbcIm0d95OnMsqKMuIrvcOoQR8fY7cCN
         isPq/GnH7tnctozPfi039HOeVzVXXMhnzEhtj2eXO0gpa54iB1CVoyPgUGMY8pwj5NBX
         YXOHDyqM1YQ7eTpITcH0In+b06H50Bq2oBOMzeNbl0Yjk0hXEFT+tr+0nXKgl7xflGYC
         FVuiNDy47T61B5TfEHxgDjlPBOB8EQ+Bdu1sWKaLE6F9h5d9i+m39stoAGhfPhlody6K
         f8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812715; x=1708417515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B05LEYyR3ICjwHDeiWKyMo5pzjYfYHSKORFyqZMjQsw=;
        b=wsLtz4zx+v5+27LNtkU1B4SQAB7yWFUkOUdiDH3iBytlxJm+QSQdMY2Iu/1OFX8DgE
         WfenAu7vjhnWgZaIQoWMhe6Acs6lGzt26kOFb+WmrRmKcaET+fgQwQL6/53ZTrkgX64C
         Bch756Edledzi4v5vawLOve+JXGQGXhmPiMHHrzZKJ4wZ8IMg5f3op0D6PAsqlaNf3/n
         t7C0+l2s/t6J1qIVVCjhs2Qp0TeA/ifiLqJglWh3RmApeYBQh/kULSdv5iHhVgUYovr0
         Hoh373GSNxGxsgo5oM1pYkwMUHz+xbU0Ud47kBcTWDJLczInBAGojoVrCpEvMXh9BoPt
         7rPQ==
X-Gm-Message-State: AOJu0Yy0qoc01L88quwGqeN+OkH4cPCb08JkU2OddVkOZoru5nmUIjP+
	C6+C8O+W6HS26viVPVEvN7dchs2oDxCxGQPSs1G4V3vZOCYpj/9lNoYdGvlAy7YwdgDRUq+1nbs
	h1aUecsJMfvUAXc61Do8hqdMgvWzaNLfLQ4zp
X-Google-Smtp-Source: AGHT+IFGO1SpbJUhvgx/bE9EiAh12keH5uH/8QOlUwjYPTDiGVD/Dov7JnNtDm3nRybHnAZ0gi+JxDOMMoe4IiWjklk=
X-Received: by 2002:a17:906:46d2:b0:a3c:bf99:123c with SMTP id
 k18-20020a17090646d200b00a3cbf99123cmr2982211ejs.23.1707812714876; Tue, 13
 Feb 2024 00:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213081634.3652326-1-hannes@cmpxchg.org>
In-Reply-To: <20240213081634.3652326-1-hannes@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 13 Feb 2024 00:24:38 -0800
Message-ID: <CAJD7tkbQmTQJU4-L_CD=aG-k5uLSWL=W=M7NKM2OgawS8xCiVg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: clarify swapaccount=0 deprecation warning
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Jonas_Sch=C3=A4fer?= <jonas@wielicki.name>, 
	Narcis Garcia <debianlists@actiu.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:16=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> The swapaccount deprecation warning is throwing false positives. Since
> we deprecated the knob and defaulted to enabling, the only reports
> we've been getting are from folks that set swapaccount=3D1. While this
> is a nice affirmation that always-enabling was the right choice, we
> certainly don't want to warn when users request the supported mode.
>
> Only warn when disabling is requested, and clarify the warning.
>
> Fixes: b25806dcd3d5 ("mm: memcontrol: deprecate swapaccounting=3D0 mode")
> Cc: stable@vger.kernel.org
> Reported-by: "Jonas Sch=C3=A4fer" <jonas@wielicki.name>
> Reported-by: Narcis Garcia <debianlists@actiu.net>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/memcontrol.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1ed40f9d3a27..107ec5d36819 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7971,9 +7971,13 @@ bool mem_cgroup_swap_full(struct folio *folio)
>
>  static int __init setup_swap_account(char *s)
>  {
> -       pr_warn_once("The swapaccount=3D commandline option is deprecated=
 "
> -                    "Please report your usecase to linux-mm@kvack.org if=
 you "
> -                    "depend on this functionality.\n");
> +       bool res;
> +
> +       if (!kstrtobool(s, &res) && !res)
> +               pr_warn_once("The swapaccount=3D0 commdandline option is =
deprecated "
> +                            "in favor of configuring swap control via cg=
roupfs. "
> +                            "Please report your usecase to linux-mm@kvac=
k.org if you "
> +                            "depend on this functionality.\n");

This line is surely getting long, but I see other similar instances so
I guess that's okay.

>         return 1;
>  }
>  __setup("swapaccount=3D", setup_swap_account);
> --
> 2.43.0
>

