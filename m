Return-Path: <linux-kernel+bounces-109544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5997881AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BDE1C20E26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A561C2E;
	Thu, 21 Mar 2024 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2rCzmt+"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDF63AE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985665; cv=none; b=lGvZQpeHq+fsGggzIr0v0Wx5BLb7VB5DLKq30NcmqbWzJ60RrjGUpXRLcGHZ+Wp2jdKhU8da2LMJzbNjQk2Kv0dsmH6li7bOstegORdNf9KhMTD5bmuPjFGuO1uykFQ2HilhLyot8Mo5DvqkAd6RJMC1j3YbpI+IVqw6D3C1jMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985665; c=relaxed/simple;
	bh=innGn1gRjEEA70FFSFWrBlMqIE72Mis+QUn8qEWYLnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8kHkAtE2+mjvjRpBATxNJG9NsdYZ5BrX7SiuCqVxXK1OZ0CjCfB7YBTuphHml+bojRRs2wxoKAgviwFGKSZv/5OwwmF/uozJvBrZ8tnaRzmjkLcXZs0fCNOIDXRoRenG70qd/cii+RaxNyezrLx3CChvoeNMYL5iWyddr8SmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2rCzmt+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1deddb82b43so85225ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710985663; x=1711590463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx6SfRuv9LLLnehF2XOw09ZyMX/yZGxxNegkKjOPj2s=;
        b=Z2rCzmt+i18GkwtP6zoN9I+ZzhxzbTK+gjBEejU1+5/ckEKAtrri316PnNpR+SaXHH
         TYNlNvh8kS6hWjLF6ENS12e2QLe2xI6Faw7yfNXIkWNoROklxjI2I8TTJxN7wRippxP6
         H5Fhwn5cV/CA9eMKmihJLNWonf/WcwqvLAhVIuC3HJRxH733r+x30oZEhKQnuHHWl62o
         iM0OsCJEz7Sc8mtzohkp2V6W7leP0itrtXr3Uc6bEtJxKjKkBsRGVr2cFmByOvcCFluj
         w/bUFXVZaKhNn82zYrnLwLYbSBO3OL/Jqng3MVp2bhCvWpDE+wHa6wrQUK/QbWXXGhJh
         HtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985663; x=1711590463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sx6SfRuv9LLLnehF2XOw09ZyMX/yZGxxNegkKjOPj2s=;
        b=kJsfENN+jtt/pdgi1JEgkl9lZPiQ6EhdQSzob4llkON1l4zpY/Vk2vi3zZMAQeyZHD
         k6WJqVDxNAF8nYaZ1IW4QECqNaHQHMgR8Gs31AiB8HIPfizqAHqBXgk5nJVnGD+TfYzp
         9gcCxp/AjtMjaT0cCqPQBofm69zjTJWTpQ3o0NPE13gJqvYEn1LvR3NJ4OCtnJAUwfKe
         SUplPn4vh/r35M6zhAxHeiK6JXWrpaLPVqIBjQpPTm5IboMNs2bPGtOfPRJXFR3szHoe
         kzz4JTdUyVlH5K5LjPg+QowLLozuxfpqiLowtjaV3wKPq9w4tGtbc03ytzNXiXC1tSGS
         sr+w==
X-Forwarded-Encrypted: i=1; AJvYcCWUzvAyVU5hEufs3DvBz8kinmqUQe2dol7k0Q5fXZmPERworCOSm57HwSkzfxseLjkxTmhLr2aQu7mvNGWkCqC6gba1QlLKy0MYWu2t
X-Gm-Message-State: AOJu0Yz2eiiGmqB56rwMZsOh50UxuiaZ8XTms4t7aa3EmVZ1aFAyyHTh
	BBpjObJdcRTNHsY5DQH1DnN0YH6ejernFJitZqlBqu3glrGExJwGrPr/A58FwKwOq3r+Q7LO4Us
	hKkqOqvHmn5Uk3T/8Dg1R1un9Q4WCPkBlml3t
X-Google-Smtp-Source: AGHT+IEdfW4gsOO9KtJU/DA9EOOHiJsoyZ4egTT2mau5BDr8h+gDYoq5NMuN6Cpd7WVnFDjmAhRxijmxEZPptKsyVVs=
X-Received: by 2002:a17:902:e750:b0:1de:ed50:41f8 with SMTP id
 p16-20020a170902e75000b001deed5041f8mr120729plf.22.1710985662419; Wed, 20 Mar
 2024 18:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320193115.811899-1-acme@kernel.org> <20240320193115.811899-2-acme@kernel.org>
