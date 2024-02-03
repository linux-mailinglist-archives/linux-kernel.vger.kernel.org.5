Return-Path: <linux-kernel+bounces-50891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDAD847FE7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C26E1F2313A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBEDF41;
	Sat,  3 Feb 2024 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKS3aFlu"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17700F51F
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706930490; cv=none; b=qlAw6w9YDKW5NV4udyBTci2YynAvQKSF2Nze31R4/VYhFcjZEfBKxseFTaGevduYEX/BzG/3MmiZHRvPq9fqhnyoF3wV4u2Qgt7NXvV5W6Ha1n0qVF22Ks+o9F2LX+qJzBCRDSRKV0+AxcMEPefUpBe45gWWLEBBU0BZ3nyFHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706930490; c=relaxed/simple;
	bh=9bbV8v/XesQnkV5S5/dZRkkgLTcqBfC/AF/L1stS04Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grL6iYK+5PqjACEkgdj3Cfr8+4Mkf1VmMOTaR0kuVZJtSBDXJV1CWUSYVNirtRMitO8sHNIBM5j/BLGQbgqMrox/Z02HPXJjm+1LslH38h1v0i50WRUBu7meFWIBAzB7GR5yXqy4/hZF5aygHDhkXDEl2lav6rC53BxJ56wxbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKS3aFlu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93b982761so102205ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 19:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706930485; x=1707535285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2u//wf4yb5ku/Yg3213XLgXCGYC5NdB6fyXKhm401o=;
        b=BKS3aFlumkez5V5oDS5j2KUX5/QIX6g5OXxPyQBf64pINCy7sAC+rFIMPjY6DqmQ2g
         NKQRfCJz0VuDE81v5qSRA1bWEuvFVWGpVXyJmu+a+lRX65h7HaeiioOKDL2QOr9llp88
         Hc0hszPftWVF3FRrBdwQcpnoPbnvnFtMexrFKD51SRWl0uU8m2SlIqefeLqhbhmv4mL+
         zfdPQj3rTq3OQAoNF6DipEZAy+LXU6YFcuNHZ7snSOE940kWnQTYdG6oRVFsvBEfVavm
         P56t/efmkjJKUcWwGYFFdI4OkG/YBXMNUXGFM2P3nLgu3+ZIIeP5LWXdgu4oiD3v7OMg
         RC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706930485; x=1707535285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2u//wf4yb5ku/Yg3213XLgXCGYC5NdB6fyXKhm401o=;
        b=QyK9LCrtM4Ab9L9dFgwY1YZR00QzgejgvsL0ne1I8sH8ZfC7jImJckFj/l40Eo3u0p
         HpWQ2NiHNO9BA1eYORLk0E/kVr2pd8t0mQIem96yenbvRl7nRJpCjW3IIHaNq1gsM4hm
         NoA/SQbE3zweRt0B6ONDi2IwXF27J6kBNjYFtjPeeKeBsaI/7z4DqNyfIsXFEhd5Za7l
         MDktOfKavPfo8UNLAkDzi4UpigPhd5Ff+NMusTklR3baLF/fE6tTp4ekAc8RD4rANLPk
         6sTHu5wTZazmgiK9dXWRPPF7vf+hng8f1iD/BI5Z0ubpZoY9HhG65pj43UMIQR4f8Oax
         wfbA==
X-Gm-Message-State: AOJu0YyrkYx6MNY+atxjgVLG/6VbMTHDcY17ovy1us/z/ty2hY0T5JgX
	6/10Efk8KhdkdPDJ+TjwVdHhAUzeBnLKeHzCr8dL33gSSWDTjHe3MzG91If3SGl+ZiPaM5FS19P
	2LDtBfsR8N/ijaQTu+Zw7DF5qYZq1AGCln5Lb
X-Google-Smtp-Source: AGHT+IGAk0k1DBjlKTa3qXwHjikNO3DQIpo8PmfE1+IuKKtWK6lfiPhAVz0TF2wE8HETTzA62P0HIaMI9gbDNxccIdI=
X-Received: by 2002:a17:903:608:b0:1d8:dd63:674f with SMTP id
 kg8-20020a170903060800b001d8dd63674fmr70951plb.5.1706930480522; Fri, 02 Feb
 2024 19:21:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-15-namhyung@kernel.org>
In-Reply-To: <20240202220459.527138-15-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Feb 2024 19:21:09 -0800
Message-ID: <CAP-5=fUWaKW7d6_YkET0o26=fjBwX6PPJ1gXQ9wndQM_Oi2O3A@mail.gmail.com>
Subject: Re: [PATCH 14/14] perf annotate-data: Add stack canary type
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
> When the stack protector is enabled, compiler would generate code to
> check stack overflow with a special value called 'stack carary' at
> runtime.  On x86_64, GCC hard-codes the stack canary as %gs:40.
>
> While there's a definition of fixed_percpu_data in asm/processor.h,
> it seems that the header is not included everywhere and many places
> it cannot find the type info.  As it's in the well-known location (at
> %gs:40), let's add a pseudo stack canary type to handle it specially.

I wonder if cases like this can be handled by debug info rather than
special cases in the tool. Special cases are fine too, but are
potentially less portable.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.h |  1 +
>  tools/perf/util/annotate.c      | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index 0bfef29fa52c..e293980eb11b 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -77,6 +77,7 @@ struct annotated_data_type {
>
>  extern struct annotated_data_type unknown_type;
>  extern struct annotated_data_type stackop_type;
> +extern struct annotated_data_type canary_type;
>
>  /**
>   * struct data_loc_info - Data location information
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 5f3136f57c62..f2683dadf3cf 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -116,6 +116,13 @@ struct annotated_data_type stackop_type =3D {
>         },
>  };
>
> +struct annotated_data_type canary_type =3D {
> +       .self =3D {
> +               .type_name =3D (char *)"(stack canary)",
> +               .children =3D LIST_HEAD_INIT(canary_type.self.children),
> +       },
> +};
> +
>  static int arch__grow_instructions(struct arch *arch)
>  {
>         struct ins *new_instructions;
> @@ -3764,6 +3771,17 @@ static bool is_stack_operation(struct arch *arch, =
struct disasm_line *dl)
>         return false;
>  }
>
> +static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *=
loc)
> +{
> +       /* On x86_64, %gs:40 is used for stack canary */
> +       if (arch__is(arch, "x86")) {
> +               if (loc->segment =3D=3D INSN_SEG_X86_GS && loc->offset =
=3D=3D 40)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
>                         struct disasm_line *dl)
>  {
> @@ -3938,6 +3956,12 @@ struct annotated_data_type *hist_entry__get_data_t=
ype(struct hist_entry *he)
>                 }
>
>                 mem_type =3D find_data_type(&dloc);
> +
> +               if (mem_type =3D=3D NULL && is_stack_canary(arch, op_loc)=
) {
> +                       mem_type =3D &canary_type;
> +                       dloc.type_offset =3D 0;
> +               }
> +
>                 if (mem_type)
>                         istat->good++;
>                 else
> --
> 2.43.0.594.gd9cf4e227d-goog
>

