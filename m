Return-Path: <linux-kernel+bounces-128520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEFA895BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3018B277A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4A15B54F;
	Tue,  2 Apr 2024 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wis1wMJZ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EC85C7D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083784; cv=none; b=Fx0vNmDtO7Mfv6kqscvCPg/K4AdrZ5eTINkhg81vHVd+4wmAxV/1kpRyNeSJL22N+hdcGk7fnxPFspmBiduis+D5WjmmkAlIJpszOSMz9YgW+d5UXb3BUMFHEocdrxXuW/lhTpWQKFDYmPqxjMkBGQxXdUmgwBWJRjT6wPBaRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083784; c=relaxed/simple;
	bh=weISqq2A6RI0H2LbwN7F+0X9UdQ8TvO+tJz9Kd/Hf90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iR6ad6qBY4z/5y0DivnTmDg1UAqcJn14fM2HkxXiQj7DMeUzPgEqsc/45livGoV/TbGRJcC+h93lkPvt5Aex9LqjhE/MmGcZyd/i4llvw8JKYx8GQWx3gEtbMDCZJ7XLWj6jKR41jDWtujWOifJbATluw34ArDksmlzNNkeJyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wis1wMJZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e28d7b03e9so9675ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712083782; x=1712688582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=588W+WKWGCHDk22Ud5hS9stI2LC3FAq1GuSxHQ/M9as=;
        b=Wis1wMJZR1p7IRF3wzWLzAY99c3OMVlVZ1BsD8n3dNZRnv2JH3OoM1UohlshGO673i
         zNcss4wVhSFndY9Ed5t99BfPy4Q9h7GLrhjnxyD9dns8M23UDz2J7NWW4Nzs34aH5Ldq
         Lyk4lsF2naiZDlWvvbPDCIZaqxMRRqVANJFQ7w2UYmjmY5Gbas9iYIgGScewVO8g3FZO
         GLfZr5zjTzFtFIUoMYGp0RXoxI+KpnZ/kwt5qi/jG9L7MNfSwJU6crSWPpk3W7ivxlFh
         YOn6nl9mdd4pslTDxLNtGw9r5/OvKZ5hSCBQDNjsp6u03lo9jWOaIPUkG4tOYUBzkfHX
         OBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712083782; x=1712688582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=588W+WKWGCHDk22Ud5hS9stI2LC3FAq1GuSxHQ/M9as=;
        b=S8n/F36qKQgTstkLn1cMErQa8OFH2GaTFN+hNHXIjFHE2ctDo15nUsj276VdOsUhb5
         fO7P5JIpjpKRR+OeJX910yLFpifjJZQ5BOEHiMDzDeuVp+QHnhKkCICx8fj3vcfkSbII
         LfVwLNfinbwbBN83H27W3KAHXk1be6PZAZObtguS5rf/8IlIuLTirFUS5754axkg9Qwh
         tu3oEUwm3YfuefnFC03zioCMoMGhjo2qiUdy4Iz7MQs0ojA2KSB8C5NSXpVIkuLz6XCG
         pjkq7IJjVsAFT/+vmAQk8EzECBvmdIjso4JcEDClnktKE0Tqt+SJp1YmA+8hdeVHAnbG
         AbMw==
X-Forwarded-Encrypted: i=1; AJvYcCW5gsLsJQUyyElmXgj13K1q2ZPLZ1pmQdXNXrpMG9pvTwv1D4rd5bVrVFbO8BPEexCDDwyoJsp3QQ0aUHJR1WuMQAOHKXQ9LHmKzfzh
X-Gm-Message-State: AOJu0YwFGsrswliYF1SES3oVVuWYbbi2+vjErOJVD3g4WNYqj29EFu2Y
	nnYW2C8v12JOSwM3o9HAuf1BCN4H1eCp99d2quIXFbIgNuPAJERKns57iLJVEjnRCOHmcSWVofy
	GexsRKxcT5Ms+uNF4vuVYHvHjuP2rPS0WAC5f
X-Google-Smtp-Source: AGHT+IFqE+UQS0RbhVUDfvVWh1jxlaucrKVTE2OWHdxUHvFSzVEw8wbwfhObgRXrJ5KsEFLTxz8yLY320Q5s7zmUQM4=
X-Received: by 2002:a17:902:f645:b0:1dd:8001:d239 with SMTP id
 m5-20020a170902f64500b001dd8001d239mr29669plg.14.1712083781959; Tue, 02 Apr
 2024 11:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402184543.898923-1-namhyung@kernel.org>
In-Reply-To: <20240402184543.898923-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Apr 2024 11:49:28 -0700
Message-ID: <CAP-5=fWh+nrZukmvANf0rmG_Fw11hMgm=dPkHCG79F+tdzsTvQ@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Add a missing NULL check
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:45=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I got a report for a failure in BPF verifier on a recent kernel with
> perf lock contention command.  It checks task->sighand->siglock without
> checking if sighand is NULL or not.  Let's add one.
>
>   ; if (&curr->sighand->siglock =3D=3D (void *)lock)
>   265: (79) r1 =3D *(u64 *)(r0 +2624)     ; frame1: R0_w=3Dtrusted_ptr_ta=
sk_struct(off=3D0,imm=3D0) R1_w=3Drcu_ptr_or_null_sighand_struct(off=3D0,im=
m=3D0)
>   266: (b7) r2 =3D 0                      ; frame1: R2_w=3D0
>   267: (0f) r1 +=3D r2
>   R1 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it fir=
st
>   processed 164 insns (limit 1000000) max_states_per_insn 1 total_states =
15 peak_states 15 mark_read 5
>   -- END PROG LOAD LOG --
>   libbpf: prog 'contention_end': failed to load: -13
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -13
>   Failed to load lock-contention BPF skeleton
>   lock contention BPF setup failed
>   lock contention did not detect any lock contention
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index fb54bd38e7d0..4e5914d7eeaa 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -305,7 +305,7 @@ static inline __u32 check_lock_type(__u64 lock, __u32=
 flags)
>                 break;
>         case LCB_F_SPIN:  /* spinlock */
>                 curr =3D bpf_get_current_task_btf();
> -               if (&curr->sighand->siglock =3D=3D (void *)lock)
> +               if (curr->sighand && &curr->sighand->siglock =3D=3D (void=
 *)lock)
>                         return LCD_F_SIGHAND_LOCK;
>                 break;
>         default:
> --
> 2.44.0.478.gd926399ef9-goog
>

