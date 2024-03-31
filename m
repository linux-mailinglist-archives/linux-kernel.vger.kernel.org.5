Return-Path: <linux-kernel+bounces-126053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40689317E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC950B21623
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5941442FC;
	Sun, 31 Mar 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W0okKfoR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482175803
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711884240; cv=none; b=Bt1X7JTuo3ZEq/tpnAFIOpWotSywgXygAsdQSTZglK3oN5vuSWtH8lXsUpii+ytIb8GwDmU+ydxwU30mgqOOlZ/nsJEx6VIDjT6AqgdToip3v7gjE6hJuD/ruJC2Se8ofdnZD285mIO0ijA3Mb8PQN/8chGbYfGts7E750Wz/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711884240; c=relaxed/simple;
	bh=5JxUsSXMCSWhZ6xditAkMrzlNfdaTlrJ992weujTTts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D4zSfVRqF11bc0jjEbd6F4oWMLiTuukS8l00Ie1pKCD3WVmPRWLpj44IUP6zjYOsdfGjkljOSGHTIYnqsFVkeP9nbwkb3aXykTimjTlZAe7dqCb0ytCQhl6llMKFr2HoWfWTbj9s04EUJ0YYc/zwb2t9WHAU+w/dIahWnbYr/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W0okKfoR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5113140E016B;
	Sun, 31 Mar 2024 11:23:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zIr8XeVslluJ; Sun, 31 Mar 2024 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711884232; bh=IcVtkBPKIAjlVfemdQsIzUpiLSl2adxIcpTQ+gQY45k=;
	h=Date:From:To:Cc:Subject:From;
	b=W0okKfoR8OT3PRY0Y1XYQMLZbUouPo4o9RVGYUB1xvscH4H8hjIlScqZ48VPFU1uY
	 8kmLMl8zPDTyI/S0/iB6v1BOuvKegI/EF8YFLx5EpRbFss3C0FCutaI7DmA3G40oOe
	 s6mA/J3mMroEn2CH7Ssfmcmp6sTU8Xvv8AshpW9tH41qjY7xibBwtp/8+dYEs/If/A
	 JJt9nPQ6rxXh3hBHNewhIXkt4kZgK++LK3G5fiaGruZlczgYDCfyse9xbVN5/Ovxoq
	 y3Vn/p9cPHIwfei/lWf+xdg1OxkdDxnEc6NWRwKznAr0XgATUj7NuKK9/QkvYt4ujQ
	 tiadPxgwQES0Nk5zpG97oUmPgvJZ1+Qf/Zqi6PwitXpyFVvF7pLtFw/kXSiR5ZnUzh
	 y2P7xKcvueanRwJqCFK6qYijXEYm0gnck5XpQDNXWS+8jRMl7v+lVCu860hr1O/ZBC
	 qBvjqRiLnsX2Vm4zS/UMvZvFVl1XNMaiJqTSghc1S5e52z5qqyoWTVhUrB8haOrxq1
	 IaLWZcyRs5333qXaT53nmmT5XSsYa565b2FCNRir+egaY3/LK99NVfqNU7KEDAPGHE
	 LFnTBHURpDCxIOuHqu8MiMqUFWT9SPwFT9oSLq9kgd5JzSnVwb3tDG+HxLdiNdVxFc
	 Sl4/rhpCQN2jIzySvM0Efoh4=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 665EB40E0028;
	Sun, 31 Mar 2024 11:23:49 +0000 (UTC)
Date: Sun, 31 Mar 2024 13:23:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.9-rc2
Message-ID: <20240331112344.GAZglHwOp8M9XR1akK@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple of urgent perf fixes to the AMD side of things, for
v6.9-rc2.

Thx.

---

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.9_rc2

for you to fetch changes up to 68cdf1e6e8f2ce78ed7d8f5d80844fd75a9c54ff:

  perf/x86/amd/core: Define a proper ref-cycles event for Zen 4 and later (2024-03-26 09:04:21 +0100)

----------------------------------------------------------------
- Define the correct set of default hw events on AMD Zen4

- Use the correct stalled cycles PMCs on AMD Zen2 and newer

- Fix detection of the LBR freeze feature on AMD

----------------------------------------------------------------
Sandipan Das (4):
      x86/cpufeatures: Add new word for scattered features
      perf/x86/amd/lbr: Use freeze based on availability
      perf/x86/amd/core: Update and fix stalled-cycles-* events for Zen 2 and later
      perf/x86/amd/core: Define a proper ref-cycles event for Zen 4 and later

 arch/x86/events/amd/core.c               | 39 ++++++++++++++++++++++++++++----
 arch/x86/events/amd/lbr.c                | 16 ++++++++-----
 arch/x86/include/asm/cpufeature.h        |  6 +++--
 arch/x86/include/asm/cpufeatures.h       | 10 +++++++-
 arch/x86/include/asm/disabled-features.h |  3 ++-
 arch/x86/include/asm/required-features.h |  3 ++-
 arch/x86/kernel/cpu/scattered.c          |  1 +
 7 files changed, 62 insertions(+), 16 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

