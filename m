Return-Path: <linux-kernel+bounces-132255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F56899216
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BFCB211DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA02313C679;
	Thu,  4 Apr 2024 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmgz4EL6"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40625134418;
	Thu,  4 Apr 2024 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273039; cv=none; b=JlNQUWhgpv2Oxc89/3ZJqkahZdI7j/igBgJuFSyEWEVt3x7fXyr14FyDr5wZ/yoAeSLveq4T0ga25vLqobJcNqu2gZt9YytHCKOxNFPbeVA7bCoEjPrxOG0Vv4O7ATzqp7fchsbgPKeEXO912TeG5z4uF64sXDRmuyAyDsN04tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273039; c=relaxed/simple;
	bh=Do963hSdPrLX5zfMcrNn6SbYrENL0NCjWtgD8cm98Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ow5zyCK1HIpaAL3AXasXvCcp4rc9v11YbGbdCTsdh15aSq6/hI5D33vdL5ZYeVjrYtOhkh7lgA1w1oujCxc3DLn586A9ZSTwMOuIlA/ipm9AEI9WFlw6Xsq9FwKLjWFYQyeC3uuvn4dd7D8kx3M38xeh8pveRrtpnfsOyvDCn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmgz4EL6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4162aca8746so8000305e9.1;
        Thu, 04 Apr 2024 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712273035; x=1712877835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXnwmQPrl07FZAiqD50mf42e3pDAJdibA7+5v+qAN78=;
        b=gmgz4EL6/ZPvZ5Yhb+G4QxtHAhWjGLbn3SAmMLTUp1Kp8QDZuqhEv39zjg3ekORSGg
         Q3tnizMdq7UIHHgthc5GH6ADzInaYj80fzspJlX21IQCGLQsOiOzhmkp5nFO+moygwYo
         JuEt+3wT+JnF9zXHskwN+7/si/sW9/hNlR+rrFO1i2sXHdVZhgMVr9Zd0FSa6GppYrar
         JQVN+Cl730iMFMY62Fq2IqWzFGXa5sadyfmr4I6LwNZ9W+dyQfP5yHD3mA1bBpjyuDzJ
         JNW3faNP1gBmhBoKKxzUvJ+NYlZaZqlfeT6eg/d47a2xBA9yw++bhVwDvu7Cy30FQZjn
         y3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712273035; x=1712877835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXnwmQPrl07FZAiqD50mf42e3pDAJdibA7+5v+qAN78=;
        b=wn3/YWpkU0FJMOTgbpF+4YqplvJveYzrLTRTLVJMSqDKhyfehGlX6s5A0QNt3GeEXu
         +2IfMw5Jya2J2glpdlc+m4Q//nA4PceIm+lKxM/VfqarlHMQbJaEsuxYUIVQqKh7fwSr
         dlJc7QR60KooWd5v9w0dQvZOqIjNv4NFyv77Kto9WvRKjG5hu7IDaJDhk9DHL7AfC+Cj
         p9AM77WCCx33gZP56++fdc5RTCE9JsBtZJ28Y4AnIBw/Z55qs+b1U6UeIz0WGPNtaYQ8
         AfetziDIH/P459J7KIEDQF/A/04tJVXIYHStc+PITeq5prHZeU3oqfcxaq62YfhATFnF
         81Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXEuWOiNM92JyRmXkVqWYlxQahc1pYaopXnYhZc69ftUEhe8Bl7kUl2dtkuWqmxxTkswGrRtPLi2GzQ1uQtHEHbEjbf417b1Nb0oyMHxcqHjecb9M9qnTRGi5Yj7pdKaV19Xml+akl11Bd+rHbjlbwehtBzLoHJzprAh1wS/VPi602HSGv9P60bL6BmB0C4NtG0JSvir1T/ldm4TUqRtKVs
X-Gm-Message-State: AOJu0YykxXiHNkkDM5sPalsEnbHGiC5j+fj8M5ci/XyQ+WE+//r9vZ8o
	9iKbtq2cmM/aQA+U6VNkXh+zWSzShkEjCBzkRWnajNBnrFfsmPgz96MOTHcbLih722sxtRxoNCN
	XwgGxLPV/ovKmEl1JxDd2EDz2tQc=
