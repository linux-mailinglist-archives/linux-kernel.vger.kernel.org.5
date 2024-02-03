Return-Path: <linux-kernel+bounces-50879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1B847FB6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98D3281E6F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C358C1D;
	Sat,  3 Feb 2024 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7J3JUvI"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EE747F
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706928307; cv=none; b=J5OfQa3luRBZcx9DcT57HlW+NNTjYJ36kRMkoVbXS7Pz3L3eO380ckZVPDEbV4vjU72HnhbYNhbBgjzQD+/QjrhrXf/0rb41FWJtaP+EouCw2k1iXV5B4BcL6030XbXDxJyAAJ7QfxMubrqWkBbetNTsmNks8NYZYgRyo9lUJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706928307; c=relaxed/simple;
	bh=fmcpXMknfWCuzBxr/aoRznuV0ZYBo5hPAGuro3wj+S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEDPwG6/u91Up+PGsRKcCIWo4LrEc3yGpLoLCgblKFh5jCkHer+xeZE+4McT52OF+M8Tc9wwHe47D7Dn0KF5n2MbobOHaP7qLwxHH3lS9xXva2Cp910XAv2gVtEdhqhRy2or+BRqz74gwotmNd2NrMOaE4uGahi4s3hlebLFb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7J3JUvI; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3638bd37107so51405ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 18:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706928305; x=1707533105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPJhc6ARWb0ZIE8QVQO5KUklK/OzZ3mi6kTQhpYsUXM=;
        b=H7J3JUvInzh8T6HQVMuBWG9naGuHgX9QpJcyfy4m4yVk3jHiwu246+/7h/ckK11yAO
         1/o+pwf0E+zjmdzkQjGSeC3cZbR2wWOQxf+haN/McvXDK8vD7lYm03aBKkHEMhrZSsVW
         9Bp4Nh4J0OznOzUJX8HPvChTpX8CObq6lla3HDzkbMxZRQcFjq1//eDsqi8E3ntcutKM
         tb6NAgThVIHnBk3K5dZSVhQpMavdQfgqbOdSl25L3t8/cUpl8oAtNLufea/oMoZsaP+E
         Kp+2X7l6oSrYq8kj4bUbwLcpwKQh7NCReDZjLrVcVwd7ccaFenp2AXb4Fr3H18Vn5BgX
         2nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706928305; x=1707533105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPJhc6ARWb0ZIE8QVQO5KUklK/OzZ3mi6kTQhpYsUXM=;
        b=ZrOomDYENRcOAtU2IiFDr6lrSZYrbLy3ySYR0RsGFmMemR9DaZwz0xrLM3NyRSgbh7
         tway5TfOAYHH52RMfxlkBuMV+4IxAHnbF26DJwkyCSjjB+/X/sEhdcagDMCQN8koaLcQ
         F3kvyy0oN/+fXnoBzKc6yQ2ZKiAsLa60jVB2TzCAcwZAR31vIGvBDHUZUnHuxuKZpcPz
         Ey424vy87L8uZQ6V4hhFh35KKDOOoCnxAmnrArrYw/045uotyZEn/DGaWNriIpmodBmc
         widkk9Y7Jvg5TnYlqekTRTXWwZQdVPFe8bthNBBvkfqwncTK1eoaoZckIfbtTR7UdvsK
         ZuGA==
X-Gm-Message-State: AOJu0Yz2nPO79EBK84C467Qrd2TzHNAs3oYlH4Nb0dNw+QgUyAvdxa9R
	JgJilHCfvAV+TFcryHIsqId/GRW1zGaUR2bD67jAAPLL5MGZrCs0yRkNDxffqhKZbFHEuO9Rzzw
	7qnvbNzZEgvTbUdz0yC5k3hnoafgstpF1hEE3
X-Google-Smtp-Source: AGHT+IEFgkagKgN/9PYKFEL64LnSsGENnpdyNkduQ9hVEERhWpAyw/MxAiXAvSTyy7f2fr2evij30tOm7zv1DS8pyOs=
X-Received: by 2002:a05:6e02:240d:b0:363:babf:dc3c with SMTP id
 bs13-20020a056e02240d00b00363babfdc3cmr81081ilb.2.1706928304655; Fri, 02 Feb
 2024 18:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-7-namhyung@kernel.org>
