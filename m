Return-Path: <linux-kernel+bounces-105232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B287DAD3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B211C209FE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175B91BC41;
	Sat, 16 Mar 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eeMlV43I"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E78C07
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710606692; cv=none; b=NPcF0wpwNllYlKNl4rYrT6GGrjDSpgAyHMa6+1470te6vHIQIzWR5yYfj58xWUIAiWMUmDj/7wEmaap4sHq9pWGFzxHIgiLvOlvZKoKCsWzXEg19njKvap4z4lcXHYH/LR/BXZDNwRIRLo745PsLiiB2vV7Ca1kKt03GhfT4xmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710606692; c=relaxed/simple;
	bh=FtXvTKjVTEaLVL0RFXE16871AtouSD+UDMcaZ5Aroe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL9sYblEQTZjMC3ifoLjI9lKgPh9w4dUgz65U4ZUcOZMo2dyw26ZA9U1DWvWrxQjGwz3sEFHjy9urRTQNrIw6jhYEY/bR9s7hmDJgbOxAfeadtiaj+6LeQCOXgTb+OZtGkAROvvOVLx1+jIO7SyHdd6u/MvpmGORd+Ac3/vHgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eeMlV43I; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso4132796a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710606688; x=1711211488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DA6IqfzYqrKo5jMsuaw6DFNIhp6F8tsFp8Be6s/wIcc=;
        b=eeMlV43I1wrcBtNrw//HU1qVd8sGrr+Kh7gDKSXNDt/tcumGKpRqXsWNOdtBtR8CmJ
         tagEjtJGXNDEnXV79F+oHhO485/yDErHhbGOiuC8S0XyXOYDJq4Nf0xrDttBscdnQQ7p
         XZwJA6Q10MvaIJIB/jwyELuQ13Vl5B/D4L5Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710606688; x=1711211488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DA6IqfzYqrKo5jMsuaw6DFNIhp6F8tsFp8Be6s/wIcc=;
        b=met7y7VEntX4M2F5mgmREyxg0la+mWRfchGyZ2RpUvjWUPcKinAgIdMT0QAjuvwu64
         XxbpxVyp1og7fH3Fxzjod4E0AlcQC9GnULmUSpRlLvQeCWikZUREPwl5bTKheQ+IzsOm
         Kb0q/C2m7q2XZdm6EOyxtPp3bXKNesm6+lCr7FF6siVvWjLodu/A85JbfuNR2b7KWbLw
         88n1Eml1Tgo4xO21Hngn8P9GI90/41mmpN6phHIejOWH26ZIASxd+ffQfNDU7VtzsFWQ
         HVfUASPTCYvdav7v863OeepmIHVfN5yESLBKkMksiufGtY4v1bORrOcJSWG5IoQVva60
         zFUQ==
X-Gm-Message-State: AOJu0Yz83edKDZubSZPyj5UMmy0phMl+/wveQ03A01CdHT5X78R6LMGO
	0iuWxYQwRPox8rMBs5EjXhMbb6JrQjnU5iZ9/w9NzNjNtLM7pu3FXg8NCTitgX0xenTxQwNyitX
	ozAE9ZQ==
X-Google-Smtp-Source: AGHT+IF+SMfSCdHCkj6hiXpuMk+YaQc3FiVG09Rwj49LhDJs0uzK5IjlaX6jzEMOCLI2PbVbWrsXoQ==
X-Received: by 2002:a17:906:4ec9:b0:a46:ae1c:1ed0 with SMTP id i9-20020a1709064ec900b00a46ae1c1ed0mr260268ejv.22.1710606688380;
        Sat, 16 Mar 2024 09:31:28 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id gy4-20020a170906f24400b00a45f39b2d16sm2855260ejb.200.2024.03.16.09.31.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 09:31:27 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46af3ede0eso7639366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:31:27 -0700 (PDT)
X-Received: by 2002:a17:906:2801:b0:a46:663a:cfbb with SMTP id
 r1-20020a170906280100b00a46663acfbbmr4392834ejc.32.1710606687414; Sat, 16 Mar
 2024 09:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315122934.1d3231ce@gandalf.local.home>
In-Reply-To: <20240315122934.1d3231ce@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Mar 2024 09:31:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
Message-ID: <CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, 
	John Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort <vdonnefort@google.com>, 
	linke li <lilinke99@qq.com>, Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 09:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Add ring_buffer memory mappings

I pulled this, looked at it, and unpulled it again.

I don't want to have years of "fix up the mistakes after the fact".

This is all done entirely incorrectly, and just as an example of that,
subbuf_map_prepare() is another case of "tracing code works around the
fact that it did things wrong in the first place".

So instead of merging a new feature that was mis-designed and is
already having code working around its mis-design, I'm not merging it
at all.

              Linus