In-Reply-To: <20240320193115.811899-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 18:47:28 -0700
Message-ID: <CAP-5=fWXCL0AAdp4bSQHPo_XR1iiF8KY4=Bo4756XC1tE0PDUw@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf beauty: Introduce scrape script for various fs
 syscalls 'flags' arguments
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:31=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> It was using the first variation on producing a string representation
> for a binary flag, one that used the system's fcntl.h and preprocessor
> tricks that had to be updated everytime a new flag was introduced.
>
> Use the more recent scrape script + strarray + strarray__scnprintf_flags(=
) combo.
>
>   $ tools/perf/trace/beauty/fs_at_flags.sh
>   static const char *fs_at_flags[] =3D {
>         [ilog2(0x100) + 1] =3D "SYMLINK_NOFOLLOW",
>         [ilog2(0x200) + 1] =3D "REMOVEDIR",
>         [ilog2(0x400) + 1] =3D "SYMLINK_FOLLOW",
>         [ilog2(0x800) + 1] =3D "NO_AUTOMOUNT",
>         [ilog2(0x1000) + 1] =3D "EMPTY_PATH",
>         [ilog2(0x0000) + 1] =3D "STATX_SYNC_AS_STAT",
>         [ilog2(0x2000) + 1] =3D "STATX_FORCE_SYNC",
>         [ilog2(0x4000) + 1] =3D "STATX_DONT_SYNC",
>         [ilog2(0x8000) + 1] =3D "RECURSIVE",
>         [ilog2(0x80000000) + 1] =3D "GETATTR_NOSEC",
>   };
>   $
>
> Now we need a copy of uapi/linux/fcntl.h from tools/include/ in the
> scrape only directory tools/perf/trace/beauty/include and will use that
> fs_at_flags array for other fs syscalls.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.perf                      |   7 +
>  tools/perf/builtin-trace.c                    |   2 +-
>  tools/perf/check-headers.sh                   |   1 +
>  tools/perf/trace/beauty/Build                 |   1 +
>  tools/perf/trace/beauty/beauty.h              |   4 +-
>  tools/perf/trace/beauty/fs_at_flags.c         |  26 ++++
>  tools/perf/trace/beauty/fs_at_flags.sh        |  21 +++
>  .../trace/beauty/include/uapi/linux/fcntl.h   | 123 ++++++++++++++++++
>  tools/perf/trace/beauty/statx.c               |  31 -----
>  9 files changed, 182 insertions(+), 34 deletions(-)
>  create mode 100644 tools/perf/trace/beauty/fs_at_flags.c
>  create mode 100755 tools/perf/trace/beauty/fs_at_flags.sh
>  create mode 100644 tools/perf/trace/beauty/include/uapi/linux/fcntl.h
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index ccd2dcbc64f720d2..73d5603450b0a547 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -489,6 +489,12 @@ beauty_ioctl_outdir :=3D $(beauty_outdir)/ioctl
>  # Create output directory if not already present
>  $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outd=
ir)')
>
> +fs_at_flags_array :=3D $(beauty_outdir)/fs_at_flags_array.c
> +fs_at_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/fs_at_flags.sh
> +
> +$(fs_at_flags_array): $(beauty_uapi_linux_dir)/fcntl.h $(fs_at_flags_tbl=
)
> +       $(Q)$(SHELL) '$(fs_at_flags_tbl)' $(beauty_uapi_linux_dir) > $@
> +

I wonder if rather than update Makefile.perf, we could push more of
the logic into tools/perf/trace/beauty/Build. It would also be nice to
add there the shellcheck logic:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/Build?h=3Dperf-tools-next#n81

