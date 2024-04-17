Return-Path: <linux-kernel+bounces-147801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DB8A79D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2D7B21FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94457F8;
	Wed, 17 Apr 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C2FtbMky"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903F37B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313764; cv=none; b=KejTPCZrYq7LfEe/b/cUh2MrjiwLL/KPwnQSIDRGg3CpCjAkUPC+N6ECF8utNq2afFNIohPXMV+PbTXo6/8GVi97+vWHwTmYGi89aaZgodVxMydxc73e7eSLJpFDtiNgYM39F8Sk5CAJ3LNi2PIlvEAEHgAPWR0oLSC8XCVMSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313764; c=relaxed/simple;
	bh=Qm53qmVFwN+7mq1oZ8TjY3oDbZk01C2mzZvLY17xPuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJf14bKlB32fcLDOfLQ3Lv3fpHV89d4U2c4ymA1O4s/2vz0SB8pqFLecY76HNPRAloZYRyvUf2lRInk6NYlVdX1Ms/8e204S/BKhuCrffo06RJ8sKh3cwMO9FWJTQ+qtyQZUdSdC1vIA8DJ8gTyQQQ2uNR9NeDUesfWUL6PneGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C2FtbMky; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d4d80d00so6235175e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713313760; x=1713918560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sWCTeZrfKXEwBXDLcl0+lfpwzj1590+2p/YYNvA5SyQ=;
        b=C2FtbMkyI/tx66QoJw6d5o5sp48GjXU7/LBC1KSwbfFs3/lOlsCiiF63O1AWNQ4QP+
         cU2VbUC0G6JYomIm6g+oMzR3xEHlwxFsbdHZf06kBWbdFovKFw6eApNlEPeL3ndG6s99
         pqFg21rxKGdGjx2foRPih0hgOMmv6rt8cnry0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713313760; x=1713918560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWCTeZrfKXEwBXDLcl0+lfpwzj1590+2p/YYNvA5SyQ=;
        b=KuHZtZBp5QsQc6nDEWup13JzPdsZ0IZnbCTF/JHHWwGUukBgIeWS9L2llmSBdBoOOz
         Sy6+XqrGAOuu1eXTdU1BkWKuW/GLyLvb4HTfy/qH/WHN/j18Hc9MAoTkhbZeFpEMLG9S
         h+lSqSFHoG6vurkZS7EEjetyEcHrg1x0eHPHPfbGlEN5UDW1j3feeQvvOZljdBihFS5C
         Rr58wDeHB10SXAb4vUNo66o+b+jhxl3MZOgaRguc7j2Y00kibqJTZ+dBLRTaWunn39N1
         qaFV6OAu9Sgv5LGu24fRRcq85t3d1d910Xjvppdm7RQNIS5ap8ZedRra6bCH6G5joO14
         96+g==
X-Forwarded-Encrypted: i=1; AJvYcCWRulE/05GIf29Zp5be1nt+n1gbS1Uix1XmRqw4D7EnzmK/bICUTaBAAUwbkJiWKaJi6UtQYlfz2FqZplGzWCRQQYQCk601C+FsWula
X-Gm-Message-State: AOJu0YxDyq8p3g6CfYyS/tvjw5OK/c6deQnx7atNetgbn5gm6DtZTN2X
	JpHEHkCVEjHr7HyHbSrumoCszTnE0UUImlmLKYOeap9Wffuzj7gXaHRdv7YGQygn0ITsiYQUX9m
	k
X-Google-Smtp-Source: AGHT+IFhOMfiY5IpP3kAo/CTUu1oAgNpLPszB2zPVzcnj707Jox/yX76FgNIYZL8BjrE0l3xWKYXmg==
X-Received: by 2002:a05:6512:e91:b0:519:264b:695a with SMTP id bi17-20020a0565120e9100b00519264b695amr2941433lfb.22.1713313760342;
        Tue, 16 Apr 2024 17:29:20 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id cw4-20020a170906c78400b00a4e58c74c9fsm7395118ejb.6.2024.04.16.17.29.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 17:29:19 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51969e780eso654628166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:29:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4oSZYDmKbzET9u3aLJ5qW+hgT+1AagxCCFN8gBdc3zAUuThoKtdpGbR7eoh650uQCLiJlBcHVexUtgDnYF06n5SZV/Ga7Sqb7QfyA
X-Received: by 2002:a17:907:2da8:b0:a51:895c:6820 with SMTP id
 gt40-20020a1709072da800b00a51895c6820mr10248651ejc.44.1713313759109; Tue, 16
 Apr 2024 17:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220302043451.2441320-1-willy@infradead.org> <202404161413.8B4810C5@keescook>
In-Reply-To: <202404161413.8B4810C5@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Apr 2024 17:29:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7+dfpEvDnTnB-eR9QRZ2VySbxOEHbYqL3Ai5wwkon5Q@mail.gmail.com>
Message-ID: <CAHk-=wg7+dfpEvDnTnB-eR9QRZ2VySbxOEHbYqL3Ai5wwkon5Q@mail.gmail.com>
Subject: Re: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
To: Kees Cook <keescook@chromium.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 14:15, Kees Cook <keescook@chromium.org> wrote:
>
> I was looking at -Wshadow=local again, and remembered this series. It
> sounded like things were close, but a tweak was needed. What would be
> next to get this working?

So what is the solution to

    #define MAX(a,b) ({ \
        typeof(a) __a = (a); \
        typeof(b) __b = (b); \
        __a > __b ? __a : __b; \
    })

    int test(int a, int b, int c)
    {
        return MAX(a, MAX(b,c));
    }

where -Wshadow=all causes insane warnings that are bogus garbage?

Honestly, Willy's patch-series is a hack to avoid this kind of very
natural nested macro pattern.

But it's a horrible hack, and it does it by making the code actively worse.

Here's the deal: if we can't handle somethng like the above without
warning, -Wshadow isn't getting enabled.

Because we don't write worse code because of bad warnings.

IOW, what is the sane way to just say "this variable can shadow the
use site, and it's fine"?

Without that kind of out, I don't think -Wshadow=local is workable.

              Linus

