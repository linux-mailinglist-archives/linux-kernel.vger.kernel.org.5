Return-Path: <linux-kernel+bounces-155605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C5C8AF4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB88281D79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8F013D887;
	Tue, 23 Apr 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttevJ6Qq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC03208A9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891448; cv=none; b=tbZjhcEDTpzRoPcWAvnvmBlx079QiH35fXrdvKbGi5PfnKYFXglqOCpgSN9xtr5uLxjl6EiqXk1SZ4X82blMymMY7SNSrCDH9qOD0F9SS1B6zEXEkuIS92l04rTu5tI1XRbVoVwqq+GzXK1/Lpap17nwE7VnlgK2GZ0wNCY+uYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891448; c=relaxed/simple;
	bh=WSAGnEZjHGG4iBk3XbD+eqNOLWiSQsNvNN9QMErGy0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opX4/MzMeGYFeWBbQxPEjnbvuyhSCd6Xh3xVGPFlkIBsqAVB+hIRZ4BLu4VBgRT8/JOWOomHBSIcTlTWY4oPmPu6Ldns8JP01L30YuoSkSspG913Nz/o2P+xeNDQS/ftnWn0g0P+9FokIQJ544lbMGDIGKXwLkYvN8Wr7rIoVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttevJ6Qq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e8414dc4e8so3105ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713891446; x=1714496246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVQSZ6/UyLFVAhzq1SObZuwlgYS8Sd4w1atEPzTvjNY=;
        b=ttevJ6QqdVcdHCa33mNOZqlVHboGuSAFRZRkwxGav1uxAaxb+m6BQXinW17/mb2jEw
         Yi9ckqWyzTlzkOP4mPOAzgIHQFvzd43a8s+7l0Gmm5ILJR4cyKdX7JItnIrfoBrZKZD7
         8o6jMrp+bmez+fkMt5294ECYmcQTMKBxZV+1XnciA1JXE7qROJ/nCHYa6+N8J6YHMFi+
         2FdqPCmEKP5MuKuhmz/BAjRJPJ9BHoElRYIfyjJmGo4Ko859KksHhVUm5B6l2QiFCg9h
         QR7ulYY6y5Ciy4x46i98Fs2X421/Pc9dm9/wOvVG83HOZ+Z4QvaFSW+Lf9lkr9E/5tFX
         mZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891446; x=1714496246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVQSZ6/UyLFVAhzq1SObZuwlgYS8Sd4w1atEPzTvjNY=;
        b=l/iEPwbYe6kX0Fk/FL0LxjZbWC+wPCOh6MoRZGMiPVGNi3ZD3vjx3dziu3tU/770uH
         h1sF2e4tgUWvjvim8MDS8OF/vWZoMJFiAjBSOeo/rycanPqbkAitR0xNPBgNQKJgDzQj
         FHbDD/YMmCq32utZN60ZH6Kf9tzVpgsLD6g280yTt3KouOg5sT4hH2726Qlf4+A5dmnT
         8s3qZEHZ4bOwX5kLZ0AAInrcL20CEIFf9Io158TPeFf86J/SGJBv/q4i/szf+ZrBy22q
         SLxtzKlVigmGSCtMyUuIsmmEabPivxpAURrTaZXP3O2MWboWhx0RT+c1XBwXoQm77Fd5
         tvCg==
X-Forwarded-Encrypted: i=1; AJvYcCXA1RlNMvdsq6VmVA0xQbBETHs4xIGJCVM4L05+kpL1HH+vFprhYsTeTybxevQ6N53jL3tlTNY/bNk2FtEBIdfbr95D8Xp30eKi9CBy
X-Gm-Message-State: AOJu0YxorQUqKQTd/aRWltvLjPrqRIICFd+cL5ghwvN51RLAYSpVmFir
	iT4wMrq99WveYNgfff8tvvRnxkvQIORXeyDEWnYFUJp1mp+W+rBCx9zMfewvy9NsH0QR00o1bns
	luAD0KkAIvX9Cnxp4bhrKXdrlMuZaPlsCf4w9
X-Google-Smtp-Source: AGHT+IFfhXBzjkICpFC3kVnh4AyEtnimBRCl1+VdVe/3VKPYqxFxw7KRNNruBgaAU7MtW19UNANYiNDZFxvo6tlgdSY=
X-Received: by 2002:a17:902:fc48:b0:1e3:e253:17e5 with SMTP id
 me8-20020a170902fc4800b001e3e25317e5mr234448plb.7.1713891445755; Tue, 23 Apr
 2024 09:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423020643.740029-1-namhyung@kernel.org>
In-Reply-To: <20240423020643.740029-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Apr 2024 09:57:12 -0700
Message-ID: <CAP-5=fUjDdy1GQCq_Z96x=bMXrxmqKojnysYsOnjBvO_nufjsQ@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix data type profiling on stdio
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 7:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The loop in hists__find_annotations() never set the 'nd' pointer to NULL
> and it makes stdio output repeating the last element forever.  I think
> it doesn't set to NULL for TUI to prevent it from exiting unexpectedly.
> But it should just set on stdio mode.
>
> Fixes: d001c7a7f473 ("perf annotate-data: Add hist_entry__annotate_data_t=
ui()")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Should we have a test to cover things like this?

Thanks,
Ian

> ---
>  tools/perf/builtin-annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index 6f7104f06c42..83812b9d5363 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -491,7 +491,7 @@ static void hists__find_annotations(struct hists *his=
ts,
>                                 return;
>                         }
>
> -                       if (next !=3D NULL)
> +                       if (use_browser =3D=3D 0 || next !=3D NULL)
>                                 nd =3D next;
>
>                         continue;
> --
> 2.44.0.769.g3c40516874-goog
>

