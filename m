Return-Path: <linux-kernel+bounces-92016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2098719C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6391C20F84
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBC85473F;
	Tue,  5 Mar 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RskWlH7X"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287F537E5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631693; cv=none; b=EhG124r1I0N3CEUQBoTu9JiAt8c0YXYa+1XQgY1c3pwPkSCoCOYhZiQMHbVlnlY24k3d4DqUIgwiFmcH1FR8Nkn7hj3mguhchRBnAWi83MIw9FTEwxxXTwzHuvYAf49wSzcpBv8tY1al55tAfCGC2bRqtP1nqCMiISjbgT7j1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631693; c=relaxed/simple;
	bh=yNMRaUkoBUGzMo4lYC++zBwXHqvVQ2SDiAjTQi1KynE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNNySTYa5e19Qml8g0omh79i0/f1MRKEfDfCum6LloLbgoHDKpMCTRcqyY07D+6ZLTvK/q4orQnw6EEP4vLL9CZ5kIX7M+gWTU/0UexqF4MUivKwKrkYoCJt1msQUOBqJNEdetijyGCXvZ8W4i5j1EA4SCKJc1M/SJ5TRBdL81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RskWlH7X; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so5248554b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709631691; x=1710236491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=as9+lE8KnefmxAuKs+ZS/mXcrbxKlrRRgGu9dYI0Ql4=;
        b=RskWlH7XdjX4qeIQWlvvNpjHTHq0o33PhnA/rXe58565YvM0zbizX0EACWfdw9sq45
         kiTI44oQqKdLorR03MzTBG63Di9n4Zio+lzOVOGnlRZY0ejH5nudNqjCygIAcR+Ha+lq
         WXxm8AI5OPheLbJAUvW1MnQDAP08WbmcINil0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631691; x=1710236491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as9+lE8KnefmxAuKs+ZS/mXcrbxKlrRRgGu9dYI0Ql4=;
        b=IrXsyXx5R3nkyowXtstsWUbX+4hRwcv9k6my3hjsa4ckXwYqzjcl4e85cGtMBW9kUw
         HmL4eZedf9SYVF4E/0zRRSOM046GEaKEXKnhYrcJJVq3Gax5afWDqqCi4Xm+CFO80ayd
         4P5FQ9sop11DmPpJBdpao6dw/S8uXgAw39/vOwkulUZDKe4L2hlDOicUPR9q5p9EVnkv
         G9wyeutzdWvcgc/byQj4ilWJIy7POmsblnMNPqsS083T9MDSqHE6/fg/ME5fPUgH0eOd
         qsla8cdFpfWXMW6525p0zq8BIlK/oMc4h7Xm0ls4YlyKQS0od64c8/D6f9pN1/sAmnOX
         KTcw==
X-Forwarded-Encrypted: i=1; AJvYcCWmMUMHjXQgaKuTPUBcWjhn93pYFb2W5eAt/ZZ35nrLQFyGowkuBzZzV6oWYfUR4GMNXcNgOf/G9VfOXz0qv55xzILfJdr8uy7WKkXo
X-Gm-Message-State: AOJu0YxIZmf4ASx9q3hdILFGTsEaBUt9IMnaPaZ9+avTKcvjyKA7Q2fY
	sYZ8TRolpzVSDVa5PQpdGy+JQr3JvDO7MSRF9tQMqcCdCxjO8zgEQD5KWKIqnnG/2BqpAZYCQiI
	=
X-Google-Smtp-Source: AGHT+IHLWDn0ImiexmZH+l62XkhFStqZ8wnEDf2Edq3sxo8a271Wx6ORwR5cKmQu3cOMJO0RH2ld9w==
X-Received: by 2002:a05:6a20:7489:b0:1a1:4b3f:5571 with SMTP id p9-20020a056a20748900b001a14b3f5571mr1546542pzd.13.1709631691058;
        Tue, 05 Mar 2024 01:41:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fb32-20020a056a002da000b006e6253bbcb7sm2882057pfb.61.2024.03.05.01.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:41:30 -0800 (PST)
Date: Tue, 5 Mar 2024 01:41:29 -0800
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
Message-ID: <202403050134.784D787337@keescook>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-attentat-robust-b0da8137b7df@brauner>

On Tue, Mar 05, 2024 at 09:59:47AM +0100, Christian Brauner wrote:
> > > Uhm, this will break the seccomp notifier, no? So you can't turn on
> > > SECURITY_PROC_MEM_RESTRICT_WRITE when you want to use the seccomp
> > > notifier to do system call interception and rewrite memory locations of
> > > the calling task, no? Which is very much relied upon in various
> > > container managers and possibly other security tools.
> > > 
> > > Which means that you can't turn this on in any of the regular distros.
> > 
> > FWIW, it's a run-time toggle, but yes, let's make sure this works
> > correctly.
> > 
> > > So you need to either account for the calling task being a seccomp
> > > supervisor for the task whose memory it is trying to access or you need
> > > to provide a migration path by adding an api that let's caller's perform
> > > these writes through the seccomp notifier.
> > 
> > How do seccomp supervisors that use USER_NOTIF do those kinds of
> > memory writes currently? I thought they were actually using ptrace?
> > Everything I'm familiar with is just using SECCOMP_IOCTL_NOTIF_ADDFD,
> > and not doing fancy memory pokes.
> 
> For example, incus has a seccomp supervisor such that each container
> gets it's own goroutine that is responsible for handling system call
> interception.
> 
> If a container is started the container runtime connects to an AF_UNIX
> socket to register with the seccomp supervisor. It stays connected until
> it stops. Everytime a system call is performed that is registered in the
> seccomp notifier filter the container runtime will send a AF_UNIX
> message to the seccomp supervisor. This will include the following fds:
> 
> - the pidfd of the task that performed the system call (we should
>   actually replace this with SO_PEERPIDFD now that we have that)
> - the fd of the task's memory to /proc/<pid>/mem
> 
> The seccomp supervisor will then perform the system call interception
> including the required memory reads and writes.

Okay, so the patch would very much break that. Some questions, though:
- why not use process_vm_writev()?
- does the supervisor depend on FOLL_FORCE?

Perhaps is is sufficient to block the use of FOLL_FORCE?

I took a look at the Chrome OS exploit, and I _think_ it is depending
on the FOLL_FORCE behavior (it searches for a symbol to overwrite that
if I'm following correctly is in a read-only region), but some of the
binaries don't include source code, so I couldn't easily see what was
being injected. Mike or Adrian can you confirm this?

-- 
Kees Cook

