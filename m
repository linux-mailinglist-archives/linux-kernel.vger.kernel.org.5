Return-Path: <linux-kernel+bounces-128704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05482895E65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E631F22B53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D115E5D9;
	Tue,  2 Apr 2024 21:04:54 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA515DBB5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091893; cv=none; b=KSXhhVTWetenb0Y4iv9n4lhF7Ei5P4xezMXzIsJbZFqUo9jRmTm5NNrkbzuUSDQ/eSbvQjPP4jWss2WdVtDpAy6V4xZn6uVcMO/2c4hG/l1HpkKuchd2+8rmyCrbc/5AjKx7ZxQLprTy6MYvtKyew4g2k7suEXH41XNJAzfx6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091893; c=relaxed/simple;
	bh=7h9LuxTJrut72uV+wvmSOUAuSy5k9aWr9HGp0vzU0lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3q4qoPgc1XRdNYg0OUwbdbG+TwhBPlL1vaSHtjlayp43ux2uSgKIwDAtgvgTAsAEoFNhH4lzw1qNBhc+a038MwlKdZKs+4JNdKPNyX+XWNfE7y8m37incF5ITmGKAebJYb75j7vXWPMQKVjFinX2+kTO/G9hgMAZ1ZuB579CfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a264305ac0so715838a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 14:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712091891; x=1712696691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6fASJHkKcduj2fwMPdtWJfgZlomtoLp01vXC0KU6ws=;
        b=mHDA6OaKvPaOq4M4ZHvG8djoTvMdTbw3jrNe0JSXI1sR4igPwYGnW//Ip6IV3ltCyY
         X4dNaG3pDfQO+7I3DlXZxBXOmdUvcPyJazn/SK/bOTc4yDz6RxaJ3h5//qCjLHH371Wg
         gh53VBY4C2kATn6nHLY0dTxKOvf3iyjcsyKaEPyCj5Oz5e3g+tV4++6Zvj1dduAOm1yF
         6OLHaCYpT96qWSkg+yObvEDkNAou/S8Y0ZtRi6VMGzhdn/QUdIKK/5zJ6ubmDwxgwICs
         LI2Q87klgLXOGQWbCAvbwyVsk2+bGhsioiTvEgcmWA3K9aooJVpBoe0tkZAEgsOTt6o9
         MDiQ==
X-Gm-Message-State: AOJu0YwcPWTK41Ad8ltgi6ZYRUnSBPgAQ+Cga2NtA62ugoZksXonIAvi
	FnDoN1HSTvSv/sXGEU08tZfQjkzeDVwvmxYbV7hYHYvxdwGIffLooSF9nU1ribfnvQn2LCriLtL
	bjo8ljjbE+TP/YUtY6t3s2InxdZE=
X-Google-Smtp-Source: AGHT+IHgl/vlYMG+karekX+IXZcqgzf9vCUrDKDoveJC1Pd+j/BdYZiBCcietlj3NbKoRg/GgmJdmcgrnhFNQgO8Vk0=
X-Received: by 2002:a17:90a:d318:b0:2a0:7895:f35c with SMTP id
 p24-20020a17090ad31800b002a07895f35cmr10188357pju.7.1712091891008; Tue, 02
 Apr 2024 14:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfybkuM8DKsdX_yO@x1>
In-Reply-To: <ZfybkuM8DKsdX_yO@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 2 Apr 2024 14:04:39 -0700
Message-ID: <CAM9d7cjSN6M4VvKRifwQ=bpvbc92pLoghnjCwWiOE7SFSzXWRg@mail.gmail.com>
Subject: Re: [PATCH fyi 1/1] perf trace beauty: Sync linux/vhost.h with the
 kernel sources
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 1:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> tldr; Just FYI, I'm carrying this on the perf tools tree.

Have you applied this to perf-tools-next?

