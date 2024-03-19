Return-Path: <linux-kernel+bounces-108101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2C8805F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B8C1C22518
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A45258100;
	Tue, 19 Mar 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soel3TAg"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927125917F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879372; cv=none; b=dgCfpA7J5PDbrU4QJznVNcpdf6t3BDKu7oWP6YSUBsbcDieBlyAQcn1+1X9OJRiGuff0i0QKRL/dOgW2/GldZmKiGhEkbg6jNpvbI9sXJJBIhNXvzOAdPg4P2p4NbyOYx4a0uG7AQLN+9WZYaz6YuKjNmGmcAE5GC2Wwb55lQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879372; c=relaxed/simple;
	bh=JH5cQFGXpVzCafFtwHE30FzVNGmyj3B3iU12y4lR8bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laMqAhcyUBAEa3HrfypJL02wEC76i4IKPlDhpyvN2eB34x+nmEz4NTVm9FJQuqOt5S1d0A0HUYbpnCDxaWJv0DJO0YCPD/ayaC/CGww/R+Txy7oPnVsaC/XV7ePj1Cw26N9KvBa6a9+PXyZIIftIx/WJ/GLRjRQPb9blKz9gstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soel3TAg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dee917abd5so6135ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710879369; x=1711484169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnC/PClOUbpATx/wYZn6KxT6pkLtTGwMS8zyLcU4BoM=;
        b=soel3TAgJKAZ3ZC0ka8yrxuwT7F6FKSQ5JsrPGQmAfE5sTw3apeOLj7TtWFMiEE4B3
         K6YYX1aFNKZj3wOnavMeqc4WljMB1Z3/Xbl6xLbzgZA1GKIbLUBr51R+po0VvKFiYmj7
         hUu+KLHLh8/UITB9P0OE0GzSwKx+GCZuLpVDPvcrvvnW+BPD2P2kL0IhWFkfjCnqcxeR
         B5Qs24K1IcpOKyRHGyWsG6i2BgJsyA2qTFxHGmI41MKq5Jh9nJTg1BT+izKVBCtZsZcF
         RCpo2ExU+71Y0gmDmOPKsycC2NVig/OGXVcikmB5V5TkXJXHLZcbZpslXHlvBMXVEDTZ
         x9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710879369; x=1711484169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnC/PClOUbpATx/wYZn6KxT6pkLtTGwMS8zyLcU4BoM=;
        b=p1IwV4qJFdeueLRGP26ssfBVzNQgLXsztjdiqkrqMaStRdMmzrUaLzCAZE6NCxTD+G
         kYdZFpBGdiI3UKC4b0p6TOBwEo3fsDdxF5aTuzKdgeUtKTHu2lKsQw7+MG68r9kbC+74
         glkWyd8Zb9DJr5FJSj3+oqwRxdP7BAD+9uoucS1Zv2rh0WvnkVUb2Igh1foZksSsahGM
         hFfAIlGeDbbr1Ym8vPG4Hv4Mg8YpfSIXjLLU9Jrm3EP2xe7v1HPVrtcisKV2644qF8qK
         FXoSQSTym3fVChGeZLP9h3Obuw4SDiTbW4/B2j3p22+X3tOh631x7f581uqLQRLQvPMD
         GR6A==
X-Forwarded-Encrypted: i=1; AJvYcCVe2POll8nA49+p/qnOcDMqDH1VcegqScgDP5X3gJH21P5aAn/4V6yv7zvCY6frACNeer0XrBQvqc7WqUnNLaGTuCrZufsBJXnmuRYF
X-Gm-Message-State: AOJu0YxKwQGpUW24lBgK0T+KUCEIBc0LA0xekbx6rXKsbG1A8w4IHpFm
	7gMoo7kFLhGcCgy19s3h35weVQ5Who1BFdDIJY1uwOOhPSvLZp0dr3ksoWbMmjPZ74DYFBdrc1o
	1lfdks2Re0bog75DqcYy/fNeyPSqtQ8MAF9H7
X-Google-Smtp-Source: AGHT+IFtEN2l8gbs+mGTRyAO6FTcwds4VZNdiQhf6GQmhYMVguy4Vukog9e5rZI9dQ62/M+ZzNCttn5AH6TiIrKzXTo=
X-Received: by 2002:a17:902:6502:b0:1dd:8d29:868e with SMTP id
 b2-20020a170902650200b001dd8d29868emr13761plk.1.1710879368541; Tue, 19 Mar
 2024 13:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfnULIn3XKDq0bpc@x1>
