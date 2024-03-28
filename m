Return-Path: <linux-kernel+bounces-123217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9211890498
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC92D1C2ECF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3EA131184;
	Thu, 28 Mar 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0X+j32pB"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5734130A4D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642001; cv=none; b=MF8AhfUt1T9s7YEsLP/ZTpQlp6r/4QxSSitJ+g/dCJMGNXND75pMYa76i3+9ngr8DLeAw9WF3R2k3xGAawMAbzSb1ZzipcoDSafd9RAn0gnY5BB3DcRcxQ0wjyXZEiB3ADALFtOOXSE6rn4dmT8Tg0SXfPtiXqQkb1CR+mm7m90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642001; c=relaxed/simple;
	bh=YNTfzZXkS2tduXOtdCnsa35rn72an0t5DimbmCwLsNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDiNH4ZH6oX8do97INdOXPAZvj8C+HVtt+FbLpSl50Xzx37Kl6BoAzCjZo4vs6dN43nk16L295qKbQ5eg9GSZvFZfr6RFN5fjMBj4p9ovLmkbKbSrkpraOPw3KYn5L1cJewaq8N5x7QKhjJ7NqTrxKS3L9iSEerOOLQQ1GtBR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0X+j32pB; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-368c8845dd0so2575ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711641999; x=1712246799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujVLH+Y4heKh4N6QqT0QfQEa56kMv090ypPqHTTSdJA=;
        b=0X+j32pBo6R96cNotlDLcgsEgsoOqKjzs0hvgRs8nGsGX97aA6yzicEzkoVgdZ43Lz
         To67Flr1UvAXIHWWGGlKQLKijgAum4/4NT0ILd9UEd8odtZhF8jTJnIWjkprHhfzKOkQ
         oJ0xCEW7/FQrd8AVtjYgM336/4hRIUE5FdnnQM5VGc83nXdaZA8vMKg7VsuguK3H7Qnp
         ecpNMsPSMy3vmuhcU/lT42Vz42mGNf5EmD/F9ih3Pp1TjUhdc7BQNVB2hwxaBOGlMBcg
         /TjShuywDloxevXM62o5x0G4QmS3nfIYF/9WsOR3DAZjeKxXShuEHDDmBpPcC3y8H16c
         2Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711641999; x=1712246799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujVLH+Y4heKh4N6QqT0QfQEa56kMv090ypPqHTTSdJA=;
        b=U7sIAhSbscBzaXFD2QK8qLQi4JPBrcTpRXhhTPKked5LahZtPHbvJ3hX8pDCnkBhUy
         qY2PdhyBgZI8JcPU8k9DzTA0u1DyhzHm7jbwL4DJ3Ywf+XZ7I1GvOJFll3CvQsxrJJwN
         UQlcV62ObFEGnB/bb9yt8yXXd8S7m1dPN/JpSabbiD0Mm0KQxUODr0A5dTtWwY7GnTX7
         LIfuyrLN4sdBzdgd7DTOtuBuhyjr5LLnv3XWM+0KSPR+3BCZ5knip4AUk60Q79my7tsx
         jgbx6jwPpzG58++weG/crSTmfq3Lpfs957R78wjHuqamzoQTLLeV3Di3QoUD1njiEuvB
         v69g==
X-Forwarded-Encrypted: i=1; AJvYcCVc4QLZvN0/khh/1QUfnPdq0RjcU9VlFqPD8wTABjf10tkfIQ7EXA4MhmlVgSl5I78urDp2hLE/hwjHiBv1hpVqqx8Op+nWcYn2X6yD
X-Gm-Message-State: AOJu0YwrH6wklT8VN2Hr7KLw6TiN9jU5f5mh7wC6eUtB/uDQF7JpQAVr
	5uB631MCxlHgEAGeD+rvSrWiObQhhrRlLeVIHOHJDawzgonOQM0iX9U5hNUWbGS/LX3sICXt/IU
	glbZ1r4h89p0VQmjfgijA8cS3DQYZGt3K/vXA
X-Google-Smtp-Source: AGHT+IGXyb02hCuIjtAdd5mD/XhWKmGBf7L9DX4y3Ph+vjGiubBqK//IsbbdX+zKsmiF2LodL4NeS6pdMyKCdfx5Ee0=
X-Received: by 2002:a92:ca49:0:b0:368:775b:ad1a with SMTP id
 q9-20020a92ca49000000b00368775bad1amr258472ilo.16.1711641998501; Thu, 28 Mar
 2024 09:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328055857.383180-1-yangjihong@bytedance.com> <20240328055857.383180-2-yangjihong@bytedance.com>
