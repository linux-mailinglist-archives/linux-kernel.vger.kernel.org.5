Return-Path: <linux-kernel+bounces-161914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF68B5339
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8FDB213AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E76175AD;
	Mon, 29 Apr 2024 08:36:25 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EFBF9C3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379785; cv=none; b=DDkpgkRCrBPNWcFo8GjKaFkidyHer5hsJK1QentxI7vqfHfS/jC61OOBSXxTAWav0J3DMgie/gfV6FfkRHFO/ZobPKkN8j/bjZUDzJnaQ/Y8NmcMz++CO0GWNoHfDZNuxSfZSuZGYh+NSq7bP9miQfZI6dFyaQQsExdklbhmqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379785; c=relaxed/simple;
	bh=g5890trmuBojCK0qfRbHZouMugKri9GSWs9sSkpjVWs=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IS7fgZ8cBCRrlYb6REMYPGaqtQcMLmjdDDkNZ965bVs9sZoo5ibOLnueOI50eHes0WmitXwjgX1h1Y8/BOt8SU7wsoYKD+ATx8g/Pg95jKiRMX/CsfxkYbQbM8LBa7GB19W9kHQPMFAw5JUsUzu7daS6g48iiyBfAOaIO9x0/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c638:ea8a:e2dc:eb6f])
	by michel.telenet-ops.be with bizsmtp
	id GwcE2C00V0BATYP06wcFKM; Mon, 29 Apr 2024 10:36:15 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s1MUg-00GCIM-UA
	for linux-kernel@vger.kernel.org;
	Mon, 29 Apr 2024 10:36:14 +0200
Date: Mon, 29 Apr 2024 10:36:14 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.9-rc6
In-Reply-To: <20240429083040.4015092-1-geert@linux-m68k.org>
Message-ID: <21838384-b8c0-e38e-691d-c2cf6b87fa@linux-m68k.org>
References: <CAHk-=witYatGg+jW1kVu2Moq6yF2JNFe3wn7G0sMNhE=H=9voA@mail.gmail.com> <20240429083040.4015092-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 29 Apr 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.9-rc6[1] to v6.9-rc5[3], the summaries are:
>  - build errors: +11/-7

   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x0), (.fixup+0x18), (.fixup+0x10), (.fixup+0x20), (.fixup+0x8)
   + error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040), (.head.text+0x5100)
   + error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

sparc64-gcc13/sparc-allmodconfig (seen before)

   + {standard input}: Error: displacement to undefined symbol .L107 overflows 12-bit field:  => 758
   + {standard input}: Error: displacement to undefined symbol .L119 overflows 12-bit field:  => 761
   + {standard input}: Error: displacement to undefined symbol .L121 overflows 12-bit field:  => 729
   + {standard input}: Error: displacement to undefined symbol .L96 overflows 12-bit field:  => 791, 716, 852, 696, 943, 775, 800, 739, 916
   + {standard input}: Error: displacement to undefined symbol .L96 overflows 8-bit field :  => 932, 870

sh4-gcc13/sh-allyesconfig (ICE crickets)

   + {standard input}: Error: pcrel too far: 561, 552, 588, 563, 545, 570, 554, 579, 543, 581, 590, 572 => 833, 878, 557, 720, 550, 884, 566, 586, 933, 575, 779, 806, 877, 925, 568, 856, 765, 888, 844, 827, 584, 559, 548, 804, 909, 927, 679, 593, 858, 700, 843, 920, 595, 828, 706, 577

sh4-gcc13/sh-all{mod,yes}config (ICE crickets)

   + {standard input}: Error: unknown pseudo-op: `.cfi_def_cfa_off':  => 609

sh4-gcc13/sh-allmodconfig (ICE crickets)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e67572cd2204894179d89bd7b984072f19313b03/ (all 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ed30a4a51bb196781c8058073ea720133a65596f/ (all 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

