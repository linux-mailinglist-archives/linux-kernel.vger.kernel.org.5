Return-Path: <linux-kernel+bounces-34149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33132837474
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5ECD287AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E965647A47;
	Mon, 22 Jan 2024 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TS8zk41k"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDD40BEE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956490; cv=none; b=nEgzBUdU9z2vn8St6PytpzqrVZW5/Vs6D5ydYIGEVWeUEDehF5EzXaSbLRc1jTpxD2ogjFFXNe8eWotIzJEWi++ObLMCyVRTu1sdycNgEqcmJdQ1rbX5Pys69HjbZamKuiVGBVmSyJ4GwBG/egDx8HknsPLw854LunLXfg+ky20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956490; c=relaxed/simple;
	bh=RYQC2KkWpj9RT7UI3rcfTlQnhAUqT2n8BoXl2E7DtbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvFVr7kIa95doSoY6sPzEuVeYILJ92SPqEu6ovqVwWj28OEOfhDGm/sRS/8K3OTP0+/AKYFMAbF5IQAA/qk4DrHOQ3TRZmZhZ0qAyAYK8x1X/0p/dZZ2hQhowQ4zAf6KIXp07nF0Pw7Jv1qptQ0jGi2p3Z9Cc0h/PIZeDmf1h5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TS8zk41k; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2903498ae21so1843207a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705956488; x=1706561288; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nXbpsEnHClGHGXt9fUpUqdjWwEkQ1678gxMm5C6Enb4=;
        b=TS8zk41ko1gX7uuMYeezE8T11gdoSm+GFf/mBxOVnaV8QfnlcDBzWNEtReXADA5Lj4
         zJPbad4UyJM3OOkc9J8Fl6upRnlqnejMKEMcK/6bGfj6KS/0cToI5FvNbG9Ey752XQcl
         gpm0ntmYa8Iplfq9jTbr4QVqUiq1H/rcCHs0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705956488; x=1706561288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXbpsEnHClGHGXt9fUpUqdjWwEkQ1678gxMm5C6Enb4=;
        b=iS0TgEwlzIHB/wO/GJjIe+MNrwX8Q0joMg13bQGRyhF/Vva6DbetMJxHV9ogVa9Fe+
         lHteTDQFBGkWFn4Z4hYJXBAJjXi1fbjg86AfRDv79CTtgEUxCLKyXdlnp3ZD3T/go9i8
         jPmLOMfoUz1WPgQHpQJYsBYz/X9yyK9OZL47Nfkvr6wfcXuNLiTrbf5XIxZv9gYEFCub
         PR2T6N4i3qCkZcpDaQ7kfJm5EZ18C/zlaSuLGtOKkeEPCk2XFPRqW1mzgDHcA3NZGoW+
         ke7XUmOIJViHRDq6K+YkFeDiZkm1AtWIy2KEGKb2uk9NxNUM/izVo2rA98W4ORx5Qgy2
         kRcw==
X-Gm-Message-State: AOJu0YzermbafnwVfrgKUVOZr5WY3xMli3G0452hU/duXqoDEigS68xr
	KPMTwsn5gz7VIBZyufovI7o7sWIj7HJUE99rF+xGW3fdeUS18/T90olw54XWJSisZPgXA+K+oMk
	=
X-Google-Smtp-Source: AGHT+IFINZ8RYKV8rUEcCkP82iAD5yOfN/QLX5ecmImdhqK8CPCz1Jgle0iGvVw8/+T7qOUD2TEqMg==
X-Received: by 2002:a17:90b:4007:b0:290:c6bb:4c59 with SMTP id ie7-20020a17090b400700b00290c6bb4c59mr436412pjb.40.1705956487910;
        Mon, 22 Jan 2024 12:48:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sb12-20020a17090b50cc00b0028cef2025ddsm10257875pjb.15.2024.01.22.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 12:48:07 -0800 (PST)
Date: Mon, 22 Jan 2024 12:48:06 -0800
From: Kees Cook <keescook@chromium.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jan Bujak <j@exia.io>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Message-ID: <202401221226.DAFA58B78@keescook>
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <874jf5co8g.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jf5co8g.fsf@email.froward.int.ebiederm.org>

On Mon, Jan 22, 2024 at 10:43:59AM -0600, Eric W. Biederman wrote:
> Jan Bujak <j@exia.io> writes:
> 
> > Hi.
> >
> > I recently updated my kernel and one of my programs started segfaulting.
> >
> > The issue seems to be related to how the kernel interprets PT_LOAD headers;
> > consider the following program headers (from 'readelf' of my reproduction):
> >
> > Program Headers:
> >   Type  Offset   VirtAddr  PhysAddr  FileSiz  MemSiz   Flg Align
> >   LOAD  0x001000 0x10000   0x10000   0x000010 0x000010 R   0x1000
> >   LOAD  0x002000 0x11000   0x11000   0x000010 0x000010 RW  0x1000
> >   LOAD  0x002010 0x11010   0x11010   0x000000 0x000004 RW  0x1000
> >   LOAD  0x003000 0x12000   0x12000   0x0000d2 0x0000d2 R E 0x1000
> >   LOAD  0x004000 0x20000   0x20000   0x000004 0x000004 RW  0x1000
> >
> > Old kernels load this ELF file in the following way ('/proc/self/maps'):
> >
> > 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
> > 00011000-00012000 rw-p 00002000 00:02 131  ./bug-reproduction
> > 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
> > 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
> >
> > And new kernels do it like this:
> >
> > 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
> > 00011000-00012000 rw-p 00000000 00:00 0
> > 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
> > 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
> >
> > That map between 0x11000 and 0x12000 is the program's '.data' and '.bss'
> > sections to which it tries to write to, and since the kernel doesn't map
> > them anymore it crashes.
> >
> > I bisected the issue to the following commit:
> >
> > commit 585a018627b4d7ed37387211f667916840b5c5ea
> > Author: Eric W. Biederman <ebiederm@xmission.com>
> > Date:   Thu Sep 28 20:24:29 2023 -0700
> >
> >     binfmt_elf: Support segments with 0 filesz and misaligned starts
> >
> > I can confirm that with this commit the issue reproduces, and with it
> > reverted it doesn't.
> >
> > I have prepared a minimal reproduction of the problem available here,
> > along with all of the scripts I used for bisecting:
> >
> > https://github.com/koute/linux-elf-loading-bug
> >
> > You can either compile it from source (requires Rust and LLD), or there's
> > a prebuilt binary in 'bin/bug-reproduction` which you can run. (It's tiny,
> > so you can easily check with 'objdump -d' that it isn't malicious).
> >
> > On old kernels this will run fine, and on new kernels it will
> > segfault.
> 
> Frankly your ELF binary is buggy, and probably the best fix would be to
> fix the linker script that is used to generate your binary.
> 
> The problem is the SYSV ABI defines everything in terms of pages and so
> placing two ELF segments on the same page results in undefined behavior.
> 
> The code was fixed to honor your .bss segment and now your .data segment
> is being stomped, because you defined them to overlap.
> 
> Ideally your linker script would place both your .data and .bss in
> the same segment.  That would both fix the issue and give you a more
> compact elf binary, while not changing the generated code at all.
> 
> 
> That said regressions suck and it would be good if we could update the
> code to do something reasonable in this case.
> 
> We can perhaps we can update the .bss segment to just memset an existing
> page if one has already been mapped.  Which would cleanly handle a case
> like yours.  I need to think about that for a moment to see what the
> code would look like to do that.

It's the "if one has already been mapped" part which might
become expensive...

-- 
Kees Cook

