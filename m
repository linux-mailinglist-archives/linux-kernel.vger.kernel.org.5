Return-Path: <linux-kernel+bounces-55922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E132584C368
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8DC286189
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624BB10A14;
	Wed,  7 Feb 2024 04:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jozsAp0A"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C215491
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 04:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279226; cv=none; b=r0sVopXeHvneTNOGJY5VqZFhirHMtYxMvFwl1NUYsK5faaD4uD87g5HaLaDdEIE+Z1ZnYd1lp0HIQ/2xIUAX/WEDMtnuCNpIfe3l8B2C58WOtERPQBJc4/uyRUfXEj+Sgw9CzHS7XVwid11d4nincSIn1jH7yoQcdRonNZtnSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279226; c=relaxed/simple;
	bh=DawtPmRgk6yjmGv8Et+8qRTVs6tdkKeMMQQpJIvE9NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K89/dAxACiL+sbzq91rQl11NNzm6FCEVjNtBb5GPK+u1JiNipDi8NxTm4sZnlfM2U/P4KRB1WYLjcto3TQNt3KWs3rMUixqm3Jt1nHediagBOpnLDvpjSsmaqvwZ9FPpW0mfXc981Kp2Iw4yCuiXiTyJub70JhqIlg6iC13wiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jozsAp0A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d93b982761so35765ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 20:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707279224; x=1707884024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHLcblWjU6UgGzJLYm+rTZl/ZAIvc9e3m6tFVYB02E0=;
        b=jozsAp0AWY8j5F1ybvtQxukfY9/t4sJ9lUUHfnJUdl3rOaAN+oqPWVw36SWVM2ZADe
         U+AyTUvuVMhKckhCwXrh23kh/cgOFhQbUNCb0hlwtrEZYxdo63QwRz7hZ5RmS3oj8DSd
         prc10qxhgXndxVBSsqFpZm/yX/ES8r6zccTHPeWcS41xWcRCzsaHngW6S8fVHVD9zLub
         OEyxDothn54rg84r+f3Ucs1HL5vZtOuza7yYHW1kRGAbvLOeqj4mkGtoRfGDgFnEfkuC
         5DVLIkw8AdGimCZtX1Irq0J49EfMxsE1Am5F0Hn5PjYMYLAYSnShq+rYTTx4jeXgxeMM
         U19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707279224; x=1707884024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHLcblWjU6UgGzJLYm+rTZl/ZAIvc9e3m6tFVYB02E0=;
        b=acDserZA7EjIMKY/KD7RxOdVUhNLCz4HCE4jtGuvofTJ74418Ed4GKpUrAxDH/sr3a
         +sUDUY24OwKMRCp5EBTtA6cDjMZ0z0+KlIKAQhlFTW9X3eIdiEev1cEdqlczHOfw4Qve
         WvWmvU232KDgfOFXh0Q6V1vUjvA9Fm7s/j4HWv1Ok0pn7MPMrVLTxcDBaaQLWqJ12BXH
         faZD8PYzuUAtBhRNRlyj0K4T7vFc9l1ChJgw+yDukTG2xgAuMEBs/Ygds46sSEsLtcQA
         RWW8dublMI1au11ioYeIEhErxEwmx0OCdsC5viS652NvR2nYAXsywm7JmsyUosb2ej7+
         Pkzw==
X-Forwarded-Encrypted: i=1; AJvYcCUhVNrAK7UwpFBABM4DNakZql+Fcbsv/PPK6uH+tgzpcrxIraD+f+49hoXuMQj9Ckp+0E2G74lxleIzD7woGTlrBLaP/DpwbAmy672D
X-Gm-Message-State: AOJu0Yy76plyfoRdFmQ9nZ/dIlAPFOA1r+ajORod7SAmKD/uulUsfkno
	s64DL5wfELTyY/F4j7pDjd+N5qnHqacBqKJfN1gYfHWnWMey78m5XPR0BxivDo5k2mOrqj/A/L9
	35uRe64okKQ0etHp55aZbE/ngdnCGM2xsioDC
X-Google-Smtp-Source: AGHT+IEhuDRvsjd7RWO6TeE99G2pJfH9ARn3kF+Guau3neKYQ+hKEQp/WdB5SfAQ+RqGulk9oUXQ5+4qHEZn0MLQbwc=
X-Received: by 2002:a17:902:ec8a:b0:1d8:d90d:c9ae with SMTP id
 x10-20020a170902ec8a00b001d8d90dc9aemr15347plg.1.1707279224349; Tue, 06 Feb
 2024 20:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112231340.779469-1-namhyung@kernel.org>
In-Reply-To: <20240112231340.779469-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 Feb 2024 20:13:32 -0800
Message-ID: <CAP-5=fWCQqzPMV=3+o5W6fWx2vy2h0gMicU+ysnTqCy6iiLbaA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Display data size on pipe mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Currently pipe mode doesn't set the file size and it results in a
> misleading message of 0 data size at the end.  Although it might miss
> some accounting for pipe header or more, just displaying the data size
> would reduce the possible confusion.
>
> Before:
>   $ perf record -o- perf test -w noploop | perf report -i- -q --percent-l=
imit=3D1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]    <=3D=3D=3D=3D=3D=3D  =
(here)
>       99.58%  perf     perf                  [.] noploop
>
> After:
>   $ perf record -o- perf test -w noploop | perf report -i- -q --percent-l=
imit=3D1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.229 MB - ]
>       99.46%  perf     perf                  [.] noploop
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 91e6828c38cc..21ebcb04f1d8 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1773,8 +1773,11 @@ record__finish_output(struct record *rec)
>         struct perf_data *data =3D &rec->data;
>         int fd =3D perf_data__fd(data);
>
> -       if (data->is_pipe)
> +       if (data->is_pipe) {
> +               /* Just to display approx. size */
> +               data->file.size =3D rec->bytes_written;
>                 return;
> +       }
>
>         rec->session->header.data_size +=3D rec->bytes_written;
>         data->file.size =3D lseek(perf_data__fd(data), 0, SEEK_CUR);
> --
> 2.43.0.275.g3460e3d667-goog
>

