Return-Path: <linux-kernel+bounces-71072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AA685A051
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02544B20B23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478CC2C1AD;
	Mon, 19 Feb 2024 09:54:20 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294E2C1A0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336459; cv=none; b=fKuJDdUi8aN5iXPEILxiMHI04C8cRiyOyysD5AsWde28nYjYHlijEIGPlwhFsMb+s7kO5hv3Rza2BtzgF6ExcBikLoQkEkTnbYPskiZZMKmZb+pGMUUjzO87GyAIwvE+OK4iTAuOqRDprpLJwfkdA6GMwpV93Z4nIuWAykF1GTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336459; c=relaxed/simple;
	bh=yAYtJwb0OUxa/S46uQCMYkWmGhyJFxgd4hNKwdIGFMY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fTGhBYEzCrVHj36EfPZz2CpoqPB/Hx8OVYFWB6vjkfnufbNawX7VstBH+6RidQB8o8sSrYbyiqMIv3b6I7KMibelslK3F7SWYn0FU5GjL6IYxT/wiw/GKRTai+TPHNs2Yhlg9yQ3u1/CH1duGArfWKekrNWWpvZVJHMT63Gkqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:79b0:1378:2db5:5f5a])
	by laurent.telenet-ops.be with bizsmtp
	id oxuE2B0051qcN2A01xuEdN; Mon, 19 Feb 2024 10:54:15 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rc0Lm-0016At-Ck;
	Mon, 19 Feb 2024 10:54:14 +0100
Date: Mon, 19 Feb 2024 10:54:14 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: Fangrui Song <maskray@google.com>, Mark Rutland <mark.rutland@arm.com>, 
    Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
    sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: Build regressions/improvements in v6.8-rc5
In-Reply-To: <20240219080729.777675-1-geert@linux-m68k.org>
Message-ID: <a8609e7e-fb0-7ac-aca9-6aa21ba5126b@linux-m68k.org>
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com> <20240219080729.777675-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 19 Feb 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.8-rc5[1] to v6.8-rc4[3], the summaries are:
>  - build errors: +6/-14

   + /kisskb/src/arch/arm64/include/asm/jump_label.h: error: invalid 'asm': invalid operand:  => 25:2

arm64-gcc5/arm64-allmodconfig

   + /kisskb/src/arch/sparc/kernel/setup_64.c: error: no previous prototype for 'alloc_irqstack_bootmem' [-Werror=missing-prototypes]:  => 602:13

sparc64-gcc{5,13}/sparc64-{allmod,allno,def}config

   + /kisskb/src/arch/sparc/kernel/time_64.c: error: no previous prototype for 'sched_clock' [-Werror=missing-prototypes]:  => 880:20

sparc64-gcc5/sparc64-{allmod,allno,def}config
sparc64-gcc13/sparc64-{allno,def}config

   + error: modpost: "__moddi3" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!:  => N/A
   + error: modpost: "__umoddi3" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!:  => N/A

m68k-gcc8/m68k-allmodconfig
xtensa-gcc13/xtensa-allmodconfig
parisc-gcc13/parisc-allmodconfig

Fixes available

   + {standard input}: Error: unknown pseudo-op: `.cfi_def_cfa_offse':  => 605

SH ICE crickets

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b401b621758e46812da61fa58a67c3fd8d91de0d/ (144 out of 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/841c35169323cd833294798e58b9bf63fa4fa1de/ (238 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

