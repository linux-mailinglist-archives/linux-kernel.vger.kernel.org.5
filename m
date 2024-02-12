Return-Path: <linux-kernel+bounces-61936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB48518A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FA1B214E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97513D0B4;
	Mon, 12 Feb 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRVmeHTG"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C43D0A8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754021; cv=none; b=oKhnfnwCbVPrANcKxk5t13IFwWcS45bF4ghypkTh38jSJAq5exxiAoDuallHBTBrTaf4AD8dErPoP0IgcaZdDFpYsIEt/xVuvYebLsoM3gBz6kn91VGnArRIMhkuc5Olh142dc3msYSV9YtzLmgy6H6oQK0vag2sFdOlS9lLRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754021; c=relaxed/simple;
	bh=6VljTnqgIgygVWGxmCUMJQmUDyt4BmVYXuCIwltV1hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f34GxJqnKo/trTMYUG9IBzSgpF/KyTR5xE4V+/541DeS38dU9SnVia4HgExVUxS/E+mBXmMhA3kaR8Jn7EWCgrRpgBpl1WtuXYT4bF0MhL+tR6lAB03mJ3VdJAMJbIsRYpsCOTdWGbjsdwcxQrsIQUHbwOTddA7kCnIyZxGLYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRVmeHTG; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-363c980faa2so454795ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707754018; x=1708358818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V812vhaPKlOTRNmWcK0bgkq24J9lpm1PdtO4QK4iOp4=;
        b=tRVmeHTGJ343PbXRI26ljN03Kthcw0DA2oX03eGIFzh7MhehS105ifLE5DbtDsvRtz
         PJLgfD+rZoTF1TxGNfsfQyEQWwUqf2ACcF6puFRqik69sBbgG3GbIjFuDBL8l04xrA14
         gkRhYTJBhUSWkZj664s759XKv/F9L0O0bXc44vN2vE6wym511weJP/x0KGYqv/1gKWid
         IMWG1arLK5LzqJ+7WHsH7kWrQbNNJUbuvlB7pQg5lGTjhJ3ZTmtvttEECONyun/0J+kO
         N8qqO8ac2mxd6YFhC4kb1q7fVPM+Jr87WkLRBlbYYrYY+xdj7PzJFhWhUaBasV6Rm5+U
         sXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707754018; x=1708358818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V812vhaPKlOTRNmWcK0bgkq24J9lpm1PdtO4QK4iOp4=;
        b=YBAxBOahA4HU9HQ8a2UZBiAErxBd4xR/xvTznffgIZigRoNKq34OeC+vvIFqm1STrE
         qJiiMutTGuKEfLZyzCc79viHE8zhrw+RajTkqujUeeyRd9a0aqQyfQS/fiSjZvRtNH6I
         n1935N/CoMLmAcW+LtYdAkqP+0yIEKwKNwjvmMqHkMMEJ6FO5lUIVYn8qzavAqRd7oTx
         3xF8NRh8ySVnFNUIDtZa9i5grxJaUAQ9+vpaxeN5Ogyc+4JT6kE/xUDArnXcfzaZUgIY
         WRbRVDmqrHSytnouoJmjaUavKyDVk0a7Iy18ukMICcfPvLRcHP3S0FDSLBjHWrK5rzcq
         L8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVwXUCb38OnmckBNp0NARPudWGbS6ly5vHx64b2tp4qvGXggDi3kclwEX7eJqOy0/4SoacKlOBd9952hTdwfPVBOSqocBQmvdKatAY9
X-Gm-Message-State: AOJu0YxPByxD7uUaZmrBZ5QfPfsu0yfBfYOOK8vSJaKIuojsd5gl6kTr
	m3zr6LNEHJDcEtS14uc2nO5SEnTUh7SpM1ZC4mcziGfve6iCexNLch/EnpHMptChPD6RH3lW6Cz
	KXapbt/XhXrxH3x2CyEeXBnV7PLyZLb69Ng0a
