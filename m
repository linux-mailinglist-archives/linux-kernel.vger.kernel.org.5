Return-Path: <linux-kernel+bounces-141469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DDF8A1EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9819B2941E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DFB535AF;
	Thu, 11 Apr 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="r2Ir/7JZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B415337F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859600; cv=none; b=XuQtX6RfXuzmJ23CdOo3H6Vb5/Qvc7UHVQXHRuiJbaeXC5I/ONyVspd5DRjvsEJw5qX07KsxQym/xUkxQ048DDB5zon7NTl6PrVB73dDkan7eLrVbTOjw/tkh6xn7ijJtfkZ/RNpKineMnyWMyA5y0CTYGzCaXjHJ6yQU5EQ6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859600; c=relaxed/simple;
	bh=DlhRJllmhJ/R6mygUDiBFRj5CYdSdksZF5o1G0y3Ymc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+XjSvvOPywzNCZZCUsJbS24rEhQM2MQkRJLyj1Hm30vymTdbRyCjF5Y+JsUTfDJAUAExYasXjuEfpgQQxnSwdevOXsDNflgZgXq1ju8Piidu+D/iexO2sw2VYtSHWJ6D5dbsIRriBSr8hxiF8bHCkbPyfGengp14pzrRQlVs0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2Ir/7JZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e42a6158d5so25025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712859597; x=1713464397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYgZpIssHVpu0u/CXgkG5uKsh4raukztjaG7gWpX5II=;
        b=r2Ir/7JZFFDjBKDmIiIII1QXxljBHASOWISbYN7LGH6MON9z1grbVs0Nhb8whb5Abq
         2Da1OGKq+LQl7RG+ot/zYar2tp6tscLBgFTgDQ9xC8kvYMG05ErkWQ0ni74uDX3R6sQP
         YSgBbmT+wn4PzAR00y1LF7jWPRzwUWYkKMv+0LFkNdOJOo5JeCYijQktlGIqNMvyqphe
         WXpu5UahqB6M3Tivq6ZrBnYvyPli9YEHiddlFxAmOUw7cSo3HsX+qkGsF/nlyfH6JVLc
         e2uqkMJg9iiU9/eQ+L43dFeMz+bx4RIvI6YTQ6URT4MaQxw/01jllYLdyWKI/MyduZXd
         1bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859597; x=1713464397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYgZpIssHVpu0u/CXgkG5uKsh4raukztjaG7gWpX5II=;
        b=axEPnkLmfi3tKQtNJkhI/nZW9lIviu8PxQ074/8/Nxy4WH+pLWLT9SY7KnkcYEB2f2
         ixHO/3H6YJHGhhAAyPv4d2QKy73bhefHNHgbH71iohOlr46iB6Bm20jmhkWqj38SfoZo
         DMwHqiwZ9/r0XLU9A3O6+2QvPyGUlYOwl2Kj3TR46iPFFsCI6IxpWO2CKFB3vBe6fFlF
         V9qeRMMes5RAVmiCuPzTWfMefPBLm1fhTQnFtJ2dYV+uZ+D0j0Et3gOlhe0hT4t4cHDb
         MqCuRP553rrwv8iY8XVh/YRAirOJecQsSSK0xifMSdsfcI2OkluyRUs0K1Hb1ROrmP5E
         ioBg==
X-Forwarded-Encrypted: i=1; AJvYcCVqidT1/AzPZbHRyTcrnC2jWdLbx9LO7STYgzV8oah1Rtba1al1Wf4sE3bMatlf7GIChKiofXEUQBY8EPl4YnTx6EpM7us3dIRqX1Bf
X-Gm-Message-State: AOJu0YxnHcMmheKYIh64bW7L0UGq5RA3VieVVOas7iBwWdGpeYbELIvM
	ds18sgISg5G2YbTMwbpfKsMPVZpS1dLdHrh6NfjHegJHT1tm/zDj3wAyuq4u/WCwxLcB8Jh6+N7
	FEu5O+gpYP3kgkm6wc40qT8ygpdyoXvBBpL2XqwttlhpO2Ze0jDsLd5s=
X-Google-Smtp-Source: AGHT+IGirjQT1ja8kbcn22hPL4Fgf1LsJe13hrX/4rFbffneva9tgWx6VGalx/t6arfsE75Zsh6p+R/HYzDIdUp9MgI=
X-Received: by 2002:a17:902:ec89:b0:1e3:e253:17e5 with SMTP id
 x9-20020a170902ec8900b001e3e25317e5mr5662plg.7.1712859596483; Thu, 11 Apr
 2024 11:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313123634.4353-1-adrian.hunter@intel.com>
In-Reply-To: <20240313123634.4353-1-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Apr 2024 11:19:42 -0700
Message-ID: <CAP-5=fW1bH8qQkD7LrO6_3fJ3NsqoW1GrX8=s-sfaTbrvk58+A@mail.gmail.com>
Subject: Re: [PATCH V2] perf scripts python: Add a script to run instances of
 perf script in parallel
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 5:36=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Add a Python script to run a perf script command multiple times in
> parallel, using perf script options --cpu and --time so that each job
> processes a different chunk of the data.
>
> The script supports the use of normal perf script options like
>  --dlfilter and --script, so that the benefit of running parallel jobs
> naturally extends to them also. In addition, a command can be provided
> (refer --pipe-to option) to pipe standard output to a custom command.
>
> Refer to the script's own help text at the end of the patch for more
> details.
>
> The script is useful for Intel PT traces, that can be efficiently
> decoded by perf script when split by CPU and/or time ranges. Running
> jobs in parallel can decrease the overall decoding time.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
>
> Changes in V2:
>
>         Added option to pipe to a custom command
>         Added option to set a minimum time interval
>         Minor tidying
>
>
>  tools/perf/scripts/python/parallel-perf.py | 989 +++++++++++++++++++++
>  1 file changed, 989 insertions(+)
>  create mode 100755 tools/perf/scripts/python/parallel-perf.py
>
> diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/scri=
pts/python/parallel-perf.py
> new file mode 100755
> index 000000000000..8fe398f81a42
> --- /dev/null
> +++ b/tools/perf/scripts/python/parallel-perf.py
> @@ -0,0 +1,989 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0

With the python summer of code proposal, that no-one applied to, I
wanted to package things like a perf.data IO library in some public
package index. As GPL 2 isn't permissive then we may need to
reimplement this code because of this. Fwiw, my preference is
GPL-2.0-only or BSD.

