Return-Path: <linux-kernel+bounces-82537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE3D868600
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4B71C21A36
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A994863B8;
	Tue, 27 Feb 2024 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="FJ6YLI7s"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D7525D;
	Tue, 27 Feb 2024 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997757; cv=none; b=V3dMERc7m1J2bAjxSDuHgpZG5Zf7EPy6vuZhT4r8q2/y7Qhd8o2j25jHy3UEgLFAbNZV3L0QuOvrybMiIQwr+DzgNouAOwKn8LfS91zn9y+Sq7w2VzwTAHW4Ky/pDqALGjQonxS5pt7UoOs+iENw3eqg/S8CzgbUbQAcmgo3aRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997757; c=relaxed/simple;
	bh=5prQOo/5DUmjL9n6Mn2+etl4F9JkZ9RfZ2EqTaQr7jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7swM/Vaxlg8YZn100pzzsLZ96OTQocgbs6a0Wz8qNG47jDbu37L6+vGRblHejBoSU8qQeWpEyUoyE7h3wSLLZbAOkxPYg2JeFcxROk6H/mD5CiMWilcQBss8j7S8c1WDDRl0ePHtPpcbLh0i90M6OwYXhMKuPC/e5wppb33II0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=FJ6YLI7s; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 0D6F48A;
	Mon, 26 Feb 2024 17:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1708997754;
	bh=2LGMoG5lzw93A3enN/2kw2d60L6ZTNDD2AvAsIcBPUA=;
	h=From:To:Cc:Subject:Date:From;
	b=FJ6YLI7sYbcpLH87YNKyDBadQUCtbuQwg4rTyYqz82ieGu866VqzLPH9zFr/wftHg
	 /ZlGqrj5BMlSWjMcPcAhBIqAlS2fWO4rWhGjUgjSiz2mBSatUs9hQR4xht8Fud0WPh
	 QJSVNGF2oJ0NU7A7ElTtq0x2ZjoxEH3TSSWL9hdU=
From: Zev Weiss <zev@bewilderbeest.net>
To: Russell King <linux@armlinux.org.uk>,
	linux-parisc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Helge Deller <deller@gmx.de>,
	Florent Revest <revest@chromium.org>
Cc: Zev Weiss <zev@bewilderbeest.net>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Yin Fengwei <fengwei.yin@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>,
	Josh Triplett <josh@joshtriplett.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	Sam James <sam@gentoo.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND 0/2] ARM: prctl: Reject PR_SET_MDWE where not supported
Date: Mon, 26 Feb 2024 17:35:40 -0800
Message-ID: <20240227013546.15769-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Resending as per Russell's request...]

Hello,

I noticed after a recent kernel update that my ARM926 system started
segfaulting on any execve() after calling prctl(PR_SET_MDWE).  After
some investigation it appears that ARMv5 is incapable of providing the
appropriate protections for MDWE, since any readable memory is also
implicitly executable.

(Note that I'm not an expert in either ARM arch details or the mm
subsystem, so please bear with me if I've botched something in the
above analysis.)

The prctl_set_mdwe() function already had some special-case logic
added disabling it on PARISC (commit 793838138c15, "prctl: Disable
prctl(PR_SET_MDWE) on parisc"); this patch series (1) generalizes that
check to use an arch_*() function, and (2) adds a corresponding
override for ARM to disable MDWE on pre-ARMv6 CPUs.

With the series applied, prctl(PR_SET_MDWE) is rejected on ARMv5 and
subsequent execve() calls (as well as mmap(PROT_READ|PROT_WRITE)) can
succeed instead of unconditionally failing; on ARMv6 the prctl works
as it did previously.


Thanks,
Zev

[0] https://lore.kernel.org/all/2023112456-linked-nape-bf19@gregkh/

Zev Weiss (2):
  prctl: Generalize PR_SET_MDWE support check to be per-arch
  ARM: prctl: Reject PR_SET_MDWE on pre-ARMv6

 arch/arm/include/asm/mman.h    | 14 ++++++++++++++
 arch/parisc/include/asm/mman.h | 14 ++++++++++++++
 include/linux/mman.h           |  8 ++++++++
 kernel/sys.c                   |  7 +++++--
 4 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/mman.h
 create mode 100644 arch/parisc/include/asm/mman.h

-- 
2.43.2


