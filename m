Return-Path: <linux-kernel+bounces-55776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BAF84C19C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922C7B23B67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE0753A0;
	Wed,  7 Feb 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVVsLqtt"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5AC8F55
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267663; cv=none; b=KS34h7eMjn3UIysp/niL4pORXmwnfTrfWRLvnUg9imkVp235KhizerCj928UPceGAZfQCOw9mQDTixaWxbSfFCcxejT4k+8b1ZgElQI/pA0cep+L5sc6gwiZ5Gbm0exmYMln2L4UPvIl19a2FcB0Q5RO6eewJzVZ24y0WR2wk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267663; c=relaxed/simple;
	bh=d0U+lPmSpGG89mqt9VZzbfl05d/4D3RqX+PjFTcUCxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3XNSL+sIx+qfcYduP8hlWCQGqe8/q6hjJbLLnoaB/XTRbbKieaZNMH74SIE5Glekaeanqpv95J+n/UIIRT4Vtd8gkbgbwGpjzx/w23YWDW3vcv7dlE+PPKJYKKAtgIJxINy8lY+SfhowlZlVu7rN4iT62/rSl+egNCCg81CarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVVsLqtt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d9daf74f41so29575ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 17:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707267661; x=1707872461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuiYdoH3hy6joRciIMiO91EZyMIi9pF66tPM5AaMmHE=;
        b=tVVsLqttmh9yJ5ufP/ts1+dFC3QWmZxxt6Wp+/F3HDtG18I8JsISg9+mqFJ3m9KPRu
         Z8uuEjJ4im2R2RtWDc8UQXQzEhUm1jRZZgnFeeYLqXicKOYnRgNzBgOzkZaCbC4Qn3XG
         j5sMYPaiGIJPo2QCjfimsiPXFDcegOueHjnfaRzZElb2QSePLs3BeUsNPLO+rqcFWDhn
         tEGEFVO2lX/iGI12RI0KNkGiH870nv0Yfie6tVPh4J6nemLc4pNQNd0aCYp5tCtz4sRj
         lA4N66Nk7KTTcELNSo2LUmj5VOGkvXGsknxeP8k+MWjrrvMux6oNsCK2105lpxIVImIU
         A6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707267661; x=1707872461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuiYdoH3hy6joRciIMiO91EZyMIi9pF66tPM5AaMmHE=;
        b=lmP3kuVbJwElWT/FvJRmjJ4bO7SRgQWmFcMi39ZfD1txxUlPUnPi4iAHWFNaFFQ1OI
         nYVQ4ldFyLFK35eyhFM9w1ju93py3eGBFHGInLECVg9XEn9OAxGGTDBy9AaXIfczLMEh
         nnrm0U6V2MBfp2Z0AFy+ld5js7HVk8SLcC+l1F3B+t+g4VfBaZNrlKJkGMQ4IWJJ565i
         1HwoDhXf9zSX0n9zCFsXAyVsskCqbexkr3Vs+A9b4X5TaNikaViwp3704WkUSMGGoYTU
         YOgDYnxkiIheUcJwj8NGnoldrKy5N2OeBzCMPAjimdh5RNxLlBhw04w2xcDi3slYDetC
         JbeA==
X-Forwarded-Encrypted: i=1; AJvYcCUrpUrK5vBhEBWFbncHE4l8qzb5Mb/7MC7FMQcLSjUnvByVAJkDbIrLu2dbdDlaPKxS62WafOpeoZt/uBahEbYzlu7NRKcjYaJEYCyt
X-Gm-Message-State: AOJu0YyXOQ/eeOvSySvQVGHwPOfAIdh8/TyOjSf5mXwbcjoE5fAWmLkr
	sCbz5O7MFjdn/AuG8cQ+4vcCs11UU03CC5WRdr7z+bpM2mAYTwKLmz+b1q1fHseToEj+3eHiS9x
	Sx+WoWymkSQMzl9LMhMbO4LxmfcPcraq+EKZe
X-Google-Smtp-Source: AGHT+IEVJFqtfDZARbVkeEGxOE5+b9pxdIKtQ4BrQjTr//hkIO9kWywuNWMrgLQ1J4ADjCfdBOc6Dsv96zJ1Yn9jl0I=
X-Received: by 2002:a17:902:ced1:b0:1d9:7a7a:3cf6 with SMTP id
 d17-20020a170902ced100b001d97a7a3cf6mr22075plg.12.1707267660520; Tue, 06 Feb
 2024 17:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205145819.1943114-1-kan.liang@linux.intel.com>
