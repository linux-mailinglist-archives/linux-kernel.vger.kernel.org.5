Return-Path: <linux-kernel+bounces-133727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C0089A7CD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89401F22C61
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81481C6BD;
	Sat,  6 Apr 2024 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zO1SDI7H"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59317C2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361761; cv=none; b=K5Mm1EIvUNAFmLPNIROn1sC+Rkxn4qy8FAhAog1O/K89jJF7/UFJYHeSTtfOiwuBacyq6M19jYyeYWcWcthM3eJouUCBTGypO1MVac7oHFQaW1KlhkF3lt3/FJyFqyO7HeBOrL/RRZIyAhh4qXBPdE950nbPocCYow5btAKBmy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361761; c=relaxed/simple;
	bh=KpAjSKdrkXBv5fhkmB8UZX/hjLXR4hCJGaSDHH5mrss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDxRdGbSKqaQlR2R6aNGzAqZ4qzSqBih1yQ+oTyl8pzv1dDbHHg9YYkYAqoQbhchqq5FcmLrjkCcnhEl4C6dPrAih92QXja4hD/7o+VgxgUWpQGq5b+sk/HcZXxtIg+f9LLrYK0bhCt0iHuJwUebmvTtPZhSC6DDouU24FmwVQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zO1SDI7H; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-432d55b0fa9so77931cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712361758; x=1712966558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLJYi/uIy6sK2MdDlOJLgbHqv1oRQBKBfPlyT2agfv8=;
        b=zO1SDI7Hao4uFec5vz5KPhe9XkCtS9MVXqdz1xs50qgPOgAnDxqP5uWfVr+u0Sb/WS
         Lq+QmVBqoQYtWXYvCjpPH5JsqkRob2xvpaTs8q77Ul29fn2JyVxWqeFHsWUkZt39903k
         2/mFW9/SVMuofkZOPMYgQOev1AZyM9njhl+G9IEzOc0WL+x3B1a0x/6WPDQzDzsWiFl7
         i9s8FOPlurNcca/33vXzVp3u9tiD3fpqjJK4ZTI0XdOTC+cGvn/+bGfrFe24pkgukTb/
         46Z6Xw4Kr3Pyyn4lb0yGlCT9+xqJWOYCSHmFipoMxTIf6om5yDbuYUzrzSyDvHZoOO8G
         4yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361758; x=1712966558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLJYi/uIy6sK2MdDlOJLgbHqv1oRQBKBfPlyT2agfv8=;
        b=JVmmfnNlsX/SiG5ELx/iOu4c0p88g41NK43+YYXsDc/zYkBoi1Bcspiyshe+e2bh9o
         ASAl4FJI4mCZX/YgT0W0hNuFMmlriYAW//vTLqPIBYwugOzWouM8juh8yn4IVFTPRmwb
         mTcbzSRNWsmz34Tl09fX2ZrPkOa3+K4TmKB8e+pGOQgQeNzFfoglNKUP3hMrc+bCslUe
         SnpWlxEtIczyOa9e8LL5rRCBi6iNbmCNs6DAnhucx32t3dbNWDeAGqU+bEYA1gI96QzS
         tLK703Vv/nzuiUMMatoQE79b1pQqWmlQflekdV8qM9aJr/mjNmEdv/omA4xvdmSAoRhi
         QgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYe6spUbAdgDVPIkMumh4PAe7YpP3ois2HHMe5nTBUi/eQ344GFcuQqXInN4WiekSBaT3BIr+oXrVYOs8fiounLu2D0yptPwS23owO
X-Gm-Message-State: AOJu0Yw01VHY14mc7440OnI1u0ag7G3dm5t4v2xg6m+Kmep6JjBWCyc4
	rGEg1U+dM8/DeZ7vDsOE0xKNhwhspJjJodcCGppenmDv80YTYTESJY0vBvvxIewzZoEotp+DrMS
	yyuEJB5Q0NqVFilRf+E4uASlbWnSJwO+VjjzM
X-Google-Smtp-Source: AGHT+IHDwjio3l7mml1EfKtiOH234s8twE/rMYCk/i2c0VPCw0Zx/DnaBqN791dqwnniasoxYJ08IkF6E1rOTp4zMAI=
X-Received: by 2002:a05:622a:4114:b0:432:c041:462a with SMTP id
 cc20-20020a05622a411400b00432c041462amr109796qtb.28.1712361755157; Fri, 05
 Apr 2024 17:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405211800.1412920-1-namhyung@kernel.org>
In-Reply-To: <20240405211800.1412920-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Apr 2024 17:02:20 -0700
Message-ID: <CAP-5=fUhngjbL3Q7a3EuBSGdDKg8PFjRzpe5yHTDdeLmz4oWDg@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf annotate-data: small random fixes and updates
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> I found some problems in the data type profiling with perf annotate.
> The patch 1 should go to perf-tools and others can go to perf-tools-next.
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf annotate: Make sure to call symbol__annotate2() in TUI
>   perf annotate-data: Fix global variable lookup
>   perf annotate-data: Do not delete non-asm lines
>   perf annotate: Get rid of symbol__ensure_annotate()

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/ui/browsers/annotate.c |   2 +-
>  tools/perf/util/annotate-data.c   |  10 ++-
>  tools/perf/util/annotate.c        | 104 ++++++++++++++++++++----------
>  3 files changed, 80 insertions(+), 36 deletions(-)
>
>
> base-commit: b6347cb5e04e9c1d17342ab46e2ace2d448de727
> --
> 2.44.0.478.gd926399ef9-goog
>

