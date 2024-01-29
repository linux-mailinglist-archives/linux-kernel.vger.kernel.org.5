Return-Path: <linux-kernel+bounces-43251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A07784116C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1866B251E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9716F066;
	Mon, 29 Jan 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OyneKBkT"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C33F9EA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551011; cv=none; b=BpEoSj9APU7wJ43F8rqF1UcYPLKDSsbXo89HrGxaVrCBFVRRx4EB2HrAPqrq0Qc7GgXROcbj1j6fyTqpSa7Pk53/4x4U3lNyqr0XYqs4fx2xJj8zAEFqHUbi3Kk02NgdO7xLGovWWz0lO63tdSYi97LkPLKeo8j8/J0/EVyELWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551011; c=relaxed/simple;
	bh=tS4YyJziMo9kpVlp+pJ1MlqRkete9IXfSfz8JHxqHTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2hKTgzwlbzcTdqznYjJAHSAAuVt8NExUyqhZmfzSysHZ97LUxYtsqzz2aywzKND1MNAIXukMne1WL8Hz5cfd74cJSRNRXhP+yid/tbyuojYZgjz4VlERImw5vEBabAq0A59AUd+ec8RKUqBgTLVOnY48I22wIhgUyCR8l8DSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OyneKBkT; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d03fde0bd9so22147201fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706551007; x=1707155807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eM8zR6VYCF0hOlY4Lnp7mb0cO2V2uGCLbKBvIv9aWnU=;
        b=OyneKBkT+V7hPYr1zSObEnfZZxK8n4mBELikTjOyYByd1suZviFYm7O6J4CKRakd+N
         gGBeAyurwEuJbZkRw2K4Tv3Hir28wLSLWA0HYCHeenZdO4V8Bm4GGqLywJDXrk7xEF6w
         MLpgO4b6lzuVBwIXFklum6eMdWmc2m/ww+ts8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551007; x=1707155807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM8zR6VYCF0hOlY4Lnp7mb0cO2V2uGCLbKBvIv9aWnU=;
        b=ndSD4ugbEJlg0JMEovEDf7gQagL9JkdvmOmdHxmZs2KyjltClZSROK7AshR09X2zgJ
         z3tgrb0s39SLZn2w6irwrlfy0Fr7vsjb4rv77V7FqqZyPhYAYvS8uwZcKWP7gEcoRB+K
         BLo5wdg9er3jCBfjdyukcxvnogWZEUXHCBtDe9V4w/GoEZRqwsdOLKC+c8KYCcftYXN1
         YBQEilLa5bTyqwJpaknRcm0CHByywWHzlpzbbpVltIDYz0Au/TYpUNlPdGuTDtpyzS56
         TP3VIxGIcLstKb3n06Q0sF6+L1LHGTuflSp2lmh2lTln2RzUXBaI6UR6f6Q/hGHWqDsi
         ie0A==
X-Gm-Message-State: AOJu0YyD449QYifldolCMiA4NMdR+yhYSk3LpnrFUzea21iSEN9w4qx8
	I0q6AZI1y+8IK7G933r66gm5dUSH4Zd0wcN+dut/XJZFo0aSDVcbnp2ulqxgk5Oy65PoecAEAPN
	ho1oubA==
X-Google-Smtp-Source: AGHT+IFbyLboNHB9LvFMX0KXOU+YM3KX7iPvK2eEp6Nz3CzBfDXjjtqrvVo6bQOWXSxxdrFV1mcjdQ==
X-Received: by 2002:a05:651c:2124:b0:2cf:3006:6dce with SMTP id a36-20020a05651c212400b002cf30066dcemr5406843ljq.15.1706551007666;
        Mon, 29 Jan 2024 09:56:47 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7c351000000b0055c4a251205sm3937000edr.90.2024.01.29.09.56.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 09:56:47 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f13b682d4so1340027a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:56:46 -0800 (PST)
X-Received: by 2002:aa7:d811:0:b0:55e:ebe5:f65a with SMTP id
 v17-20020aa7d811000000b0055eebe5f65amr3047956edq.7.1706551006540; Mon, 29 Jan
 2024 09:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <20240129124436.4b7d0129@gandalf.local.home>
In-Reply-To: <20240129124436.4b7d0129@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 09:56:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPMDeav5B1es50j+fZSK3wxGUc0cWca0obZGR-abrJbQ@mail.gmail.com>
Message-ID: <CAHk-=wiPMDeav5B1es50j+fZSK3wxGUc0cWca0obZGR-abrJbQ@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 09:44, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 29 Jan 2024 09:40:06 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Now, I do agree that your locking is strange, and that should be fixed
> > *too*, but I think the above is the "right" fix for this particular
> > issue.
>
> Would you be OK if I did both as a "fix"?

See my crossed email - not dropping the mutex *is* actually a fix for
another piece of data.

          Linus

