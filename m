Return-Path: <linux-kernel+bounces-122235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6388F3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A1A1F3607E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE417C8B;
	Thu, 28 Mar 2024 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SXQ0g5Dp"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A671171C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585804; cv=none; b=btGG2nNhL404ZHVDMFKLUq97GJmatR9Sb8HOIIGhG3Cr8w8u8G6GYMezd1uHflVQLwMPyOH6KnPSXK//4Yl/Ix35i+BmRHiVon/K8PqS/OnWYW7//32iA1KB2OxKp2Nz4053Go8P4xQY+4yVFBFhghwwR4ShEQdZt1CaS5YTGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585804; c=relaxed/simple;
	bh=X7LR67auLYzcjOSyNskbLGXFRUtr8/utf8npVk2W7n0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=pW9zcWuSXU8A6VqAYex46QJhYsP4gzTxukQKFYqVdWEPcLh5NVk0tRg+CbPBnNWQhw/I5bXKYGo0gX2CkPkFBf5Mp/nnLFcZ1oBj5PSYyKLrOpiksPFxF1RXS1TLwP7idcvY2Oxcp8B8IvB4RFzPpAI0YtQLVV3ZhALhmEuinSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SXQ0g5Dp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dddbe47ac1so10189815ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711585802; x=1712190602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7LR67auLYzcjOSyNskbLGXFRUtr8/utf8npVk2W7n0=;
        b=SXQ0g5Dp/r91rfZMcWqFeKKeSgzymN/dSM1AlK9uI626EhEHPag7g6hhImE0v/ph6T
         PngQpt0cpNUfazB9Xruumk50sOR5iH6uy/VcwsauRyYslFbDwpB62hYg7ZwpWujeb5G8
         uEienXOMqOkkFSTOU+xb2//vMf+eBp1veZeZk6rWfGkDwq22fQk6kwjxxGmsvkGTr3Cu
         PHDju3g1zMaZQpdaB9w7QXgiEO1LkU9od9uVffJDcemr2dKq4RltVYcdLS34BgLZihpB
         ATVhSmLTKTllpNH50rT9C975eV+9YvjQADUTuKTZg0vYCDUI29KmdRnelHcZAd6Cg49J
         PWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711585802; x=1712190602;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X7LR67auLYzcjOSyNskbLGXFRUtr8/utf8npVk2W7n0=;
        b=g0dt7VIpOdrp+YicK73Zc4KzNbc9DBHqVKfRI22aGlhCEMsp+jYedkMRKzc4dVT4pA
         IJw8CU7ijI+MzRORgTzqmObvmqpLdfGC6Ql7pckhYbUWmLi2B2NjzVzeWmkitd2DMzzA
         YGO7TLzfWg9fryunaJqgJt3wSnK0aAeqNcT7MSLX1m5IrwIxPcGndAo6x7odwdL3Wcea
         0H8IfoifzottWj3gHyoPCTv1HsIIkh6Jww1dP93hvw6suNgK+08a4O/6N3MNIcFUB9WZ
         anBmLlVF6ljBnCMWXOYVkF+afYs+Pm5Kms4m8HffBlMrCdN7QsUmOjY+pRkQr3qupKBq
         Imiw==
X-Forwarded-Encrypted: i=1; AJvYcCUe/hIa2bdNK0ocISE9zRBeRd2XGlz7/lZf/Pnz1zvX5LB1m9bPGOeXAErlshtcXs+snimDaOhAgPhdSw1BDaFP7I6N60bLGdkklgS7
X-Gm-Message-State: AOJu0YwHbNYODv9urypyBF+OrC1M00N5qz8SKfT7WQvx2oCzuwHdFzkL
	96yHgUZXsBrS0d0dBFxJz5xuL2qwsyuKs0BX+oysObkv6AlROli/GPGIGUnTFG0j+EILU51H/zD
	9PR0=
X-Google-Smtp-Source: AGHT+IHlAqi8F11qAlHTj6dbvzQjsq4MRZk1SHXOM4xt7u9U5pA9WzIPKBB2ZnW6vsmHKZjsd9hc2A==
X-Received: by 2002:a17:902:dac3:b0:1dd:1c6f:af51 with SMTP id q3-20020a170902dac300b001dd1c6faf51mr1155990plx.16.1711585801737;
        Wed, 27 Mar 2024 17:30:01 -0700 (PDT)
Received: from [10.0.16.165] ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b001e120a9e964sm133028plc.126.2024.03.27.17.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 17:30:01 -0700 (PDT)
Message-ID: <bc21c53f-23b9-4596-b757-fc7707f91f24@rivosinc.com>
Date: Wed, 27 Mar 2024 17:30:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vineet Gupta <vineetg@rivosinc.com>
Subject: ARM SVE ABI: kernel dropping SVE/SME state on syscalls
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Waterman <andrew@sifive.com>, Palmer Dabbelt
 <palmer@rivosinc.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Will, Marc,

In the RISC-V land we are hitting an issue and need some help
understanding the SVE ABI about dropping the state on syscalls (and its
implications etc - in hindsight)

If I'm reading the arm64 code correctly, SVE state is unconditionally
(for any syscall whatsoever) dropped in following code path:

el0_svc
    fp_user_discard

The RISC-V Vector ABI mandates something similar and kernel implements
something similar.

    2023-06-29 9657e9b7d253 riscv: Discard vector state on syscalls  

However in recent testing with RISC-V vector builds we are running into
an issue when this just doesn't work.

Just for some background, RISC-V vector instructions relies on
additional state in a VTYPE register which is setup using an apriori
VSETVLI insn.
So consider the following piece of code:

   3ff80:    cc787057              vsetivli    zero,16,e8,mf2,ta,ma    
<-- sets up VTYPE
   3ff84:    44d8                    lw    a4,12(s1)
   3ff86:    449c                    lw    a5,8(s1)
   3ff88:    06f75563              bge    a4,a5,3fff2
   3ff8c:    02010087              vle8.v    v1,(sp)
   3ff90:    020980a7              vse8.v    v1,(s3)   <-- Vector store
instruction
Here's the sequence of events that's causing the issue 1. The vector
store instruction (in say bash) takes a page fault, enters kernel.
2. In PF return path, a SIGCHLD signal is pending (a bash sub-shell
which exited, likely on different cpu).
3. kernel resumes in userspace signal handler which ends up making an
rt_sigreturn syscall - and which as specified discards the V state (and
makes VTYPE reg invalid).
4. When sigreturn finally returns to original Vector store instruction,
invalid VTYPE triggers an Illegal instruction which causes a SIGILL (as
state was discarded above).

So there is no way dropping syscall state would work here.

How do you guys handle this for SVE/SME ? One way would be to not do the
discard in rt_sigreturn codepath, but I don't see that - granted I'm not
too familiar with arch/arm64/*/**

Other thing I wanted to ask is, have there been any perf implications of
this ABI decision: as in if this was other way around, userspace (and/or
compilers) could potentially leverage the fact that SVE/SME state would
still be valid past a syscall - and won't have to reload/resetup etc.

Thanks,
-Vineet