In-Reply-To: <ZfnULIn3XKDq0bpc@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 13:15:57 -0700
Message-ID: <CAP-5=fXtwu285_=dLVT5NDP5Ck=3OV0kTBn68p9=mFjjFniRkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf beauty: Introduce scraper script for 'clone'
 syscall 'flags' argument
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:06=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> It was using the first variation on producing a string representation
> for a binary flag, one that used the copy of uapi/linux/sched.h with
> preprocessor tricks that had to be updated everytime a new flag was
> introduced.
>
> Use the more recent scraper script + strarray + strarray__scnprintf_flags=
() combo.
>
>   $ tools/perf/trace/beauty/clone.sh | head -5
>   static const char *clone_flags[] =3D {
>         [ilog2(0x00000100) + 1] =3D "VM",
>         [ilog2(0x00000200) + 1] =3D "FS",
>         [ilog2(0x00000400) + 1] =3D "FILES",
>         [ilog2(0x00000800) + 1] =3D "SIGHAND",
>   $
>
> Now we can move uapi/linux/sched.h from tools/include/, that is used for
> building perf to the scrap only directory tools/perf/trace/beauty/include=
.

nit: scrape?

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.perf                      | 14 ++++--
>  tools/perf/check-headers.sh                   |  2 +-
>  tools/perf/trace/beauty/clone.c               | 46 ++-----------------
>  tools/perf/trace/beauty/clone.sh              | 17 +++++++
>  .../trace/beauty}/include/uapi/linux/sched.h  |  0
>  5 files changed, 34 insertions(+), 45 deletions(-)
>  create mode 100755 tools/perf/trace/beauty/clone.sh
>  rename tools/{ =3D> perf/trace/beauty}/include/uapi/linux/sched.h (100%)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f5654d06e31385b7..ccd2dcbc64f720d2 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -485,13 +485,20 @@ x86_arch_asm_dir :=3D $(srctree)/tools/arch/x86/inc=
lude/asm/
>
>  beauty_outdir :=3D $(OUTPUT)trace/beauty/generated
>  beauty_ioctl_outdir :=3D $(beauty_outdir)/ioctl
> -drm_ioctl_array :=3D $(beauty_ioctl_outdir)/drm_ioctl_array.c
> -drm_hdr_dir :=3D $(srctree)/tools/include/uapi/drm
> -drm_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
>
>  # Create output directory if not already present
>  $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outd=
ir)')
>
> +clone_flags_array :=3D $(beauty_outdir)/clone_flags_array.c
> +clone_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/clone.sh
> +
> +$(clone_flags_array): $(beauty_uapi_linux_dir)/sched.h $(clone_flags_tbl=
)
> +       $(Q)$(SHELL) '$(clone_flags_tbl)' $(beauty_uapi_linux_dir) > $@
> +
> +drm_ioctl_array :=3D $(beauty_ioctl_outdir)/drm_ioctl_array.c
> +drm_hdr_dir :=3D $(srctree)/tools/include/uapi/drm
> +drm_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
> +
>  $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm=
_ioctl_tbl)
>         $(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
>
> @@ -765,6 +772,7 @@ build-dir   =3D $(or $(__build-dir),.)
>
>  prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
>         arm64-sysreg-defs \
> +       $(clone_flags_array) \
>         $(drm_ioctl_array) \
>         $(fadvise_advice_array) \
>         $(fsconfig_arrays) \
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 859cd6f35b0ac9b1..413c9b747216020f 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -15,7 +15,6 @@ FILES=3D(
>    "include/uapi/linux/kvm.h"
>    "include/uapi/linux/in.h"
>    "include/uapi/linux/perf_event.h"
> -  "include/uapi/linux/sched.h"
>    "include/uapi/linux/seccomp.h"
>    "include/uapi/linux/vhost.h"
>    "include/linux/bits.h"
> @@ -93,6 +92,7 @@ BEAUTY_FILES=3D(
>    "include/uapi/linux/fs.h"
>    "include/uapi/linux/mount.h"
>    "include/uapi/linux/prctl.h"
> +  "include/uapi/linux/sched.h"
>    "include/uapi/linux/usbdevice_fs.h"
>    "include/uapi/sound/asound.h"
>  )
> diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/cl=
one.c
> index f4db894e0af6d14b..c9fa8f7e82b909fb 100644
> --- a/tools/perf/trace/beauty/clone.c
> +++ b/tools/perf/trace/beauty/clone.c
> @@ -7,52 +7,16 @@
>
>  #include "trace/beauty/beauty.h"
>  #include <linux/kernel.h>
> +#include <linux/log2.h>
>  #include <sys/types.h>
> -#include <uapi/linux/sched.h>
> +#include <sched.h>
>
>  static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size=
_t size, bool show_prefix)
>  {
> -       const char *prefix =3D "CLONE_";
> -       int printed =3D 0;
> +#include "trace/beauty/generated/clone_flags_array.c"
> +       static DEFINE_STRARRAY(clone_flags, "CLONE_");
>
> -#define        P_FLAG(n) \
> -       if (flags & CLONE_##n) { \
> -               printed +=3D scnprintf(bf + printed, size - printed, "%s%=
s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
> -               flags &=3D ~CLONE_##n; \
> -       }
> -
> -       P_FLAG(VM);
> -       P_FLAG(FS);
> -       P_FLAG(FILES);
> -       P_FLAG(SIGHAND);
> -       P_FLAG(PIDFD);
> -       P_FLAG(PTRACE);
> -       P_FLAG(VFORK);
> -       P_FLAG(PARENT);
> -       P_FLAG(THREAD);
> -       P_FLAG(NEWNS);
> -       P_FLAG(SYSVSEM);
> -       P_FLAG(SETTLS);
> -       P_FLAG(PARENT_SETTID);
> -       P_FLAG(CHILD_CLEARTID);
> -       P_FLAG(DETACHED);
> -       P_FLAG(UNTRACED);
> -       P_FLAG(CHILD_SETTID);
> -       P_FLAG(NEWCGROUP);
> -       P_FLAG(NEWUTS);
> -       P_FLAG(NEWIPC);
> -       P_FLAG(NEWUSER);
> -       P_FLAG(NEWPID);
> -       P_FLAG(NEWNET);
> -       P_FLAG(IO);
> -       P_FLAG(CLEAR_SIGHAND);
> -       P_FLAG(INTO_CGROUP);
> -#undef P_FLAG
> -
> -       if (flags)
> -               printed +=3D scnprintf(bf + printed, size - printed, "%s%=
#x", printed ? "|" : "", flags);
> -
> -       return printed;
> +       return strarray__scnprintf_flags(&strarray__clone_flags, bf, size=
, show_prefix, flags);
>  }
>
>  size_t syscall_arg__scnprintf_clone_flags(char *bf, size_t size, struct =
syscall_arg *arg)
> diff --git a/tools/perf/trace/beauty/clone.sh b/tools/perf/trace/beauty/c=
lone.sh
> new file mode 100755
> index 0000000000000000..18b6c0d75693721d
> --- /dev/null
> +++ b/tools/perf/trace/beauty/clone.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: LGPL-2.1
> +
> +if [ $# -ne 1 ] ; then
> +       beauty_uapi_linux_dir=3Dtools/perf/trace/beauty/include/uapi/linu=
x/
> +else
> +       beauty_uapi_linux_dir=3D$1
> +fi
> +
> +linux_sched=3D${beauty_uapi_linux_dir}/sched.h
> +
> +printf "static const char *clone_flags[] =3D {\n"
> +regex=3D'^[[:space:]]*#[[:space:]]*define[[:space:]]+CLONE_([^_]+[[:alnu=
m:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
> +grep -E $regex ${linux_sched} | \
> +       sed -r "s/$regex/\2 \1/g"       | \
> +       xargs printf "\t[ilog2(%s) + 1] =3D \"%s\",\n"
> +printf "};\n"
> diff --git a/tools/include/uapi/linux/sched.h b/tools/perf/trace/beauty/i=
nclude/uapi/linux/sched.h
> similarity index 100%
> rename from tools/include/uapi/linux/sched.h
> rename to tools/perf/trace/beauty/include/uapi/linux/sched.h
> --
> 2.44.0
>

