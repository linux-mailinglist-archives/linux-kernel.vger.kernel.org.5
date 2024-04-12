Return-Path: <linux-kernel+bounces-143008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867498A3322
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF97281F77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44A148852;
	Fri, 12 Apr 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SLalmpmo"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A831487E4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938059; cv=none; b=AoY8uWdkeSuf9EDQAvo3At8qjkSf282g5OwAVJx1JGcdPO3qy4sig+2QRX6X4IME6y45hG7K3vfYDGpmLZfqKmrEGXTQhmH1/iLTPdGz1J7QfkGWSrMzM6OYlXmMkjFK4Ja13A3l60fNabLnh1nhnJSXC9koSAjopPhO96maxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938059; c=relaxed/simple;
	bh=fvWvh5FWVbuLQ7Jx+PSlpJADo+WJiPUgm/CsRvJo010=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2C9m56vrGc2GFGzIiKuz7MMr+yKbF8+RC5ImFnMthfyI4BWVUir9qYf608MqraJ4soEqpLA9OhG9oKG9BBeuZChWXcv0HrYn97o2NVRWYQ5+Fq4zSLJ1SRvySPKGdaes2uYvPZSD0toZzmPary9xaKfb7gv1oO3wMTDnS/Nw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SLalmpmo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5200afe39eso127514366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712938056; x=1713542856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WCixfb+YFPc8XTlcPM6xbP4h1EJ8glxU4TlgV2ptkiw=;
        b=SLalmpmokPfs7mmtCFnJNPV5wFMYlxWMKdqZUU4nXbGQG+71ii3KfzOP/s0LCqYIX0
         P/yz4NS4DDBHjIZYeosNBl0Il9vaEikzLzEI685vaaAznAut3dUGnKECnpSCAgZvKaC1
         LsGbN3gEIKPCOm0tQdWHShXfpjyOYg6LMvQHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712938056; x=1713542856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCixfb+YFPc8XTlcPM6xbP4h1EJ8glxU4TlgV2ptkiw=;
        b=dmB51rD4Dlvwd93rSD24bXd706aj+ehMjMSNzJ8QgcHOImLXtNspMe+jW4Y/Xt9hvq
         eQKzbuWdnMyGxyNRnkLibg/20ZwNW4Uq08etrq5UOpuI5WIGSVPgyEnI563iWxloPHP/
         WM0eOR6wA3PmCX6yHIyadHIQbRxA4KJZDflvCriJosffnejJmL+biprn+SB9BJ7BypRL
         aeAZa+4jgtx0famiXx0bdEEW66yZvMmfodkLLAVkWPJ+EgWxABlSda/XTvd0TykC0g2l
         frKxJc44Z651YrxRZZGV6aipx2l8YC+kJ8wunYuh75IauTilYOGVXnOp5Crmq02W/1LX
         cpsw==
X-Gm-Message-State: AOJu0Yzn7urH0Kxy/ynLpt55CHDTVJnzPR7NsaRvEPtIzoLYzgyeDsbT
	ukTkWW2w+eU0jq41JuE1r2+8eqAjBWweJXvmifLSWteF3zI71xsEVXcq8cHP5p6D9OJNbty4zir
	HhjeJEQ==
X-Google-Smtp-Source: AGHT+IF0VPb6yoR7HZSk5JbwpnFYx4T0gKzYiISf40jBLVt6chrFuGaKD1GSmqatgD4dm5ghdHpCOA==
X-Received: by 2002:a17:906:770c:b0:a51:fe13:b400 with SMTP id q12-20020a170906770c00b00a51fe13b400mr2476118ejm.31.1712938056050;
        Fri, 12 Apr 2024 09:07:36 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090670c800b00a52244ab819sm1726961ejk.170.2024.04.12.09.07.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 09:07:35 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5200afe39eso127510266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:07:35 -0700 (PDT)
X-Received: by 2002:a17:906:b0c2:b0:a51:e0de:2758 with SMTP id
 bk2-20020a170906b0c200b00a51e0de2758mr2542075ejb.42.1712938055063; Fri, 12
 Apr 2024 09:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412103204.453d912c@gandalf.local.home>
In-Reply-To: <20240412103204.453d912c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Apr 2024 09:07:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw2NW5tar-Xew614JZPKfyTdet5fC0mgwK+2sUsZ0Ekw@mail.gmail.com>
Message-ID: <CAHk-=wgw2NW5tar-Xew614JZPKfyTdet5fC0mgwK+2sUsZ0Ekw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Prasad Pandit <pjp@fedoraproject.org>, 
	Yang Li <yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 07:29, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Replace bad tab with space in Kconfig for FTRACE_RECORD_RECURSION_SIZE

Argh. What parser is this? We need to fix this craziness.

Yes, yes, we have "tabs and spaces" issues due to the fundamental
brokenness of make, and we can't get rid of *that* bogosity.

But for our own Kconfig files? Whitespace is whitespace (ignoring
crazy unicode extensions), we need to get away from "tabs and spaces
act differently".

              Linus