X-Google-Smtp-Source: AGHT+IELDycs8Tmz4kVIWaOz90pVFimzN/8PHU3NEjxswWqigqc6Fh/8ut+n0sVFLjVwXD8RlCLctsIME6xMLay3jPc=
X-Received: by 2002:a05:600c:3b08:b0:414:12f6:a105 with SMTP id
 m8-20020a05600c3b0800b0041412f6a105mr2948928wms.5.1712273035487; Thu, 04 Apr
 2024 16:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404190146.1898103-1-elver@google.com>
In-Reply-To: <20240404190146.1898103-1-elver@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 16:23:44 -0700
Message-ID: <CAADnVQKc+Z39k9wbU2MHf-fPFma+9QsyOugmmmGq3ynQCTVfCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_probe_write_user_registered()
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:02=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> With all the known caveats, tracing BPF programs may directly write to
> user-space memory with the bpf_probe_write_user() helper. Memory safety
> is an obvious problem when using this helper, since it is too easy to
> overwrite memory across all running processes that user space did not
> expect to be touched (neither the verifier nor the kernel knows what may
> be touched). While it is possible to come up with mechanisms to safely
> communicate to the BPF program which memory region may be written to,
> there are no built-in guarantees of safety. For this reason, the helper
> produces a warning in the kernel log, and in newer kernels it is
> possible to disallow use of the helper since 51e1bb9eeaf7 ("bpf: Add
> lockdown check for probe_write_user helper").

So is it a fix or a feature?

> Nevertheless, direct user-space memory writes from BPF programs can be
> useful to efficiently manipulate and communicate with cooperating user
> space processes.

But there are many different ways for bpf to communicate with user space:
perf ringbuf, bpf ringbug, various maps including mmap-ed array and arena.
The commit log doesn't explain why we need another one.

> For example, one of our use cases are for events that happen relatively
> frequently in the kernel (e.g. specific scheduler events), but a set of
> user space threads want to check for such events in very hot code paths
> to make more optimal decisions (the cost of such a check can be no more
> than a load and compare). The types of events and heuristics used may
> change based on system environment and application, and a BPF program
> provides the best trade-offs in terms of performance and deployment.

and the tasks can use mmaped array shared across all or unique to each
process.
And both bpf and user space can read/write them with a single instruction.

>
> To achieve better safety, introduce tagged user writable regions, that
> must explicitly be registered before tracing BPF programs may use them:
>
>  1. The prctl() option PR_BPF_REGISTER_WRITABLE allows any user space
>     process (that is allowed to use prctl()) to register tagged writable
>     memory regions for the current thread.
>
>  2. Conversely, the prctl() option PR_BPF_UNREGISTER_WRITABLE allows a
>     user space process to unregister a writable memory region that was
>     previously registered from the current thread. This must be done
>     before freeing memory if the thread that registered a region is
>     still running.
>
>  3. Tracing BPF programs may write to any registered region in the
>     current thread with bpf_probe_write_user_registered(). If the memory
>     region has been tagged with a non-zero value, the BPF program must
>     provide a matching tag.
>
> Admin capabilities are still required to attach BPF programs that use
> the new bpf_probe_write_user_registered() helper.

We stopped adding new helpers ~2 years ago.
Only new kfuncs are allowed.

>
> With this interface, user space threads are guaranteed that no writes
> happen to regions that they did not explicitly register. Tagging can be
> used to associate additional semantics with the memory region.
>
> A note on tag allocation: Since such programs can only be installed by
> the local system administrator, tag allocation may be done by the system
> administrator. For example, by providing headers with tag definitions,
> or a central service to distribute tags to the BPF program loader and to
> user applications.

Not clear how that's achieved in practice.
To do prctl(REGSISTER, ... tag)
the process will just pass this u32 tag.
There is no way for the admin or other process to enforce certain
tag usage.
Since there is no way to enforce extra tag seems like a weak
protection against something? What in particular?