In-Reply-To: <20240205145819.1943114-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 Feb 2024 17:00:49 -0800
Message-ID: <CAP-5=fWB-URhxGG00h9azV-e1tZBWNFpZbzhEW+zbLaQGFeJHQ@mail.gmail.com>
Subject: Re: [PATCH] perf script: Print source line for each jump in brstackinsn
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, mingo@kernel.org, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	ak@linux.intel.com, amiri.khalil@intel.com, ahmad.yasin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 6:58=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> With the srcline option, the perf script only prints a source line at
> the beginning of a sample with call/ret from functions, but not for
> each jump in brstackinsn. It's useful to print a source line for each
> jump in brstackinsn when the end user analyze the full assembler
> sequences of branch sequences for the sample.
>
> The srccode option can also be used to locate the source code line.
> However, it's printed almost for every line and makes the output less
> readable.
>
>  $perf script -F +brstackinsn,+srcline --xed
>
> Before the patch,
>
>  tchain_edit_deb 1463275 15228549.107820:     282495 instructions:u:     =
       401133 f3+0xd (/home/kan/os.li>
>   tchain_edit.c:22
>         f3+40:  tchain_edit.c:20
>         000000000040114e                        jle 0x401133             =
       # PRED 6 cycles [6]
>         0000000000401133                        movl  -0x4(%rbp), %eax
>         0000000000401136                        and $0x1, %eax
>         0000000000401139                        test %eax, %eax
>         000000000040113b                        jz 0x401143
>         000000000040113d                        addl  $0x1, -0x4(%rbp)
>         0000000000401141                        jmp 0x401147             =
       # PRED 3 cycles [9] 2.00 IPC
>         0000000000401147                        cmpl  $0x3e7, -0x4(%rbp)
>         000000000040114e                        jle 0x401133             =
       # PRED 6 cycles [15] 0.33 IPC
>
> After the patch,
>
>  tchain_edit_deb 1463275 15228549.107820:     282495 instructions:u:     =
       401133 f3+0xd (/home/kan/os.li>
>   tchain_edit.c:22
>         f3+40:  tchain_edit.c:20
>         000000000040114e                        jle 0x401133             =
        srcline: tchain_edit.c:20      # PRED 6 cycles [6]
>         0000000000401133                        movl  -0x4(%rbp), %eax
>         0000000000401136                        and $0x1, %eax
>         0000000000401139                        test %eax, %eax
>         000000000040113b                        jz 0x401143
>         000000000040113d                        addl  $0x1, -0x4(%rbp)
>         0000000000401141                        jmp 0x401147             =
        srcline: tchain_edit.c:23      # PRED 3 cycles [9] 2.00 IPC
>         0000000000401147                        cmpl  $0x3e7, -0x4(%rbp)
>         000000000040114e                        jle 0x401133             =
        srcline: tchain_edit.c:20      # PRED 6 cycles [15] 0.33 IPC
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b1f57401ff23..af63b7c37c8a 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1162,7 +1162,8 @@ static int print_srccode(struct thread *thread, u8 =
cpumode, uint64_t addr)
>  static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>                             struct perf_insn *x, u8 *inbuf, int len,
>                             int insn, FILE *fp, int *total_cycles,
> -                           struct perf_event_attr *attr)
> +                           struct perf_event_attr *attr,
> +                           struct thread *thread)
>  {
>         int ilen =3D 0;
>         int printed =3D fprintf(fp, "\t%016" PRIx64 "\t%-30s\t", ip,
> @@ -1171,6 +1172,16 @@ static int ip__fprintf_jump(uint64_t ip, struct br=
anch_entry *en,
>         if (PRINT_FIELD(BRSTACKINSNLEN))
>                 printed +=3D fprintf(fp, "ilen: %d\t", ilen);
>
> +       if (PRINT_FIELD(SRCLINE)) {
> +               struct addr_location al;
> +
> +               addr_location__init(&al);
> +               thread__find_map(thread, x->cpumode, ip, &al);
> +               printed +=3D map__fprintf_srcline(al.map, al.addr, " srcl=
ine: ", fp);
> +               printed +=3D fprintf(fp, "\t");
> +               addr_location__exit(&al);
> +       }
> +
>         printed +=3D fprintf(fp, "#%s%s%s%s",
>                               en->flags.predicted ? " PRED" : "",
>                               en->flags.mispred ? " MISPRED" : "",
> @@ -1182,6 +1193,7 @@ static int ip__fprintf_jump(uint64_t ip, struct bra=
nch_entry *en,
>                 if (insn)
>                         printed +=3D fprintf(fp, " %.2f IPC", (float)insn=
 / en->flags.cycles);
>         }
> +
>         return printed + fprintf(fp, "\n");
>  }
>
> @@ -1260,7 +1272,7 @@ static int perf_sample__fprintf_brstackinsn(struct =
perf_sample *sample,
>                                            x.cpumode, x.cpu, &lastsym, at=
tr, fp);
>                 printed +=3D ip__fprintf_jump(entries[nr - 1].from, &entr=
ies[nr - 1],
>                                             &x, buffer, len, 0, fp, &tota=
l_cycles,
> -                                           attr);
> +                                           attr, thread);
>                 if (PRINT_FIELD(SRCCODE))
>                         printed +=3D print_srccode(thread, x.cpumode, ent=
ries[nr - 1].from);
>         }
> @@ -1291,7 +1303,7 @@ static int perf_sample__fprintf_brstackinsn(struct =
perf_sample *sample,
>                         printed +=3D ip__fprintf_sym(ip, thread, x.cpumod=
e, x.cpu, &lastsym, attr, fp);
>                         if (ip =3D=3D end) {
>                                 printed +=3D ip__fprintf_jump(ip, &entrie=
s[i], &x, buffer + off, len - off, ++insn, fp,
> -                                                           &total_cycles=
, attr);
> +                                                           &total_cycles=
, attr, thread);
>                                 if (PRINT_FIELD(SRCCODE))
>                                         printed +=3D print_srccode(thread=
, x.cpumode, ip);
>                                 break;
> --
> 2.35.1
>