X-Google-Smtp-Source: AGHT+IFN1k4a8xKqLL837bVzWrBksaHMIqM1/h45wRcG9S7HfMYRYNm1TbVw0RhAd9mTK+DTdio3lh12s3nw55K2q8I=
X-Received: by 2002:a05:6e02:3385:b0:363:d56d:1b0c with SMTP id
 bn5-20020a056e02338500b00363d56d1b0cmr435240ilb.26.1707754018456; Mon, 12 Feb
 2024 08:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com> <20240201001504.1348511-6-irogers@google.com>
 <CAM9d7cjka_O5OmCxkrp-K6g45VnxEJNd73jjv6kQanutf+6sbg@mail.gmail.com>
In-Reply-To: <CAM9d7cjka_O5OmCxkrp-K6g45VnxEJNd73jjv6kQanutf+6sbg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Feb 2024 08:06:43 -0800
Message-ID: <CAP-5=fV1dA_hbH=UAZFL8DeuRzvRqW51-gQFSpuEsHpWEDDtWw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] perf tests: Use scandirat for shell script finding
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 8:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Jan 31, 2024 at 4:15=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Avoid filename appending buffers by using openat, faccessat and
> > scandirat more widely. Turn the script's path back to a file name
> > using readlink from /proc/<pid>/fd/<fd>.
> >
> > Read the script's description using api/io.h to avoid fdopen
> > conversions. Whilst reading perform additional sanity checks on the
> > script's contents.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > -static const char *shell_test__description(char *description, size_t s=
ize,
> > -                                           const char *path, const cha=
r *name)
> > +static char *shell_test__description(int dir_fd, const char *name)
> >  {
> > -       FILE *fp;
> > -       char filename[PATH_MAX];
> > -       int ch;
> > +       struct io io;
> > +       char buf[128], desc[256];
> > +       int ch, pos =3D 0;
> >
> > -       path__join(filename, sizeof(filename), path, name);
> > -       fp =3D fopen(filename, "r");
> > -       if (!fp)
> > +       io__init(&io, openat(dir_fd, name, O_RDONLY), buf, sizeof(buf))=
;
> > +       if (io.fd < 0)
> >                 return NULL;
> >
> >         /* Skip first line - should be #!/bin/sh Shebang */
> > +       if (io__get_char(&io) !=3D '#')
> > +               goto err_out;
> > +       if (io__get_char(&io) !=3D '!')
> > +               goto err_out;
> >         do {
> > -               ch =3D fgetc(fp);
> > -       } while (ch !=3D EOF && ch !=3D '\n');
> > -
> > -       description =3D fgets(description, size, fp);
> > -       fclose(fp);
> > +               ch =3D io__get_char(&io);
> > +               if (ch < 0)
> > +                       goto err_out;
> > +       } while (ch !=3D '\n');
> >
> > -       /* Assume first char on line is omment everything after that de=
sc */
> > -       return description ? strim(description + 1) : NULL;
> > +       do {
> > +               ch =3D io__get_char(&io);
> > +               if (ch < 0)
> > +                       goto err_out;
> > +       } while (ch =3D=3D '#' || isspace(ch));
> > +       while (ch > 0 && ch !=3D '\n') {
> > +               desc[pos++] =3D ch;
> > +               if (pos >=3D (int)sizeof(desc) - 1)
>
> Maybe (pos =3D=3D sizeof(desc) - 2) ?  I'm not sure what happens if it ha=
s a
> description longer than the buffer size.

Thanks Namhyung!

sizeof(desc) - 1 =3D=3D sizeof(char[256]) - 1 =3D=3D 255 , so at this point
pos can at most be 255 and there is one space after pos for a trailing
'\0'.

> > +                       break;
> > +               ch =3D io__get_char(&io);
> > +       }
> > +       while (pos > 0 && isspace(desc[--pos]))
> > +               ;

Here pos is moved back to at least one to 254.

> > +       desc[++pos] =3D '\0';
>
> Wouldn't it overflow the buffer?

At this point pos can only have a maximum value of 255 which is within
the bounds of desc.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +       close(io.fd);
> > +       return strdup(desc);
> > +err_out:
> > +       close(io.fd);
> > +       return NULL;
> >  }

