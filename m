Return-Path: <linux-kernel+bounces-128727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3354895EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0EEB291D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6CB15E5BE;
	Tue,  2 Apr 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qw40s9/b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141B15E1F5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093030; cv=none; b=remqdvZkfRGoSbb+dyHvav2RMfTPyjsj9FWwnwZ/Thlp5aojl4wXDTpdT7DLk2sGXmjP2aHEHI0ZfIkb2xDOWfktSmhF2o/5C4x19pLAe+fB1D0IlNZ7OpL6Ko+P8JHzSqVx19QqglhIBAWQ3cH6JcWAwymjkX6IecPG3v8QTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093030; c=relaxed/simple;
	bh=3LK6BSSSZXPvfQ5gKh7pcQDJMzVxdZHlpkniJicNZyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxLpr0gLYR451zV2IA8/etCLgmeFZCzA3bDxLdv53DNjCET83ZSi+jh/9xCjkkN+yNRJOovIF0ozRy91URYqdOWLd9kQXPvlZsQpgapcbVwJ/3fBw2IIR8LuP/O7KZ79OxAUZe1FssnwGyvg8yc7ShYyVOmujy6VaJioijix4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qw40s9/b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712093027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sHMZ5ZfjDlzhuCc8wxpi09Fy7l7fXAvEFvPzhQUXtRs=;
	b=Qw40s9/bQJuBcYOvVKhYeZnfxn8Ax8Lcu8I4an+tQ92w/fYau18Y4V461p+1xfCHxDRg5c
	2GFu1hYTKDwvGvB3SE4KhFKIaaK8ydaMPNYmq0W4ZvHnKzDdRCukKi+paHv5s/qAfebcZH
	FkQ0MqnU94dGvqeJxiaSJwVbTq2TZRQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-0o7nbL4QPwqyIizc-gfOaQ-1; Tue, 02 Apr 2024 17:23:46 -0400
X-MC-Unique: 0o7nbL4QPwqyIizc-gfOaQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4751d1e7a2so210107866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 14:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093025; x=1712697825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHMZ5ZfjDlzhuCc8wxpi09Fy7l7fXAvEFvPzhQUXtRs=;
        b=WMfq35zB1499gnunucXFOq3bYOnVr2p7EsanH5n7JMT0FUV4WI9Bhg9QPZvuOjR5Xo
         XoGcOJmFTmj6jyyJ5VQTdF8g29p6f4zacHc0D3+FIiQCsT75osH6uG+Bfn5BjzV7Wlpq
         C0THnL5z3r36iUwJOpacGa4gAHIOP7kJ0plCk96Ock3nISiiQpVRzAzKooVq7trvFGxk
         C7BqmNXlQXjWBRGsYn/zgBphkjpTb/sDT9VtA4goumTUpeT3cQmD/MTS5OHjbjtfKHlc
         DNm4NafTOL+bHWIqD3gfOQ8quW833i0b/ESyic19LkCnItqnwK56Jk45816w8l86uguL
         NHWQ==
X-Gm-Message-State: AOJu0YzGmFzAihwoX7ff9ud/AsHuPjRG/uThW4YlDgzOS1D/Ojm34z8q
	LtrAKWtaNBZLwoGRs338Ba2FNqfvuNlm3WC6oGmszYxFPzdb1/KUVXCvZMujv5D1id0QXO2f9p9
	KsC1+X405I+EdWNqFdGZssOOeAH/UO6OqOIZk7KMybqpTThzzrxjbpytLdCridg==
X-Received: by 2002:a17:907:7216:b0:a47:34b2:ca4b with SMTP id dr22-20020a170907721600b00a4734b2ca4bmr12327336ejc.50.1712093024798;
        Tue, 02 Apr 2024 14:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGULpRIdIbK84GHy/2/ll7SdIhtU9wnGMuoqs/sHVNvE3CjrQ4KprMkJlpjjf3lAtTu+69Nug==
X-Received: by 2002:a17:907:7216:b0:a47:34b2:ca4b with SMTP id dr22-20020a170907721600b00a4734b2ca4bmr12327323ejc.50.1712093024199;
        Tue, 02 Apr 2024 14:23:44 -0700 (PDT)
Received: from redhat.com ([2.52.21.244])
        by smtp.gmail.com with ESMTPSA id pk26-20020a170906d7ba00b00a46aafc6948sm6915889ejb.74.2024.04.02.14.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:23:43 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:23:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH fyi 1/1] perf trace beauty: Sync linux/vhost.h with the
 kernel sources
Message-ID: <20240402172151-mutt-send-email-mst@kernel.org>
References: <ZfybkuM8DKsdX_yO@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfybkuM8DKsdX_yO@x1>

On Thu, Mar 21, 2024 at 05:41:54PM -0300, Arnaldo Carvalho de Melo wrote:
> tldr; Just FYI, I'm carrying this on the perf tools tree.
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
>   static const char *fadvise_advices[] = {
>         [0] = "NORMAL",
>         [1] = "RANDOM",
>         [2] = "SEQUENTIAL",
>         [3] = "WILLNEED",
>         [4] = "DONTNEED",
>         [5] = "NOREUSE",
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
>   $ cp include/uapi/linux/vhost.h tools/perf/trace/beauty/include/uapi/linux/vhost.h
>   $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
>   $ diff -u before after
>   --- before	2024-03-21 17:33:58.878173388 -0300
>   +++ after	2024-03-21 17:34:07.687563333 -0300
>   @@ -49,6 +49,7 @@
>    	[0x7B] = "VDPA_GET_VRING_GROUP",
>    	[0x7F] = "VDPA_GET_VRING_DESC_GROUP",
>    	[0x80] = "VDPA_GET_VQS_COUNT",
>   +	[0x80] = "VDPA_GET_VRING_SIZE",
>    	[0x81] = "VDPA_GET_GROUP_NUM",
>    	[0x8] = "NEW_WORKER",
>    };
>   $
> 
> For instance, see how those 'cmd' ioctl arguments get translated, now
> VDPA_GET_VRING_SIZE will be as well.
> 
>   # perf trace -a -e ioctl --max-events=10
>        0.000 ( 0.011 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                   = 0
>       21.353 ( 0.014 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                   = 0
>       25.766 ( 0.014 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)    = 0
>       25.845 ( 0.034 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70) = 0
>       25.916 ( 0.011 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)       = 0
>       25.941 ( 0.025 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ATOMIC, arg: 0x7ffe4a22c840)       = 0
>       32.915 ( 0.009 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_RMFB, arg: 0x7ffe4a22cf9c)         = 0
>       42.522 ( 0.013 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)    = 0
>       42.579 ( 0.031 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70) = 0
>       42.644 ( 0.010 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)       = 0
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


Thanks a lot for taking care of this! So given the header is actually
buggy pls hang on to this change until I merge the fix for the header
(you were CC'd on the patch).
It's great we have this redundancy which allowed us to catch the bug
in time, and many thanks to Namhyung Kim for reporting the issue!


> ---
>  tools/perf/trace/beauty/include/uapi/linux/vhost.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> index 649560c685f13b73..bea6973906134656 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> @@ -227,4 +227,11 @@
>   */
>  #define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
>  					      struct vhost_vring_state)
> +
> +/* Get the queue size of a specific virtqueue.
> + * userspace set the vring index in vhost_vring_state.index
> + * kernel set the queue size in vhost_vring_state.num
> + */
> +#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x80,	\
> +					      struct vhost_vring_state)
>  #endif
> -- 
> 2.44.0


