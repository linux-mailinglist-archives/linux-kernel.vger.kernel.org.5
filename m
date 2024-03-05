Return-Path: <linux-kernel+bounces-92836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0258726AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A4C1C22CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B01B597;
	Tue,  5 Mar 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DVR+j9BP"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79317BBA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663844; cv=none; b=oQUPd2/89GnBGPIu2ebKRZGe6lJrhfVJT8JtYz+ulgxPhBVpXHSwkf2XQfwBi24LkJMXwxtoSaQ9fxSLRQZX1Nl7puJ28DaEIoN7H2y4Oh/b9ERJgQJi3k9mbsXc4X9gC1ywnaZrI+b0b67Jh3/9LZ4sOqJsKazHwGZov+HehPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663844; c=relaxed/simple;
	bh=5fF9Zt93l1sw5LdtE5rAlykL44jfpeE2DjNHNyT8Kto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aG/21VHB3YbRqkNlYaOk/K+a7GsHwfgxzmjTiDoXoIrEAy+pHtNess5mjPfmu5MZH3XyoSPGc+0nAk3C7l8pI5MyBmu0Hy9aTi8bdnuvciBIKiMRLxLm2ZHdMwsLC2/wsectVs8+iBz8KgjIUtMTBlMxMh1f09r6/JcX418jiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DVR+j9BP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dcc7f4717fso60122045ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 10:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709663842; x=1710268642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+a4npK3MsOrRQDl9PU2Ms+f3vwWs3ArwrgeaNqw4OUo=;
        b=DVR+j9BP6kqxSIciDH0FsuiY/lcZJrC29H1oqgyWwsU7ZUIX+OIlFFXDZcBJh7opBc
         YHiGz/o26rJyHwUqc++zJyGsqvI5eYLkGChRKgypTxjWt9KVnYGZulMJHxKkEFeY8mRe
         PGv0VXHDA50zBOXwzg09dRgFvyHDncUcIHFqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663842; x=1710268642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a4npK3MsOrRQDl9PU2Ms+f3vwWs3ArwrgeaNqw4OUo=;
        b=KCowyfSKxW9OBAapDUyFFDd5LRnLyzU8zWnybCchR6rMmyxWA6kvUvvsZVrdLXhkB7
         T/2z/3fHvmPnxrC0qTOFxOlCB251z0swy/xWcwRCFKt37drnG2trvHY0ZtmzTZbEqc3P
         Ucz+V5C7zDgClAVjAKvLsIWYp//eFcH0PokyVVOhXmmZxnrTBVwJhgb+Z2U8y7w20RWK
         EnlfOkUEJpQXfV4YiCQmSCzJEmvCfyEfWCxFUw5oLmcJCdo4fGRjqDzWW6+2k9GY3q+N
         TBOCIFHjhr5fsHapYjc7kVRR+rJmHFzUFbmO2tOJpbVA4idLlnVLXFPrJgqvBNDMZ6TA
         XQlg==
X-Forwarded-Encrypted: i=1; AJvYcCXW1oEDQXu/wxCg3LJPflz3VKC2nYaoI/D5xZuQ6RFuirctwanRU/Ij4BsI37OzBrYzv6gRBJb5XZ3gLHvleyIyGicTpN6gmSgxqyPx
X-Gm-Message-State: AOJu0Yz6HahfNmTv/sjdaKAbvdyeLrTu31tfPoyf0gTz7EvJ2sY63inX
	KvpzMlbF3hy2krzEYeSZbnF3sz1OeOajDd7H4n5+WnIB0d7hRDZaII4PaMd82g==
X-Google-Smtp-Source: AGHT+IHDWHoXuLIFlbxBpZaNECWt4rX2fhzwHIpZw+LJxcfzi63h9uZSaiPhb/LOSL6sAW7ZN4mKcw==
X-Received: by 2002:a17:902:da8d:b0:1db:8555:55b1 with SMTP id j13-20020a170902da8d00b001db855555b1mr3109224plx.37.1709663841973;
        Tue, 05 Mar 2024 10:37:21 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001d54b763995sm10842713plh.129.2024.03.05.10.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:37:21 -0800 (PST)
Date: Tue, 5 Mar 2024 10:37:20 -0800
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org, kernel@collabora.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <202403051033.9527DD75@keescook>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
 <202403050134.784D787337@keescook>
 <20240305-kontakt-ticken-77fc8f02be1d@brauner>
 <202403050211.86A44769@keescook>
 <20240305-brotkrumen-vorbild-9709ce924d25@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-brotkrumen-vorbild-9709ce924d25@brauner>

On Tue, Mar 05, 2024 at 11:32:04AM +0100, Christian Brauner wrote:
> On Tue, Mar 05, 2024 at 02:12:26AM -0800, Kees Cook wrote:
> > On Tue, Mar 05, 2024 at 10:58:25AM +0100, Christian Brauner wrote:
> > > Since the write handler for /proc/<pid>/mem does raise FOLL_FORCE
> > > unconditionally it likely would implicitly. But I'm not familiar enough
> > > with FOLL_FORCE to say for sure.
> > 
> > I should phrase the question better. :) Is the supervisor writing into
> > read-only regions of the child process?
> 
> Hm... I suspect we don't. Let's take two concrete examples so you can
> tell me.
> 
> Incus intercepts the sysinfo() syscall. It prepares a struct sysinfo
> with cgroup aware values for the supervised process and then does:
> 
> unix.Pwrite(siov.memFd, &sysinfo, sizeof(struct sysinfo), seccomp_data.args[0]))
> 
> It also intercepts some bpf system calls attaching bpf programs for the
> caller. If that fails we update the log buffer for the supervised
> process:
> 
> union bpf_attr attr = {}, new_attr = {};
> 
> // read struct bpf_attr from mem_fd
> ret = pread(mem_fd, &attr, attr_len, req->data.args[1]);
> if (ret < 0)
>         return -errno;
> 
> // Do stuff with attr. Stuff fails. Update log buffer for supervised process:
> if ((new_attr.log_size) > 0 && (pwrite(mem_fd, new_attr.log_buf, new_attr.log_size, attr.log_buf) != new_attr.log_size))

This is almost certainly in writable memory (either stack or .data).

> But I'm not sure if there are other use-cases that would require this.

Maybe this option needs to be per-process (like no_new_privs), and with
a few access levels:

- as things are now
- no FOLL_FORCE unless by ptracer
- no writes unless by ptracer
- no FOLL_FORCE ever
- no writes ever
- no reads unless by ptracer
- no reads ever

Which feels more like 3 toggles: read, write, FOLL_FORCE. Each set to
"DAC", "ptracer", and "none"?

-- 
Kees Cook

