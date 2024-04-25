Return-Path: <linux-kernel+bounces-157961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8ED8B1958
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE641F22F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8F1CD2B;
	Thu, 25 Apr 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjOHtVYT"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F324C89
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015118; cv=none; b=XPmGnNjjfte8ySmQz/N/sen8kRQ8TcemoKIrXdfCni1xFdbE1+YLSxn2pAguQqFczrCsCaiEVyhG5UL1zb03yD59Gfmgs2JjtcgK2pprIjDb66bQ0J0Z8zP314ZZ4MyI4cOyAuHF//qBnmZMFyZt/MyhPmeDYoJFQ/mFwiLLCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015118; c=relaxed/simple;
	bh=Ns7Fo30/xpBBMDoCH6XFa8kXXTSy9aXlglwSRJUr1S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeCBxZ2Qq4RG1kdhRT7vY5UjElHAA0xMmtP+dtyS0DUt0dIwTUPddwq7DVE+Ae3EpBhxDQP+GxXbi2/P6R5vLisshtKqeSUPAdV1D4cDaM2EeXUwoR3tvlBV5CcCEu35gXsSFJVudr4DqjdGg9pMmzFoEKcOXb83jdLebgSHBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjOHtVYT; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36b3738f01cso73905ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714015116; x=1714619916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPYiVyxMu3u5xOHBv4eVLhhrFMPrsWmts8AO796WRkI=;
        b=GjOHtVYT1xniLQ9wjvVzxdDXqV5eK08Gc4QHHABtW9UFer34tOnrfAZfhsahNWDsUk
         CZw4d9gMRi+4vXyOe/ZfqfrNxnhASnFCsGLygs1oycmJXQXzSBgNiGk0g8feKTArcSSZ
         +mAwY9w/7U53NbtIDd5DSgEdpRUT60bEHSe+eZOX4JxFQ2X3x4H6BX8ebPlRDm7J7tFS
         6FXUrYTD1EbwqHfTYoFyfyPKqH3Hgug15KatOauv4f9yWB2KXtMbEHqNhSGA4ihqkquG
         SoRSWPvvk4wG9TYMD5GSTdzXz7uCOS1jFWnin22KRlThVhGJC0wGf2WyvPNYhhoJoq99
         2/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015116; x=1714619916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPYiVyxMu3u5xOHBv4eVLhhrFMPrsWmts8AO796WRkI=;
        b=ovgDUsQTSHotfACDO3iyg/a09C8q2pthO3xfvUWAzVGk1LUsTgy//0T8lycsnkLMQr
         4n3PWlMpfJV8nI8VE+C5Ob8sl/wOWbP5eOMfTbVpFB3bZ89QvJiH1HNjKoBzpnA9dVa3
         S7U9XGxcZiZR1MGZjLDQefRJOeMQA4mZm4I4SVZ1jIaWe/51BrFJCxfjpweUqX6xiAxp
         Al9GSOTLfO2w82SP/2XEfN/beTw7qhiGHmquIohYXy1oepncem8FnzMvLamqR/R8r1Au
         IRMqgx5TcH/0emkkrttU/RT5lZ7Vr0BsZcaZaRWkHXQ4CwcKNbGhJNQpOpod8c+eBYnV
         W8/A==
X-Forwarded-Encrypted: i=1; AJvYcCWCg3PdWJvtY0qR/9KZ4/6ZoGRt9vjmBHb4Xn60hN9/v1t/eUNUb+7d0n9PNsFbpOBPI4zq6FVs1YrdH4GREJh2yM0jDsOodg1Ab7Bf
X-Gm-Message-State: AOJu0Yzf2xYiIMggbdk6HFQToXHHaADZp4c3b0rwI66n3ERj5b55MiSz
	oBi6s0iHsY4pYaR9GicCicIBqIRrq0FUekBkP11QbT9rmYnBq8Czwu7C+LUhWQnZ9hr80hRCmrK
	ZkWNSiTSnvcziq2c5n62sohf21dQLD9twZIm9
X-Google-Smtp-Source: AGHT+IHF+CVLmAdpjL8XDaGa9FnoI/B07c0ipnHIB8jLOOAXa3rQAeDSGJB4Zy4e7sRp9tCchiO6pzYblkTQeU1g9WY=
X-Received: by 2002:a05:6e02:68b:b0:36b:2eee:85c2 with SMTP id
 o11-20020a056e02068b00b0036b2eee85c2mr95258ils.15.1714015116024; Wed, 24 Apr
 2024 20:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424230015.1054013-1-namhyung@kernel.org>
In-Reply-To: <20240424230015.1054013-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Apr 2024 20:18:24 -0700
Message-ID: <CAP-5=fV5mgVqi2rEgV1hY0BSCZ_6dLKjc0Mp=EDxDirzmB9qPg@mail.gmail.com>
Subject: Re: [PATCH] perf annotate-data: Check annotation on perf report TUI
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 4:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> As it removed the sample accounting for code when no symbol sort key is
> given for perf report TUI, it might not allocate the annotated_source
> yet.  Let's check if it's NULL first.
>
> Fixes: 6cdd977ec24e1 ("perf report: Do not collect sample histogram unnec=
essarily")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index dca2c08ab8c5..f5b6b5e5e757 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -906,7 +906,7 @@ int symbol__annotate(struct map_symbol *ms, struct ev=
sel *evsel,
>         if (parch)
>                 *parch =3D arch;
>
> -       if (!list_empty(&notes->src->source))
> +       if (notes->src && !list_empty(&notes->src->source))
>                 return 0;
>
>         args.arch =3D arch;
> --
> 2.44.0.769.g3c40516874-goog
>
>

