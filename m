Return-Path: <linux-kernel+bounces-88031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF1886DC62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12AA4B24C70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4596C6996E;
	Fri,  1 Mar 2024 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7gjzTS3"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B376994C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279464; cv=none; b=HbGSr0pGFL7Xem1JW4yjmunKLo6mYeIf4QkkIZJJd5OETvbTsBKc2xlN2fuQxm58tzhz+4eScXcZLsBzrDFQlNk7CWKgx3yg5VUWz5Osdcm00qBUgqxkmHK8x2UgVErfhm+t9zely/K6TSeHlw78Lx9KqrKnLdcSEB/IYX2FkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279464; c=relaxed/simple;
	bh=TuuRQzWEoaH1NVjEFDOE++6u29MLWMWxkaXmHgd3VE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TzLbWwCxnDjC1F7w9nFT6ZDOq1SMJwi+gx7GJCsZPGKhQiZF/MK0dIfEVLYFk7fio+IX5Bi1UGzbmMsJwqyrXIRR21fHTVVtyeEkLUjhO9X7koLOaA1BFLmqKgqHew+0MRZ5lSEMHCP4UhWb1Cn1/GSOZ473tBXwYWoddicQAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7gjzTS3; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3653e1240e3so105635ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709279462; x=1709884262; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7LWZcQoUZlxKLxUZpTru/ypydEJSZ5JsxZQauyrv0U=;
        b=N7gjzTS3o5QSrUxlsWrwuCFEek17DY+0xnJsfqQlcMPgZbYmXDmRutSDZJfiZabI4v
         xwu8ovynmwF4x6fri+wTK3siqkRgeM74XtzHGfgmyZaZSaRZ0EBwghn4rc0fHIvO8h2V
         p2qVQ2YVa6DWi5M1A6nx5kajhroaZ3SRS6A4kOe1M0whDO8p6oD/GBk3CsQvOvHRdt51
         B65QpLDwo8Jyedj1MclVKz2Yx1aqSCtjDsO72tHWaUJsM1KkvV3sXbnmiBwJ0WX0/XG9
         akZPFzKVmoARozoU7BLXqcoVF/aP88IoPxd44qRIrQSnN5fwJuzkSyxyL3H/xrEXYwEq
         1vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279462; x=1709884262;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7LWZcQoUZlxKLxUZpTru/ypydEJSZ5JsxZQauyrv0U=;
        b=s1B3W9WruK9UPKmjY9s+HcdPTske7ogRzaYQ5Rm0T/5WUyxahDmQ9cVW9gMmlTqj8k
         X30ZZDBKhCPfH5GYggGcRB1VGLa0aGBtXj+ITgkSx5iweHm+KemKs5OjJ93X91zhT50J
         GUU4xAKpwJZOt4Pxo7UjaHHJFG2y1co4xyHFFBFs/j3Y2Hjn4tVYe0q6ZJaZqjAIATOU
         CosTj5e9qaqSh0kiEUe9p/1kRkGJhUxUeQX58wmnsdWrU+6VHv/Q8eODvaTu84rlMwvJ
         36Gqj2DyXHDGPiXKSbbgFBXnQHVE0jCpW2PHtWBbuhBRqZXRdCTpPY+/w6IbgRUvah11
         GJTA==
X-Forwarded-Encrypted: i=1; AJvYcCUsnowU4iy7GkslmyTczrQl1gvglPZUl7H6aZBZZPgItJmuuoyoaJkDyXn5JYZUfxia164Oitta5ruTCoUG0HuwICvyQngt7VyulhuN
X-Gm-Message-State: AOJu0YzuBcsfmfz9RMK/Gkfe/g5KEojJG7BoQEmivb8EMwB97HXBxtgM
	Nrn3Yz7YcPd6P6uVh6Y4kymRV99Jrduaj+J877wOqQU/UPrDzwDJiUB8PAulundUSH7fCskEl2w
	mDzGQlF0L7k3/JM/UEx82AIKzNNUj5gkyxBG9
X-Google-Smtp-Source: AGHT+IFv3s843zTdq+qbNxC9is7eEc4H3YoyiTuOQqPPNlkjR0dAw7JRCDngLN6hF+f12VRJ5vIXi//3Xla2BVihOkE=
X-Received: by 2002:a05:6e02:1c2f:b0:363:d784:d24 with SMTP id
 m15-20020a056e021c2f00b00363d7840d24mr114895ilh.23.1709279462062; Thu, 29 Feb
 2024 23:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301074639.2260708-1-irogers@google.com>
In-Reply-To: <20240301074639.2260708-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 23:50:48 -0800
Message-ID: <CAP-5=fX7JDkyPEXwJGmhYf75EA5KsFQpZ3tC-70hNe8kUnZ=rw@mail.gmail.com>
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

On Thu, Feb 29, 2024 at 11:47=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> The session has a header in it which contains a perf env with
> bpf_progs. The bpf_progs are accessed by the sideband thread and so
> the sideband thread must be stopped before the session is deleted, to
> avoid a use after free.  This error was detected by AddressSanitizer
> in the following:
>
> ```
> =3D=3D2054673=3D=3DERROR: AddressSanitizer: heap-use-after-free on addres=
s 0x61d000161e00 at pc 0x55769289de54 bp 0x7f9df36d4ab0 sp 0x7f9df36d4aa8
> READ of size 8 at 0x61d000161e00 thread T1
>     #0 0x55769289de53 in __perf_env__insert_bpf_prog_info util/env.c:42
>     #1 0x55769289dbb1 in perf_env__insert_bpf_prog_info util/env.c:29
>     #2 0x557692bbae29 in perf_env__add_bpf_info util/bpf-event.c:483
>     #3 0x557692bbb01a in bpf_event__sb_cb util/bpf-event.c:512
>     #4 0x5576928b75f4 in perf_evlist__poll_thread util/sideband_evlist.c:=
68
>     #5 0x7f9df96a63eb in start_thread nptl/pthread_create.c:444
>     #6 0x7f9df9726a4b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.=
S:81
>
> 0x61d000161e00 is located 384 bytes inside of 2136-byte region [0x61d0001=
61c80,0x61d0001624d8)
> freed by thread T0 here:
>     #0 0x7f9dfa6d7288 in __interceptor_free libsanitizer/asan/asan_malloc=
_linux.cpp:52
>     #1 0x557692978d50 in perf_session__delete util/session.c:319
>     #2 0x557692673959 in __cmd_record tools/perf/builtin-record.c:2884
>     #3 0x55769267a9f0 in cmd_record tools/perf/builtin-record.c:4259
>     #4 0x55769286710c in run_builtin tools/perf/perf.c:349
>     #5 0x557692867678 in handle_internal_command tools/perf/perf.c:402
>     #6 0x557692867a40 in run_argv tools/perf/perf.c:446
>     #7 0x557692867fae in main tools/perf/perf.c:562
>     #8 0x7f9df96456c9 in __libc_start_call_main ../sysdeps/nptl/libc_star=
t_call_main.h:58
> ```
>
> Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
> Signed-off-by: Ian Rogers <irogers@google.com>

Note, after this series I'm seeing parallel perf testing being as
reliable as serial but parallel testing is nearly 3 times faster. I
think after these changes land we can make parallel execution the
default.

Thanks,
Ian

