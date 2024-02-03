Return-Path: <linux-kernel+bounces-50885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D34847FDA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E75B21ABA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4F883D;
	Sat,  3 Feb 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJ+thUtV"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BA9101CE
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929759; cv=none; b=be5RuwqK7tZcFe4qT89lS6z/u4GLXeJeIImj9jXbP1/YhOJS4Ad/DqF0P6AFFgaoBDpYWWYP/k63wB84pFZNtWz8EMa5dQyff9apM4AwsQeCUnaaHcaWsy709w6sLMpyG5kPnyRcZXZfJ05cyPNqMrl1cLN5e0wx2tS/jxx4yRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929759; c=relaxed/simple;
	bh=KLM26Yfrtc8SeQCiqpSzGGfhWq7k+6JxiLtHj7A+bGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hafhT1yrAFmnGIfaYHkCYZJF9BknUnkIPVqc++MWFdR2KxyUW67hefJmuduph/m6BZ1pKJ1Nt88tlnGdiu9gGo4r+sF1Ubsaz9HoOMKPBKPtAYzxJUjdNbaWzP//XF164X0IMkUUZiaf0uURj/bj2lmzr1Y3LLSG9qLW8okKSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJ+thUtV; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3638bd37107so52895ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 19:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706929756; x=1707534556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1DU4tok1X0r9bYtqZ6dNhjxfX0/7CKeHdYGkX55OSE=;
        b=hJ+thUtVNbyUF1HPW0HiEbQmPcQUT9xO7AzHVMbe35f0DQD0WH8OXXfZrN+sfE+9Zy
         hHucswnk+Z9laWpb9MD4LQ/8NSDHlJ5bU9ZKnM8mzJugG+WCdedOiVP7oz2JrJ9k4IlL
         gbG6KAw5F/UrdBLFWqYnlILDcwRC+2Jv412iVdphCGUIbamOqVe7cPjkFssN4YWsT59L
         Qsi3bwDtfrj33v3Z+s+9tyWM6JF4mL7ZgS3y/zM6N12tYSSfqgUBVfb9i3sQpGhQzIMU
         vFMc+az0tOWt3W/LdKF9XOFN2bwcoZQohL9BVXOB33S5dRWqEIx8khaz4T6/gY4xnC6L
         Jk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706929756; x=1707534556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1DU4tok1X0r9bYtqZ6dNhjxfX0/7CKeHdYGkX55OSE=;
        b=PqdsydjQ8+AxurLHXPTAcCLi5AiyrU7lXrVYNxkXogMtS45TKkdpYl7PbIs67zdd6K
         VRzyKBZQDYFhNEW5JFGOz3PQebK6+m+DkiyTEIOnGNd5bQKJxJRSVQx9MWjsjYvcBVkg
         3xk1YdPNmOmIZXGeJwLDwbop+lPm4YsgAY9yhsW50m3BYq26ykh6OWMatdzPBQhmhdIs
         HwjsK85lgsETAZIUUWDOV/FrkNcdA07l59d95BhtfvFnEmv6xdTTtPOfBiJqfC49+d0w
         XW/VRilZ17rm4ekuR3OS5To5EJOESl2pKvZVWUhmopmRlLkcjwV8VkdcNFmxkeWTZcvZ
         zVkg==
X-Gm-Message-State: AOJu0Yz7jxNZYQmdEvDNxGy6ZGWS5WgK7WJThnE17b6N2UnhOoANuoil
	Fi/sVyJJCp+3JzaMy9jEwm0NeZwG0qbdwtKe0Tu8LWNn/baxiKskgCaR0hElyZzpXBJl5gsQZkA
	tVIVH1ZIqSopT77Yw5VNB0ieWm91EHrM1ZAu/
X-Google-Smtp-Source: AGHT+IG7wLGht0xNBz+bt/mG1e+4dxWnO7yhbSbVk/YuCf/7WkBuPoV05DoNtWLubTwidHCIpLEFOQAsMQDSUDgL4OA=
X-Received: by 2002:a05:6e02:23c3:b0:363:8007:d7dd with SMTP id
 br3-20020a056e0223c300b003638007d7ddmr71455ilb.3.1706929756513; Fri, 02 Feb
 2024 19:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-10-namhyung@kernel.org>