>  clone_flags_array :=3D $(beauty_outdir)/clone_flags_array.c
>  clone_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/clone.sh
>
> @@ -772,6 +778,7 @@ build-dir   =3D $(or $(__build-dir),.)
>
>  prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
>         arm64-sysreg-defs \
> +       $(fs_at_flags_array) \
>         $(clone_flags_array) \
>         $(drm_ioctl_array) \
>         $(fadvise_advice_array) \
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 8fb032caeaf53288..8417387aafa8295d 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1144,7 +1144,7 @@ static const struct syscall_fmt syscall_fmts[] =3D =
{
>         { .name     =3D "stat", .alias =3D "newstat", },
>         { .name     =3D "statx",
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT,        /* fdat */=
 },
> -                  [2] =3D { .scnprintf =3D SCA_STATX_FLAGS, /* flags */ =
} ,
> +                  [2] =3D { .scnprintf =3D SCA_FS_AT_FLAGS, /* flags */ =
} ,
>                    [3] =3D { .scnprintf =3D SCA_STATX_MASK,  /* mask */ }=
, }, },
>         { .name     =3D "swapoff",
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FILENAME, /* specialfil=
e */ }, }, },
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 413c9b747216020f..d23a84fdf3efef78 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -89,6 +89,7 @@ BEAUTY_FILES=3D(
>    "arch/x86/include/asm/irq_vectors.h"
>    "arch/x86/include/uapi/asm/prctl.h"
>    "include/linux/socket.h"
> +  "include/uapi/linux/fcntl.h"
>    "include/uapi/linux/fs.h"
>    "include/uapi/linux/mount.h"
>    "include/uapi/linux/prctl.h"
> diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Buil=
d
> index d11ce256f5114034..d8ce1b6989832134 100644
> --- a/tools/perf/trace/beauty/Build
> +++ b/tools/perf/trace/beauty/Build
> @@ -1,6 +1,7 @@
>  perf-y +=3D clone.o
>  perf-y +=3D fcntl.o
>  perf-y +=3D flock.o
> +perf-y +=3D fs_at_flags.o
>  perf-y +=3D fsmount.o
>  perf-y +=3D fspick.o
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
> diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/b=
eauty.h
> index 9feb794f5c6e15f4..c94ae8701bc65a2f 100644
> --- a/tools/perf/trace/beauty/beauty.h
> +++ b/tools/perf/trace/beauty/beauty.h
> @@ -234,8 +234,8 @@ size_t syscall_arg__scnprintf_socket_protocol(char *b=
f, size_t size, struct sysc
>  size_t syscall_arg__scnprintf_socket_level(char *bf, size_t size, struct=
 syscall_arg *arg);
>  #define SCA_SK_LEVEL syscall_arg__scnprintf_socket_level
>
> -size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct =
syscall_arg *arg);
> -#define SCA_STATX_FLAGS syscall_arg__scnprintf_statx_flags
> +size_t syscall_arg__scnprintf_fs_at_flags(char *bf, size_t size, struct =
syscall_arg *arg);
> +#define SCA_FS_AT_FLAGS syscall_arg__scnprintf_fs_at_flags
>
>  size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct s=
yscall_arg *arg);
>  #define SCA_STATX_MASK syscall_arg__scnprintf_statx_mask
> diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/bea=
uty/fs_at_flags.c
> new file mode 100644
> index 0000000000000000..2a099953d9935782
> --- /dev/null
> +++ b/tools/perf/trace/beauty/fs_at_flags.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: LGPL-2.1
> +/*
> + * trace/beauty/fs_at_flags.c
> + *
> + *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redh=
at.com>
> + */
> +
> +#include "trace/beauty/beauty.h"
> +#include <sys/types.h>
> +#include <linux/log2.h>
> +
> +#include "trace/beauty/generated/fs_at_flags_array.c"
> +static DEFINE_STRARRAY(fs_at_flags, "AT_");
> +
> +static size_t fs_at__scnprintf_flags(unsigned long flags, char *bf, size=
_t size, bool show_prefix)
> +{
> +       return strarray__scnprintf_flags(&strarray__fs_at_flags, bf, size=
, show_prefix, flags);
> +}
> +
> +size_t syscall_arg__scnprintf_fs_at_flags(char *bf, size_t size, struct =
syscall_arg *arg)
> +{
> +       bool show_prefix =3D arg->show_string_prefix;
> +       int flags =3D arg->val;
> +
> +       return fs_at__scnprintf_flags(flags, bf, size, show_prefix);
> +}
> diff --git a/tools/perf/trace/beauty/fs_at_flags.sh b/tools/perf/trace/be=
auty/fs_at_flags.sh
> new file mode 100755
> index 0000000000000000..456f59addf741062
> --- /dev/null
> +++ b/tools/perf/trace/beauty/fs_at_flags.sh
> @@ -0,0 +1,21 @@
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
> +linux_fcntl=3D${beauty_uapi_linux_dir}/fcntl.h
> +
> +printf "static const char *fs_at_flags[] =3D {\n"
> +regex=3D'^[[:space:]]*#[[:space:]]*define[[:space:]]+AT_([^_]+[[:alnum:]=
_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
> +# AT_EACCESS is only meaningful to faccessat, so we will special case it=
 there...