> +#
> +# Run a perf script command multiple times in parallel, using perf scrip=
t
> +# options --cpu and --time so that each job processes a different chunk
> +# of the data.
> +#
> +# Copyright (c) 2024, Intel Corporation.
> +
> +import subprocess
> +import argparse
> +import pathlib
> +import shlex
> +import time
> +import copy
> +import sys
> +import os
> +import re
> +
> +glb_prog_name =3D "parallel-perf.py"
> +glb_min_interval =3D 10.0
> +glb_min_samples =3D 64
> +
> +class Verbosity():
> +
> +       def __init__(self, a=3DNone):

Just to note that jevents.py is using a 2 character indent, but 4 is
more usual. We should probably lint check python code for the sake of
consistency. A lot of the other python code is also trying to use type
hints, which it'd be good to check perhaps like we do with shellcheck
- there's plenty of debate that could be had with that wrt mypy vs
pylint, etc.. Here what "a" is isn't particularly clear as there are
no type hints and the parameter name isn't intention revealing.

> +               self.normal    =3D True
> +               self.verbose   =3D False
> +               self.debug     =3D False
> +               self.self_test =3D True
> +               if a:
> +                       a.normal =3D True
> +                       if a.debug:
> +                               a.verbose =3D True
> +                       if a.verbose:
> +                               a.quiet =3D False
> +                       if a.quiet:
> +                               a.normal =3D False
> +                       for arg_name in ("normal", "verbose", "debug"):
> +                               setattr(self, arg_name, getattr(a, arg_na=
me))

Without knowing what 'a' is, this code is somewhat cryptic. If 'a' is
another Verbosity object, say for cloning, then why are we mutating it
above?

> +
> +class Work():

A class comment would be useful here.

> +
> +       def __init__(self, cmd, pipe_to, output_dir=3D"."):
> +               self.popen =3D None
> +               self.consumer =3D None
> +               self.cmd =3D cmd
> +               self.pipe_to =3D pipe_to
> +               self.output_dir =3D output_dir
> +               self.cmdout_name =3D output_dir + "/cmd.txt"
> +               self.stdout_name =3D output_dir + "/out.txt"
> +               self.stderr_name =3D output_dir + "/err.txt"

I'm not a python language lawyer but I believe it is considered more
pythonic and more readable these days to use f-strings for all of
these. For example,

self.cmdout_name =3D f"{output_dir}/cmd.txt"

Why use files here and not pipes? Could using files cause the command
to fail on a read-only file system?

> +
> +       def Command(self):
> +               sh_cmd =3D [ shlex.quote(x) for x in self.cmd ]
> +               return " ".join(self.cmd)
> +
> +       def Stdout(self):
> +               return open(self.stdout_name, "w")
> +
> +       def Stderr(self):
> +               return open(self.stderr_name, "w")
> +
> +       def CreateOutputDir(self):
> +               pathlib.Path(self.output_dir).mkdir(parents=3DTrue, exist=
_ok=3DTrue)
> +
> +       def Start(self):
> +               if self.popen:
> +                       return
> +               self.CreateOutputDir()
> +               with open(self.cmdout_name, "w") as f:
> +                       f.write(self.Command())
> +                       f.write("\n")
> +               stdout =3D self.Stdout()
> +               stderr =3D self.Stderr()
> +               if self.pipe_to:
> +                       self.popen =3D subprocess.Popen(self.cmd, stdout=
=3Dsubprocess.PIPE, stderr=3Dstderr)
> +                       args =3D shlex.split(self.pipe_to)
> +                       self.consumer =3D subprocess.Popen(args, stdin=3D=
self.popen.stdout, stdout=3Dstdout, stderr=3Dstderr)
> +               else:
> +                       self.popen =3D subprocess.Popen(self.cmd, stdout=
=3Dstdout, stderr=3Dstderr)
> +
> +       def RemoveEmptyErrFile(self):
> +               if os.path.exists(self.stderr_name):
> +                       if os.path.getsize(self.stderr_name) =3D=3D 0:
> +                               os.unlink(self.stderr_name)
> +
> +       def Errors(self):
> +               if os.path.exists(self.stderr_name):
> +                       if os.path.getsize(self.stderr_name) !=3D 0:
> +                               return [ "Non-empty error file " + self.s=
tderr_name ]

nit: f-string, and below.. I'll not mark them.

> +               return []
> +
> +       def TidyUp(self):
> +               self.RemoveEmptyErrFile()
> +
> +       def RawPollWait(self, p, wait):
> +               if wait:
> +                       return p.wait()
> +               return p.poll()
> +
> +       def Poll(self, wait=3DFalse):
> +               if not self.popen:
> +                       return None
> +               result =3D self.RawPollWait(self.popen, wait)
> +               if self.consumer:
> +                       res =3D result
> +                       result =3D self.RawPollWait(self.consumer, wait)
> +                       if result !=3D None and res =3D=3D None:
> +                               self.popen.kill()
> +                               result =3D None
> +                       elif result =3D=3D 0 and res !=3D None and res !=
=3D 0:
> +                               result =3D res
> +               if result !=3D None:
> +                       self.TidyUp()
> +               return result
> +
> +       def Wait(self):
> +               return self.Poll(wait=3DTrue)
> +
> +       def Kill(self):
> +               if not self.popen:
> +                       return
> +               self.popen.kill()
> +               if self.consumer:
> +                       self.consumer.kill()
> +
> +def KillWork(worklist, verbosity):
> +       for w in worklist:
> +               w.Kill()
> +       for w in worklist:
> +               w.Wait()
> +
> +def NumberOfCPUs():
> +       return os.sysconf("SC_NPROCESSORS_ONLN")
> +
> +def NanoSecsToSecsStr(x):
> +       if x =3D=3D None:
> +               return ""
> +       x =3D str(x)
> +       if len(x) < 10:
> +               x =3D "0" * (10 - len(x)) + x
> +       return x[:len(x) - 9] + "." + x[-9:]
> +
> +def InsertOptionAfter(cmd, option, after):
> +       try:
> +               pos =3D cmd.index(after)
> +               cmd.insert(pos + 1, option)
> +       except:
> +               cmd.append(option)
> +
> +def CreateWorkList(cmd, pipe_to, output_dir, cpus, time_ranges_by_cpu):
> +       max_len =3D len(str(cpus[-1]))
> +       cpu_dir_fmt =3D "cpu-%." + str(max_len) + "u"
> +       worklist =3D []
> +       pos =3D 0
> +       for cpu in cpus:
> +               if cpu >=3D 0:
> +                       cpu_dir =3D os.path.join(output_dir, cpu_dir_fmt =
% cpu)
> +                       cpu_option =3D "--cpu=3D" + str(cpu)
> +               else:
> +                       cpu_dir =3D output_dir
> +                       cpu_option =3D None
> +
> +               tr_dir_fmt =3D "time-range"
> +
> +               if len(time_ranges_by_cpu) > 1:
> +                       time_ranges =3D time_ranges_by_cpu[pos]
> +                       tr_dir_fmt +=3D "-" + str(pos)
> +                       pos +=3D 1
> +               else:
> +                       time_ranges =3D time_ranges_by_cpu[0]
> +
> +               max_len =3D len(str(len(time_ranges)))
> +               tr_dir_fmt +=3D "-%." + str(max_len) + "u"
> +
> +               i =3D 0
> +               for r in time_ranges:
> +                       if r =3D=3D [None, None]:
> +                               time_option =3D None
> +                               work_output_dir =3D cpu_dir
> +                       else:
> +                               time_option =3D "--time=3D" + NanoSecsToS=
ecsStr(r[0]) + "," + NanoSecsToSecsStr(r[1])
> +                               work_output_dir =3D os.path.join(cpu_dir,=
 tr_dir_fmt % i)
