Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FEA753BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjGNNnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjGNNnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC42D64
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C378461D08
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B21C433C8;
        Fri, 14 Jul 2023 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689342209;
        bh=Wl+NOirb0+IZpn85ajXuMmTBackogxREuPeBWQEkt5w=;
        h=Date:From:To:Cc:Subject:From;
        b=Ho7/7Y21p+m6b4dUaDJlBJM6AJap8U3+8SSpEAkHci19lT8AWN23RSrlaKJPBAEGL
         1q03mv9Q72t3ZTwx9JJfCyOMnvRz162PD25BAZ2fuIe3J08nzwT0b9jsujbM+ZQYgT
         WctExiXCKBY7ijwKp/tWw/TtSl2t3KwwcjEWd46rT8ye9iBYO6vlhyWgbKhFtaS0UI
         qM3Gi1GfWQuvGZeIXlEVbmLtALdxCMqGSfbMHKitwOqPH6t/cMD3Ile3ZpaAlaNGwE
         o2jETN1rHtlwaZ2PbGLgcZ0Mz9GBpFRJajckOVG8U4y+duOIqJt/HJ7ztLJ+2ZiYM7
         sZJXRaeuHVXPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3A0AB40516; Fri, 14 Jul 2023 10:43:26 -0300 (-03)
Date:   Fri, 14 Jul 2023 10:43:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers arm64: Sync arm64's cputype.h with the
 kernel sources
Message-ID: <ZLFQ/tu/ATQwDEIW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To get the changes in:

  e910baa9c1efdf76 ("KVM: arm64: vgic: Add Apple M2 PRO/MAX cpus to the list of broken SEIS implementations")

That makes this perf source code to be rebuilt:

  CC      /tmp/build/perf-tools/util/arm-spe.o

The changes in the above patch don't affect things that are used in
arm-spe.c (things like MIDR_NEOVERSE_N1, etc). Unsure if Apple M2 has
SPE (Statistical Profiling Extension) :-)

That addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ali Saidi <alisaidi@amazon.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/asm/cputype.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 683ca3af408485aa..5f6f84837a490375 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -126,6 +126,10 @@
 #define APPLE_CPU_PART_M1_FIRESTORM_MAX	0x029
 #define APPLE_CPU_PART_M2_BLIZZARD	0x032
 #define APPLE_CPU_PART_M2_AVALANCHE	0x033
+#define APPLE_CPU_PART_M2_BLIZZARD_PRO	0x034
+#define APPLE_CPU_PART_M2_AVALANCHE_PRO	0x035
+#define APPLE_CPU_PART_M2_BLIZZARD_MAX	0x038
+#define APPLE_CPU_PART_M2_AVALANCHE_MAX	0x039
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
 
@@ -181,6 +185,10 @@
 #define MIDR_APPLE_M1_FIRESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_MAX)
 #define MIDR_APPLE_M2_BLIZZARD MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD)
 #define MIDR_APPLE_M2_AVALANCHE MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE)
+#define MIDR_APPLE_M2_BLIZZARD_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_PRO)
+#define MIDR_APPLE_M2_AVALANCHE_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_PRO)
+#define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
+#define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
-- 
2.37.1

