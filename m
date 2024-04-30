Return-Path: <linux-kernel+bounces-164549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BC8B7F30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0862C1C232E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3720F180A93;
	Tue, 30 Apr 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zEpKEwI2"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7217BB16
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499211; cv=none; b=PHlx74Gxy2sTYW3tAvov/XvySD6KwVYW10dcyiAjyPP8Jb2ifTKigntln3M8YF5Wo/v9OO8GiidzRNlBAiiYkdb9B0qybAiH1ttLw9EYVpO5I9zCBNry6VyMGlNenqmcIipkRxixN9w42eZOY/r1Rw0gNK9bXiW2MhCyvBqHMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499211; c=relaxed/simple;
	bh=W6ac2L3mZw4udeI+hS8Q578eVio2S4J4DCWerOSFsdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JguiRH9eAI5yGJ0qbMDYBoa39uQgakT78f0Iwy7vZoJb3CkhwD5pStyCm6BvIDj1p8kcLb9v1DSsayCdKyg6KiGAcIxTcecMR5UMypt25UkGhYAjfEZ9GnHnpy3bn30DjtIkeqpKNgOi/DNQsMGhFBGda3qYikS4fn2FLXnRc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zEpKEwI2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec182ab287so14435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714499208; x=1715104008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpKTfqnj3CRiS2xW53PmZnJhP8tb/+iKK2ylukjJ2nA=;
        b=zEpKEwI2smD7gPPOnK+tKrCCnl/4RghSoWR3OFCfWC3IbvARhRSHh571bYPoXH80zQ
         ocwcaAm+yAUtTjPbt+yCyGGkwV1T4Hc6AO07gJLw++RF4cMOzTMVGlm7M8Q8AvPZFQKo
         2zCx01PHb4use5jQj1yPmM0BSL6uwdsSYYR9ToK9TWUfgXnr3O8NsdtclMjlzhLBjxGi
         7Rdguk4ztbux3VHot+2t2jQj7uAROHuug6SoY0g609wa5c+4cmKv631vjl464n30A4KL
         LOkLemGjL+5iFeE9IC1xAzZORZjyIzISSMz6DhgzLqC3xdX+743W6Q0U/E0r6Lbmxxkr
         jZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499208; x=1715104008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpKTfqnj3CRiS2xW53PmZnJhP8tb/+iKK2ylukjJ2nA=;
        b=s1VWHGowwtDn3v4+PWD0XUDMOogPCbTh8A7EwOYHbCDtNiqIpp6mjiqZF7rPRnfNWR
         I+Qp1zQrWTwTIAJyB3MtW2iRsKxzcGGrVbFFyxb8k8I21n9AvLjoaSXhYspERNRb9sin
         ku9/Ag7zBMAUH0vGw2d9FCnflSpNHHaPNqRHlIHHFPKFWDYM/dLkPITs3uK7Pu2KmRMh
         SsXQkdH1VLY6ALMk47I48nbDD+UH4lfBHIULc3EzmrqEjuujTQZGxVmI+6Gu3/iIeEa9
         q5KsC8tK0O1l70D/2fL2FMj9konCYLFt5RGIP70SlpM9vTwaUNioK8Pku8xlIr3SI3qg
         PNgw==
X-Forwarded-Encrypted: i=1; AJvYcCUlfwoEWuNq82CdH8xfRnSgoZZTHmnIuPw2l0M6N/j03YBH20kZkwD7174tUoFDoeIaKsDJj6Q3saUa9lu6WNoib1HvEpjU65oIVeVr
X-Gm-Message-State: AOJu0YyC2vfR5oLFhrie5spV8oH5G1thtMjFFX92jttcZCrVrXiFKbgs
	WuXjVmAPnIpchoBH6W7j76eDiDBX+3ORhMBD7O3/aMwM6To7SbAYwg2BPj0b8vvn/h88ByXyibN
	5npU8Yc2CfU5zziqWrfY1x5E3V8HU8SnfrIk7
