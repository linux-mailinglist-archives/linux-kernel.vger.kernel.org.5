Return-Path: <linux-kernel+bounces-105028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A851B87D7D2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE951F2284C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFFB4C70;
	Sat, 16 Mar 2024 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N9ojlGze"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DD4A22
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710552213; cv=none; b=UPEemftc6Uf72SD5DZk8nCnt3kqHsh/0x++xB64gKiMI1OiRoyFdD5LKDQSsnKwHrfhvU76CDAeyFPYzJkJwlEJf8UuG+7hCQHnbCKGQjhBEfbU4TsiFAJ36EOBhU8rzdLEii1gIT8xdmPThCRgTdK9uMWf/gJLa0oktF1Qhw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710552213; c=relaxed/simple;
	bh=zrk0mlljUXq6JrTr3qaP5fW3ShetdUZodGHSY6f3a6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIfqGUy+z52tF9TkR8djK11Qxidc2f8EIRk4ZPx8yBgQSn1XF5QXacwhcy10wOI2ToLQuHbgaIAfs568n3UgYqEjDbBsOyzGsc2emNg5U+qcc9OHSUvr2NoyM0bxWTaS1JdcT+WXGom5MJtrl4B/9QlowlFWojGQVEkk8njKukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N9ojlGze; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5684c3313cdso3240854a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1710552210; x=1711157010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=69cI/hdQb0CMrhhOHzUcjMzxCnMmxWubP/uXkL4m1gc=;
        b=N9ojlGze6DfF2yy0ie+4jvUiWOhTWE2Emqd5XhR5TRA75MiQdbNH7q+5hA8SoxY5EY
         0HMxoeFwtvPUxIQZYskqqOifKTqSTC1gj0MB64uJ4feEXCR58C4EMsvrj2OQM8bdSBVD
         CKZxyPE3h/9jWpI8OnjkINJZPcUucz7MDNQA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710552210; x=1711157010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69cI/hdQb0CMrhhOHzUcjMzxCnMmxWubP/uXkL4m1gc=;
        b=tJIF0t/Gt6Le2iblo+kO1nQ303WGV0kaqrIFfRfYH/N6Cgf3qmRENppor28XHxwOKf
         ijD5t9VFfuLfxIO+dfD1AHFn1ArRIjl0yOTMjuDoby7YJgoPt6l0Vsyx7RgmqTxrQp27
         tZZ1RwRyt1swMer1jPJxpM9IJX5NfEOiLM7f5caP1rrfazc9FaXrBHkSd5i6rXMB4sY6
         SjbUaG+A/ZprBIpryWwQO3k+NFT1iFv8dV2N6iOOco6Hc2XfJjfdgWw6xtJqr7szcQBA
         1BdwaBqw2maljTl6ydFC40loEjuw2QlFrIBU1f4+Qk85b87n/nNxAtRJ69D++IRzj2dA
         1VVw==
X-Forwarded-Encrypted: i=1; AJvYcCWoEi7keoblfrFmKHgM+/BCXKGhaMXGH38Z6KFapmTbSalP79gqy7ik7ato0A3CJCdnpyxpqHKlzN6LDZSmfR1OWV/ZZQT4gagHLvwf
X-Gm-Message-State: AOJu0Yzq1z2w1P3CyhDyDYYZKjOpQ/Mjg3J0AA56WnAyUGEqhiyZaoL4
	Lccm5tanJl+1YPgK6P6F8tsgf6d1CZlLnBVDShFec0VoVdvM4TExnStzRnMD0V7cXr2URuczFd2
	hE6xZ3A==
X-Google-Smtp-Source: AGHT+IFZ5X8y19Nvjb89s7uJRjXvCfZ8KxcqH0Xk+mEOrsJNn0aHHXIHBzpJTZYIR78WEvpIBWm12w==
X-Received: by 2002:a17:906:508:b0:a43:f587:d427 with SMTP id j8-20020a170906050800b00a43f587d427mr2550612eja.34.1710552210430;
        Fri, 15 Mar 2024 18:23:30 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id sd9-20020a170906ce2900b00a4628cacad4sm2201368ejb.195.2024.03.15.18.23.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 18:23:29 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4644bde1d4so343840166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:23:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHKs/JwijisHHOnn6I33YWwwYvN8BKqvjn31OuSf4rWKmq9sHZMiuUocwvv5gyVQ33OlUXGrQAiQcxpDI0/9YU2jVEleDLq2YkEdiC
X-Received: by 2002:a17:906:3654:b0:a46:9711:4f04 with SMTP id
 r20-20020a170906365400b00a4697114f04mr1417533ejb.13.1710552209212; Fri, 15
 Mar 2024 18:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303235029.555787150@linutronix.de> <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net> <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx> <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
 <877ci3j80k.ffs@tglx>
In-Reply-To: <877ci3j80k.ffs@tglx>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 15 Mar 2024 18:23:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg50AGnzhmOK0TNqDN99T3dWd747h3y-ZFuv4bNZ4Q0tw@mail.gmail.com>
Message-ID: <CAHk-=wg50AGnzhmOK0TNqDN99T3dWd747h3y-ZFuv4bNZ4Q0tw@mail.gmail.com>
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 18:11, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> You wish. We still support 486 and some of the still produced 486 clones
> do not have a local APIC.

Ouch. I was _sure_ we had dropped i486 support too due to cmpxchg8b.

But apparently that was just a discussion, and my wishful thinking,
and we never actually followed through.

         Linus