In-Reply-To: <20240202220459.527138-7-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Feb 2024 18:44:53 -0800
Message-ID: <CAP-5=fX-LASq92NCAd-8+41S9Bo_8xiH7iEGvKZqRbSdM-9zkw@mail.gmail.com>
Subject: Re: [PATCH 06/14] perf annotate-data: Maintain variable type info
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> As it collected basic block and variable information in each scope, it
> now can build a state table to find matching variable at the location.
>
> The struct type_state is to keep the type info saved in each register
> and stack slot.  The update_var_state() updates the table when it finds
> variables in the current address.  It expects die_collect_vars() filled
> a list of variables with type info and starting address.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 155 ++++++++++++++++++++++++++++++++
>  tools/perf/util/annotate-data.h |  29 ++++++
>  tools/perf/util/dwarf-aux.c     |   4 +
>  3 files changed, 188 insertions(+)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index b8e60c42af8c..f8768c224bcc 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -23,6 +23,57 @@
>  #include "symbol.h"
>  #include "symbol_conf.h"
>
> +/* Type information in a register, valid when ok is true */
> +struct type_state_reg {
> +       Dwarf_Die type;
> +       bool ok;
> +       bool scratch;
> +};
> +
> +/* Type information in a stack location, dynamically allocated */
> +struct type_state_stack {
> +       struct list_head list;
> +       Dwarf_Die type;
> +       int offset;
> +       int size;
> +       bool compound;
> +};
> +
> +/* FIXME: This should be arch-dependent */
> +#define TYPE_STATE_MAX_REGS  16

Perhaps 32, presumably 16 won't work on Arm64.

Thanks,
Ian

