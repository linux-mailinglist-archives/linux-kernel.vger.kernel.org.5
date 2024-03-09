Return-Path: <linux-kernel+bounces-98035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647B58773E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF8E281AF7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBEC4594C;
	Sat,  9 Mar 2024 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A81inLTu"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2222F07
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710016855; cv=none; b=A8f5uL668zJjVIObLXHbz/v36jONS2dITK+5oZn742UxZddQkory4qjxis5WynYB4wMijZW0JhbHPqvAPRPV9zlU1li/cWk+JJcpfkhGndcX4BDi1WsNq/71Rc7gQGDhtf/9ptwzXDbQOb2TbJ8puPKcFA8EMhWCsRoV0WxRLwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710016855; c=relaxed/simple;
	bh=uE50W8MUy4lSTRYg4NWhzIY/9N5XBckWRq+A+J3xEsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU+KVlVNQU3nR682EPoGTAtPoKIfygLIxUVNfPqNYc5CIhaua+F9ciwB91PmE1CgmwtUCm3t4sO0XeV4X67ncxshzGzUfEYp2vTznMQIFXkvfiRKJk96B3y8QffDSsMhkNigoCISAXI6nyqsTzaXusFBgFChGAeZ4LMPiBs0tC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A81inLTu; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e510bd228fso755788a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 12:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710016853; x=1710621653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tscT2usgPffMVegTTqmjfELkm+wIQF6i7UxyEnNlDB8=;
        b=A81inLTu9O0JRGj9yH6+ls4wHeiBTAedT6gVLKCjkN1LPr3rsOCxufCxoYHx6iY3Tc
         f7GNfiFoA4FHRT1iUBH6Cw3D0qsIta5vIy8nRMVYVumTsWFbBAXAnOhREw6jUJLY9rCJ
         lVQWT+qm7xQbXk6wG9U1jEt82gLRPGO6Ptcv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710016853; x=1710621653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tscT2usgPffMVegTTqmjfELkm+wIQF6i7UxyEnNlDB8=;
        b=xE34ooomwpdKkcZ2dJaF8KyniaD3juEzcbj+41sjYAc9YljQmFs3Mo1xdEwAp3KU1d
         6IC9evbdrcR6i0JLqv18Y7RP63jseSkjli2LTL0S3mUnJI/spW5poqfyzvewgEJJbxrt
         uScM8nf4XTZPYDgTAaIS1djL2SrKZAF+57YsjE6SelwhmenfCoofoxFhycPgun0cn2tO
         BbWwXXbk+Wy6wOu/xmsqPw9AXA1vqaYjWlTk9f0w752XVWRw5/BRIggFfAqHffCbFHTe
         RRaVeYwqAYFVUCMuJfLTkIwad7qoD7zHPMJLZ8+qYv67aV7G3OjyEhmFLoCxDI4vQhfE
         0Qpw==
X-Gm-Message-State: AOJu0YzZ+hRRHZfnmUuwMIVNaBJB/lL9TUOwqKPS5R8l0THQrAgejfKA
	0we6H1/rE5oLYQEICYqKuEKU3LDYNN9Wlwu0KfOy8q442XFPVbeEUwMJ6RGf6g==
X-Google-Smtp-Source: AGHT+IF7Luizf7uSrZ2SAOviO1ISARKjfHr7TfzwMsR7uciQGcduXiH2Ic34WPKwRdGdLC5UYxSUoQ==
X-Received: by 2002:a9d:5a05:0:b0:6e5:21f0:d028 with SMTP id v5-20020a9d5a05000000b006e521f0d028mr1375411oth.28.1710016852854;
        Sat, 09 Mar 2024 12:40:52 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902c40800b001dca9b21267sm1688698plk.186.2024.03.09.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 12:40:52 -0800 (PST)
Date: Sat, 9 Mar 2024 12:40:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, suleiman@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Youssef Esmat <youssefesmat@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/8] tracing: Persistent traces across a reboot or crash
Message-ID: <202403091234.DE25C77028@keescook>
References: <20240306015910.766510873@goodmis.org>
 <202403091016.5CDF0E2EE@keescook>
 <20240309135116.40f65cee@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309135116.40f65cee@rorschach.local.home>

On Sat, Mar 09, 2024 at 01:51:16PM -0500, Steven Rostedt wrote:
> On Sat, 9 Mar 2024 10:27:47 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Tue, Mar 05, 2024 at 08:59:10PM -0500, Steven Rostedt wrote:
> > > This is a way to map a ring buffer instance across reboots.  
> > 
> > As mentioned on Fedi, check out the persistent storage subsystem
> > (pstore)[1]. It already does what you're starting to construct for RAM
> > backends (but also supports reed-solomon ECC), and supports several
> > other backends including EFI storage (which is default enabled on at
> > least Fedora[2]), block devices, etc. It has an existing mechanism for
> > handling reservations (including via device tree), and supports multiple
> > "frontends" including the Oops handler, console output, and even ftrace
> > which does per-cpu recording and event reconstruction (Joel wrote this
> > frontend).
> 
> Mathieu was telling me about the pmem infrastructure.

I use nvdimm to back my RAM backend testing with qemu so I can examine
the storage "externally":

RAM_SIZE=16384
NVDIMM_SIZE=200
MAX_SIZE=$(( RAM_SIZE + NVDIMM_SIZE ))
..
qemu-system-x86_64 \
	...
        -machine pc,nvdimm=on \
        -m ${RAM_SIZE}M,slots=2,maxmem=${MAX_SIZE}M \
        -object memory-backend-file,id=mem1,share=on,mem-path=$IMAGES/x86/nvdimm.img,size=${NVDIMM_SIZE}M,align=128M
\
        -device nvdimm,id=nvdimm1,memdev=mem1,label-size=1M \
	...
        -append 'console=uart,io,0x3f8,115200n8 loglevel=8 root=/dev/vda1 ro ramoops.mem_size=1048576 ramoops.ecc=1 ramoops.mem_address=0x440000000 ramoops.console_size=16384 ramoops.ftrace_size=16384 ramoops.pmsg_size=16384 ramoops.record_size=32768 panic=-1 init=/root/resume.sh '"$@"


The part I'd like to get wired up sanely is having pstore find the
nvdimm area automatically, but it never quite happened:
https://lore.kernel.org/lkml/CAGXu5jLtmb3qinZnX3rScUJLUFdf+pRDVPjy=CS4KUtW9tLHtw@mail.gmail.com/

> Thanks for the info. We use pstore on ChromeOS, but it is currently
> restricted to 1MB which is too small for the tracing buffers. From what
> I understand, it's also in a specific location where there's only 1MB
> available for contiguous memory.

That's the area that is specifically hardware backed with persistent
RAM.

> I'm looking at finding a way to get consistent memory outside that
> range. That's what I'll be doing next week ;-)
> 
> But this code was just to see if I could get a single contiguous range
> of memory mapped to ftrace, and this patch set does exactly that.

Well, please take a look at pstore. It should be able to do everything
you mention already; it just needs a way to define multiple regions if
you want to use an area outside of the persistent ram area defined by
Chrome OS's platform driver.

-Kees

-- 
Kees Cook