In-Reply-To: <20240202220459.527138-10-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Feb 2024 19:09:05 -0800
Message-ID: <CAP-5=fWhHb8iomEQ_rhwC50kGhPEVbDZv6X6riY_3pr787bhAQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] perf annotate-data: Handle call instructions
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
> When updating instruction states, the call instruction should play a
> role since it can change the register states.  For simplicity, mark some
> registers as scratch registers (should be arch-dependent), and
> invalidate them all after a function call.

nit: Volatile or caller-save would be a more conventional name than scratch=
.

Thanks,
Ian

> If the function returns something, the designated register (ret_reg)
> will have the type info.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 45 +++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index e46e162c783f..185cb896b9d6 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -23,10 +23,14 @@
>  #include "symbol.h"
>  #include "symbol_conf.h"
>
> -/* Type information in a register, valid when ok is true */
> +/*
> + * Type information in a register, valid when @ok is true.
> + * The @scratch registers are invalidated after a function call.
> + */
>  struct type_state_reg {
>         Dwarf_Die type;
>         bool ok;
> +       bool scratch;
>  };
>
>  /* Type information in a stack location, dynamically allocated */
> @@ -50,6 +54,7 @@ struct type_state_stack {
>  struct type_state {
>         struct type_state_reg regs[TYPE_STATE_MAX_REGS];
>         struct list_head stack_vars;
> +       int ret_reg;
>  };
>
>  static bool has_reg_type(struct type_state *state, int reg)
> @@ -57,10 +62,23 @@ static bool has_reg_type(struct type_state *state, in=
t reg)
>         return (unsigned)reg < ARRAY_SIZE(state->regs);
>  }
>
> -void init_type_state(struct type_state *state, struct arch *arch __maybe=
_unused)
> +void init_type_state(struct type_state *state, struct arch *arch)
>  {
>         memset(state, 0, sizeof(*state));
>         INIT_LIST_HEAD(&state->stack_vars);
> +
> +       if (arch__is(arch, "x86")) {
> +               state->regs[0].scratch =3D true;
> +               state->regs[1].scratch =3D true;
> +               state->regs[2].scratch =3D true;
> +               state->regs[4].scratch =3D true;
> +               state->regs[5].scratch =3D true;
> +               state->regs[8].scratch =3D true;
> +               state->regs[9].scratch =3D true;
> +               state->regs[10].scratch =3D true;
> +               state->regs[11].scratch =3D true;
> +               state->ret_reg =3D 0;
> +       }
>  }
>
>  void exit_type_state(struct type_state *state)
> @@ -417,6 +435,29 @@ void update_insn_state(struct type_state *state, str=
uct data_loc_info *dloc,
>         int fbreg =3D dloc->fbreg;
>         int fboff =3D 0;
>
> +       if (ins__is_call(&dl->ins)) {
> +               Dwarf_Die func_die;
> +
> +               /* __fentry__ will preserve all registers */
> +               if (dl->ops.target.sym &&
> +                   !strcmp(dl->ops.target.sym->name, "__fentry__"))
> +                       return;
> +
> +               /* Otherwise invalidate scratch registers after call */
> +               for (unsigned i =3D 0; i < ARRAY_SIZE(state->regs); i++) =
{
> +                       if (state->regs[i].scratch)
> +                               state->regs[i].ok =3D false;
> +               }
> +
> +               /* Update register with the return type (if any) */
> +               if (die_find_realfunc(cu_die, dl->ops.target.addr, &func_=
die) &&
> +                   die_get_real_type(&func_die, &type_die)) {
> +                       state->regs[state->ret_reg].type =3D type_die;
> +                       state->regs[state->ret_reg].ok =3D true;
> +               }
> +               return;
> +       }
> +
>         /* FIXME: remove x86 specific code and handle more instructions l=
ike LEA */
>         if (!strstr(dl->ins.name, "mov"))
>                 return;
> --
> 2.43.0.594.gd9cf4e227d-goog
>

