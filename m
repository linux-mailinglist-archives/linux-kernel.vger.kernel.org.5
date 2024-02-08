Return-Path: <linux-kernel+bounces-57365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DAD84D78B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA69F284314
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED4F200AE;
	Thu,  8 Feb 2024 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="irSxI+Fu"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982541D6AA;
	Thu,  8 Feb 2024 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355598; cv=none; b=dF3x15Z4GqfnUzdnEchVMEfvveN4lF1OcVNpOnrWuyjO2j2c2RCOJdeyq+bHF7IFQq5SKVjR7qrliD63y6OMgLj1ekdHa0abLAVpNqXg1OA2tUmIhb2UxLtwd9FkNJlkVZhz1HcAzuDkMo6gAzMDSRpBX6t2Gd3VMbeyLztAHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355598; c=relaxed/simple;
	bh=j6d/T+9LmwknQyPw9UW66o8FfW4OYtd1tl4c1Kp289Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8qDgyLVtcgomhI25XuNEoSQbnU0soaYie/qCsx0TA6haSXdrLukY3mJ7AcBr13cvV+xnnd7boMywTYrNepwj8KG6AwWW7ABeVPB8kJ+3sty1Xsrrvh9mlxiXD5NR1zNoOOYGi79wMTfIejfpwnwA1nJilS2NqDUAc4mAtSDU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=irSxI+Fu; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 44659C9;
	Wed,  7 Feb 2024 17:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1707355588;
	bh=6ONNLssa/JJa3YO5Up1AtekZAzMtVDM0uR/O3aO7Adc=;
	h=From:To:Cc:Subject:Date:From;
	b=irSxI+FuU1hFzLtneHeVJ0eyyzW/aD27p1URn43PrNZ3mCJTaF8gG/XgUnNZoO+A/
	 oZkd4fPJQiT+LDTivSrrTc7wgokOgZn9Kdqxjenj0Yik29OMCIppa5NAZ2AV3SPt0B
	 ma0+vsxmXVNd0y/4K0ylCCx3i+O8juWJez93rPa4=
From: Zev Weiss <zev@bewilderbeest.net>
To: linux-parisc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Helge Deller <deller@gmx.de>,
	Florent Revest <revest@chromium.org>
Cc: Zev Weiss <zev@bewilderbeest.net>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Stefan Roesch <shr@devkernel.io>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Sam James <sam@gentoo.org>,
	stable@vger.kernel.org
Subject: [PATCH 0/2] ARM: prctl: Reject PR_SET_MDWE where not supported
Date: Wed,  7 Feb 2024 17:26:18 -0800
Message-ID: <20240208012620.32604-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Since this was effectively a userspace-breaking change in v6.3 (with
newer MDWE-aware userspace on older pre-MDWE kernels the prctl would
simply fail safely) I've CCed -stable for v6.3+, though since the
patches depend on the PARISC one above it will only apply cleanly on
the linux-6.6.y and linux-6.7.y branches, since at least at time of
writing the 6.3 through 6.5 branches don't have that patch backported
(due to further missing dependencies [0]).


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
2.43.0