X-Google-Smtp-Source: AGHT+IFbyctZTE3ocM/KnKMqXJyAPzaowBmvVYTZB+Fm5ndNLyaw/qpXsJEGqTfrvOfbceanRdPBjgs69jnBlceSW7k=
X-Received: by 2002:a17:902:f642:b0:1eb:7899:ada9 with SMTP id
 m2-20020a170902f64200b001eb7899ada9mr4738plg.26.1714499207555; Tue, 30 Apr
 2024 10:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314063000.2139877-1-yangjihong@bytedance.com> <CAP-5=fV--O=QB8To+cbR=C06JzPqBFLFYTc1oh9gJZwBQ3BE=w@mail.gmail.com>
In-Reply-To: <CAP-5=fV--O=QB8To+cbR=C06JzPqBFLFYTc1oh9gJZwBQ3BE=w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Apr 2024 10:46:32 -0700
Message-ID: <CAP-5=fXJAu8OO_Gaw45Hx3uq6N8VQBNFhqcUy3Zm2vKT-TDSOQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Add LIBTRACEEVENT_DIR build option
To: Yang Jihong <yangjihong@bytedance.com>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 12:07=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Mar 13, 2024 at 11:30=E2=80=AFPM Yang Jihong <yangjihong@bytedanc=
e.com> wrote:
> >
> > Currently, when libtraceevent is not linked,
> > perf does not support tracepoint:
> >
> >   # ./perf record -e sched:sched_switch -a sleep 10
> >   event syntax error: 'sched:sched_switch'
> >                        \___ unsupported tracepoint
> >
> >   libtraceevent is necessary for tracepoint support
> >   Run 'perf list' for a list of valid events
> >
> >    Usage: perf record [<options>] [<command>]
> >       or: perf record [<options>] -- <command> [<options>]
> >
> >       -e, --event <event>   event selector. use 'perf list' to list ava=
ilable events
> >
> > For cross-compilation scenario, library may not be installed in the def=
ault
> > system path. Based on the above requirements, add LIBTRACEEVENT_DIR bui=
ld
> > option to support specifying path of libtraceevent.
> >
> > Example:
> >
> >   1. Cross compile libtraceevent
> >   # cd /opt/libtraceevent
> >   # CROSS_COMPILE=3Daarch64-linux-gnu- make
> >
> >   2. Cross compile perf
> >   # cd tool/perf
> >   # make VF=3D1 ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- NO_LIBE=
LF=3D1 LDFLAGS=3D--static LIBTRACEEVENT_DIR=3D/opt/libtraceevent
> >   <SNIP>
> >   Auto-detecting system features:
> >   <SNIP>
> >   ...                       LIBTRACEEVENT_DIR: /opt/libtraceevent
> >
> > Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>
> This all looks good to me, thanks!
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> > ---
> >  tools/perf/Makefile.config | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 1fe8df97fe88..7783479de691 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -182,6 +182,16 @@ endif
> >  FEATURE_CHECK_CFLAGS-libzstd :=3D $(LIBZSTD_CFLAGS)
> >  FEATURE_CHECK_LDFLAGS-libzstd :=3D $(LIBZSTD_LDFLAGS)
> >
> > +# for linking with debug library, run like:
> > +# make DEBUG=3D1 LIBTRACEEVENT_DIR=3D/opt/libtraceevent/
> > +TRACEEVENTLIBS :=3D -ltraceevent
> > +ifdef LIBTRACEEVENT_DIR
> > +  LIBTRACEEVENT_CFLAGS  :=3D -I$(LIBTRACEEVENT_DIR)/include
> > +  LIBTRACEEVENT_LDFLAGS :=3D -L$(LIBTRACEEVENT_DIR)/lib
> > +endif

