Return-Path: <linux-kernel+bounces-37728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6C83B480
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D421F242DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AA8135A4B;
	Wed, 24 Jan 2024 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QHcgDBCk"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580F13541F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134277; cv=none; b=bMk13izpq1ab4kAipwdr+WzSR83s11MIGm/OfpEy5mclNFLK0HiBm5VW/IuSB0N0VkTCxe1qpq66aSDDc7C3WAMm20zuv7xNjCVGlKnZ1XZyOKqX8uDvvtrLRRcbVnkFYTj/VrpGHZtsLk1TTs7pjYDzHhJRSvdmtdah1UVaIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134277; c=relaxed/simple;
	bh=vXTfMlgh7kH671ORMb4QoEyy8NAM0PglagPwr/wSiJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt33/bqjy7OLF/LR+ertqscEhnB0ujy+qjrWLpzzkHMy5J1kfmS/Oln6UQW/HsmKIUHFJneJO0Ke8CDGQcLAOU+tIt+W+zONW7miDHaSAcKcFWZyW/Know/6PvwMQog11JAFL0gM+gHm35b2QVzcic/ruZ6tXfZ+aeuJqlZq/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QHcgDBCk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so679080366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706134273; x=1706739073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=24nC7FWGIti38IzxnMvpNU7GROBNbes/8B7YDtU6FyY=;
        b=QHcgDBCk3imF0ZJpTG3gmFOsxuXq1aTDHiSgTJUFVhBGTvQFt4weQnbWwOncDJYjBJ
         pHYfV4r6QPaO0anLtUGRByLqs3mpU46lLXzTEDOGpG8IrGJ2zDOt34uc1ObHTsE89GlV
         gbO3WKiMMZTVQ6WwgNAHLPhyG6J+w5G3NE/N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706134273; x=1706739073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24nC7FWGIti38IzxnMvpNU7GROBNbes/8B7YDtU6FyY=;
        b=LB7uB7KRIJJIIVRTSANgOI2SI4aIeZCNrdUHpZEtUURh/aoUKkbyF6P0ceCEFgGCag
         6XaU+Stgneizh4/rHOQkp64Kspkfm/v5omy0K0JZqrw6QgO3+bwrUBa6etSP+lbENod7
         y36l94m9VE2PwWzjQosxjHCr+7tN8LXSHNSx7IqmfxJ9sgKQv4ViEC0hbP5Qvi/qBBXk
         kINUy+4veMriIcRpyFq4NUo5ZyZYwg2WqutPF43OtbxAGpNY0u+5G6kaW3VyZFuX5VvC
         m5YIR9QfjG2m84jynxs/WDkwER577nq5A1am4YiMWSFOCzUWbALewd4/JB15wIRo1Kni
         fmtQ==
X-Gm-Message-State: AOJu0YxhUq2J+qjU1JJftHcs+Ohqj5zPfGawicUuhfNQLqh/5qHuVJDC
	l69Sf9HSbrnkgdxpLWIGvzuXL00nmTyu7b9nCrsiIyKJaV2q3DpzkYgNASqbZrE5dU6EK6edWRP
	7p6pQaw==
X-Google-Smtp-Source: AGHT+IF1uf72tXA5vxhRffJxxtxPpmpEgjGhF5wxRFEnuppkIOCg/R9uEwyhOoRLIog3QKe4CZdPKw==
X-Received: by 2002:a17:906:53d0:b0:a31:2b80:2e12 with SMTP id p16-20020a17090653d000b00a312b802e12mr10160ejo.107.1706134273490;
        Wed, 24 Jan 2024 14:11:13 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id dt3-20020a170906b78300b00a2f1888ddecsm307394ejb.166.2024.01.24.14.11.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 14:11:12 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ec6a002a7so12409965e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:11:12 -0800 (PST)
X-Received: by 2002:a05:600c:138c:b0:40e:3a07:41e with SMTP id
 u12-20020a05600c138c00b0040e3a07041emr1033857wmf.162.1706134271813; Wed, 24
 Jan 2024 14:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
 <mvmplxraqmd.fsf@suse.de> <9481b6d9d015aea25d8f2563bf7bd6f6462f758f.camel@xry111.site>
 <0be1203c9df55432548c92281c8392dfa2f7d6bf.camel@xry111.site>
 <e8583a3ab0522b4e75ba0ada47b6f093b186fa81.camel@xry111.site> <CAHk-=wgVrw+8P68Sy2krcc3QFbm_eu_DRs0-i7mct_0BDORZuA@mail.gmail.com>
In-Reply-To: <CAHk-=wgVrw+8P68Sy2krcc3QFbm_eu_DRs0-i7mct_0BDORZuA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 14:10:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkEXGOCEZFO2vAZ9rDd8uW8MJwFNYg9KXaC_vZVso6iA@mail.gmail.com>
Message-ID: <CAHk-=whkEXGOCEZFO2vAZ9rDd8uW8MJwFNYg9KXaC_vZVso6iA@mail.gmail.com>
Subject: Re: Strange EFAULT on mips64el returned by syscall when another
 thread is forking
To: Xi Ruoyao <xry111@xry111.site>
Cc: Andreas Schwab <schwab@suse.de>, Ben Hutchings <ben@decadent.org.uk>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 13:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> And I think the "fails with any integer in [1, 8)" is because the MIPS
> "copy_from_user()" code is likely doing something special for those
> small copies.

Lcopy_bytes_checklen\@: does COPY_BYTE(0) for the first access, which is

#define COPY_BYTE(N)                    \
        LOADB(t0, N(src), .Ll_exc\@);   \
        SUB     len, len, 1;            \
        beqz    len, .Ldone\@;          \
        STOREB(t0, N(dst), .Ls_exc_p1\@)

so yeah, for 'copy_to_user()" (which is what that "read (fd, buf, 7)"
will do, we have that user space write ("STOREB()") in the branch
delay slot of the length test.

So that matches.

And it only fails when

 (a) you're unlucky, and that stack buffer

          char buf[16] = {};

     happens to be just under the last page that has been accessed, so
you get a page fault

 (b) you hit a mmap_sem already being locked, presumably because
another thread is doing that fork().

Anyway, I'm pretty sure this is the bug, now some MIPS person just
needs to fix the MIPS version of "instruction_pointer()" to do what
"exception_epc()" already does.

              Linus