> +# AT_STATX_SYNC_TYPE is not a bit, its a mask of AT_STATX_SYNC_AS_STAT, =
AT_STATX_FORCE_SYNC and AT_STATX_DONT_SYNC
> +grep -E $regex ${linux_fcntl} | \
> +       grep -v AT_EACCESS | \
> +       grep -v AT_STATX_SYNC_TYPE | \
> +       sed -r "s/$regex/\2 \1/g"       | \
> +       xargs printf "\t[ilog2(%s) + 1] =3D \"%s\",\n"
> +printf "};\n"
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/p=
erf/trace/beauty/include/uapi/linux/fcntl.h
> new file mode 100644
> index 0000000000000000..282e90aeb163c028
> --- /dev/null
> +++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_FCNTL_H
> +#define _UAPI_LINUX_FCNTL_H
> +
> +#include <asm/fcntl.h>
> +#include <linux/openat2.h>
> +
> +#define F_SETLEASE     (F_LINUX_SPECIFIC_BASE + 0)
> +#define F_GETLEASE     (F_LINUX_SPECIFIC_BASE + 1)
> +
> +/*
> + * Cancel a blocking posix lock; internal use only until we expose an
> + * asynchronous lock api to userspace:
> + */
> +#define F_CANCELLK     (F_LINUX_SPECIFIC_BASE + 5)
> +
> +/* Create a file descriptor with FD_CLOEXEC set. */
> +#define F_DUPFD_CLOEXEC        (F_LINUX_SPECIFIC_BASE + 6)
> +
> +/*
> + * Request nofications on a directory.
> + * See below for events that may be notified.
> + */
> +#define F_NOTIFY       (F_LINUX_SPECIFIC_BASE+2)
> +
> +/*
> + * Set and get of pipe page size array
> + */
> +#define F_SETPIPE_SZ   (F_LINUX_SPECIFIC_BASE + 7)
> +#define F_GETPIPE_SZ   (F_LINUX_SPECIFIC_BASE + 8)
> +
> +/*
> + * Set/Get seals
> + */
> +#define F_ADD_SEALS    (F_LINUX_SPECIFIC_BASE + 9)
> +#define F_GET_SEALS    (F_LINUX_SPECIFIC_BASE + 10)
> +
> +/*
> + * Types of seals
> + */
> +#define F_SEAL_SEAL    0x0001  /* prevent further seals from being set *=
/
> +#define F_SEAL_SHRINK  0x0002  /* prevent file from shrinking */
> +#define F_SEAL_GROW    0x0004  /* prevent file from growing */
> +#define F_SEAL_WRITE   0x0008  /* prevent writes */
> +#define F_SEAL_FUTURE_WRITE    0x0010  /* prevent future writes while ma=
pped */
> +#define F_SEAL_EXEC    0x0020  /* prevent chmod modifying exec bits */
> +/* (1U << 31) is reserved for signed error codes */
> +
> +/*
> + * Set/Get write life time hints. {GET,SET}_RW_HINT operate on the
> + * underlying inode, while {GET,SET}_FILE_RW_HINT operate only on
> + * the specific file.
> + */
> +#define F_GET_RW_HINT          (F_LINUX_SPECIFIC_BASE + 11)
> +#define F_SET_RW_HINT          (F_LINUX_SPECIFIC_BASE + 12)
> +#define F_GET_FILE_RW_HINT     (F_LINUX_SPECIFIC_BASE + 13)
> +#define F_SET_FILE_RW_HINT     (F_LINUX_SPECIFIC_BASE + 14)
> +
> +/*
> + * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
> + * used to clear any hints previously set.
> + */
> +#define RWH_WRITE_LIFE_NOT_SET 0
> +#define RWH_WRITE_LIFE_NONE    1
> +#define RWH_WRITE_LIFE_SHORT   2
> +#define RWH_WRITE_LIFE_MEDIUM  3
> +#define RWH_WRITE_LIFE_LONG    4
> +#define RWH_WRITE_LIFE_EXTREME 5
> +
> +/*
> + * The originally introduced spelling is remained from the first
> + * versions of the patch set that introduced the feature, see commit
> + * v4.13-rc1~212^2~51.
> + */
> +#define RWF_WRITE_LIFE_NOT_SET RWH_WRITE_LIFE_NOT_SET
> +
> +/*
> + * Types of directory notifications that may be requested.
> + */
> +#define DN_ACCESS      0x00000001      /* File accessed */
> +#define DN_MODIFY      0x00000002      /* File modified */
> +#define DN_CREATE      0x00000004      /* File created */
> +#define DN_DELETE      0x00000008      /* File removed */
> +#define DN_RENAME      0x00000010      /* File renamed */
> +#define DN_ATTRIB      0x00000020      /* File changed attibutes */
> +#define DN_MULTISHOT   0x80000000      /* Don't remove notifier */
> +
> +/*
> + * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EA=
CCESS is
> + * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only t=
o
> + * unlinkat.  The two functions do completely different things and there=
fore,
> + * the flags can be allowed to overlap.  For example, passing AT_REMOVED=
IR to
> + * faccessat would be undefined behavior and thus treating it equivalent=
 to
> + * AT_EACCESS is valid undefined behavior.
> + */
> +#define AT_FDCWD               -100    /* Special value used to indicate
> +                                           openat should use the current
> +                                           working directory. */
> +#define AT_SYMLINK_NOFOLLOW    0x100   /* Do not follow symbolic links. =
 */
