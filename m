Return-Path: <linux-kernel+bounces-31847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E461F83356A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242D8284149
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C81010A08;
	Sat, 20 Jan 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Op9cexCb"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692110979
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705770036; cv=none; b=ilbqMRNOU8wzLIgOHexFilaKaP6Pu9NUZDmfUQp+CIZKZve60LAUkDtbKaOFWWyDoqIDAHT271LCikUwW04HCXe5cDW3y+pZtoIb8G3xR9oyKmhD5nKIVcXf62C8HQgl+np+qQX+GbbeFqOoQYR5OWdAGVJzWEJEMUfAkr8OYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705770036; c=relaxed/simple;
	bh=AjsF/ew79q1rxwqFpLchAi2I9Lgbtykummu8teyFBpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ1UEBG2JlhZtRrix+umdSkX3t0k5zDwfD2vw21ByJ+N8Pn7chl/bjJa1rsbzZjzM9LXB6YRMZpcIo8dZYpd122OA6c1moe4IjSFu6dC8AhL5BjT7QRT0HqBgvICUDpoPuYjjrQixyQAMtZN6dknkWis8hhR/pHGjpD2pLFa/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Op9cexCb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so213514466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705770032; x=1706374832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DIHej7AiTWXhetxkzClgi5vGZxcxwr+5xqPSPNaw8Uo=;
        b=Op9cexCbSCOWkq6zLVWGAeqH9U5I9vqqFbdVpmG69641f52gL2G2F4c2a7soihBcvA
         ADV497rdwwruGUBi53H3ee5JWLjDvZLDhu7kmDot3o6alW2ICV7U4NbVZ25X9JGz62d/
         aNAR0/+YOgEfoT4LXiTPdmuqGfgg3w6fQgwxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705770032; x=1706374832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIHej7AiTWXhetxkzClgi5vGZxcxwr+5xqPSPNaw8Uo=;
        b=dP3jlIV/QU6gcXFyEkVqcH/JyroEIOBiwr8SDu8k2WhGO9rUfFO9PBK5Zl9e8AzXDi
         A/OChitBFa7ACUMZhlfN7c++GAlR3l0F7hPdNafCsxIYTVu0VYSa88Ty2xoyxHzuuNud
         lGYUdEK7q9BagXm2IfensxG7Ch416LHImwPTXREA5MDhfPnx/M7c0hG//tPMceHHtCQq
         zJW8irttq7AUf09eqCvVmmO1j2UdPucznFwisYA76H7J0mWbvRLi8lbvrBGkNE1h4sSk
         p7kchPy28FyxMkyEgGbfbVG3YqAcCZcKIWODA6iakjOlalODeDEvOBp9Jftx2GA2gxQ4
         kApQ==
X-Gm-Message-State: AOJu0YwVhToVEfBGIwObAyqQx8vHWYgqzD9iBrMhNWNUaMsf69ppNKs+
	49ro7HJIhWXe/z2p6guQldwvxXX5r9ShwnumTStU+i0b+NKxA+ZNJ8aAwc6/joUYOxUCWswhzMX
	o4uWhGA==
X-Google-Smtp-Source: AGHT+IFjSEZvrcRpExpbjUMzOqTXN1blT++E6RZwvUdHVgwntPsKCp7mSRWwVDKctgPT4SVj5IHMQw==
X-Received: by 2002:a17:906:cec2:b0:a2a:7404:cf5d with SMTP id si2-20020a170906cec200b00a2a7404cf5dmr529967ejb.114.1705770032389;
        Sat, 20 Jan 2024 09:00:32 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id s2-20020a170906354200b00a293c6cc184sm11527787eja.24.2024.01.20.09.00.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 09:00:31 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so2366944a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 09:00:31 -0800 (PST)
X-Received: by 2002:a05:6402:3138:b0:55a:214:c7f7 with SMTP id
 dd24-20020a056402313800b0055a0214c7f7mr515704edb.84.1705770031241; Sat, 20
 Jan 2024 09:00:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org>
 <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org> <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
In-Reply-To: <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sat, 20 Jan 2024 09:00:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whtFk2DoO8WhtmsbU9nGXUd8sKShV1Dk71krFLBjPUSeg@mail.gmail.com>
Message-ID: <CAHk-=whtFk2DoO8WhtmsbU9nGXUd8sKShV1Dk71krFLBjPUSeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Glaser <tg@debian.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, 
	rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-toolchains@vger.kernel.org, jpoimboe@redhat.com, 
	alexei.starovoitov@gmail.com, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jan 2024 at 00:28, H. Peter Anvin <hpa@zytor.com> wrote:
>
> %eiz was something that binutils used to put in when disassembling certain redundant encodings with SIB at some point.

Yeah, it's purely (bad) syntactic sugar for "no register". Somebody
decided that the fact that so many RISC architectures have a "zero
register" means that they should make x86 look like it has a "zero
register" too.

I assume it regularized some very silly decoding issue, but it was horrible.

It's not the worst thing I've ever seen - in objdump output, and it's
easy to just remove with a sed script or a simple search-and-replace
in the editor.  Unlike some of the other "design" choices of objdump.

On that note, does anybody have a better disassembler than objdump? Or
even a script around it to make it more useful? I do use "objdump
--disassemble" a fair amount, and I hate how bad it is.

My pet peeve is the crazy relocation handling (or lack there-of). IOW,
if I do something like

    objdump --disassemble \
        --no-show-raw-insn
        --no-addresses \
        kernel/exit.o

I get output like this:

        call   <delayed_put_task_struct+0x1a>

whis is garbage: it's not calling delayed_put_task_struct+0x1a at all,
that's just "the offset bytes are all zero because the data is in the
relocation".

And if I add "-r" to get relocation info, I get

        call   <delayed_put_task_struct+0x1a>
                        R_X86_64_PLT32  rethook_flush_task-0x4

which shows the raw relocation data, but with truly mind-bogglingly
horrendous syntax.

Is there some sane tool that just does the sane thing and shows this as

        call   rethook_flush_task

which is what the thing actually means?

And no, the llvm-objdump thing isn't any better. It isn't compatible
with the GNU binutils objdump, but it does the same insanely bad
decoding.

            Linus

