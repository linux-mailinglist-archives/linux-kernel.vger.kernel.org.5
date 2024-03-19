Return-Path: <linux-kernel+bounces-107832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B317688023B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C2E1F24A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8A81AC6;
	Tue, 19 Mar 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GrOisRmg"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02BA657D1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865412; cv=none; b=g7Evx/zW+pDndl54h7Co0407/0YjrQNnBkic/rWZRTJPPlK0eY73d0JAHgUMgrgr1OEzCVl5T6urpU2NddeMKX5v3ywQiWgZbfnQZZ4IWVTJnuSSVd5YjvIyjhRR1VMVaVFO7RQgnpVgzMdgVUGfHMFj7w4NL9MCLZttLd12vG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865412; c=relaxed/simple;
	bh=vTNZLb5s5LBffVjG1LWSaRwOwHNVROAI7vdgF5MIcH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+2YMq/v35WUg/47AltFa+vE8I5Uv2lWabndv/uw1GBNO4yYqrXkSl2quqQO8s5rznV3PODLpc0Na4PYQnFdmrO2aNiZ3+E/uARD7dv9nORGaGBDM2HzsV8EA0BRs7W+zVCaofFWaYjT6V4SsJ/EtRyRNaJd0qjy1Q0ayiPtx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GrOisRmg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso9895448e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710865408; x=1711470208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SLVaY8B/wtZ4RzbuufUnY+AWNsyVScU0e2XfqjI4X2w=;
        b=GrOisRmgpLq28jjCX2otsiDX4mZODRxenpfkIag5sasNQSxIMqNuidhagLrFR3so6b
         A5JsZKsOTmjg9aLdUXspL8fD9dVjFcbb4+2jC59E9Q8/jnJE0k50KyYHktWrIZMqPWhq
         dh7X4p7KbYa3/bi2v1vwwp1CAnG313EpIJEFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865408; x=1711470208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLVaY8B/wtZ4RzbuufUnY+AWNsyVScU0e2XfqjI4X2w=;
        b=LUosSErUNCsnZ4L5Vqw3GTFYFq/ZaN24NHP/xcN3kaumE4Paaoa3NY7jyGvnoekXYE
         fS+V69SWHs4S2npMsbyxbXDe3Lpb79dD7AmONFONTlycgIez7cm/KwDHlo3gpgjYCI5K
         MuLneHWgM6wNbcaJZbYpehM1IDxBxL7Km45XX7ugosiuqR4ng87kYwzhN9yDar2zjQv+
         +mjvXFEYzs+3LmBhzxCWdP093Cr6e1t5L8IAxM3AaPhU5LsSYHrynAiuXrp1h30hYVNo
         bzxR+jev1ofwMw/vEj1rtxNsZTBZeokTdeidZadztznAEmXBPtoPX86QsZ/fd6hm/oCn
         BTzQ==
X-Gm-Message-State: AOJu0YzB9hDbY5WRFESjkaUjPFnfl1cw6xzcGaXfn+NLPIvPmWxjH7u+
	q8BeR0zVgRggMoEzDL81/+D4RT4MwQIqP3OA8linjyI1FUzwa1CGHU9Hn5DBIwYcymfPLKLBinB
	NGGquSw==
X-Google-Smtp-Source: AGHT+IE3XBZL95xDoURtx/T5deUJVETtMh+6OHjPMNUoqIQvSe2ENU1eJ9uTK8dhK2HQr0IZvul0Bg==
X-Received: by 2002:a05:6512:45a:b0:513:ebb5:d9b0 with SMTP id y26-20020a056512045a00b00513ebb5d9b0mr4624821lfk.52.1710865407883;
        Tue, 19 Mar 2024 09:23:27 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g20-20020a19ee14000000b005131cafecc0sm1989182lfb.25.2024.03.19.09.23.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:23:27 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513e6777af4so4531730e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:23:27 -0700 (PDT)
X-Received: by 2002:ac2:499e:0:b0:513:e8a0:2d85 with SMTP id
 f30-20020ac2499e000000b00513e8a02d85mr6295586lfl.44.1710865406739; Tue, 19
 Mar 2024 09:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318113053.7f87ce7f@gandalf.local.home>
In-Reply-To: <20240318113053.7f87ce7f@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Mar 2024 09:23:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com>
Message-ID: <CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com>
Subject: Re: [GIT PULL v2] tracing: Updates for v6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alison Schofield <alison.schofield@intel.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Huang Yiwei <quic_hyiwei@quicinc.com>, John Garry <john.g.garry@oracle.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Thorsten Blum <thorsten.blum@toblux.com>, 
	Vincent Donnefort <vdonnefort@google.com>, linke li <lilinke99@qq.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 08:28, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Added checks to make sure that the source of __string() is also the
>   source of __assign_str() so that it can be safely removed in the next
>   merge window.

Aargh.

I didn't notice this initially, because it doesn't happen with gcc (or
maybe not with allmodconfig), but with clang I get

    CC [M]  net/sunrpc/sched.o
  In file included from net/sunrpc/sched.c:31:
  In file included from ./include/trace/events/sunrpc.h:2524:
  In file included from ./include/trace/define_trace.h:102:
  In file included from ./include/trace/trace_events.h:419:
  include/trace/events/sunrpc.h:707:4: error: result of comparison
against a string literal is unspecified (use an explicit string
comparison function instead) [-Werror,-Wstring-compare]

and then about 250 lines ot messy "explanations" for how it was
expanded because it happens on line 709 too in the same macro, and it
ends up being three macros deep or something.

So no, this all needs to be re-done. That

                WARN_ON_ONCE(__builtin_constant_p(src) ?                \
                             strcmp((src), __data_offsets.dst##_ptr_) : \
                             (src) != __data_offsets.dst##_ptr_);       \

does *NOT* work.

Also, looking at that __assign_str() macro, it seems literally insane.
On the next line it will do

                memcpy(__str__, __data_offsets.dst##_ptr_ ? :           \
                       EVENT_NULL_STR, __len__);                        \

so now it checks "__data_offsets.dst##_ptr_" for NULL - but that's one
line after it just did that strcmp on it.

WTF?

This code is completely bogus.

               Linus