>
> Full explanation:
>
> There used to be no copies, with tools/ code using kernel headers
> directly. From time to time tools/perf/ broke due to legitimate kernel
> hacking. At some point Linus complained about such direct usage. Then we
> adopted the current model.
>
> The way these headers are used in perf are not restricted to just
> including them to compile something.
>
> There are sometimes used in scripts that convert defines into string
> tables, etc, so some change may break one of these scripts, or new MSRs
> may use some different #define pattern, etc.
>
> E.g.:
>
>   $ ls -1 tools/perf/trace/beauty/*.sh | head -5
>   tools/perf/trace/beauty/arch_errno_names.sh
>   tools/perf/trace/beauty/drm_ioctl.sh
>   tools/perf/trace/beauty/fadvise.sh
>   tools/perf/trace/beauty/fsconfig.sh
>   tools/perf/trace/beauty/fsmount.sh
>   $
>   $ tools/perf/trace/beauty/fadvise.sh
>   static const char *fadvise_advices[] =3D {
>         [0] =3D "NORMAL",
>         [1] =3D "RANDOM",
>         [2] =3D "SEQUENTIAL",
>         [3] =3D "WILLNEED",
>         [4] =3D "DONTNEED",
>         [5] =3D "NOREUSE",
>   };
>   $
>
> The tools/perf/check-headers.sh script, part of the tools/ build
> process, points out changes in the original files.
>
> So its important not to touch the copies in tools/ when doing changes in
> the original kernel headers, that will be done later, when
> check-headers.sh inform about the change to the perf tools hackers.
>
> To get the changes in:
>
>   1496c47065f9f841 ("vhost-vdpa: uapi to support reporting per vq size")
>
> To pick up these changes and support them:
>
>   $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
>   $ cp include/uapi/linux/vhost.h tools/perf/trace/beauty/include/uapi/li=
nux/vhost.h
>   $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
>   $ diff -u before after
>   --- before    2024-03-21 17:33:58.878173388 -0300
>   +++ after     2024-03-21 17:34:07.687563333 -0300
>   @@ -49,6 +49,7 @@
>         [0x7B] =3D "VDPA_GET_VRING_GROUP",
>         [0x7F] =3D "VDPA_GET_VRING_DESC_GROUP",
>         [0x80] =3D "VDPA_GET_VQS_COUNT",
>   +     [0x80] =3D "VDPA_GET_VRING_SIZE",

This gives me a build error:

  CC      trace/beauty/ioctl.o
In file included from trace/beauty/ioctl.c:93:
linux/tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:
   In function =E2=80=98ioctl__scnprintf_vhost_virtio_cmd=E2=80=99:
linux/tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:53=
:18:
   error: initialized field overwritten [-Werror=3Doverride-init]
   53 |         [0x80] =3D "VDPA_GET_VRING_SIZE",
      |                  ^~~~~~~~~~~~~~~~~~~~~
linux/tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:53=
:18:
   note: (near initialization for =E2=80=98vhost_virtio_ioctl_read_cmds[128=
]=E2=80=99)

Because there are two entries for 0x80 now.

Is it ok for vhost to have the same number for VQS_COUNT
and VRING_SIZE?

Thanks,
Namhyung


>         [0x81] =3D "VDPA_GET_GROUP_NUM",
>         [0x8] =3D "NEW_WORKER",
>    };
>   $
>
> For instance, see how those 'cmd' ioctl arguments get translated, now
> VDPA_GET_VRING_SIZE will be as well.
>
>   # perf trace -a -e ioctl --max-events=3D10
>        0.000 ( 0.011 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSY=
NC, arg: 0x1)                   =3D 0
>       21.353 ( 0.014 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSY=
NC, arg: 0x1)                   =3D 0
>       25.766 ( 0.014 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IR=
Q_WAIT, arg: 0x7ffe4a22c740)    =3D 0
>       25.845 ( 0.034 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915=
_IRQ_EMIT, arg: 0x7fd43915dc70) =3D 0
>       25.916 ( 0.011 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADD=
FB2, arg: 0x7ffe4a22c8a0)       =3D 0
>       25.941 ( 0.025 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ATO=
MIC, arg: 0x7ffe4a22c840)       =3D 0
>       32.915 ( 0.009 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_RMF=
B, arg: 0x7ffe4a22cf9c)         =3D 0
>       42.522 ( 0.013 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IR=
Q_WAIT, arg: 0x7ffe4a22c740)    =3D 0
>       42.579 ( 0.031 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915=
_IRQ_EMIT, arg: 0x7fd43915dc70) =3D 0
>       42.644 ( 0.010 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADD=
FB2, arg: 0x7ffe4a22c8a0)       =3D 0
>   #
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Zhu Lingshan <lingshan.zhu@intel.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/trace/beauty/include/uapi/linux/vhost.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/p=
erf/trace/beauty/include/uapi/linux/vhost.h
> index 649560c685f13b73..bea6973906134656 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> @@ -227,4 +227,11 @@
>   */
>  #define VHOST_VDPA_GET_VRING_DESC_GROUP        _IOWR(VHOST_VIRTIO, 0x7F,=
       \
>                                               struct vhost_vring_state)
> +
> +/* Get the queue size of a specific virtqueue.
> + * userspace set the vring index in vhost_vring_state.index
> + * kernel set the queue size in vhost_vring_state.num
> + */
> +#define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x80,       \
> +                                             struct vhost_vring_state)
>  #endif
> --
> 2.44.0
>

