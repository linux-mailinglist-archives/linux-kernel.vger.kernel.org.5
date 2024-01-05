Return-Path: <linux-kernel+bounces-18291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E484825AFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA91B22603
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7235EFC;
	Fri,  5 Jan 2024 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrFWCUSW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E936F358AA;
	Fri,  5 Jan 2024 19:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EB9C433C7;
	Fri,  5 Jan 2024 19:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704481996;
	bh=TuxsHZPh+jbfgxImCTm71c5GyVdW17unYFAC6L4xxiI=;
	h=From:Date:Subject:To:Cc:From;
	b=JrFWCUSW2E4tRnzwwDquw1A+SwIN/7ErdY9UvtNhlpkhKwTNOBKtnqNmSn6JenF8i
	 DPW1oPh8+jTyFCiC0b4IgljMTI4vFPBra0KQl7W0+i4y00vyK5lYMNhAjr5gmbD++O
	 IX+16X3Lh3tdODgYB9jxIkOHwvfXTHJWtHp6Q/LAKSoj97YNWqw1mZs+HH0QnQImXQ
	 6EtdPlLzRT2rieESyqbe+LmIf741E03rgundm0X3z4FTKue90lVW6Wwec05pjzS513
	 asD4Axef+hrgUO3bz6XmY821dZaHQmAQcqHK15fmYBqSysUswWk5Mx8xblhDV3iDCC
	 0KCFjNI01ACqQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 05 Jan 2024 12:13:04 -0700
Subject: [PATCH] lib/Kconfig.debug: Disable CONFIG_DEBUG_INFO_BTF for
 Hexagon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-hexagon-disable-btf-v1-1-ddab073e7f74@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL9UmGUC/x3MQQqAIBBG4avErBvQKIquEi00f2sgLDRCiO6et
 PwW7z2UEAWJxuqhiFuSHKFA1xUtmwkrWFwxNapplVYdb8hmPQI7ScbuYHt51kC/GNu7zg9UyjP
 CS/6v0/y+H4xK7h1lAAAA
To: akpm@linux-foundation.org
Cc: ndesaulniers@google.com, acme@kernel.org, dwarves@vger.kernel.org, 
 llvm@lists.linux.dev, linux-hexagon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
 kernel test robot <lkp@intel.com>, Brian Cain <bcain@quicinc.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=nathan@kernel.org;
 h=from:subject:message-id; bh=TuxsHZPh+jbfgxImCTm71c5GyVdW17unYFAC6L4xxiI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKkzQk5HJ8ROCf97a3ar7/Tfrxy0Nt5e+fPP3jaWO4c+y
 vxXSlgk3VHKwiDGxSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAm4vyEkeGpa0zO3M1h7lek
 uvbtamWwNOt8mhnYHmizpnTu3D03WnMZ/goEafGf8ikQfrxT5HuggOF3V1sNSxtdW70Ck12ZW/b
 zsgAA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

pahole, which generates BTF, relies on elfutils to process DWARF debug
info. Because kernel modules are relocatable files, elfutils needs to
resolve relocations when processing the DWARF .debug sections.

Hexagon is not supported in binutils or elfutils, so elfutils is unable
to process relocations in kernel modules, causing pahole to crash during
BTF generation.

Do not allow CONFIG_DEBUG_INFO_BTF to be selected for Hexagon until it
is supported in elfutils, so that there are no more cryptic build
failures during BTF generation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312192107.wMIKiZWw-lkp@intel.com/
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Brian Cain <bcain@quicinc.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4405f81248fb..1b939f5583eb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -378,6 +378,8 @@ config DEBUG_INFO_BTF
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
 	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >= 121
+	# pahole uses elfutils, which does not have support for Hexagon relocations
+	depends on !HEXAGON
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert

---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240105-hexagon-disable-btf-1ee7cab7d5f8

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


