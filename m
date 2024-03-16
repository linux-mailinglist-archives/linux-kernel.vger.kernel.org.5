Return-Path: <linux-kernel+bounces-105267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AE887DB38
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2768328195E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA44F1BF58;
	Sat, 16 Mar 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KQGi3bnv"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0591172C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710613107; cv=none; b=e4YdOfHnQhGukDNKB8Ae6uPBwitArCGDfYFXwy8y2VwCCpDms166yHj72uusLH9CWDTymnH8qeCv/GQ4ewhGsT6VybA5g7gWHjQu0ym53dsUEzRlIgx1iqB3s7pBvZ3riIJSACcLsyMRQGUcvjlrHLEEJ7CgQArBvRTHJc8IwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710613107; c=relaxed/simple;
	bh=pgebCKvCkwVomojS5FqT6Lrc12uxNPn160ZOqqBbiGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQc4oaGjvhPnSNis0TDLGyXFX2u5Z/75uzfI9Hl5GttRbvt3FwX2nq+lokluwkJzT73ZsXM8f7K4nzQTY3vNES4V37rjiNm80cU29JxwUDeqAd0wWlImtuiTIq0X96YDo88GakNDvQEjM5boYJSCo9j2JQ3FXDqqcbiLj0/GZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KQGi3bnv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466f89560eso397385466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710613102; x=1711217902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLpXkDAYjPG9BCm6FpcnxRIHT0mGwTq8E0HFcJCyd5o=;
        b=KQGi3bnv/IsQ8N/f/eueqLSnkDAZOlZH0NgdiTg9avuqeMYVCBYVnyCBs5pr/elEH6
         G9wju4eOGie7xE+MSTDdy2gBzaoHKynnllDv1E+FE5PkuXrg3CzeKXasTiHBVGg3964C
         udhzhscTesiasIOZkHDsxog1U1HNIQsMw7q5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710613102; x=1711217902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLpXkDAYjPG9BCm6FpcnxRIHT0mGwTq8E0HFcJCyd5o=;
        b=Wm0SZA7UrmC0HtMDKmcAV3lnJQA+sv8iyw6PwIv9cEIzhE825mtZAErMKyLxoQUnM4
         XUhsLb5u7blZQ1AkgtjF2T1WWDio/FghCqAOznEuQ+gr7WCihJ7pKMPn758jcq2sdLtN
         1c3E3EUq8hfl1mTXh+hOGvc/mt3fifWTEUgwAyfVcz7qYVJZYn6Zb8ZLfxHx2Kkg4Q8m
         S3UpvymN4FTszi8pjjmmekZuGgrQPH/Nev+igjXrfjXvKEDniZ3uFQDkSfj+RMaPFyFg
         7Xi9zrbxzMkmWBFTckd5x5gNYd1QrfgTLIJYQ/fiwNqBewa4w71YuPIoxrjLwGFPo71Z
         SbKA==
X-Gm-Message-State: AOJu0YzRiHwVkyT1XNLAsG5cOwLIy7EjieUJoL76xvGmc1ZK3v/W74yy
	eHULT7JAMXh38jH6t89Lnt6hTxSKRT96kGTzyN+0zPzYJLlv7w5pfZzx0Xy5fuOWdWVzIR9PrVp
	PfkH+sQ==
X-Google-Smtp-Source: AGHT+IF/3EfmCMn30FKHVVBiLPcicicSrBq6H+Psd/P6MQ3R9vIbxosV3kNP4r+S0wOeaH2P75aWrw==
X-Received: by 2002:a17:907:86ab:b0:a46:ac10:1cde with SMTP id qa43-20020a17090786ab00b00a46ac101cdemr1040731ejc.45.1710613102412;
        Sat, 16 Mar 2024 11:18:22 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090612c800b00a46aab70226sm627515ejb.180.2024.03.16.11.18.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 11:18:19 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so4434566a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:18:19 -0700 (PDT)
X-Received: by 2002:a17:906:30cd:b0:a46:4e14:c9fd with SMTP id
 b13-20020a17090630cd00b00a464e14c9fdmr5264463ejb.23.1710613098865; Sat, 16
 Mar 2024 11:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315122934.1d3231ce@gandalf.local.home> <CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
 <CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
In-Reply-To: <CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Mar 2024 11:18:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0g7YN7htrhQ7GNRbRb5+WtMJv8MuoqBJhY6iARD7E9Q@mail.gmail.com>
Message-ID: <CAHk-=wg0g7YN7htrhQ7GNRbRb5+WtMJv8MuoqBJhY6iARD7E9Q@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, 
	John Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort <vdonnefort@google.com>, 
	linke li <lilinke99@qq.com>, Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 09:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  - I'd suggest marking it all VM_DONTCOPY | VM_IO | VM_DONTEXPAND to
> not let people play games with the mapping.

You already did set VM_DONTCOPY (and VM_DONTDUMP is a good idea too).
And you cleared VM_MAYWRITE. Those are all good.

I'd also suggest requiring the mma[ to be MAP_SHARED.

With a read-only mapping, that doesn't really do all that much, but I
don't think you actually need the vm_ops at all once you do everything
at mmap() time, and then it causes a SIGBUS instead of a "insert zero
page".

And _technically_ it could tell the architecture code to try to align
the mapping to the cache aliasing boundaries.

Of course, because of how you insert the meta-page at the beginning of
the mapping, you end up with the actual page table entries not aligned
anyway, so it doesn't actually help the cache coloring, but it's still
conceptually the right thing to do. So even if it ends up mostly just
a "document the fact that these are shared with the kernel" flag, I
think it's a good idea.

               Linus

