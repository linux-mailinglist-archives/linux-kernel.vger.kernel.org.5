Return-Path: <linux-kernel+bounces-97613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736F876C78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59122826E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026F5FB8B;
	Fri,  8 Mar 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g7Kz0q5D"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCFA604A4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933976; cv=none; b=UH9U3WfChdcLWPWH3BP/gDvbeJjoM1hn5WJuQakV6VvNdFid42nMt2LvNq4JadpiR3xHnVzDDBoXVIqIopBYUu0Wkc+EIfQGQC+NIA+d95p92FjnGddeeDWP/h8J920Ppm9+G3waYSzcbHYwdiaUJgOEyyq1PcWxLS1UEOHLRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933976; c=relaxed/simple;
	bh=a7v96kmQhDkc8Kx+zJIfhWvdsBlkGzLICy5mfG0ttH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGDeM78IRxGTSmSifjOTvcNTEEk6qk66POYaK8yalPxCh4jnY/47vUo4hh1J8p+FfCyNYAEWJqTN/JyTPO/9muFpHfs7lVznGVcKD0gELjJp9lKaEogX+uPtEDNfZf9GTrAjKArBqUttR2zlx+o9OQetjgaTSiT57Oet+yUfM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g7Kz0q5D; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so24812261fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709933972; x=1710538772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivKkfUleh9PGqoywIX/iRlhl8v/B2TOp1fqf3Qv6buM=;
        b=g7Kz0q5DpZYrPg3eHabd2YVDBEIDCZu384/Cu9FPlKF7xXFL2Cbi8ir9IhEvJ5cKAH
         2I9bH0HdzshhRxNiLNBBV17DVAtFZv5f/X/ccSJ/HiqPaTIqMumw/SZFvwICTQ2Bk88/
         aBcATymiHtMHEhdCiUcVI5Lh1Ox/ZSSd1YwgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709933972; x=1710538772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivKkfUleh9PGqoywIX/iRlhl8v/B2TOp1fqf3Qv6buM=;
        b=fd64ZGju9z2u2NFmHwiqy1ODh51G8Lms24v80PS2H7D8Mh+8Xia+lCtd4+9lwdwOdf
         cHg2ol8pkHxlJqxFWHmhHa3hPiNgJyudDNM/+elYPI8rH5oCBRY7w8zW+A7DMz8bz+2d
         CPcWSOSO0bsUcj0dboKFlPbTgiZZLyn3VFAGwZ20GuuF+FHbby9WgVmbdzR6FpdX97Gn
         27fbsmQD6AKVpsLLKwein4APGmn1tMx+i16dD+xwfZSWkOK/WOloXJTj8E+W2R8lKhxV
         q6rbbUgnAPhDrvTuF4njzjIDrZ3z7NIyvSH5yMFsGhzJym4h9U5gFjOxat2+xyalJ1dH
         Gwgg==
X-Gm-Message-State: AOJu0YylAwlMrxi8BBwfIFWljXobfHH/UljW0IPpVXdoKF+8+WH6dPJo
	PzUcSXRkh0dbogAmVCE8m/qr5Djj73Y7F3MH0bE4xubOx2R+BuAEH8TgsIsk81DYkzUAT1XcvFL
	w92gBbg==
X-Google-Smtp-Source: AGHT+IHJ1eu1jJyuhrshXN+mCzgRc4cikF6ozquGUj+NBCErOzUtz0qaI3ui+NVU48oKdHLYjxqqFA==
X-Received: by 2002:a05:6512:324c:b0:513:26b5:139a with SMTP id c12-20020a056512324c00b0051326b5139amr156294lfr.23.1709933972289;
        Fri, 08 Mar 2024 13:39:32 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id k20-20020a17090627d400b00a453b2261b4sm189597ejc.184.2024.03.08.13.39.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 13:39:31 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so326959166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:39:31 -0800 (PST)
X-Received: by 2002:a17:906:f6c9:b0:a3f:ac54:5aa1 with SMTP id
 jo9-20020a170906f6c900b00a3fac545aa1mr180745ejb.21.1709933971409; Fri, 08 Mar
 2024 13:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308183816.676883229@goodmis.org> <CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
 <20240308163528.3980c639@gandalf.local.home>
In-Reply-To: <20240308163528.3980c639@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Mar 2024 13:39:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaVBe14mbW4QWNuywBP_ZvGJYRZ3dbgx9-ebSxnNTXiQ@mail.gmail.com>
Message-ID: <CAHk-=whaVBe14mbW4QWNuywBP_ZvGJYRZ3dbgx9-ebSxnNTXiQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] tracing/ring-buffer: Fix wakeup of ring buffer waiters
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joel@joelfernandes.org, linke li <lilinke99@qq.com>, Rabin Vincent <rabin@rab.in>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 13:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> There's two layers:
>
> 1) the ring buffer has the above simple producer / consumer.
>    Where the wake ups can happen at the point of where the buffer has
>    the amount filled that the consumer wants to start consuming with.
>
> 2) The tracing layer; Here on close of a file, the consumers need to be
>    woken up and not wait again. And just take whatever was there to finish
>    reading.
>
>    There's also another case that the ioctl() just kicks the current
>    readers out, but doesn't care about new readers.

But that's the beauty of just using the wait_event() model.

Just add that "exit" condition to the condition.

So the above "complexity" is *literally* just changing the

                  (new = atomic_read_acquire(&my->seq)) != old

condition to

                  should_exit ||
                  (new = atomic_read_acquire(&my->seq)) != old

(replace "should_exit" with whatever that condition is, of course) and
the wait_event() logic will take care of the rest.

             Linus