In-Reply-To: <20240328055857.383180-2-yangjihong@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 28 Mar 2024 09:06:28 -0700
Message-ID: <CAP-5=fWA0EmxfxHOL2N2j=itUu_-wPxugB1Am6zi2pRAxBSFtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf evsel: Use evsel__name_is() helper
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:59=E2=80=AFPM Yang Jihong <yangjihong@bytedance.=
com> wrote:
>
> Code cleanup, replace strcmp(evsel__name(evsel, {NAME})) with
> evsel__name_is() helper.
>
> No functional change.
>
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-kmem.c               |  2 +-
>  tools/perf/builtin-sched.c              |  4 +--
>  tools/perf/builtin-script.c             |  2 +-
>  tools/perf/builtin-trace.c              |  4 +--
>  tools/perf/tests/evsel-roundtrip-name.c |  4 +--
>  tools/perf/tests/parse-events.c         | 39 +++++++++----------------
>  6 files changed, 22 insertions(+), 33 deletions(-)
>
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 9714327fd0ea..6fd95be5032b 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -1408,7 +1408,7 @@ static int __cmd_kmem(struct perf_session *session)
>         }
>
>         evlist__for_each_entry(session->evlist, evsel) {
> -               if (!strcmp(evsel__name(evsel), "kmem:mm_page_alloc") &&
> +               if (evsel__name_is(evsel, "kmem:mm_page_alloc") &&
>                     evsel__field(evsel, "pfn")) {
>                         use_pfn =3D true;
>                         break;
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 1bfb22347371..0fce7d8986c0 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2148,7 +2148,7 @@ static bool is_idle_sample(struct perf_sample *samp=
le,
>                            struct evsel *evsel)
>  {
>         /* pid 0 =3D=3D swapper =3D=3D idle task */
> -       if (strcmp(evsel__name(evsel), "sched:sched_switch") =3D=3D 0)
> +       if (evsel__name_is(evsel, "sched:sched_switch"))
>                 return evsel__intval(evsel, sample, "prev_pid") =3D=3D 0;
>
>         return sample->pid =3D=3D 0;
> @@ -2375,7 +2375,7 @@ static bool timehist_skip_sample(struct perf_sched =
*sched,
>         }
>
>         if (sched->idle_hist) {
> -               if (strcmp(evsel__name(evsel), "sched:sched_switch"))
> +               if (!evsel__name_is(evsel, "sched:sched_switch"))
>                         rc =3D true;
>                 else if (evsel__intval(evsel, sample, "prev_pid") !=3D 0 =
&&
>                          evsel__intval(evsel, sample, "next_pid") !=3D 0)
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 37088cc0ff1b..cc981531ec00 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3471,7 +3471,7 @@ static int check_ev_match(char *dir_name, char *scr=
iptname,
>
>                         match =3D 0;
>                         evlist__for_each_entry(session->evlist, pos) {
> -                               if (!strcmp(evsel__name(pos), evname)) {
> +                               if (evsel__name_is(pos, evname)) {
>                                         match =3D 1;
>                                         break;
>                                 }
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 90eaff8c0f6e..9b93807a1906 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4902,7 +4902,7 @@ int cmd_trace(int argc, const char **argv)
>                 goto out;
>         }
>         trace.syscalls.events.bpf_output =3D evlist__last(trace.evlist);
> -       assert(!strcmp(evsel__name(trace.syscalls.events.bpf_output), "__=
augmented_syscalls__"));
> +       assert(evsel__name_is(trace.syscalls.events.bpf_output), "__augme=
nted_syscalls__");
>  skip_augmentation:
>  #endif
>         err =3D -1;
> @@ -4959,7 +4959,7 @@ int cmd_trace(int argc, const char **argv)
>          */
>         if (trace.syscalls.events.bpf_output) {
>                 evlist__for_each_entry(trace.evlist, evsel) {
> -                       bool raw_syscalls_sys_exit =3D strcmp(evsel__name=
(evsel), "raw_syscalls:sys_exit") =3D=3D 0;
> +                       bool raw_syscalls_sys_exit =3D evsel__name_is(evs=
el, "raw_syscalls:sys_exit");
>
>                         if (raw_syscalls_sys_exit) {
>                                 trace.raw_augmented_syscalls =3D true;
> diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/e=
vsel-roundtrip-name.c
> index 15ff86f9da0b..1922cac13a24 100644
> --- a/tools/perf/tests/evsel-roundtrip-name.c
> +++ b/tools/perf/tests/evsel-roundtrip-name.c
> @@ -37,7 +37,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
>                                         continue;
>                                 }
>                                 evlist__for_each_entry(evlist, evsel) {
> -                                       if (strcmp(evsel__name(evsel), na=
me)) {
> +                                       if (!evsel__name_is(evsel, name))=
 {
>                                                 pr_debug("%s !=3D %s\n", =
evsel__name(evsel), name);
>                                                 ret =3D TEST_FAIL;
>                                         }
> @@ -71,7 +71,7 @@ static int perf_evsel__name_array_test(const char *cons=
t names[], int nr_names)
>                         continue;
>                 }
>                 evlist__for_each_entry(evlist, evsel) {
> -                       if (strcmp(evsel__name(evsel), names[i])) {
> +                       if (!evsel__name_is(evsel, names[i])) {
>                                 pr_debug("%s !=3D %s\n", evsel__name(evse=
l), names[i]);
>                                 ret =3D TEST_FAIL;
>                         }
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index feb5727584d1..0b70451451b3 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -470,8 +470,7 @@ static int test__checkevent_breakpoint_modifier(struc=
t evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_=
kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip)=
;
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "mem:0:u"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:u"));
>
>         return test__checkevent_breakpoint(evlist);
>  }
> @@ -484,8 +483,7 @@ static int test__checkevent_breakpoint_x_modifier(str=
uct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude=
_kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip)=
;
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "mem:0:x:k"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:x:k"))=
;
>
>         return test__checkevent_breakpoint_x(evlist);
>  }
> @@ -498,8 +496,7 @@ static int test__checkevent_breakpoint_r_modifier(str=
uct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_=
kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv)=
;
>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "mem:0:r:hp"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:r:hp")=
);
>
>         return test__checkevent_breakpoint_r(evlist);
>  }
> @@ -512,8 +509,7 @@ static int test__checkevent_breakpoint_w_modifier(str=
uct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_=
kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "mem:0:w:up"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:w:up")=
);
>
>         return test__checkevent_breakpoint_w(evlist);
>  }
> @@ -526,8 +522,7 @@ static int test__checkevent_breakpoint_rw_modifier(st=
ruct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude=
_kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "mem:0:rw:kp"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:rw:kp"=
));
>
>         return test__checkevent_breakpoint_rw(evlist);
>  }
> @@ -540,8 +535,7 @@ static int test__checkevent_breakpoint_modifier_name(=
struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_=
kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip)=
;
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "breakpoint"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint")=
);
>
>         return test__checkevent_breakpoint(evlist);
>  }
> @@ -554,8 +548,7 @@ static int test__checkevent_breakpoint_x_modifier_nam=
e(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude=
_kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip)=
;
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "breakpoint"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint")=
);
>
>         return test__checkevent_breakpoint_x(evlist);
>  }
> @@ -568,8 +561,7 @@ static int test__checkevent_breakpoint_r_modifier_nam=
e(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_=
kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv)=
;
>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "breakpoint"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint")=
);
>
>         return test__checkevent_breakpoint_r(evlist);
>  }
> @@ -582,8 +574,7 @@ static int test__checkevent_breakpoint_w_modifier_nam=
e(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_=
kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "breakpoint"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint")=
);
>
>         return test__checkevent_breakpoint_w(evlist);
>  }
> @@ -596,8 +587,7 @@ static int test__checkevent_breakpoint_rw_modifier_na=
me(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude=
_kernel);
>         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "breakpoint"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint")=
);
>
>         return test__checkevent_breakpoint_rw(evlist);
>  }
> @@ -609,12 +599,12 @@ static int test__checkevent_breakpoint_2_events(str=
uct evlist *evlist)
>         TEST_ASSERT_VAL("wrong number of entries", 2 =3D=3D evlist->core.=
nr_entries);
>
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT =3D=3D evsel->=
core.attr.type);
> -       TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "breakp=
oint1"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint1"=
));
>
>         evsel =3D evsel__next(evsel);
>
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT =3D=3D evsel->=
core.attr.type);
> -       TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "breakp=
oint2"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint2"=
));
>
>         return TEST_OK;
>  }
> @@ -691,15 +681,14 @@ static int test__checkevent_pmu_name(struct evlist =
*evlist)
>         TEST_ASSERT_VAL("wrong number of entries", 2 =3D=3D evlist->core.=
nr_entries);
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type);
>         TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
> -       TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "krava"=
));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
>
>         /* cpu/config=3D2/u" */
>         evsel =3D evsel__next(evsel);
>         TEST_ASSERT_VAL("wrong number of entries", 2 =3D=3D evlist->core.=
nr_entries);
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type);
>         TEST_ASSERT_VAL("wrong config", test_config(evsel, 2));
> -       TEST_ASSERT_VAL("wrong name",
> -                       !strcmp(evsel__name(evsel), "cpu/config=3D2/u"));
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "cpu/config=
=3D2/u"));
>
>         return TEST_OK;
>  }
> --
> 2.25.1
>