> +                               i +=3D 1
> +                       work_cmd =3D list(cmd)
> +                       if time_option !=3D None:
> +                               InsertOptionAfter(work_cmd, time_option, =
"script")
> +                       if cpu_option !=3D None:
> +                               InsertOptionAfter(work_cmd, cpu_option, "=
script")
> +                       w =3D Work(work_cmd, pipe_to, work_output_dir)
> +                       worklist.append(w)
> +       return worklist
> +
> +def DoRunWork(worklist, nr_jobs, verbosity):
> +       nr_to_do =3D len(worklist)
> +       not_started =3D list(worklist)
> +       running =3D []
> +       done =3D []
> +       chg =3D False
> +       while True:
> +               nr_done =3D len(done)
> +               if chg and verbosity.normal:
> +                       nr_run =3D len(running)
> +                       print(f"\rThere are {nr_to_do} jobs: {nr_done} co=
mpleted, {nr_run} running", flush=3DTrue, end=3D" ")

Ok, f-strings may just be a consistency issue :-)

> +                       if verbosity.verbose:
> +                               print()
> +                       chg =3D False
> +               if nr_done =3D=3D nr_to_do:
> +                       break
> +               while len(running) < nr_jobs and len(not_started):
> +                       w =3D not_started.pop(0)
> +                       running.append(w)
> +                       if verbosity.verbose:
> +                               print("Starting:", w.Command())
> +                       w.Start()
> +                       chg =3D True
> +               if len(running):
> +                       time.sleep(0.1)
> +               finished =3D []
> +               not_finished =3D []
> +               while len(running):
> +                       w =3D running.pop(0)
> +                       r =3D w.Poll()
> +                       if r =3D=3D None:
> +                               not_finished.append(w)
> +                               continue
> +                       if r =3D=3D 0:
> +                               if verbosity.verbose:
> +                                       print("Finished:", w.Command())
> +                               finished.append(w)
> +                               chg =3D True
> +                               continue
> +                       if verbosity.normal and not verbosity.verbose:
> +                               print()
> +                       print("Job failed!\n    return code:", r, "\n    =
command:    ", w.Command())
> +                       if w.pipe_to:
> +                               print("    piped to:   ", w.pipe_to)
> +                       print("Killing outstanding jobs")
> +                       KillWork(not_finished, verbosity)
> +                       KillWork(running, verbosity)
> +                       return False
> +               running =3D not_finished
> +               done +=3D finished
> +       errorlist =3D []
> +       for w in worklist:
> +               errorlist +=3D w.Errors()
> +       if len(errorlist):
> +               print("Errors:")
> +               for e in errorlist:
> +                       print(e)
> +       elif verbosity.normal:
> +               print("\r"," "*50, "\rAll jobs finished successfully", fl=
ush=3DTrue)
> +       return True
> +
> +def RunWork(worklist, nr_jobs=3DNumberOfCPUs(), verbosity=3DVerbosity())=
:
> +       try:
> +               return DoRunWork(worklist, nr_jobs, verbosity)
> +       except:
> +               for w in worklist:
> +                       w.Kill()
> +               raise
> +       return True
> +
> +def ReadHeader(perf, file_name):
> +       return subprocess.Popen([perf, "script", "--header-only", "--inpu=
t", file_name], stdout=3Dsubprocess.PIPE).stdout.read().decode("utf-8")
> +
> +def ParseHeader(hdr):
> +       result =3D {}
> +       lines =3D hdr.split("\n")
> +       for line in lines:
> +               if ":" in line and line[0] =3D=3D "#":
> +                       pos =3D line.index(":")
> +                       name =3D line[1:pos-1].strip()
> +                       value =3D line[pos+1:].strip()
> +                       if name in result:
> +                               orig_name =3D name
> +                               nr =3D 2
> +                               while True:
> +                                       name =3D orig_name + " " + str(nr=
)
> +                                       if name not in result:
> +                                               break
> +                                       nr +=3D 1
> +                       result[name] =3D value
> +       return result
> +
> +def HeaderField(hdr_dict, hdr_fld):
> +       if hdr_fld not in hdr_dict:
> +               raise Exception("'" + hdr_fld + "' missing from header in=
formation")
> +       return hdr_dict[hdr_fld]
> +
> +class OptPos():

A class comment would be useful here.

> +
> +       def Init(self, opt_element=3D-1, value_element=3D-1, opt_pos=3D-1=
, value_pos=3D-1, error=3DNone):
> +               self.opt_element =3D opt_element          # list element =
that contains option
> +               self.value_element =3D value_element      # list element =
that contains option value
> +               self.opt_pos =3D opt_pos                  # string positi=
on of option
> +               self.value_pos =3D value_pos              # string positi=
on of value
> +               self.error =3D error                      # error message=
 string
> +
> +       def __init__(self, args, short_name, long_name, default=3DNone):
> +               self.args =3D list(args)
> +               self.default =3D default
> +               n =3D 2 + len(long_name)
> +               m =3D len(short_name)
> +               pos =3D -1
> +               for opt in args:
> +                       pos +=3D 1
> +                       if m and opt[:2] =3D=3D "-" + short_name:
> +                               if len(opt) =3D=3D 2:
> +                                       if pos + 1 < len(args):
> +                                               self.Init(pos, pos + 1, 0=
, 0)
> +                                       else:
> +                                               self.Init(error =3D "-" +=
 short_name + " option missing value")
> +                               else:
> +                                       self.Init(pos, pos, 0, 2)
> +                               return
> +                       if opt[:n] =3D=3D "--" + long_name:
> +                               if len(opt) =3D=3D n:
> +                                       if pos + 1 < len(args):
> +                                               self.Init(pos, pos + 1, 0=
, 0)
> +                                       else:
> +                                               self.Init(error =3D "--" =
+ long_name + " option missing value")
> +                               elif opt[n] =3D=3D "=3D":
> +                                       self.Init(pos, pos, 0, n + 1)
> +                               else:
> +                                       self.Init(error =3D "--" + long_n=
ame + " option expected '=3D'")
> +                               return
> +                       if m and opt[:1] =3D=3D "-" and opt[:2] !=3D "--"=
 and short_name in opt:
> +                               ipos =3D opt.index(short_name)
> +                               if "-" in opt[1:]:
> +                                       hpos =3D opt[1:].index("-")
> +                                       if hpos < ipos:
> +                                               continue
> +                               if ipos + 1 =3D=3D len(opt):
> +                                       if pos + 1 < len(args):
> +                                               self.Init(pos, pos + 1, i=
pos, 0)
> +                                       else:
> +                                               self.Init(error =3D "-" +=
 short_name + " option missing value")
> +                               else:
> +                                       self.Init(pos, pos, ipos, ipos + =
1)
> +                               return
> +               self.Init()
> +
> +       def Value(self):
> +               if self.opt_element >=3D 0:
> +                       if self.opt_element !=3D self.value_element:
> +                               return self.args[self.value_element]
> +                       else:
> +                               return self.args[self.value_element][self=
value_pos:]
> +               return self.default
> +
> +       def Remove(self, args):
> +               if self.opt_element =3D=3D -1:
> +                       return
> +               if self.opt_element !=3D self.value_element:
> +                       del args[self.value_element]
> +               if self.opt_pos:
> +                       args[self.opt_element] =3D args[self.opt_element]=
[:self.opt_pos]
> +               else:
> +                       del args[self.opt_element]
> +
> +def DetermineInputFileName(cmd):
> +       p =3D OptPos(cmd, "i", "input", "perf.data")
> +       if p.error:
> +               raise Exception("perf command " + p.error)
> +       file_name =3D p.Value()
> +       if not os.path.exists(file_name):
> +               raise Exception("perf command input file '" + file_name +=
 "' not found")
> +       return file_name
> +
> +def ReadOption(args, short_name, long_name, err_prefix, remove=3DFalse):
> +       p =3D OptPos(args, short_name, long_name)
> +       if p.error:
> +               raise Exception(err_prefix + p.error)
> +       value =3D p.Value()
> +       if remove:
> +               p.Remove(args)
> +       return value
> +
> +def ExtractOption(args, short_name, long_name, err_prefix):
> +       return ReadOption(args, short_name, long_name, err_prefix, True)
> +
> +def ReadPerfOption(args, short_name, long_name):
> +       return ReadOption(args, short_name, long_name, "perf command ")
> +
> +def ExtractPerfOption(args, short_name, long_name):
> +       return ExtractOption(args, short_name, long_name, "perf command "=
)
> +
> +def PerfDoubleQuickCommands(cmd, file_name):
> +       cpu_str =3D ReadPerfOption(cmd, "C", "cpu")
> +       time_str =3D ReadPerfOption(cmd, "", "time")
> +       # Use double-quick sampling to determine trace data density
> +       times_cmd =3D ["perf", "script", "--ns", "--input", file_name, "-=
-itrace=3Dqqi"]
> +       if cpu_str !=3D None and cpu_str !=3D "":
> +               times_cmd.append("--cpu=3D" + cpu_str)
> +       if time_str !=3D None and time_str !=3D "":
> +               times_cmd.append("--time=3D" + time_str)
> +       cnts_cmd =3D list(times_cmd)
> +       cnts_cmd.append("-Fcpu")
> +       times_cmd.append("-Fcpu,time")
> +       return cnts_cmd, times_cmd
> +
> +class CPUTimeRange():
> +       def __init__(self, cpu):
> +               self.cpu =3D cpu
> +               self.sample_cnt =3D 0
> +               self.time_ranges =3D None
> +               self.interval =3D 0
> +               self.interval_remaining =3D 0
> +               self.remaining =3D 0
> +               self.tr_pos =3D 0
> +
> +def CalcTimeRangesByCPU(line, cpu, cpu_time_ranges, max_time):
> +       cpu_time_range =3D cpu_time_ranges[cpu]
> +       cpu_time_range.remaining -=3D 1
> +       cpu_time_range.interval_remaining -=3D 1
> +       if cpu_time_range.remaining =3D=3D 0:
> +               cpu_time_range.time_ranges[cpu_time_range.tr_pos][1] =3D =
max_time
> +               return
> +       if cpu_time_range.interval_remaining =3D=3D 0:
> +               time =3D TimeVal(line[1][:-1], 0)
> +               time_ranges =3D cpu_time_range.time_ranges
> +               time_ranges[cpu_time_range.tr_pos][1] =3D time - 1
> +               time_ranges.append([time, max_time])
> +               cpu_time_range.tr_pos +=3D 1
> +               cpu_time_range.interval_remaining =3D cpu_time_range.inte=
rval
> +
> +def CountSamplesByCPU(line, cpu, cpu_time_ranges):
> +       try:
> +               cpu_time_ranges[cpu].sample_cnt +=3D 1
> +       except:
> +               print("exception")
> +               print("cpu", cpu)
> +               print("len(cpu_time_ranges)", len(cpu_time_ranges))
> +               raise
> +
> +def ProcessCommandOutputLines(cmd, per_cpu, fn, *x):
> +       # Assume CPU number is at beginning of line and enclosed by []
> +       pat =3D re.compile(r"\s*\[[0-9]+\]")
> +       p =3D subprocess.Popen(cmd, stdout=3Dsubprocess.PIPE)
> +       while True:
> +               if line :=3D p.stdout.readline():
> +                       line =3D line.decode("utf-8")
> +                       if pat.match(line):
> +                               line =3D line.split()
> +                               if per_cpu:
> +                                       # Assumes CPU number is enclosed =
by []
> +                                       cpu =3D int(line[0][1:-1])
> +                               else:
> +                                       cpu =3D 0
> +                               fn(line, cpu, *x)
> +               else:
> +                       break
> +       p.wait()
> +
> +def IntersectTimeRanges(new_time_ranges, time_ranges):
> +       pos =3D 0
> +       new_pos =3D 0
> +       # Can assume len(time_ranges) !=3D 0 and len(new_time_ranges) !=
=3D 0
> +       # Note also, there *must* be at least one intersection.
> +       while pos < len(time_ranges) and new_pos < len(new_time_ranges):
> +               # new end < old start =3D> no intersection, remove new
> +               if new_time_ranges[new_pos][1] < time_ranges[pos][0]:
> +                       del new_time_ranges[new_pos]
> +                       continue
> +               # new start > old end =3D> no intersection, check next
> +               if new_time_ranges[new_pos][0] > time_ranges[pos][1]:
> +                       pos +=3D 1
> +                       if pos < len(time_ranges):
> +                               continue
> +                       # no next, so remove remaining
> +                       while new_pos < len(new_time_ranges):
> +                               del new_time_ranges[new_pos]
> +                       return
> +               # Found an intersection
> +               # new start < old start =3D> adjust new start =3D old sta=
rt
> +               if new_time_ranges[new_pos][0] < time_ranges[pos][0]:
> +                       new_time_ranges[new_pos][0] =3D time_ranges[pos][=
0]
> +               # new end > old end =3D> keep the overlap, insert the rem=
ainder
> +               if new_time_ranges[new_pos][1] > time_ranges[pos][1]:
> +                       r =3D [ time_ranges[pos][1] + 1, new_time_ranges[=
new_pos][1] ]
> +                       new_time_ranges[new_pos][1] =3D time_ranges[pos][=
1]
> +                       new_pos +=3D 1
> +                       new_time_ranges.insert(new_pos, r)
> +                       continue
> +               # new [start, end] is within old [start, end]
> +               new_pos +=3D 1
> +
> +def SplitTimeRangesByTraceDataDensity(time_ranges, cpus, nr, cmd, file_n=
ame, per_cpu, min_size, min_interval, verbosity):
> +       if verbosity.normal:
> +               print("\rAnalyzing...", flush=3DTrue, end=3D" ")
> +               if verbosity.verbose:
> +                       print()
> +       cnts_cmd, times_cmd =3D PerfDoubleQuickCommands(cmd, file_name)
> +
> +       nr_cpus =3D cpus[-1] + 1 if per_cpu else 1
> +       if per_cpu:
> +               nr_cpus =3D cpus[-1] + 1
> +               cpu_time_ranges =3D [ CPUTimeRange(cpu) for cpu in range(=
nr_cpus) ]
> +       else:
> +               nr_cpus =3D 1
> +               cpu_time_ranges =3D [ CPUTimeRange(-1) ]
> +
> +       if verbosity.debug:
> +               print("nr_cpus", nr_cpus)
> +               print("cnts_cmd", cnts_cmd)
> +               print("times_cmd", times_cmd)
> +
> +       # Count the number of "double quick" samples per CPU
> +       ProcessCommandOutputLines(cnts_cmd, per_cpu, CountSamplesByCPU, c=
pu_time_ranges)
> +
> +       tot =3D 0
> +       mx =3D 0
> +       for cpu_time_range in cpu_time_ranges:
> +               cnt =3D cpu_time_range.sample_cnt
> +               tot +=3D cnt
> +               if cnt > mx:
> +                       mx =3D cnt
> +               if verbosity.debug:
> +                       print("cpu:", cpu_time_range.cpu, "sample_cnt", c=
nt)
> +
> +       if min_size < 1:
> +               min_size =3D 1
> +
> +       if mx < min_size:
> +               # Too little data to be worth splitting
> +               if verbosity.debug:
> +                       print("Too little data to split by time")
> +               if nr =3D=3D 0:
> +                       nr =3D 1
> +               return [ SplitTimeRangesIntoN(time_ranges, nr, min_interv=
al) ]
> +
> +       if nr:
> +               divisor =3D nr
> +               min_size =3D 1
> +       else:
> +               divisor =3D NumberOfCPUs()
> +
> +       interval =3D int(round(tot / divisor, 0))
> +       if interval < min_size:
> +               interval =3D min_size
> +
> +       if verbosity.debug:
> +               print("divisor", divisor)
> +               print("min_size", min_size)
> +               print("interval", interval)
> +
> +       min_time =3D time_ranges[0][0]
> +       max_time =3D time_ranges[-1][1]
> +
> +       for cpu_time_range in cpu_time_ranges:
> +               cnt =3D cpu_time_range.sample_cnt
> +               if cnt =3D=3D 0:
> +                       cpu_time_range.time_ranges =3D copy.deepcopy(time=
_ranges)
> +                       continue
> +               # Adjust target interval for CPU to give approximately eq=
ual interval sizes
> +               # Determine number of intervals, rounding to nearest inte=
ger
> +               n =3D int(round(cnt / interval, 0))
> +               if n < 1:
> +                       n =3D 1
> +               # Determine interval size, rounding up
> +               d, m =3D divmod(cnt, n)
> +               if m:
> +                       d +=3D 1
> +               cpu_time_range.interval =3D d
> +               cpu_time_range.interval_remaining =3D d
> +               cpu_time_range.remaining =3D cnt
> +               # Init. time ranges for each CPU with the start time
> +               cpu_time_range.time_ranges =3D [ [min_time, max_time] ]
> +
> +       # Set time ranges so that the same number of "double quick" sampl=
es
> +       # will fall into each time range.
> +       ProcessCommandOutputLines(times_cmd, per_cpu, CalcTimeRangesByCPU=
, cpu_time_ranges, max_time)
> +
> +       for cpu_time_range in cpu_time_ranges:
> +               if cpu_time_range.sample_cnt:
> +                       IntersectTimeRanges(cpu_time_range.time_ranges, t=
ime_ranges)
> +
> +       return [cpu_time_ranges[cpu].time_ranges for cpu in cpus]
> +
> +def SplitSingleTimeRangeIntoN(time_range, n):
> +       if n <=3D 1:
> +               return [time_range]
> +       start =3D time_range[0]
> +       end   =3D time_range[1]
> +       duration =3D int((end - start + 1) / n)
> +       if duration < 1:
> +               return [time_range]
> +       time_ranges =3D []
> +       for i in range(n):
> +               time_ranges.append([start, start + duration - 1])
> +               start +=3D duration
> +       time_ranges[-1][1] =3D end
> +       return time_ranges
> +
> +def TimeRangeDuration(r):
> +       return r[1] - r[0] + 1
> +
> +def TotalDuration(time_ranges):
> +       duration =3D 0
> +       for r in time_ranges:
> +               duration +=3D TimeRangeDuration(r)
> +       return duration
> +
> +def SplitTimeRangesByInterval(time_ranges, interval):
> +       new_ranges =3D []
> +       for r in time_ranges:
> +               duration =3D TimeRangeDuration(r)
> +               n =3D duration / interval
> +               n =3D int(round(n, 0))
> +               new_ranges +=3D SplitSingleTimeRangeIntoN(r, n)
> +       return new_ranges
> +
> +def SplitTimeRangesIntoN(time_ranges, n, min_interval):
> +       if n <=3D len(time_ranges):
> +               return time_ranges
> +       duration =3D TotalDuration(time_ranges)
> +       interval =3D duration / n
> +       if interval < min_interval:
> +               interval =3D min_interval
> +       return SplitTimeRangesByInterval(time_ranges, interval)
> +
> +def RecombineTimeRanges(tr):
> +       new_tr =3D copy.deepcopy(tr)
> +       n =3D len(new_tr)
> +       i =3D 1
> +       while i < len(new_tr):
> +               # if prev end + 1 =3D=3D cur start, combine them
> +               if new_tr[i - 1][1] + 1 =3D=3D new_tr[i][0]:
> +                       new_tr[i][0] =3D new_tr[i - 1][0]
> +                       del new_tr[i - 1]
> +               else:
> +                       i +=3D 1
> +       return new_tr
> +
> +def OpenTimeRangeEnds(time_ranges, min_time, max_time):
> +       if time_ranges[0][0] <=3D min_time:
> +               time_ranges[0][0] =3D None
> +       if time_ranges[-1][1] >=3D max_time:
> +               time_ranges[-1][1] =3D None
> +
> +def BadTimeStr(time_str):
> +       raise Exception("perf command bad time option: '" + time_str + "'=
\nCheck also 'time of first sample' and 'time of last sample' in perf scrip=
t --header-only")
> +
> +def ValidateTimeRanges(time_ranges, time_str):
> +       n =3D len(time_ranges)
> +       for i in range(n):
> +               start =3D time_ranges[i][0]
> +               end   =3D time_ranges[i][1]
> +               if i !=3D 0 and start <=3D time_ranges[i - 1][1]:
> +                       BadTimeStr(time_str)
> +               if start > end:
> +                       BadTimeStr(time_str)
> +
> +def TimeVal(s, dflt):
> +       s =3D s.strip()
> +       if s =3D=3D "":
> +               return dflt
> +       a =3D s.split(".")
> +       if len(a) > 2:
> +               raise Exception("Bad time value'" + s + "'")
> +       x =3D int(a[0])
> +       if x < 0:
> +               raise Exception("Negative time not allowed")
> +       x *=3D 1000000000
> +       if len(a) > 1:
> +               x +=3D int((a[1] + "000000000")[:9])
> +       return x
> +
> +def BadCPUStr(cpu_str):
> +       raise Exception("perf command bad cpu option: '" + cpu_str + "'\n=
Check also 'nrcpus avail' in perf script --header-only")
> +
> +def ParseTimeStr(time_str, min_time, max_time):
> +       if time_str =3D=3D None or time_str =3D=3D "":
> +               return [[min_time, max_time]]
> +       time_ranges =3D []
> +       for r in time_str.split():
> +               a =3D r.split(",")
> +               if len(a) !=3D 2:
> +                       BadTimeStr(time_str)
> +               try:
> +                       start =3D TimeVal(a[0], min_time)
> +                       end   =3D TimeVal(a[1], max_time)
> +               except:
> +                       BadTimeStr(time_str)
> +               time_ranges.append([start, end])
> +       ValidateTimeRanges(time_ranges, time_str)
> +       return time_ranges
> +
> +def ParseCPUStr(cpu_str, nr_cpus):
> +       if cpu_str =3D=3D None or cpu_str =3D=3D "":
> +               return [-1]
> +       cpus =3D []
> +       for r in cpu_str.split(","):
> +               a =3D r.split("-")
> +               if len(a) < 1 or len(a) > 2:
> +                       BadCPUStr(cpu_str)
> +               try:
> +                       start =3D int(a[0].strip())
> +                       if len(a) > 1:
> +                               end =3D int(a[1].strip())
> +                       else:
> +                               end =3D start
> +               except:
> +                       BadCPUStr(cpu_str)
> +               if start < 0 or end < 0 or end < start or end >=3D nr_cpu=
s:
> +                       BadCPUStr(cpu_str)
> +               cpus.extend(range(start, end + 1))
> +       cpus =3D list(set(cpus)) # Remove duplicates
> +       cpus.sort()
> +       return cpus
> +
> +class ParallelPerf():
> +
> +       def __init__(self, a):
> +               for arg_name in vars(a):
> +                       setattr(self, arg_name, getattr(a, arg_name))
> +               self.orig_nr =3D self.nr
> +               self.orig_cmd =3D list(self.cmd)
> +               self.perf =3D self.cmd[0]
> +               if os.path.exists(self.output_dir):
> +                       raise Exception("Output '" + self.output_dir + "'=
 already exists")
> +               if self.jobs < 0 or self.nr < 0 or self.interval < 0:
> +                       raise Exception("Bad options (negative values): t=
ry -h option for help")
> +               if self.nr !=3D 0 and self.interval !=3D 0:
> +                       raise Exception("Cannot specify number of time su=
bdivisions and time interval")
> +               if self.jobs =3D=3D 0:
> +                       self.jobs =3D NumberOfCPUs()
> +               if self.nr =3D=3D 0 and self.interval =3D=3D 0:
> +                       if self.per_cpu:
> +                               self.nr =3D 1
> +                       else:
> +                               self.nr =3D self.jobs
> +
> +       def Init(self):
> +               if self.verbosity.debug:
> +                       print("cmd", self.cmd)
> +               self.file_name =3D DetermineInputFileName(self.cmd)
> +               self.hdr =3D ReadHeader(self.perf, self.file_name)
> +               self.hdr_dict =3D ParseHeader(self.hdr)
> +               self.cmd_line =3D HeaderField(self.hdr_dict, "cmdline")
> +
> +       def ExtractTimeInfo(self):
> +               self.min_time =3D TimeVal(HeaderField(self.hdr_dict, "tim=
e of first sample"), 0)
> +               self.max_time =3D TimeVal(HeaderField(self.hdr_dict, "tim=
e of last sample"), 0)
> +               self.time_str =3D ExtractPerfOption(self.cmd, "", "time")
> +               self.time_ranges =3D ParseTimeStr(self.time_str, self.min=
_time, self.max_time)
> +               if self.verbosity.debug:
> +                       print("time_ranges", self.time_ranges)
> +
> +       def ExtractCPUInfo(self):
> +               if self.per_cpu:
> +                       nr_cpus =3D int(HeaderField(self.hdr_dict, "nrcpu=
s avail"))
> +                       self.cpu_str =3D ExtractPerfOption(self.cmd, "C",=
 "cpu")
> +                       if self.cpu_str =3D=3D None or self.cpu_str =3D=
=3D "":
> +                               self.cpus =3D [ x for x in range(nr_cpus)=
 ]
> +                       else:
> +                               self.cpus =3D ParseCPUStr(self.cpu_str, n=
r_cpus)
> +               else:
> +                       self.cpu_str =3D None
> +                       self.cpus =3D [-1]
> +               if self.verbosity.debug:
> +                       print("cpus", self.cpus)
> +
> +       def IsIntelPT(self):
> +               return self.cmd_line.find("intel_pt") >=3D 0
> +
> +       def SplitTimeRanges(self):
> +               if self.IsIntelPT() and self.interval =3D=3D 0:
> +                       self.split_time_ranges_for_each_cpu =3D \
> +                               SplitTimeRangesByTraceDataDensity(self.ti=
me_ranges, self.cpus, self.orig_nr,
> +                                                                 self.or=
ig_cmd, self.file_name, self.per_cpu,
> +                                                                 self.mi=
n_size, self.min_interval, self.verbosity)
> +               elif self.nr:
> +                       self.split_time_ranges_for_each_cpu =3D [ SplitTi=
meRangesIntoN(self.time_ranges, self.nr, self.min_interval) ]
> +               else:
> +                       self.split_time_ranges_for_each_cpu =3D [ SplitTi=
meRangesByInterval(self.time_ranges, self.interval) ]
> +
> +       def CheckTimeRanges(self):
> +               for tr in self.split_time_ranges_for_each_cpu:
> +                       # Re-combined time ranges should be the same
> +                       new_tr =3D RecombineTimeRanges(tr)
> +                       if new_tr !=3D self.time_ranges:
> +                               if self.verbosity.debug:
> +                                       print("tr", tr)
> +                                       print("new_tr", new_tr)
> +                               raise Exception("Self test failed!")
> +
> +       def OpenTimeRangeEnds(self):
> +               for time_ranges in self.split_time_ranges_for_each_cpu:
> +                       OpenTimeRangeEnds(time_ranges, self.min_time, sel=
f.max_time)
> +
> +       def CreateWorkList(self):
> +               self.worklist =3D CreateWorkList(self.cmd, self.pipe_to, =
self.output_dir, self.cpus, self.split_time_ranges_for_each_cpu)
> +
> +       def PerfDataRecordedPerCPU(self):
> +               if "--per-thread" in self.cmd_line.split():
> +                       return False
> +               return True
> +
> +       def DefaultToPerCPU(self):
> +               # --no-per-cpu option takes precedence
> +               if self.no_per_cpu:
> +                       return False
> +               if not self.PerfDataRecordedPerCPU():
> +                       return False
> +               # Default to per-cpu for Intel PT data that was recorded =
per-cpu,
> +               # because decoding can be done for each CPU separately.
> +               if self.IsIntelPT():
> +                       return True
> +               return False
> +
> +       def Config(self):
> +               self.Init()
> +               self.ExtractTimeInfo()
> +               if not self.per_cpu:
> +                       self.per_cpu =3D self.DefaultToPerCPU()
> +               if self.verbosity.debug:
> +                       print("per_cpu", self.per_cpu)
> +               self.ExtractCPUInfo()
> +               self.SplitTimeRanges()
> +               if self.verbosity.self_test:
> +                       self.CheckTimeRanges()
> +               # Prefer open-ended time range to starting / ending with =
min_time / max_time resp.
> +               self.OpenTimeRangeEnds()
> +               self.CreateWorkList()
> +
> +       def Run(self):
> +               if self.dry_run:
> +                       print(len(self.worklist),"jobs:")
> +                       for w in self.worklist:
> +                               print(w.Command())
> +                       return True
> +               result =3D RunWork(self.worklist, verbosity=3Dself.verbos=
ity)
> +               if self.verbosity.verbose:
> +                       print(glb_prog_name, "done")
> +               return result
> +
> +def RunParallelPerf(a):
> +       pp =3D ParallelPerf(a)
> +       pp.Config()
> +       return pp.Run()
> +
> +def Main(args):
> +       ap =3D argparse.ArgumentParser(
> +               prog=3Dglb_prog_name, formatter_class =3D argparse.RawDes=
criptionHelpFormatter,
> +               description =3D
> +"""
> +Run a perf script command multiple times in parallel, using perf script =
options
> +--cpu and --time so that each job processes a different chunk of the dat=
a.
> +""",
> +               epilog =3D
> +"""
> +Follow the options by '--' and then the perf script command e.g.
> +
> +       $ perf record -a -- sleep 10
> +       $ parallel-perf.py --nr=3D4 -- perf script --ns
> +       All jobs finished successfully
> +       $ tree parallel-perf-output/
> +       parallel-perf-output/
> +       =E2=94=9C=E2=94=80=E2=94=80 time-range-0
> +       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
> +       =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 out.txt
> +       =E2=94=9C=E2=94=80=E2=94=80 time-range-1
> +       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
> +       =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 out.txt
> +       =E2=94=9C=E2=94=80=E2=94=80 time-range-2
> +       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
> +       =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 out.txt
> +       =E2=94=94=E2=94=80=E2=94=80 time-range-3
> +           =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
> +           =E2=94=94=E2=94=80=E2=94=80 out.txt
> +       $ find parallel-perf-output -name cmd.txt | sort | xargs grep -H =
.
> +       parallel-perf-output/time-range-0/cmd.txt:perf script --time=3D,9=
466.504461499 --ns
> +       parallel-perf-output/time-range-1/cmd.txt:perf script --time=3D94=
66.504461500,9469.005396999 --ns
> +       parallel-perf-output/time-range-2/cmd.txt:perf script --time=3D94=
69.005397000,9471.506332499 --ns
> +       parallel-perf-output/time-range-3/cmd.txt:perf script --time=3D94=
71.506332500, --ns
> +
> +Any perf script command can be used, including the use of perf script op=
tions
> +--dlfilter and --script, so that the benefit of running parallel jobs
> +naturally extends to them also.
> +
> +If option --pipe-to is used, standard output is first piped through that
> +command. Beware, if the command fails (e.g. grep with no matches), it wi=
ll be
> +considered a fatal error.
> +
> +Final standard output is redirected to files named out.txt in separate
> +subdirectories under the output directory. Similarly, standard error is
> +written to files named err.txt. In addition, files named cmd.txt contain=
 the
> +corresponding perf script command. After processing, err.txt files are r=
emoved
> +if they are empty.
> +
> +If any job exits with a non-zero exit code, then all jobs are killed and=
 no
> +more are started. A message is printed if any job results in a non-empty
> +err.txt file.
> +
> +There is a separate output subdirectory for each time range. If the --pe=
r-cpu
> +option is used, these are further grouped under cpu-n subdirectories, e.=
g.
> +
> +       $ parallel-perf.py --per-cpu --nr=3D2 -- perf script --ns --cpu=
=3D0,1
> +       All jobs finished successfully
> +       $ tree parallel-perf-output
> +       parallel-perf-output/
> +       =E2=94=9C=E2=94=80=E2=94=80 cpu-0
> +       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 time-range-0
> +       =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
> +       =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 out.txt
> +       =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 time-range-1
> +       =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
> +       =E2=94=82       =E2=94=94=E2=94=80=E2=94=80 out.txt
> +       =E2=94=94=E2=94=80=E2=94=80 cpu-1
> +           =E2=94=9C=E2=94=80=E2=94=80 time-range-0
> +           =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
> +           =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 out.txt
> +           =E2=94=94=E2=94=80=E2=94=80 time-range-1
> +               =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
> +               =E2=94=94=E2=94=80=E2=94=80 out.txt
> +       $ find parallel-perf-output -name cmd.txt | sort | xargs grep -H =
.
> +       parallel-perf-output/cpu-0/time-range-0/cmd.txt:perf script --cpu=
=3D0 --time=3D,9469.005396999 --ns
> +       parallel-perf-output/cpu-0/time-range-1/cmd.txt:perf script --cpu=
=3D0 --time=3D9469.005397000, --ns
> +       parallel-perf-output/cpu-1/time-range-0/cmd.txt:perf script --cpu=
=3D1 --time=3D,9469.005396999 --ns
> +       parallel-perf-output/cpu-1/time-range-1/cmd.txt:perf script --cpu=
=3D1 --time=3D9469.005397000, --ns
> +
> +Subdivisions of time range, and cpus if the --per-cpu option is used, ar=
e
> +expressed by the --time and --cpu perf script options respectively. If t=
he
> +supplied perf script command has a --time option, then that time range i=
s
> +subdivided, otherwise the time range given by 'time of first sample' to
> +'time of last sample' is used (refer perf script --header-only). Similar=
ly, the
> +supplied perf script command may provide a --cpu option, and only those =
CPUs
> +will be processed.
> +
> +To prevent time intervals becoming too small, the --min-interval option =
can
> +be used.
> +
> +Note there is special handling for processing Intel PT traces. If an int=
erval is
> +not specified and the perf record command contained the intel_pt event, =
then the
> +time range will be subdivided in order to produce subdivisions that cont=
ain
> +approximately the same amount of trace data. That is accomplished by cou=
nting
> +double-quick (--itrace=3Dqqi) samples, and choosing time ranges that enc=
ompass
> +approximately the same number of samples. In that case, time ranges may =
not be
> +the same for each CPU processed. For Intel PT, --per-cpu is the default,=
 but
> +that can be overridden by --no-per-cpu. Note, for Intel PT, double-quick
> +decoding produces 1 sample for each PSB synchronization packet, which in=
 turn
> +come after a certain number of bytes output, determined by psb_period (r=
efer
> +perf Intel PT documentation). The minimum number of double-quick samples=
 that
> +will define a time range can be set by the --min_size option, which defa=
ults to
> +64.
> +""")
> +       ap.add_argument("-o", "--output-dir", default=3D"parallel-perf-ou=
tput", help=3D"output directory (default 'parallel-perf-output')")
> +       ap.add_argument("-j", "--jobs", type=3Dint, default=3D0, help=3D"=
maximum number of jobs to run in parallel at one time (default is the numbe=
r of CPUs)")
> +       ap.add_argument("-n", "--nr", type=3Dint, default=3D0, help=3D"nu=
mber of time subdivisions (default is the number of jobs)")
> +       ap.add_argument("-i", "--interval", type=3Dfloat, default=3D0, he=
lp=3D"subdivide the time range using this time interval (in seconds e.g. 0.=
1 for a tenth of a second)")
> +       ap.add_argument("-c", "--per-cpu", action=3D"store_true", help=3D=
"process data for each CPU in parallel")
> +       ap.add_argument("-m", "--min-interval", type=3Dfloat, default=3Dg=
lb_min_interval, help=3D"minimum interval (default "+str(glb_min_interval)+=
" seconds)")
> +       ap.add_argument("-p", "--pipe-to", help=3D"command to pipe output=
 to (optional)")
> +       ap.add_argument("-N", "--no-per-cpu", action=3D"store_true", help=
=3D"do not process data for each CPU in parallel")
> +       ap.add_argument("-b", "--min_size", type=3Dint, default=3Dglb_min=
_samples, help=3D"minimum data size (for Intel PT in PSBs)")
> +       ap.add_argument("-D", "--dry-run", action=3D"store_true", help=3D=
"do not run any jobs, just show the perf script commands")
> +       ap.add_argument("-q", "--quiet", action=3D"store_true", help=3D"d=
o not print any messages except errors")
> +       ap.add_argument("-v", "--verbose", action=3D"store_true", help=3D=
"print more messages")
> +       ap.add_argument("-d", "--debug", action=3D"store_true", help=3D"p=
rint debugging messages")
> +       cmd_line =3D list(args)
> +       try:
> +               split_pos =3D cmd_line.index("--")
> +               cmd =3D cmd_line[split_pos + 1:]
> +               args =3D cmd_line[:split_pos]
> +       except:
> +               cmd =3D None
> +               args =3D cmd_line
> +       a =3D ap.parse_args(args=3Dargs[1:])
> +       a.cmd =3D cmd
> +       a.verbosity =3D Verbosity(a)
> +       try:
> +               if a.cmd =3D=3D None:
> +                       if len(args) <=3D 1:
> +                               ap.print_help()
> +                               return True
> +                       raise Exception("Command line must contain '--' b=
efore perf command")
> +               return RunParallelPerf(a)
> +       except Exception as e:
> +               print("Fatal error: ", str(e))
> +               if a.debug:
> +                       raise
> +               return False
> +
> +if __name__ =3D=3D "__main__":
> +       if not Main(sys.argv):
> +               sys.exit(1)

Other than the style nits this all looks good to me. Could we have a test?

Thanks,
Ian

> --
> 2.34.1
>

