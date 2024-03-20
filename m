Return-Path: <linux-kernel+bounces-108430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F315880A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37511F2225A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0D312E58;
	Wed, 20 Mar 2024 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umQltqgJ"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E2125AC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710909760; cv=none; b=YN3mZwy1TRKYO459iCN98MHIK0unXLHDXyq8lgabc0uzMYouJTzHbGT8GTqiloSL8qASAo58RxSBxYrlmdwe8f+J/4XZ6BKOWapHsfM/3Bx/ImtIwbzXVCJUNxwqFwq9souMJIhvqj+7yk/CYeFOIlOiNbqzzGGHhbcF1eI7/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710909760; c=relaxed/simple;
	bh=FFkw7m91uLgfhzY8lSs7u3SRzgLtl3hfepkuhkqEOco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GNXLgHFTosUvL24u1bBvnwtebLFjOpBWl6XiYcDrcMbjZKe2tsSsA3KFnzbu0GuoHz1+iH1t0wW8f6O2gtvsYpAmva5+LzL8aGNlAW9vNznsAIAOWulFtzUi2yJnztZUmhIajxs6N7RPu0+ZpuNoa2cvN0S8ONSBfjjQADCiw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umQltqgJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430e1e06e75so221961cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710909757; x=1711514557; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOiFkCsSh82NJJ1OPmoUof4RsaZcNQDwXob9oPa1+fo=;
        b=umQltqgJvKjISLCQoXswHJ1OmRyYhQQqfidbg/Xg0BLoL9l0YvWui6ATV0qvP+fYFX
         vfUnCrIkFVwhQvncI0vGL4fvEBWeZ3s5OaY54GWA8nLDJgtI19sZ2BEAAPsOSx6MefSJ
         3nLmeNQQNPEDC6VMef8nJOQDdsbWlRaO5If2Kmo2s4jm5cH0WLSfrRMVoTnlrR02gVVl
         QhlrhfiWqjQHRhTMgnJlEmlEA7/E7U1PnPbRazlU4m/n+Oj/pn1KpxiD2qkvUJEZYMpw
         oSw3T7zBCl/lTVwjBDWpwqNfYn13UAg8tAy2mR13i4Zln8igaN47P6chTkbb5le1kGju
         Uiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710909757; x=1711514557;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOiFkCsSh82NJJ1OPmoUof4RsaZcNQDwXob9oPa1+fo=;
        b=OVkg1+Z0YnfGS/SVZRrUO1xROdxW7wqxLb75J8kj8Q9MEZ8avv7gg1oShcu5ZNbvXc
         qyl9JPnmQKqWVh3NA7n9z5ycLHOL9hGw30og7NiJEXjrf4reOPu4e4DEHxxpocfnQRl+
         HvngQakv/kvL9uFDrov/ocleDKJK3HvfhwmZXXaGeB3fAdaruALhISUWGlzhYT8qsnHN
         s5kOU2XTtoQrIQbVzvddvZwp2fj2Td4l3q4/s+WrNaZ1y6Iy6yJQHmY46HM+fP+3qHJ6
         nzmuirM/sKKjp00+1mujaVU7S0eZ02FDdUKdxr8xqQ4asQKVrnUA/0021tBTcAe6gPxr
         +JJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbLUfXpzCezN2qcHhFYXPEaSVeEcQ3YFSx/2NmK7FbY6DR9p77k0k/MoL+xdOC/FEkQf/st+fkQc4GPStytEV9wbjHUPfIDfiWPlN+
X-Gm-Message-State: AOJu0Ywy0j8LineVaUFKuCpTOBPG1PNmU6s0V3lG3T/JBWIX1/jmnsdm
	hd2pojYOR3rJXBJnUNffxPMXgevuESj9SCWBZCvR/3rKX+8YsvxvEeRDISL5I/Z5E9HF+I0r8iY
	/LPSRkyj6/e45at3DcL/dYK1ztaVokZq4wZ3K
X-Google-Smtp-Source: AGHT+IGvy6ooA+9qkzEhIrOI3gXaBwhszV/McOy/gsH1cWTMSTRqckFGy0rcatNzzbMM7CZUnFl6+FXXBeEblwuCZrg=
X-Received: by 2002:ac8:5c91:0:b0:42e:e40f:fca4 with SMTP id
 r17-20020ac85c91000000b0042ee40ffca4mr136551qta.13.1710909757167; Tue, 19 Mar
 2024 21:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301074639.2260708-1-irogers@google.com> <CAP-5=fX7JDkyPEXwJGmhYf75EA5KsFQpZ3tC-70hNe8kUnZ=rw@mail.gmail.com>
In-Reply-To: <CAP-5=fX7JDkyPEXwJGmhYf75EA5KsFQpZ3tC-70hNe8kUnZ=rw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 21:42:26 -0700
Message-ID: <CAP-5=fW_B-HOU0moGXjesjNaz2FR8emSB1LsadXOh5O71CrWWQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf record: Delete session after stopping
 sideband thread
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Brauner <brauner@kernel.org>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Disha Goel <disgoel@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:50=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Feb 29, 2024 at 11:47=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > The session has a header in it which contains a perf env with
> > bpf_progs. The bpf_progs are accessed by the sideband thread and so
> > the sideband thread must be stopped before the session is deleted, to
> > avoid a use after free.  This error was detected by AddressSanitizer
> > in the following:
> >
> > ```
> > =3D=3D2054673=3D=3DERROR: AddressSanitizer: heap-use-after-free on addr=
ess 0x61d000161e00 at pc 0x55769289de54 bp 0x7f9df36d4ab0 sp 0x7f9df36d4aa8
> > READ of size 8 at 0x61d000161e00 thread T1
> >     #0 0x55769289de53 in __perf_env__insert_bpf_prog_info util/env.c:42
> >     #1 0x55769289dbb1 in perf_env__insert_bpf_prog_info util/env.c:29
> >     #2 0x557692bbae29 in perf_env__add_bpf_info util/bpf-event.c:483
> >     #3 0x557692bbb01a in bpf_event__sb_cb util/bpf-event.c:512
> >     #4 0x5576928b75f4 in perf_evlist__poll_thread util/sideband_evlist.=
c:68
> >     #5 0x7f9df96a63eb in start_thread nptl/pthread_create.c:444
> >     #6 0x7f9df9726a4b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone=
3.S:81
> >
> > 0x61d000161e00 is located 384 bytes inside of 2136-byte region [0x61d00=
0161c80,0x61d0001624d8)
> > freed by thread T0 here:
> >     #0 0x7f9dfa6d7288 in __interceptor_free libsanitizer/asan/asan_mall=
oc_linux.cpp:52
> >     #1 0x557692978d50 in perf_session__delete util/session.c:319
> >     #2 0x557692673959 in __cmd_record tools/perf/builtin-record.c:2884
> >     #3 0x55769267a9f0 in cmd_record tools/perf/builtin-record.c:4259
> >     #4 0x55769286710c in run_builtin tools/perf/perf.c:349
> >     #5 0x557692867678 in handle_internal_command tools/perf/perf.c:402
> >     #6 0x557692867a40 in run_argv tools/perf/perf.c:446
> >     #7 0x557692867fae in main tools/perf/perf.c:562
> >     #8 0x7f9df96456c9 in __libc_start_call_main ../sysdeps/nptl/libc_st=
art_call_main.h:58
> > ```
> >
> > Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Note, after this series I'm seeing parallel perf testing being as
> reliable as serial but parallel testing is nearly 3 times faster. I
> think after these changes land we can make parallel execution the
> default.

Ping.

Thanks,
Ian