I'm finding to test a libtraceevent asan build on a system that has
libtraceevent installed, I need to carry this change:
```
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..b356520d8291 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -187,7 +187,7 @@ FEATURE_CHECK_LDFLAGS-libzstd :=3D $(LIBZSTD_LDFLAGS)
TRACEEVENTLIBS :=3D -ltraceevent
ifdef LIBTRACEEVENT_DIR
  LIBTRACEEVENT_CFLAGS  :=3D -I$(LIBTRACEEVENT_DIR)/include
-  LIBTRACEEVENT_LDFLAGS :=3D -L$(LIBTRACEEVENT_DIR)/lib
+  LIBTRACEEVENT_LDFLAGS :=3D -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib64
endif
FEATURE_CHECK_CFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_CFLAGS)
FEATURE_CHECK_LDFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_LDFLAGS)
$(TRACEEVENTLIBS)
```

I'm not sure how to make this something that'll work well with cross
compilation, etc.

Thanks,
Ian

> > +FEATURE_CHECK_CFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_CFLAGS)
> > +FEATURE_CHECK_LDFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_LDFLAGS) $(TR=
ACEEVENTLIBS)
> > +
> >  FEATURE_CHECK_CFLAGS-bpf =3D -I. -I$(srctree)/tools/include -I$(srctre=
e)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
> >  # include ARCH specific config
> >  -include $(src-perf)/arch/$(SRCARCH)/Makefile
> > @@ -1165,9 +1175,10 @@ endif
> >  ifneq ($(NO_LIBTRACEEVENT),1)
> >    $(call feature_check,libtraceevent)
> >    ifeq ($(feature-libtraceevent), 1)
> > -    CFLAGS +=3D -DHAVE_LIBTRACEEVENT
> > -    EXTLIBS +=3D -ltraceevent
> > -    LIBTRACEEVENT_VERSION :=3D $(shell $(PKG_CONFIG) --modversion libt=
raceevent)
> > +    CFLAGS +=3D -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
> > +    LDFLAGS +=3D $(LIBTRACEEVENT_LDFLAGS)
> > +    EXTLIBS +=3D ${TRACEEVENTLIBS}
> > +    LIBTRACEEVENT_VERSION :=3D $(shell PKG_CONFIG_PATH=3D$(LIBTRACEEVE=
NT_DIR) $(PKG_CONFIG) --modversion libtraceevent)
> >      LIBTRACEEVENT_VERSION_1 :=3D $(word 1, $(subst ., ,$(LIBTRACEEVENT=
_VERSION)))
> >      LIBTRACEEVENT_VERSION_2 :=3D $(word 2, $(subst ., ,$(LIBTRACEEVENT=
_VERSION)))
> >      LIBTRACEEVENT_VERSION_3 :=3D $(word 3, $(subst ., ,$(LIBTRACEEVENT=
_VERSION)))
> > @@ -1175,7 +1186,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
> >      CFLAGS +=3D -DLIBTRACEEVENT_VERSION=3D$(LIBTRACEEVENT_VERSION_CPP)
> >      $(call detected,CONFIG_LIBTRACEEVENT)
> >    else
> > -    $(error ERROR: libtraceevent is missing. Please install libtraceev=
ent-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=3D1)
> > +    $(error ERROR: libtraceevent is missing. Please install libtraceev=
ent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_L=
IBTRACEEVENT=3D1)
> >    endif
> >
> >    $(call feature_check,libtracefs)
> > @@ -1301,6 +1312,7 @@ ifeq ($(VF),1)
> >    $(call print_var,LIBUNWIND_DIR)
> >    $(call print_var,LIBDW_DIR)
> >    $(call print_var,JDIR)
> > +  $(call print_var,LIBTRACEEVENT_DIR)
> >
> >    ifeq ($(dwarf-post-unwind),1)
> >      $(call feature_print_text,"DWARF post unwind library", $(dwarf-pos=
t-unwind-text)) $(info $(MSG))
> > --
> > 2.25.1
> >

