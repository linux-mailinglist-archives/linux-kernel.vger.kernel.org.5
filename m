Return-Path: <linux-kernel+bounces-89587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910F786F25D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA4F282EDE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568A405FF;
	Sat,  2 Mar 2024 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G8EkiYDG"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB52BAEB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709411125; cv=none; b=mk/QdEdgSkVa5R3vob9bt5vbwfRf8/hAHoZq2iwwI++8sUPc8GV70V5PsI+ML0XmYaE3Kr0ORRoCSDzal2oS0CEXeH1D6HO3zJ79ito9Pkk3VhY9D0iBSJSSSswedgC5rQZy90H6TPosxowKSZ5n2ySjsZLrzj1/zbJJViOYKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709411125; c=relaxed/simple;
	bh=uDobg8R2XVwA0yobS1XRrtwXl2uMQovFjgbo7Y+FVBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qa3BNshYyXN01p/6y/x2sWaJsKug890PFQtiGRUpNqumHZhFNF6+smoq+u7alHQLtdU44j/VPUS6BM8LlBCOVD/Dri5qclhTPvAHfBpp6NOUdj9+vePlYaYRZGYg8qebVHXX4WYQcUu0jZMsGLlzop/GEfr1wHdlW26VLRwAZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G8EkiYDG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso4716357a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 12:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709411121; x=1710015921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2foc15xOe/nXw7rjgw/qR+1JhHhfTIQg+OrYFxLfdOU=;
        b=G8EkiYDGpdgE8ji0Kv1peozs5lODPSYzWzFLtQPueJX8UMJ7ShgLjvfToeBCuZyIwq
         UZPAU/x1DGbofvEWmrGLheCGCvd5G+/i6bba+tc/uJfzw69sYPqWANb68HeqPxzSaPtr
         XW5G3rR2JC3YcNfb2blOW4vRGkkyBQsrjlxZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709411121; x=1710015921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2foc15xOe/nXw7rjgw/qR+1JhHhfTIQg+OrYFxLfdOU=;
        b=qkuQuY7O50PXfCW2sWmmA6knh/CvgjA21JaAInWrqrnDQJZMqa+ur07oLgk9oA/dda
         ahRScNxrGOZU+GXHMs7f5glj267mr3LrlOCJD8+quANtc+HU6GyGlAiWpjXUqniydtXw
         rs9ZlSicU1w/2Geir9FEEVUygnOura5tdYnDrWaqYQ3nIBdpM+ZAbwaEFKb3z6Ifi8mZ
         k16f0ISA8wAzda6XOf0SdK3PfV20yZFcjXWWEl0WQPcojUagyjmc5SlUkurVQmAFaHU4
         +wCA1i1I9GycGjoPUNx2B/t+dJTFVRw3LmqQimssGjO93TB+t8NesCezFAi8SXutQzla
         u/pA==
X-Gm-Message-State: AOJu0Yzjoify8N6Nk1BBf4r6r0FDdZ8zdoFhZeQRwdvysEBhHsKHQloY
	bf3NfK9te3N0vNnEITACmcFMvQYb/uFt7qAwM+rmpz6SZttMvvKHVdxIxdAdneIm+/RgXeR/ke/
	7c9NrJg==
X-Google-Smtp-Source: AGHT+IEhjWjbJCZXkZoT29YeONpETCGlzLxSDzaSxUD0azxEO6Dfob4jjJpP2gOLUqWIBnte++IaGg==
X-Received: by 2002:a50:ef0e:0:b0:567:a7d:b573 with SMTP id m14-20020a50ef0e000000b005670a7db573mr1476538eds.36.1709411121698;
        Sat, 02 Mar 2024 12:25:21 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id u17-20020a056402111100b0056729e902f7sm119712edv.56.2024.03.02.12.25.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 12:25:21 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so104222666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 12:25:21 -0800 (PST)
X-Received: by 2002:a17:906:5a9a:b0:a43:bf25:989 with SMTP id
 l26-20020a1709065a9a00b00a43bf250989mr3703292ejq.9.1709411120805; Sat, 02 Mar
 2024 12:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302111244.3a1674be@gandalf.local.home> <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
 <20240302145958.05aabdd2@rorschach.local.home>
In-Reply-To: <20240302145958.05aabdd2@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 12:25:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgyTTSw6yTaQ9-safdT8-MEpUWgFjqzHyeDrc8cZFui2g@mail.gmail.com>
Message-ID: <CAHk-=wgyTTSw6yTaQ9-safdT8-MEpUWgFjqzHyeDrc8cZFui2g@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 12:00, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I don't have control over the strings. Anyone can do in user space:
>
>         fd = open("/sys/kernel/tracing/trace_marker", O_WRONLY);
>         r = write(fd, huge_string, 10000000);

So?

Stop the stupidity.

You already limit the string.

Just limit it to a sane value. if somebody uses a 10kB trace marker,
return an error, or just truncate it to 100 bytes.

You already were willing to truncate it to 32kB. Use your brain, and
realize that 32kB is a ridiculous limit.

Why do I even need to tell you this? I'm getting really tired of
having these idiotic arguments with you.

         Linus

