Return-Path: <linux-kernel+bounces-126028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11A89312C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAA1282707
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DBC2EAE5;
	Sun, 31 Mar 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a4pXD/Jl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF676050
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711880204; cv=none; b=utMzpLz+C4mmWHSyKhnGWRQvaovHjHxUIiQ8hDWoX6xNqmHk0zDhDpYQ8LRKqd2nMuxQG3KtP5K5POny4NRw1M730Rt0hDQJ9aEFZhl/Cq9wcZ5VtwAVwE4qfXS5uTBqHIsEy0mJiXDedElHkwY8SVCQIsXRxj3SOr7oZGv8abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711880204; c=relaxed/simple;
	bh=H3ycVgsRJTJJrcDSqrUsU2RC18j3B+ELOPKEFoqwY14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jrQNpJ0jdKcGdHaaji+bWr2dkaxKRmmH2CItvygreG9/oQlNn/HcJV1xo3J8/RuHEAhsofvAMgLGaiIUd9AZ37Erp/RepLdoDUQxwJ3qhVCT5itYIa1Yce+niwx9475VifohV49Xc3JMRYUHTzn4xheTW6X2QBBRSUYBlzgxHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a4pXD/Jl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78A7A40E0202;
	Sun, 31 Mar 2024 10:16:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L1UBLig6gS8s; Sun, 31 Mar 2024 10:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711880197; bh=Wc8KOaLGsOSzixx6Mvq1IC+2rGDC4iJp6dAFoNuW15A=;
	h=Date:From:To:Cc:Subject:From;
	b=a4pXD/JlXXqASiT4JL3aIw9Rio9y6AcNjQpNlHC/rsOTY5sS2L6YIk1na+RwxdjO+
	 wCaeIZMOV2/R4iGuCOzsnJ53QYKNaMM8CBqeJpts4HkmRImJxRQC0ja+H31M7UJPXY
	 M8XHqz3ESSyQ09jwWhmRgKbS5dG42VhOakW1lY0RhBZETzJ1L1OXpRuJ2FLfDPMoI9
	 PUcbg2MUeGzk98nXbdb+tmu8Mo8Vtqfy4g3XZ22OIBuYkVzdwzbvvW78/gdZBYqkEp
	 qgcou6t2gwn4gTzRWjPohDLH4cwLBtlTlGMyol5Cmy2OC5E8FVB+H8+qRsiuANH03o
	 w3Ua1MWZXZYhfLdHBakPso6J57KkrGi2hfByqFmNLlc+u96TmJPDeTqHkJr2296Xtn
	 ojZjF6nuqpyY5cOfl4wextvg8nWkuq8hEiJthLJYuZn69pD28wMJOUW+DQcp20Jcms
	 VnmV3SFBDjGRei4yJqTjIpZf4J66etEOJkA7xj2LM14Q795jQj30PWckw6Ng5QFQWM
	 SJMWeU5PfdjoDwHrNAF2esDD3o4fW78vnVPO3eUThCE2jB/XW0uisSOMpeP4hTtTIt
	 aT/1mnfdh+b4ryOT5Pmwj0Lhiu8RUTk2ykkbMU6PL3g3/xwd6iPrFtRJDqzzvmiZLP
	 BxEEv1ZxKwzyWIv3hWmGhWLY=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02EB440E00B2;
	Sun, 31 Mar 2024 10:16:33 +0000 (UTC)
Date: Sun, 31 Mar 2024 12:16:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.9-rc2
Message-ID: <20240331101625.GAZgk3-cPeMkj9y3JD@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull x86 urgent fixes for v6.9-rc2.

Thx.

---

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.9_rc2

for you to fetch changes up to 3f1a9bc5d878004ed4bc3904e5cb9b7fb317fbe2:

  x86/build: Use obj-y to descend into arch/x86/virt/ (2024-03-30 10:41:49 +0100)

----------------------------------------------------------------
- Make sure single object builds in arch/x86/virt/ ala
    make ... arch/x86/virt/vmx/tdx/seamcall.o
  work again

- Do not do ROM range scans and memory validation when the kernel is
  running as a SEV-SNP guest as those can get problematic and, before
  that, are not really needed in such a guest

- Exclude the build-time generated vdso-image-x32.o object from objtool
  validation and in particular the return sites in there due to
  a warning which fires when an unpatched return thunk is being used

- Improve the NMI CPUs stall message to show additional information
  about the state of each CPU wrt the NMI handler

- Enable gcc named address spaces support only on !KCSAN configs due to
  compiler options incompatibility

- Revert a change which was trying to use GB pages for mapping regions
  only when the regions would be large enough but that change lead to
  kexec failing

- A documentation fixlet

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/vdso: Fix rethunk patching for vdso-image-x32.o too

Ingo Molnar (2):
      Documentation/x86: Fix title underline length
      Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Kevin Loughlin (1):
      x86/sev: Skip ROM range scans and validation for SEV-SNP guests

Masahiro Yamada (1):
      x86/build: Use obj-y to descend into arch/x86/virt/

Paul E. McKenney (1):
      x86/nmi: Upgrade NMI backtrace stall checks & messages

Uros Bizjak (1):
      x86/percpu: Disable named address spaces for KCSAN

 Documentation/arch/x86/resctrl.rst |  2 +-
 arch/x86/Kbuild                    |  2 +-
 arch/x86/Kconfig                   |  2 ++
 arch/x86/Makefile                  |  2 --
 arch/x86/entry/vdso/Makefile       |  1 +
 arch/x86/include/asm/sev.h         |  4 ++--
 arch/x86/include/asm/x86_init.h    |  3 ++-
 arch/x86/kernel/eisa.c             |  3 ++-
 arch/x86/kernel/nmi.c              | 24 ++++++++++++++----------
 arch/x86/kernel/probe_roms.c       | 10 ----------
 arch/x86/kernel/setup.c            |  3 +--
 arch/x86/kernel/sev.c              | 27 ++++++++++++---------------
 arch/x86/kernel/x86_init.c         |  2 ++
 arch/x86/mm/ident_map.c            | 23 +++++------------------
 arch/x86/mm/mem_encrypt_amd.c      | 18 ++++++++++++++++++
 arch/x86/virt/Makefile             |  2 +-
 16 files changed, 64 insertions(+), 64 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

