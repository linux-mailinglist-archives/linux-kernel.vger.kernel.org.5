Return-Path: <linux-kernel+bounces-119208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8194D88C5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3606E1F61F00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231F13C801;
	Tue, 26 Mar 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4BQDDTk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2EFED9;
	Tue, 26 Mar 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464475; cv=none; b=PAfCurn4xudZRybbuD85+d1vw6LsFdeT7zqCxPDo39QLV7XhXMOJGm1k1yxRKqyi/JSfoG5+YLF4ugZ6nQjqqvREPql0L07GKtHxjbtZpDu9b+lkaM+lIs+RJpyd7A7k6CQ1yWwUuidiIwpPiYFOs/JkpbbCUNCgv3waKKlOwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464475; c=relaxed/simple;
	bh=2VRodtLYji0E2iO14KF37hDwen2VjVMAvwAcrcgPpT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RP8DQWyViGOgZmbG2QgzfPgzfywKA/8kNopgnvNdc4T6EGj7lUY4r7gXw1Opte+0uc+fUuisIXtCDlUPqjnQW03IOAW28kHepgtmA8eSrcorHK9W+3xOlMOLutz9UQHP5vIMjzlkvWulGnlVHp5NSC5gpQjGL6gYvjuJAQ743BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4BQDDTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C54DC433F1;
	Tue, 26 Mar 2024 14:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464475;
	bh=2VRodtLYji0E2iO14KF37hDwen2VjVMAvwAcrcgPpT4=;
	h=From:To:Cc:Subject:Date:From;
	b=E4BQDDTkgrdwdIkmMvielkRpTAsqHIEG3dNSrY21fnxwoLYvLOoCje+XGKi0Q6+lb
	 vXFNIViLU9NTXcLVTR3XwdRIIouf6xWYpzwnmHI2t5ZxiCoyK5CtJGLAMaMQhP4GqM
	 LFJItP61E8WSzWQOgV3iidHNLT5C63yxLkS/wCtha2CzziKBhSzJgJ8mdUJnDc4MsM
	 mHMWnrCmz0M9BMr26mXQL/Ot8TdiiiLpbc7Z6ykNI9wEj4r4WuyvPMGjqE0R7U0B4a
	 JYlh8463XR1dZ+1yi/iNsx2NnACkLOIgc70LBf5p2SbJ28JbOOieq3jHp29R//i1VX
	 XyBZZot1G0W0w==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Bill Metzenthen <billm@melbpc.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Manoj N. Kumar" <manoj@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: [PATCH 00/12] kbuild: enable some -Wextra warnings by default
Date: Tue, 26 Mar 2024 15:47:15 +0100
Message-Id: <20240326144741.3094687-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This is a follow-up on a couple of patch series I sent in the past,
enabling -Wextra (aside from stuff that is explicitly disabled),
-Wcast-function-pointer-strict and -Wrestrict.

I have tested these on 'defconfig' and 'allmodconfig' builds across
all architectures, as well as many 'randconfig' builds on x86, arm and
arm64. It would be nice to have all the Makefile.extrawarn changes in
v6.10, hopefully with the driver fixes going in before that through
the respective subsystem trees.

     Arnd

Arnd Bergmann (12):
  kbuild: make -Woverride-init warnings more consistent
  [v3] parport: mfc3: avoid empty-body warning
  kbuild: turn on -Wextra by default
  kbuild: remove redundant extra warning flags
  firmware: dmi-id: add a release callback function
  nouveau: fix function cast warning
  cxlflash: fix function pointer cast warnings
  x86: math-emu: fix function cast warnings
  kbuild: enable -Wcast-function-type-strict unconditionally
  sata: sx4: fix pdc20621_get_from_dimm() on 64-bit
  [v4] kallsyms: rework symbol lookup return codes
  kbuild: turn on -Wrestrict by default

 arch/x86/math-emu/fpu_etc.c                   |  9 +++--
 arch/x86/math-emu/fpu_trig.c                  |  6 ++--
 arch/x86/math-emu/reg_constant.c              |  7 +++-
 drivers/ata/sata_sx4.c                        |  6 ++--
 drivers/firmware/dmi-id.c                     |  7 +++-
 .../gpu/drm/amd/display/dc/dce110/Makefile    |  2 +-
 .../gpu/drm/amd/display/dc/dce112/Makefile    |  2 +-
 .../gpu/drm/amd/display/dc/dce120/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/dce60/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile |  2 +-
 drivers/gpu/drm/i915/Makefile                 |  6 ++--
 .../drm/nouveau/nvkm/subdev/bios/shadowof.c   |  7 +++-
 drivers/gpu/drm/xe/Makefile                   |  4 +--
 drivers/net/ethernet/renesas/sh_eth.c         |  2 +-
 drivers/parport/parport_mfc3.c                |  3 +-
 drivers/pinctrl/aspeed/Makefile               |  2 +-
 drivers/scsi/cxlflash/lunmgt.c                |  4 +--
 drivers/scsi/cxlflash/main.c                  | 14 ++++----
 drivers/scsi/cxlflash/superpipe.c             | 34 +++++++++----------
 drivers/scsi/cxlflash/superpipe.h             | 11 +++---
 drivers/scsi/cxlflash/vlun.c                  |  7 ++--
 fs/proc/Makefile                              |  2 +-
 include/linux/filter.h                        | 14 ++++----
 include/linux/ftrace.h                        |  6 ++--
 include/linux/module.h                        | 14 ++++----
 kernel/bpf/Makefile                           |  2 +-
 kernel/bpf/core.c                             |  7 ++--
 kernel/kallsyms.c                             | 23 +++++++------
 kernel/module/kallsyms.c                      | 26 +++++++-------
 kernel/trace/ftrace.c                         | 13 +++----
 mm/Makefile                                   |  3 +-
 scripts/Makefile.extrawarn                    | 33 ++++--------------
 32 files changed, 134 insertions(+), 148 deletions(-)

-- 
2.39.2

Cc: Bill Metzenthen <billm@melbpc.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: "Manoj N. Kumar" <manoj@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-scsi@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-modules@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev

