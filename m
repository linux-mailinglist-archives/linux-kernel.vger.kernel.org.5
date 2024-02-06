Return-Path: <linux-kernel+bounces-55712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48C84C0A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD81C23A49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDADB1C6A4;
	Tue,  6 Feb 2024 23:06:37 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B31CF80;
	Tue,  6 Feb 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260797; cv=none; b=GPdeRcF+4Yh2axQZ6fLsacDV3kGMk92RJVoeeLY3vIGbnhIQqu4u2gezmLioxafKCcn7+27gwsYIyDrQyXvVQHCPQAbD7vV6Z6hhgDiM0RujHXYWdfTVpE+ngRJMr/xzPtlop1Xxtl0EwBI2SDmoDa0zx/ieNNUuOSXIjLeTV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260797; c=relaxed/simple;
	bh=cBjWTNh7rjlosSaQiFZdFl8LDY8ZRpEQjHh3P4Qm9Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQGh2QhNtpOffn745B+H97SReDt+dV/0oTrisqU2K6UyYKD43Ga9Jh0cZZuPCs1uUNaKmAOB1RC6POIHt1gulqcUkCU48RflRq1cPR9qd/LhJiKkx6v7QX1Jcv9+i9avlYN+Yzym0ZN4u9cPAoHUCgnZohqpHWENLgfpJftKV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d93f2c3701so320915ad.3;
        Tue, 06 Feb 2024 15:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707260795; x=1707865595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnIcPzdmLAJUO8fCLPD2o8875WllcuHrU7dhome3I8A=;
        b=BSnsf+cf66zyPd84p9wkDNIAhMp5iVoLowR1jSJFKROpM3spZb7EUC2Yyherv7jvGM
         uobnrIjhsgeaOErOUZjH6a7lRv5hy4ZycI217ZbD1teMfUoeeSxcDBBkelmGSSGGrPJy
         P+YFDV8fkUryS76vSXm4I9N5ZCXCrtesdQ+VFRkZ/jDY0FctY4pDK6OsU2f9WMyfC9w3
         mS2JgG4sEN6F0mbfMjzd7Zk9i9hDMwacME1RTQ/7a8gIBUWScI2Lflt0O5WtgCxc1uuM
         qjckU+W2NUKbYpWPeNgxnXaKME91/vf9Azl2cwuHnF9mLg2HFlhsSewzIahfFHjOvVrP
         rGqg==
X-Forwarded-Encrypted: i=1; AJvYcCVvFkFMrMcevV/l3Np98czJ2pC9wxPgQiaffp+T0pUWt8emoYKekuQC5mQ+43a69uSi3tmLE9jGCCDokm1ACL/7DkCVhbaBA32wFmiCm924T9C8s2YRIEE3IuYYokXzyahXEKozKrD5cfvo0GMoTl8CJPkPyZaqxk+EcP5B5Eo+WSyBfb7oDJ7drUCrplL+/5/DKhL1xXqUsQnk3qsXoFdxef6fdzCKVK+0se9ZBxuvqr5fxQ==
X-Gm-Message-State: AOJu0YzebdBWEF3fqNQlr6UWE5TIzGGZfVbr7jHwQPWVVLAkDt69HzES
	8FRMpJuw+YtWo9ILhsTpvbgwAupr6psCgOgZ4v7es3+DXmBrRp9hnJqqYO011F2gfTGhgA+GNO9
	vG/5KWGxV9CHUGqvUu0vJ7p7me8c=
X-Google-Smtp-Source: AGHT+IGv+BZP/eqlRq4okHwJHc93F2HVCrWlSrF+Kk3jxV6YRr6epA2/NQfZXpFzyJ1C/esz/uu8IinC4bWuDRvuJKw=
X-Received: by 2002:a17:902:dac4:b0:1d9:73b0:f01e with SMTP id
 q4-20020a170902dac400b001d973b0f01emr4075457plx.20.1707260795116; Tue, 06 Feb
 2024 15:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-7-namhyung@kernel.org>
 <CAP-5=fX-LASq92NCAd-8+41S9Bo_8xiH7iEGvKZqRbSdM-9zkw@mail.gmail.com>
In-Reply-To: <CAP-5=fX-LASq92NCAd-8+41S9Bo_8xiH7iEGvKZqRbSdM-9zkw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Feb 2024 15:06:24 -0800
Message-ID: <CAM9d7ciXtbi1auv5W=gk3M4zeSyFUG3K=bQz14-4YnoUpEX+eQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] perf annotate-data: Maintain variable type info
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 6:45=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > As it collected basic block and variable information in each scope, it
> > now can build a state table to find matching variable at the location.
> >
> > The struct type_state is to keep the type info saved in each register
> > and stack slot.  The update_var_state() updates the table when it finds
> > variables in the current address.  It expects die_collect_vars() filled
> > a list of variables with type info and starting address.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate-data.c | 155 ++++++++++++++++++++++++++++++++
> >  tools/perf/util/annotate-data.h |  29 ++++++
> >  tools/perf/util/dwarf-aux.c     |   4 +
> >  3 files changed, 188 insertions(+)
> >
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate=
-data.c
> > index b8e60c42af8c..f8768c224bcc 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> > @@ -23,6 +23,57 @@
> >  #include "symbol.h"
> >  #include "symbol_conf.h"
> >
> > +/* Type information in a register, valid when ok is true */
> > +struct type_state_reg {
> > +       Dwarf_Die type;
> > +       bool ok;
> > +       bool scratch;
> > +};
> > +
> > +/* Type information in a stack location, dynamically allocated */
> > +struct type_state_stack {
> > +       struct list_head list;
> > +       Dwarf_Die type;
> > +       int offset;
> > +       int size;
> > +       bool compound;
> > +};
> > +
> > +/* FIXME: This should be arch-dependent */
> > +#define TYPE_STATE_MAX_REGS  16
>
> Perhaps 32, presumably 16 won't work on Arm64.

Right, but right now I'm targeting x86_64 only.
Maybe we can change it later when it supports Arm64.

Thanks,
Namhyung