> +
> +/*
> + * State table to maintain type info in each register and stack location=
.
> + * It'll be updated when new variable is allocated or type info is moved
> + * to a new location (register or stack).  As it'd be used with the
> + * shortest path of basic blocks, it only maintains a single table.
> + */
> +struct type_state {
> +       struct type_state_reg regs[TYPE_STATE_MAX_REGS];
> +       struct list_head stack_vars;
> +};
> +
> +static bool has_reg_type(struct type_state *state, int reg)
> +{
> +       return (unsigned)reg < ARRAY_SIZE(state->regs);
> +}
> +
> +void init_type_state(struct type_state *state, struct arch *arch __maybe=
_unused)
> +{
> +       memset(state, 0, sizeof(*state));
> +       INIT_LIST_HEAD(&state->stack_vars);
> +}
> +
> +void exit_type_state(struct type_state *state)
> +{
> +       struct type_state_stack *stack, *tmp;
> +
> +       list_for_each_entry_safe(stack, tmp, &state->stack_vars, list) {
> +               list_del(&stack->list);
> +               free(stack);
> +       }
> +}
> +
>  /*
>   * Compare type name and size to maintain them in a tree.
>   * I'm not sure if DWARF would have information of a single type in many
> @@ -238,6 +289,110 @@ static int check_variable(Dwarf_Die *var_die, Dwarf=
_Die *type_die, int offset,
>         return 0;
>  }
>
> +static struct type_state_stack *find_stack_state(struct type_state *stat=
e,
> +                                                int offset)
> +{
> +       struct type_state_stack *stack;
> +
> +       list_for_each_entry(stack, &state->stack_vars, list) {
> +               if (offset =3D=3D stack->offset)
> +                       return stack;
> +
> +               if (stack->compound && stack->offset < offset &&
> +                   offset < stack->offset + stack->size)
> +                       return stack;
> +       }
> +       return NULL;
> +}
> +
> +static void set_stack_state(struct type_state_stack *stack, int offset,
> +                           Dwarf_Die *type_die)
> +{
> +       int tag;
> +       Dwarf_Word size;
> +
> +       if (dwarf_aggregate_size(type_die, &size) < 0)
> +               size =3D 0;
> +
> +       tag =3D dwarf_tag(type_die);
> +
> +       stack->type =3D *type_die;
> +       stack->size =3D size;
> +       stack->offset =3D offset;
> +
> +       switch (tag) {
> +       case DW_TAG_structure_type:
> +       case DW_TAG_union_type:
> +               stack->compound =3D true;
> +               break;
> +       default:
> +               stack->compound =3D false;
> +               break;
> +       }
> +}
> +
> +static struct type_state_stack *findnew_stack_state(struct type_state *s=
tate,
> +                                                   int offset, Dwarf_Die=
 *type_die)
> +{
> +       struct type_state_stack *stack =3D find_stack_state(state, offset=
);
> +
> +       if (stack) {
> +               set_stack_state(stack, offset, type_die);
> +               return stack;
> +       }
> +
> +       stack =3D malloc(sizeof(*stack));
> +       if (stack) {
> +               set_stack_state(stack, offset, type_die);
> +               list_add(&stack->list, &state->stack_vars);
> +       }
> +       return stack;
> +}
> +
> +/**
> + * update_var_state - Update type state using given variables
> + * @state: type state table
> + * @dloc: data location info
> + * @addr: instruction address to update
> + * @var_types: list of variables with type info
> + *
> + * This function fills the @state table using @var_types info.  Each var=
iable
> + * is used only at the given location and updates an entry in the table.
> + */
> +void update_var_state(struct type_state *state, struct data_loc_info *dl=
oc,
> +                     u64 addr, struct die_var_type *var_types)
> +{
> +       Dwarf_Die mem_die;
> +       struct die_var_type *var;
> +       int fbreg =3D dloc->fbreg;
> +       int fb_offset =3D 0;
> +
> +       if (dloc->fb_cfa) {
> +               if (die_get_cfa(dloc->di->dbg, addr, &fbreg, &fb_offset) =
< 0)
> +                       fbreg =3D -1;
> +       }
> +
> +       for (var =3D var_types; var !=3D NULL; var =3D var->next) {
> +               if (var->addr !=3D addr)
> +                       continue;
> +               /* Get the type DIE using the offset */
> +               if (!dwarf_offdie(dloc->di->dbg, var->die_off, &mem_die))
> +                       continue;
> +
> +               if (var->reg =3D=3D DWARF_REG_FB) {
> +                       findnew_stack_state(state, var->offset, &mem_die)=
;
> +               } else if (var->reg =3D=3D fbreg) {
> +                       findnew_stack_state(state, var->offset - fb_offse=
t, &mem_die);
> +               } else if (has_reg_type(state, var->reg)) {
> +                       struct type_state_reg *reg;
> +
> +                       reg =3D &state->regs[var->reg];
> +                       reg->type =3D mem_die;
> +                       reg->ok =3D true;
> +               }
> +       }
> +}
> +
>  /* The result will be saved in @type_die */
>  static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *typ=
e_die)
>  {
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index ad6493ea2c8e..7fbb9eb2e96f 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -8,9 +8,12 @@
>  #include <linux/types.h>
>
>  struct annotated_op_loc;
> +struct arch;
>  struct debuginfo;
> +struct die_var_type;
>  struct evsel;
>  struct map_symbol;
> +struct type_state;
>
>  /**
>   * struct annotated_member - Type of member field
> @@ -146,6 +149,16 @@ int annotated_data_type__update_samples(struct annot=
ated_data_type *adt,
>  /* Release all data type information in the tree */
>  void annotated_data_type__tree_delete(struct rb_root *root);
>
> +/* Initialize type state table */
> +void init_type_state(struct type_state *state, struct arch *arch);
> +
> +/* Destroy type state table */
> +void exit_type_state(struct type_state *state);
> +
> +/* Update type state table using variables */
> +void update_var_state(struct type_state *state, struct data_loc_info *dl=
oc,
> +                     u64 addr, struct die_var_type *var_types);
> +
>  #else /* HAVE_DWARF_SUPPORT */
>
>  static inline struct annotated_data_type *
> @@ -168,6 +181,22 @@ static inline void annotated_data_type__tree_delete(=
struct rb_root *root __maybe
>  {
>  }
>
> +static inline void init_type_state(struct type_state *state __maybe_unus=
ed,
> +                                  struct arch *arch __maybe_unused)
> +{
> +}
> +
> +static inline void exit_type_state(struct type_state *state __maybe_unus=
ed)
> +{
> +}
> +
> +static inline void update_var_state(struct type_state *state __maybe_unu=
sed,
> +                                   struct data_loc_info *dloc __maybe_un=
used,
> +                                   u64 addr __maybe_unused,
> +                                   struct die_var_type *var_types __mayb=
e_unused)
> +{
> +}
> +
>  #endif /* HAVE_DWARF_SUPPORT */
>
>  #endif /* _PERF_ANNOTATE_DATA_H */
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 39851ff1d5c4..f88a8fb4a350 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -9,6 +9,7 @@
>  #include <stdlib.h>
>  #include "debug.h"
>  #include "dwarf-aux.h"
> +#include "dwarf-regs.h"
>  #include "strbuf.h"
>  #include "string2.h"
>
> @@ -1147,6 +1148,8 @@ static int reg_from_dwarf_op(Dwarf_Op *op)
>         case DW_OP_regx:
>         case DW_OP_bregx:
>                 return op->number;
> +       case DW_OP_fbreg:
> +               return DWARF_REG_FB;
>         default:
>                 break;
>         }
> @@ -1160,6 +1163,7 @@ static int offset_from_dwarf_op(Dwarf_Op *op)
>         case DW_OP_regx:
>                 return 0;
>         case DW_OP_breg0 ... DW_OP_breg31:
> +       case DW_OP_fbreg:
>                 return op->number;
>         case DW_OP_bregx:
>                 return op->number2;
> --
> 2.43.0.594.gd9cf4e227d-goog
>

