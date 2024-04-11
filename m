Return-Path: <linux-kernel+bounces-141325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D08A1D55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A75B27F77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDED1B758C;
	Thu, 11 Apr 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZfdJ1k4S"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474B1A38FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853107; cv=none; b=iWUPrC7u3g6tfFPim6pbQAN9Bdgk1nTMUltgyzv8L1/+9CoCAqD85zJD+gGCRQ5jTSyz9HR2IZi2Zgen1pWm3n1F6A4/0NWc0MMWJjFHjMBETkg8kWkmW02XOT2Wjyu3iNW45ooY9PgzBtDOjcrTnSVyKoWgHAQagMBjFyalehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853107; c=relaxed/simple;
	bh=evOUe1w35ZtZ8Av7MI/0lyqOeulmgJE9vxHA7CRHUeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9kopXTai4vWmJRFnqx4xjfX1MSIcvzD8DFZfePaDzsRVFq7QmUbSHidssgn10vm/foLJtzPAObw1gopm0R1D9MrTJ1CXOgmGw13d9jhnLpa+1XUF9wKNbq2/EYHXwqlLX6pLx88QpixweN9OCj5bMazdiv7bKVWveDqo2QsTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZfdJ1k4S; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so11714195a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712853104; x=1713457904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0E4Mcvm1Ca/K7JG5a2Gt1iCkk38ClaKkzaJEpcElfU=;
        b=ZfdJ1k4Sqg4AVSPcimXMcjoQVbHBaqv/2ftg737ZM7VU3RngdiLMEXsmZNRwJMOmDU
         7fPletejNBJ9VL99DZy+xDJezPQt6jzHQK+qNhNwyv4AjWb1No2uh9mzkPOTsp5tG9b0
         M2dcPNumPqIZIIvuOFUVfIxctv8f0sAzT6gsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853104; x=1713457904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0E4Mcvm1Ca/K7JG5a2Gt1iCkk38ClaKkzaJEpcElfU=;
        b=IQIeSvx1L2fzPyhxijfYVduaQMvoqemwz3Fl5A5Ijh4s2jgTSwbkuz6/q+1XH2eDyD
         GucnQt+0UQIFA35iLrDis3mRCZgInoy6hevTaOi4Tk/IxZaQilZFupLQy1/ILNcq0v46
         PfuL5fNZmuU/urScTQ5OHPwo0bvpDVPiqObES6S85sSG24HcoGEIVBgDIZJsG/corxH5
         6bQ9FY8hItG05TmV7l7XRhZrR2I8Ugt15MQFxYSDdGDmudUKh3K3qC3ewBv+6MwNQVYR
         MjHCaDH1DZtEnITYPofN9mOlGp5rAz6U9d5FTnJBojht8879TzsNb144P/81Q87xd0wl
         hbsQ==
X-Gm-Message-State: AOJu0Yzf5QE1EL7A+a/dSzdtBpBsOsFbJzEC5e4ySOh/fmqD3hE9Lc0W
	X71ywsIfSCKEimJ1IggXwMo32otPaoLguC5Q3h+ZNSR5bPBJWrt3q0BBSCA2l/9YLYCwjiPg3HJ
	Eqwi8jA==
X-Google-Smtp-Source: AGHT+IHSFzAhB4jk8M8l0ZOYhUhqaTqOucN51JwRGS6WNl1I4k2duG2czhAsNc8aiJOENQ3jKdsdag==
X-Received: by 2002:a50:9f83:0:b0:56e:241c:3f3d with SMTP id c3-20020a509f83000000b0056e241c3f3dmr203617edf.25.1712853103979;
        Thu, 11 Apr 2024 09:31:43 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7c6cb000000b0056e7ba0497dsm826114eds.28.2024.04.11.09.31.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:31:43 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44665605f3so893850266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:31:43 -0700 (PDT)
X-Received: by 2002:a17:906:f809:b0:a4d:f5e6:2e34 with SMTP id
 kh9-20020a170906f80900b00a4df5e62e34mr160576ejb.19.1712853102671; Thu, 11 Apr
 2024 09:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325140943.815051-1-ubizjak@gmail.com> <171284242025.10875.1534973785149780371.tip-bot2@tip-bot2>
In-Reply-To: <171284242025.10875.1534973785149780371.tip-bot2@tip-bot2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 09:31:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaxi4Sau27C5yo3vty67DHz-f4L6SSOvmx1K2fQU2B_g@mail.gmail.com>
Message-ID: <CAHk-=wgaxi4Sau27C5yo3vty67DHz-f4L6SSOvmx1K2fQU2B_g@mail.gmail.com>
Subject: Re: [tip: locking/core] locking/pvqspinlock: Use try_cmpxchg_acquire()
 in trylock_clear_pending()
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Waiman Long <longman@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 06:33, tip-bot2 for Uros Bizjak
<tip-bot2@linutronix.de> wrote:
>
> Use try_cmpxchg_acquire(*ptr, &old, new) instead of
> cmpxchg_relaxed(*ptr, old, new) == old in trylock_clear_pending().

The above commit message is horribly confusing and wrong.

I was going "that's not right", because it says "use acquire instead
of relaxed" memory ordering, and then goes on to say "No functional
change intended".

But it turns out the *code* was always acquire, and it's only the
commit message that is wrong, presumably due to a bit too much
cut-and-paste.

But please fix the commit message, and use the right memory ordering
in the explanations too.

            Linus

