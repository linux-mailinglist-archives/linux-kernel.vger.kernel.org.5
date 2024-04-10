Return-Path: <linux-kernel+bounces-139424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B448A032C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF0F2837C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04176184118;
	Wed, 10 Apr 2024 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="IiMjK5RZ"
Received: from ma-mailsvcp-mx-lapp03.apple.com (ma-mailsvcp-mx-lapp03.apple.com [17.32.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE1181CE4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787444; cv=none; b=mu2KAERL1EllvfWRZxN3W3U/ngV5paXehKkkjDXOABhZbjWy2RTuUTtdxldcQ3YGPQMNZPsZ0+AhiizlIE1+UjPK5EUlDQYHDncq1xfNbKzh0Rtx12WGHAtpnIqoE5goxfvH5SrZ+ZAlHpP0bk+/rtNOfrIgmTt91lqdUXCMeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787444; c=relaxed/simple;
	bh=nHTm4IkHTzWerMJ8v9avrsZE5U0RCkuIrXkQ+1yUBVM=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=o5NRnnqofwVnuMdEKnh/x9Gwu/5N7oZ/rOcB4tGbXCaq9u1cDgZKkFH4bq0iTYdVq3ThU0qHoo7LY7uGfeS32ItMfKeKLoG65C2cc2Rbt2hBb65suIneVN+HJr+cpsBq9ArIYv6Wlel2KKXMb14KDA1HztKgUWAci8K6vym0kX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=IiMjK5RZ; arc=none smtp.client-ip=17.32.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SBQ0095AWGDQO30@ma-mailsvcp-mx-lapp03.apple.com> for
 linux-kernel@vger.kernel.org; Wed, 10 Apr 2024 14:17:16 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from : to
 : cc : subject : date : message-id : mime-version : content-transfer-encoding;
 s=20180706; bh=HetBtjAbeNKKObaWpI5jJ2A3RgaXf6CNF2KW8DL5DY8=;
 b=IiMjK5RZiajWwizQ4THMkjgco3I5MZzvCZ9sIZnV2Cehh3V/G+pxjwyeYNdb53FF41Fi
 eoPkTZLvbsBXco2+GL1aLfqgbXlu2VLdageFASHZw6G79tmIsd3kh8PyAA8iqq1cw/Yr
 cpcfXAoW3+88fVKsyvEUEihJSUadoi9kSCYHTanfpaSNo4VIyovAO9tavLM+JFlalCIt
 89jE1JLPW0P5sC8t+bA8QYYvjRD6MyZMDzZT3nC55+k5vNrbMI2cbwVR22e9rQ/N4Gsh
 Rm2ZUabbgADszZr402cFkxjsMXGnGC2vIoUDcJaYNaLwOS8ZskP+Le8S1ddDAQ1sRaXI 2w==
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SBQ00B4SWGO9G91@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Wed, 10 Apr 2024 14:17:12 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SBQ00L00VZ22L00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 10 Apr 2024 14:17:12 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 062083411fbdfe5b9668648d0dddd4c2
X-Va-E-CD: cc7eb2f3f4d5c23d41ee639b8390ba78
X-Va-R-CD: 47ce8353f889a0ce7bfb0502aee22921
X-Va-ID: 1429ac5e-2a83-4311-a6c5-c195ad9577fa
X-Va-CD: 0
X-V-A:
X-V-T-CD: 062083411fbdfe5b9668648d0dddd4c2
X-V-E-CD: cc7eb2f3f4d5c23d41ee639b8390ba78
X-V-R-CD: 47ce8353f889a0ce7bfb0502aee22921
X-V-ID: 64eccdd0-ba58-4f9e-a35c-065e04ed13d3
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
Received: from mr41p01nt-relayp01.apple.com ([17.115.0.54])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SBQ00HCRWGK4E00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 10 Apr 2024 14:17:09 -0700 (PDT)
From: Zayd Qumsieh <zayd_qumsieh@apple.com>
To: zayd_qumsieh@apple.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>,
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>,
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>,
 Baoquan He <bhe@redhat.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>,
 Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tso: aarch64: Expose TSO for virtualized linux on Apple
 Silicon
Date: Wed, 10 Apr 2024 14:16:38 -0700
Message-id: <20240410211652.16640-1-zayd_qumsieh@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit

x86 CPUs use a TSO memory model. Apple Silicon CPUs have the ability to
selectively use a TSO memory model. This can be done by setting the
ACTLR.TSOEN bit to 1. This feature is useful for x86 emulators, since it
removes the need for emulators to insert memory barriers in order to abide
by the TSO memory model. This patch series will add ACTLR.TSOEN support to
virtualized linux on Apple Silicon machines. Userspace will be able to use
a prctl to change the memory model of the CPU from the default ARM64 memory
model to a TSO memory model.

A simple test can be used to determine if the TSO memory model is in use.
This must be done on Apple Silicon MacOS Sonoma version 14.4 or later,
since earlier versions do not support modification of the TSOEN bit.
https://github.com/saagarjha/TSOEnabler/blob/master/testtso/main.c

This program will hang indefinitely if TSO is in use, and will crash almost
immediately if it is not in use.

Zayd Qumsieh (3):
  tso: aarch64: allow linux kernel to read/write ACTLR.TSOEN
  tso: aarch64: context-switch tso bit on thread switch
  tso: aarch64: allow userspace to set tso bit using prctl

 arch/arm64/Kconfig                 | 19 +++++++++
 arch/arm64/include/asm/processor.h |  4 ++
 arch/arm64/include/asm/sysreg.h    |  7 ++++
 arch/arm64/include/asm/tso.h       | 19 +++++++++
 arch/arm64/kernel/Makefile         |  2 +-
 arch/arm64/kernel/process.c        | 61 +++++++++++++++++++++++++++++
 arch/arm64/kernel/tso.c            | 62 ++++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h         |  9 +++++
 kernel/sys.c                       | 11 ++++++
 9 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/tso.h
 create mode 100644 arch/arm64/kernel/tso.c

-- 
2.39.3 (Apple Git-146)