> +#define AT_EACCESS             0x200   /* Test access permitted for
> +                                           effective IDs, not real IDs. =
 */
> +#define AT_REMOVEDIR           0x200   /* Remove directory instead of
> +                                           unlinking file.  */
> +#define AT_SYMLINK_FOLLOW      0x400   /* Follow symbolic links.  */
> +#define AT_NO_AUTOMOUNT                0x800   /* Suppress terminal auto=
mount traversal */
> +#define AT_EMPTY_PATH          0x1000  /* Allow empty relative pathname =
*/
> +
> +#define AT_STATX_SYNC_TYPE     0x6000  /* Type of synchronisation requir=
ed from statx() */
> +#define AT_STATX_SYNC_AS_STAT  0x0000  /* - Do whatever stat() does */
> +#define AT_STATX_FORCE_SYNC    0x2000  /* - Force the attributes to be s=
ync'd with the server */
> +#define AT_STATX_DONT_SYNC     0x4000  /* - Don't sync attributes with t=
he server */
> +
> +#define AT_RECURSIVE           0x8000  /* Apply to the entire subtree */
> +
> +/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits.=
. */
> +#define AT_HANDLE_FID          AT_REMOVEDIR    /* file handle is needed =
to
> +                                       compare object identity and may n=
ot
> +                                       be usable to open_by_handle_at(2)=
 */
> +#if defined(__KERNEL__)
> +#define AT_GETATTR_NOSEC       0x80000000
> +#endif
> +
> +#endif /* _UAPI_LINUX_FCNTL_H */
> diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/st=
atx.c
> index 1f7e34ed4e02be86..4e0059fd02118f9c 100644
> --- a/tools/perf/trace/beauty/statx.c
> +++ b/tools/perf/trace/beauty/statx.c
> @@ -8,7 +8,6 @@
>  #include "trace/beauty/beauty.h"
>  #include <linux/kernel.h>
>  #include <sys/types.h>
> -#include <linux/fcntl.h>
>  #include <linux/stat.h>
>
>  #ifndef STATX_MNT_ID
> @@ -21,36 +20,6 @@
>  #define STATX_MNT_ID_UNIQUE    0x00004000U
>  #endif
>
> -size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct =
syscall_arg *arg)
> -{
> -       bool show_prefix =3D arg->show_string_prefix;
> -       const char *prefix =3D "AT_";
> -       int printed =3D 0, flags =3D arg->val;
> -
> -       if (flags =3D=3D 0)
> -               return scnprintf(bf, size, "%s%s", show_prefix ? "AT_STAT=
X_" : "", "SYNC_AS_STAT");
> -#define        P_FLAG(n) \
> -       if (flags & AT_##n) { \
> -               printed +=3D scnprintf(bf + printed, size - printed, "%s%=
s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
> -               flags &=3D ~AT_##n; \
> -       }
> -
> -       P_FLAG(SYMLINK_NOFOLLOW);
> -       P_FLAG(REMOVEDIR);
> -       P_FLAG(SYMLINK_FOLLOW);
> -       P_FLAG(NO_AUTOMOUNT);
> -       P_FLAG(EMPTY_PATH);
> -       P_FLAG(STATX_FORCE_SYNC);
> -       P_FLAG(STATX_DONT_SYNC);
> -
> -#undef P_FLAG
> -
> -       if (flags)
> -               printed +=3D scnprintf(bf + printed, size - printed, "%s%=
#x", printed ? "|" : "", flags);
> -
> -       return printed;
> -}
> -
>  size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct s=
yscall_arg *arg)
>  {
>         bool show_prefix =3D arg->show_string_prefix;
> --
> 2.44.0
>

