Return-Path: <linux-kernel+bounces-107939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8648803CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01141F22B94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094BD25776;
	Tue, 19 Mar 2024 17:44:46 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7302B9CF;
	Tue, 19 Mar 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870285; cv=none; b=T19UgmrnTYlHZswjLUj2fJskbzKxBPwaRQ+y7fGRjGKF4eg2Qg4xNPD0+HCXVxU749rNitzasWmbckmP7KgxenaFWxgLWZf8IwlEtzrnEIxg5O/kuh/8lL/V2vPOzGQBdFsOlfhSNb45KWR6XubUNS0gIKFsyKyc+9VtVBDhM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870285; c=relaxed/simple;
	bh=YNQG5gO9WlpU/AlVGMzkLhdH1gT/jgzXyquEnTHOZ+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VShQO6oHLksBO9IUDcUqSPcKhLFyTnlMWoheHtW7KOKi0t2UWiYilb5XxI7dm7EQu9S/6VnUdwXJCTDrpwzWHn+78M0wiAvHZMJadLjAZXuwGki5DJvR0jSXwKc8YOxe3mvLMjO7azlRYb0//9azPMZwY3YXqEB32+N+qRaqsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4723730a12.1;
        Tue, 19 Mar 2024 10:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870283; x=1711475083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLidFdPPt+9QGX0eU+M4Nd/N7qIdu9ep3/M0iAS5xu8=;
        b=cEWK4zAIUwliT+5wxQS3Z1UD6P4VM+fZd0H6tj4KfaPxtc/RVHUVZtE5SoSH1uoR5G
         STHrut/XE+f2GfOuOdU7yMwRvL2Cg2PlAisv22XUpLxlJ1lytfO1I6FDF4n0V8yFI5zn
         5XROr3DLVAVF6u6jq5artN4AmWQiCefWiyyItCDbUMErShMi7omQKXRgoJAd0tgZWTz4
         pKblbxUbC3zbjPU2uYLMsi5QUXsCUmemaJNcCigvGyOV+1B/0iMEXkRiyKAt/2qnV8j7
         ACdQtMrNe97CARH6tSbXhUxjEufXO46r/RMFpzN2oHlqAPxYmJ8tGVOJ5mjKO4wDD30M
         hzlA==
X-Forwarded-Encrypted: i=1; AJvYcCXpvTwIu0sAahrN0JWn9l2ygycNvikVgRmDWHKRH302434V/UMmIsfsJgVqogNqkdKENtss+Ectx72fCfnw8OF57ndRL/xSLX8lK2aLvLJAaiCNmMXMURVag6l5vj8zaoPEA+Q4s72Us/RNM6mymF+zYYB6fRhzmYNtfFBgQCqtTvbt/o48+xZlMghmjOiULhSUb0i6XZoxrBQQXUMUWAYud2L+DBEWokt7Ts5ACK/t7aIpUA==
X-Gm-Message-State: AOJu0YyhumyqE3V+i9L4MK3YDrwv90TaRzBQmjyOreh97IhiR3K76q+l
	GDrnp7kUp0hnN57KK8J4UMdSHl052XJQOm4WI6hc9W4dwbkh/F3/EGaDUqIpcngzzYo4eaZw9mc
	HGrsjTXFCCmGK5U1Ng90dnrv1ClE=
X-Google-Smtp-Source: AGHT+IEcwxRhZAINrFOhMoOKS6MDR9e+tjMHRVCgvgpferCGmN4fIMPxcMoI52RIPOXBxjAGEjlOyFbebnpE8YNdCn4=
X-Received: by 2002:a17:90a:ce12:b0:29b:b485:f4f8 with SMTP id
 f18-20020a17090ace1200b0029bb485f4f8mr12573838pju.20.1710870283313; Tue, 19
 Mar 2024 10:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319055115.4063940-1-namhyung@kernel.org> <20240319055115.4063940-10-namhyung@kernel.org>
 <ZfmcN4YuvQpVgJQN@x1>
In-Reply-To: <ZfmcN4YuvQpVgJQN@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 19 Mar 2024 10:44:31 -0700
Message-ID: <CAM9d7cjatKSH7hw_sC3MCmY1fYT+bDBgSpFWJg=RM2oqgL5X0A@mail.gmail.com>
Subject: Re: [PATCH 09/23] perf annotate-data: Maintain variable type info
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 7:07=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Mar 18, 2024 at 10:51:01PM -0700, Namhyung Kim wrote:
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
> >  tools/perf/util/annotate-data.c | 173 ++++++++++++++++++++++++++++++++
> >  tools/perf/util/dwarf-aux.c     |   4 +
> >  2 files changed, 177 insertions(+)
> >
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate=
-data.c
> > index f482ccfdaa91..8eaa06f1cee5 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> > @@ -46,6 +46,62 @@ static void pr_debug_type_name(Dwarf_Die *die)
> >       free(str);
> >  }
> >
> > +/* Type information in a register, valid when ok is true */
> > +struct type_state_reg {
> > +     Dwarf_Die type;
> > +     bool ok;
> > +};
> > +
> > +/* Type information in a stack location, dynamically allocated */
> > +struct type_state_stack {
> > +     struct list_head list;
> > +     Dwarf_Die type;
> > +     int offset;
> > +     int size;
> > +     bool compound;
> > +};
> > +
> > +/* FIXME: This should be arch-dependent */
> > +#define TYPE_STATE_MAX_REGS  16
> > +
> > +/*
> > + * State table to maintain type info in each register and stack locati=
on.
> > + * It'll be updated when new variable is allocated or type info is mov=
ed
> > + * to a new location (register or stack).  As it'd be used with the
> > + * shortest path of basic blocks, it only maintains a single table.
> > + */
> > +struct type_state {
> > +     struct type_state_reg regs[TYPE_STATE_MAX_REGS];
> > +     struct list_head stack_vars;
> > +};
> > +
> > +static bool has_reg_type(struct type_state *state, int reg)
> > +{
> > +     return (unsigned)reg < ARRAY_SIZE(state->regs);
> > +}
> > +
> > +/* These declarations will be remove once they are changed to static *=
/
> > +void init_type_state(struct type_state *state, struct arch *arch __may=
be_unused);
> > +void exit_type_state(struct type_state *state);
> > +void update_var_state(struct type_state *state, struct data_loc_info *=
dloc,
> > +                   u64 addr, u64 insn_offset, struct die_var_type *var=
_types);
> > +
> > +void init_type_state(struct type_state *state, struct arch *arch __may=
be_unused)
> > +{
> > +     memset(state, 0, sizeof(*state));
> > +     INIT_LIST_HEAD(&state->stack_vars);
> > +}
> > +
> > +void exit_type_state(struct type_state *state)
> > +{
> > +     struct type_state_stack *stack, *tmp;
> > +
> > +     list_for_each_entry_safe(stack, tmp, &state->stack_vars, list) {
> > +             list_del(&stack->list);
>
> list_del_init()?

Maybe.. but I'm not sure how much value it'd have as we free it right after=
.

Thanks,
Namhyung

>
> > +             free(stack);
> > +     }
> > +}
> > +

