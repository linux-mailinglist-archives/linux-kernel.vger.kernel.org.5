Return-Path: <linux-kernel+bounces-98006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC11087733C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1B8281EF0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29D2D03B;
	Sat,  9 Mar 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ilo0nbVK"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC9922F1E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008872; cv=none; b=FXob4pKatec7MsvHUVAMdAElJOLTDgkOa/n+UoUz8ii7adlRE8uC0L6kJbNXaWc12JG6efFUOT3f7iPQ8/cmHjmzXsMLwaeqVjylklTvehNRANEIJkBnqkLnR26E37suuCp8peVXYnh8JIzgNKK0sKyITrsYsFUwXAwuJS2s2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008872; c=relaxed/simple;
	bh=UT5UKKqI3JhatKWw06rgyLOKL/bMTE4lGB3wDOzIlP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvbUnDS6mceGAMySDiWw5czCp5Bq3PoHDH2PidqBmEXbKP02CxNWpcbFhsbYQRLmfWC7SQKqV1IFPy19XvCfJaczt+SLG64BCz+wmzZndFK3cB8NI+9ZLMgoh8eW/unLR0EE/UhedDhNsgqTDaMHGZpCMMrVTAUfZiTxJfYnOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ilo0nbVK; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-220ef791617so1107643fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 10:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710008870; x=1710613670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hdmVQAZZGFR9Y18bB9O0i3U2pUIXff4YlnZ+QydkXI=;
        b=Ilo0nbVKaMgoPimYFUPUTfmB5+Q6mcFnwTqARkJncMFbkIeDo6mY6Q8q8QpU5WZf0w
         dtZ7wu4/o9JHofT2njqlIqNpxSg73aV9/NESKgwZVCeMDYdnnVZBxjGlSU/yfrbR354v
         bzVd3AxHGSH5lMGYrsvGhBqu6Q0EfnZwv0cI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710008870; x=1710613670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hdmVQAZZGFR9Y18bB9O0i3U2pUIXff4YlnZ+QydkXI=;
        b=Hpj0ovmpUSWBE8UDsb6VPJIQS6pijlkJBW5imjCHvCynqJKEDM7IHt9j/jRjXWmZ3h
         ykDA3BGejRs5U6BK3RHBY5z9iGyh/pU73FIOGF26fUidsJ6IasCWQG9AJtpaXxesPweT
         JwBh5BReKzSN9VMoRnwLDIDHaPHqeyZSqysQZr2fFr2fUfDyVelRAv553EvKlY336SiT
         j03ihn/JuN0BxErBIB7NrJJLc10QOpuWMCHU47X/tckV9OcnQqCOXNGx8fQY37x7VcCv
         bH4z6ZMkYKKwkwmzIt/5UmvojqpA0HA4BroUOR2T/7ZJBdat7DrRSH2M730M3L0tPciC
         NI1Q==
X-Gm-Message-State: AOJu0YwA/qCKL7NRIxcm+L9Ro2Phk0Qppcx2kTtYVmErzhIMy3N6Jvuf
	o0iEo592cbvWa1x+xjodpemvqnZ67QZ6mK/K73jA3dywDDZJYIzp7xqalnUGHg==
X-Google-Smtp-Source: AGHT+IGxZtzWNivFdgVHDWpNlpQ/lu01OgPXiVw7KzUnwX4jEYkkp7/lm9ChhLTcVqG+wSVYRXtNNg==
X-Received: by 2002:a05:6870:a68f:b0:21e:459a:1fb6 with SMTP id i15-20020a056870a68f00b0021e459a1fb6mr2614600oam.23.1710008869899;
        Sat, 09 Mar 2024 10:27:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a28-20020a62d41c000000b006e537e90f91sm1588802pfh.131.2024.03.09.10.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 10:27:48 -0800 (PST)
Date: Sat, 9 Mar 2024 10:27:47 -0800
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
Message-ID: <202403091016.5CDF0E2EE@keescook>
References: <20240306015910.766510873@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306015910.766510873@goodmis.org>

On Tue, Mar 05, 2024 at 08:59:10PM -0500, Steven Rostedt wrote:
> This is a way to map a ring buffer instance across reboots.

As mentioned on Fedi, check out the persistent storage subsystem
(pstore)[1]. It already does what you're starting to construct for RAM
backends (but also supports reed-solomon ECC), and supports several
other backends including EFI storage (which is default enabled on at
least Fedora[2]), block devices, etc. It has an existing mechanism for
handling reservations (including via device tree), and supports multiple
"frontends" including the Oops handler, console output, and even ftrace
which does per-cpu recording and event reconstruction (Joel wrote this
frontend).

It should be pretty straight forward to implement a new frontend if the
ftrace one isn't flexible enough. It's a bit clunky still to add one,
but search for "ftrace" in fs/pstore/ram.c to see how to plumb a new
frontend into the RAM backend.

I continue to want to lift the frontend configuration options up into
the pstore core, since it would avoid a bunch of redundancy, but this is
where we are currently. :)

-Kees

[1] CONFIG_PSTORE et. al. in fs/pstore/ https://docs.kernel.org/admin-guide/ramoops.html
[2] https://www.freedesktop.org/software/systemd/man/latest/systemd-pstore.service.html

-- 
Kees Cook

