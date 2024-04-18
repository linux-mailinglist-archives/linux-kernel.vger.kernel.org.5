Return-Path: <linux-kernel+bounces-149926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C92E8A97F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0401E1F2207B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760915E1F1;
	Thu, 18 Apr 2024 10:54:22 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08715AAA5;
	Thu, 18 Apr 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437661; cv=none; b=p3P9iID+q4lvz/Sir8qo4+OOq2/RnjpLfaB7n1Rxvpg9LyULsJGub0SKEoIDEw6MTOqKgpKElMRcGFA9rslD4wClTLgxympEESQv0H94M2TtUypFncBaiRbirWtIX+l+8VzmRISNMnKb9wkW4W5e763tXbiz38FTxNTf0q4ojsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437661; c=relaxed/simple;
	bh=QXRpT+CBg+12o9QiybFt9P2/DxbFd4uWsWG/3lfHQs0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=e44LsdDpF1pLP75UfcxPiTyFyovo6Wwv7qZTjozQTzbG66DFpcXq76CEtomD6aus/o8BTHF4PFpGu/MpDgk80M3Dpu8OXxKx6GlZIJcvynJg4STVI2+VD0p5O2oye4PEDrrLpE6akvxgxASQgEl76Y+YjU2+iZ7gZ+iUGUNkQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A454440E02A8;
	Thu, 18 Apr 2024 10:54:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x14-0CbjA4uj; Thu, 18 Apr 2024 10:54:12 +0000 (UTC)
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:203:4169:60e3:2ca7:1d6e:8d5b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77DE940E0187;
	Thu, 18 Apr 2024 10:54:05 +0000 (UTC)
Date: Thu, 18 Apr 2024 12:54:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_locking/core=5D_locking/atomic/x?=
 =?US-ASCII?Q?86=3A_Introduce_arch=5Ftry=5Fcmpxchg64=5Flocal=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4b8kRgy0p3pKwheLRHx7rX+4RuY-45_Zt-CCj5sCpGjCw@mail.gmail.com>
References: <20240414161257.49145-1-ubizjak@gmail.com> <171312759954.10875.1385994404712358986.tip-bot2@tip-bot2> <20240415201119.GBZh2J57f3aouPE_JR@fat_crate.local> <CAFULd4aFSBHNxyVyVt9soPnJXDgiOu6qCCNMLoenFNXtk0W4wA@mail.gmail.com> <20240417184040.GEZiAXqKvw3uRcmTJL@fat_crate.local> <CAFULd4b8kRgy0p3pKwheLRHx7rX+4RuY-45_Zt-CCj5sCpGjCw@mail.gmail.com>
Message-ID: <F0416322-2D03-408E-BC77-E68F024DF3EF@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 17, 2024 9:21:29 PM GMT+02:00, Uros Bizjak <ubizjak@gmail=2Ecom> w=
rote:
>The above is perhaps a little unfortunate example taken from
>
>if (cmpxchg64(=2E=2E=2E))
>
>where the check is against zero=2E The compiler can optimize the check
>to a TEST insn in this particular case, but otherwise CMP will be
>emitted for different usages=2E Not a big difference, but a register has
>to be kept live across cmpxchg8b=2E
>
=2E=2E=2E
>
>There is one important issue=2E When a register (or two for double-word
>values) has to be kept live for a compare, the register pressure on
>32bit targets around cmpxchg8b goes through the roof, and when using
>the frame pointer (and maybe some fixed register, e=2Eg=2E PIC), the
>register allocator runs out of available registers=2E The number of
>spills around cmpxchg8b signals the troubles register allocator goes
>through to "fix" everything, so from the compiler PoV any relief is
>more than welcome here=2E Even in GCC internal libraries, we have had to
>take a special approach with this insn to avoid internal compiler
>errors=2E The kernel was quite lucky here ;)

That would've been a lot better reason to justify the change=2E I think yo=
u should put those things in the commit messages=2E

Thx=2E


--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

