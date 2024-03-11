Return-Path: <linux-kernel+bounces-98570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D7877C15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E777D1F2119F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF218C01;
	Mon, 11 Mar 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HhPuI/Jr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085E182DA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147596; cv=none; b=U83FcSJGi/wwqd5N2w7m6mbJBesmQ60MuSfTyzx9sBXgmzcnanOLlS9zWzSu226T9RTGuTT9WjpIxuO/luwSe4CR9xMSj9fRKzQTtQ57g+6mwDdlcdCGfZU7i2CpRf/BDf6d4lwt0grwz7OUDhHHLwh8jhPYIQAf91DwLIoT4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147596; c=relaxed/simple;
	bh=Mc3cuYZd9FQ4OqSovr4RO7iXalx9PAh+bC7geOvGND0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fz+nS9rLEsOJJGMpMAypWUYLwrc+Fh5Y0eSbhlD2djpk3++IeT7SJje5+3gRv4KUpl2YhNIv2v/DCblYJS6lCofARz3q2neNdKyDQ9cq9ScJNc00m2tXWRK6TloTSME3p5078LrA5n/11iSsNDIcVKPOVqY/cCKjGbphu70EXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HhPuI/Jr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D713840E0028;
	Mon, 11 Mar 2024 08:59:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OLASZUHsbT25; Mon, 11 Mar 2024 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710147590; bh=Ad0pIHUFtXNQn/LeOxbNbuVDrkwtgeQDc/OJ13rKKfQ=;
	h=Date:From:To:Cc:Subject:From;
	b=HhPuI/JrB+aux8YkzCWTR70DHoNs4g1bW6n9xhlCFqJi4t+qj2TRxMEb6d84tHsZJ
	 bLR7xAGjT7Q08pvMJCA/RvV7Hp7F10vKa02kHMoVOoPMeRoj2Cij+3v5q6Opo695js
	 DtmrXSnD3jO5Ryf4LBgjvxmrmXZc4FEvqoO9AN9FRNzMEiqI3PejupnS/DxtMNNDOw
	 00+fbnZMWesi/USg6lly+KAS/pTg7s1igedXUR5JiUnzF4Upn9i8bhAACBt2sNnUnB
	 YTNbSM5okl67sfZHZzdj2DiGY0NnH4JRZxUc2XOYnFaLfJNvSh7PTEQ48dScqmREf1
	 YwnPTbE1t7oHKmI3tElxQHP0UXK80SyxcbFc+/hEbtNS8sQDoy8bLg9BG5VhxZim3b
	 qVZRKKwY8A0yJ6N9/oeyOmaKGdFU1ehytRtgCfupuw0hvRmExTIcbRTaK/EfoX9ecO
	 Gzqr1zCeyYJAU74nuwiNbD5+7CuX9rZPzNXNCvUZjJNaXkg6krsk7uNboNfJ8+K9B0
	 JIOerCtiQhLTGdjN3UXtu6xyJH4UIleySOrR69MN5Zo1vEVdJkSgLJiNmLZnhZ4jsQ
	 mXCSSE+/pzl36MK0JwQ/9AL/ferLQmetTxnx7iEopW/6fZcrvCBQ9P125xf1O58MMw
	 3p5bXidE7oSBxnIn1fH1h2S0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC5E040E016C;
	Mon, 11 Mar 2024 08:59:47 +0000 (UTC)
Date: Mon, 11 Mar 2024 09:59:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/mtrr for v6.9-rc1
Message-ID: <20240311085946.GAZe7IAmgi_z4j5rMW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single improvement of PAT MSR programming for v6.9-rc1.

Thx.

---

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mtrr_for_v6.9_rc1

for you to fetch changes up to ffc92cf3db62443c626469ef160f9276f296f6c6:

  x86/pat: Simplify the PAT programming protocol (2024-02-20 14:40:51 +0100)

----------------------------------------------------------------
 - Relax the PAT MSR programming which was unnecessarily using the MTRR
   programming protocol of disabling the cache around the changes. The
   reason behind this is the current algorithm triggering a #VE
   exception for TDX guests and unnecessarily complicating things

----------------------------------------------------------------
Kirill A. Shutemov (1):
      x86/pat: Simplify the PAT programming protocol

 arch/x86/kernel/cpu/cacheinfo.c | 7 ++++---
 arch/x86/mm/pat/memtype.c       | 9 +++------
 2 files changed, 7 insertions(+), 9 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

