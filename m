Return-Path: <linux-kernel+bounces-138973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA189FCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC7A1F229F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083717A93E;
	Wed, 10 Apr 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctuW726J"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740817A920
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766557; cv=none; b=lXCPewfOpZEB/ySlcDn2CvyiqLmSqGpbEeUDe1BPcG2oTYrwaiLWgO61UXHSd8vluzbuI67j+g0PYVt2XYzOpWc0xCLcbkY11juONBzpp0AzgZEJPXQUog/P5i4K56sgsIda4IP2VA9Cadan6154DzguHeNzz6zaTC8gco7YwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766557; c=relaxed/simple;
	bh=c7/YycqgVy2m8nKCbgF/qoxGf/L67OHl4PRnam+VepE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHCEbRaSR4NYvJR+4VcbDH4YyLN4XNhvVFykeYOBE3v+jqipGbScJR77WxUZn6srsW6Hk9sCGCPxnuGjnWLMlMesskcLNMxwKog/zqAVqV/nrl4nvNvaXW4Qq00mkmgxfvLRUvvJDAWZ3BHH0TmbQGwQ0YZf56ALea9HxXKW1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctuW726J; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a3a4c9d11so177465ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712766555; x=1713371355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54EjqRfmjYGMgdcBMrDuq0O++H86LcfrhBJL4buY5JE=;
        b=ctuW726JUFaG2KcAQsQeZfy7stF9bx4XEywSVidF/RHUiJDFXXbtB7Y8VwAPNq6PH2
         syEbZ2sc+0AWjbzu5DAAhi+GUdVB8rxvcrgS4hh42lptfyLMXA7nAYUniCu/64pmQaRh
         vpegwB8nWpacMItC98Bf4pyewc+HerjVCNDuS9yST9TpGmhaNPUeL11zE0m+Ub70WvEO
         g1UYZtOglVh43zQLBva4gJXsrFVXuCiRq8El7bYnpqbnPs8RiaqFtDJqvJx83oXVai/K
         uMMNwyc3DYxq+NcHAuwZ3GCVoZGvhARnFjScevaXSbIVor2gL4cDwLPLRfaZOrh5FTew
         MwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712766555; x=1713371355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54EjqRfmjYGMgdcBMrDuq0O++H86LcfrhBJL4buY5JE=;
        b=XbgpJO+oWu/2ZOCXrcawoqULfE8kyQdy9Jn0QbfA52MtBhqZNfPlqeHhWcIDTPAJEx
         PzGol3X2ggUt+0nNYYQQliv4gMnULBPVQdENqRO2AppRctTAzoGONCOYUertnx7iK/9F
         K2AxSREYEtOViMvdw841t65Sz3tT0DlglaI68xcakFeFXIXmL6VgkTfZCbPRFDbVCytp
         1Niacqmp/5WgAtBdThzP5E7z13yl6TYyDVBTNhM1I/KiiKDr3Pv9u1lJUZocrOiIkwJW
         Z1F0TPE5B5BX8tT5AyQGkI9yuEAhm75BB399W1qpwO+klh5S4dNMK6DIXptYPe1xOzrM
         R3rA==
X-Forwarded-Encrypted: i=1; AJvYcCVflN5WHJivJlui2uE+fcnj2VB18yxezFaVKr4sDF9LxQiI735W/0lfEkWhkJhQdPnnM+p9sGG+lRENQ2iZaboHwaEPQFe5h08ZxIDr
X-Gm-Message-State: AOJu0YwYPsLAR4tnrnMMDXScGWxe5uy3MKX5Lr2cbr3dXEe3LbDEJ7uF
	gADLAVfFvYgv8MsUuEOVzU+Cqw3W5yd9Kcg40QyKGo0CQJNUu+bJrRhVgBAQVbzY838WjX21Y6+
	z7jflgEBbpWkW8FeP+ywpuCka2hmUN9MK0CzdyvD4BpsVwkPMSqHl
X-Google-Smtp-Source: AGHT+IG6/h/HVI3jX1nRW3EOsPwOe5MMpa0OD4JZUGwmkmBPfQdwzoz7yzNT+wPwcMZYHuK/XI2P9ivEwYGmt4NjIek=
X-Received: by 2002:a92:c70d:0:b0:36a:112b:b6f9 with SMTP id
 a13-20020a92c70d000000b0036a112bb6f9mr251978ilp.2.1712766554854; Wed, 10 Apr
 2024 09:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409235000.1893969-1-namhyung@kernel.org>
In-Reply-To: <20240409235000.1893969-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Apr 2024 09:29:01 -0700
Message-ID: <CAP-5=fXGBUikHNRt6rVxLzOw6UFkaWizZ-_iDAx6aX=EVEXH8w@mail.gmail.com>
Subject: Re: [PATCHSET 0/6] perf annotate: Add TUI support for data type
 profiling (v1)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> This is to support interactive TUI browser for type annotation.
>
> Like the normal (code) annotation, it should be able to display the data =
type
> annotation.  Now `perf annotate --data-type` will show the result in TUI =
by
> default if it's enabled.  Also `perf report -s type` can show the same ou=
tput
> using a menu item.
>
> It's still in a very early stage and supports the basic functionalities o=
nly.
> I'll work on more features like in the normal annotation browser later.
>
> The code is also available at 'perf/annotate-data-tui-v1' branch at
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (6):
>   perf annotate: Show progress of sample processing
>   perf annotate-data: Add hist_entry__annotate_data_tty()
>   perf annotate-data: Add hist_entry__annotate_data_tui()
>   perf annotate-data: Support event group display in TUI
>   perf report: Add a menu item to annotate data type in TUI
>   perf report: Do not collect sample histogram unnecessarily

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/builtin-annotate.c          | 149 ++++--------
>  tools/perf/builtin-report.c            |   7 +-
>  tools/perf/ui/browsers/Build           |   1 +
>  tools/perf/ui/browsers/annotate-data.c | 312 +++++++++++++++++++++++++
>  tools/perf/ui/browsers/hists.c         |  31 +++
>  tools/perf/util/annotate-data.c        | 113 +++++++++
>  tools/perf/util/annotate-data.h        |   6 +
>  tools/perf/util/annotate.c             |   7 +
>  8 files changed, 515 insertions(+), 111 deletions(-)
>  create mode 100644 tools/perf/ui/browsers/annotate-data.c
>
>
> base-commit: 9c3e9af74326978ba6f4432bb038e6c80f4f56fd
> --
> 2.44.0.478.gd926399ef9-goog
>

