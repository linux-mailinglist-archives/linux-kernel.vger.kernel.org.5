Return-Path: <linux-kernel+bounces-143061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B08A33AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF441F22430
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6E614C5BA;
	Fri, 12 Apr 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YRKv4xTo"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7814B075
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938849; cv=none; b=nJqYqzmRw1Cq+/f7xgtwNzVtkuD5oD7ubQSFqfx/1bODUlItn8LrCNhxa6+YiOtDfDK2vG839Ic1hOF073UaHXysKll+VDxKxEGi6efY65k77JnXsEOktOuCUZu+ffsrrRSM64hBl/mFvyENnhrhkl/+iogrm5HLC1AMmawh2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938849; c=relaxed/simple;
	bh=yvvx2RyWAhIbmocEUfp30EjqiMwfQv8YzNlRc2+It2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAuMYXQWlsUDrJpYcFoZv+O2uaUZV2qNvoXr5MABeha9cS8dF3sv4OcPCb2oazlN5d7c8RmrL4r+ndJo2LXdp7O2C8+KQGT4DOWxJNgpO5tz0ne0Y6DMxpKuoV6JmwjgsOyWLoR7AnQ0wA03n2rKQMu3iZo8a8okBEt+qdfg0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YRKv4xTo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200202c1bso121743166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712938845; x=1713543645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GyQMHOu1flgZatfnzoOX+9dLmySWINz83wenDs57vrg=;
        b=YRKv4xTohAR27K75wFU3rhLPASzdkZT9yfuZYRU5EshSbW2OtKN0dS2ShOSckcCkHS
         4O/SEadQbFRc1NjnxFlUXdDRIE+kxbh6IkodNKloW0dGcQidlSRu4XBXUAdumDfdqGnH
         +1V36sxEg8M+ZJ+oynqBDXHwMFsU59VzBLWvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712938845; x=1713543645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyQMHOu1flgZatfnzoOX+9dLmySWINz83wenDs57vrg=;
        b=ITY/4YK6PCdsllpJRDqlLZTUUNzseJpUtFED1oCcQZ9/lqwIN28PKLUXT3wSoyUwh7
         bccmyuPWXOnEKL5bGAZGchyikvAcXDaI9/HkuQdEojbZbz3KJj++8sYtcnYgUiRxzAxp
         Ago3S1PAYZ/+qo1vfsapljQ/cE1DhORtP05R79Q9SQX18SGlh/4ttnAABTI6orIodLsn
         uWkoKmcBTZQDN9HyAJud3p19ytVS/Sfukc4v7xx0EPTAdZ+d3Tq5xVAhBxslJqH4rT0y
         bCV3V0wgZhUjoBRD8MlbfvINpCvpt/L8UF+BMb8HRUBHST57RyTsAPI3w/R53gSV1EFh
         3g4w==
X-Gm-Message-State: AOJu0Yyp6jLKk9UEn7FyT1bEmi+BYb2li7w4zvteXqgu+Dyfk+/+f8yi
	q/40nBjrrdIgSLDAue+Afty4yLIPizUXKcS2gPGcAxCS3x/zBS6kt6y24AJULahn1OcV2dyOrrs
	dFW+otw==
X-Google-Smtp-Source: AGHT+IGgTRzIfUy/152Wvl9cjUrhZgfhc59FeoH9M4vSDNjuVs23kVNX0JaZX4t41rF4mjg7sIzbOQ==
X-Received: by 2002:a17:907:7e82:b0:a52:3d43:1103 with SMTP id qb2-20020a1709077e8200b00a523d431103mr1187452ejc.16.1712938845288;
        Fri, 12 Apr 2024 09:20:45 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id ne12-20020a1709077b8c00b00a51c5c76023sm1968218ejc.194.2024.04.12.09.20.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 09:20:44 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a52223e004dso122593366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:20:44 -0700 (PDT)
X-Received: by 2002:a17:906:b0c2:b0:a51:e0de:2758 with SMTP id
 bk2-20020a170906b0c200b00a51e0de2758mr2571163ejb.42.1712938844248; Fri, 12
 Apr 2024 09:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412103204.453d912c@gandalf.local.home> <CAHk-=wgw2NW5tar-Xew614JZPKfyTdet5fC0mgwK+2sUsZ0Ekw@mail.gmail.com>
 <20240412121531.24669544@gandalf.local.home>
In-Reply-To: <20240412121531.24669544@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Apr 2024 09:20:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-hLLN_t_m5OL4dXLaxvXKy_axuoJYXif7iczbfgAevQ@mail.gmail.com>
Message-ID: <CAHk-=wj-hLLN_t_m5OL4dXLaxvXKy_axuoJYXif7iczbfgAevQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Prasad Pandit <pjp@fedoraproject.org>, 
	Yang Li <yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 09:15, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, the tab is here:

Yeah,  yeah, I checked.

I also checked that the normal "make defconfig" does not care.

In fact, I'm seriously inclined to make sure that our main Kconfig
file has several tabs in several places, just to make damn sure that
any broken sh*t is fixed.

Because no, the fix is *not* to try to fix invisible problems in the
Kconfig files themselves.

I've pulled your thing, but any parsers that think tabs and spaces are
different need to either be fixed, or they need to be shunned.

                     Linus

