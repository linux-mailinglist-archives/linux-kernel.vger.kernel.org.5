Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949CC810778
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378153AbjLMBSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377653AbjLMBSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:18:36 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054599
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:18:42 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-59052ab970eso2692686eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702430321; x=1703035121; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AV1SAk1YVG6iuaSkOAjdNt+pW2XrIuBdrjTgLb6AGNI=;
        b=UEGUVuY2Px+VqcaQfkhDfyvmfylZNwPA9FOzNb2s9ABLM44knGig6ZsXXabB+oMaj2
         Vyt+GqaeY6UMKjDoB/xJ7qNhWGmFqdNAzjHjd+w04Mili/ThQmpoFUHbOjyyRPkO6leE
         mBS3XAhOE+yh/jM3vJWzWl182bl8RFTzcAFcCHASK3Hm0r0R/AGZ0ORmN2GN0HdSg/kr
         +t/Vnuoohj3CAzbNRJX+sXsgWCoC5DtGVPBCkRDMqQmKx+OjbCDAmpcIs2pGTL2NfJHX
         1xyNIR4c89QZTgOOQ7ssJdZ9Ly2FmN4MwpI+4j2CDZFSiDjch0O1avynp1EuANce8nTA
         4TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702430321; x=1703035121;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AV1SAk1YVG6iuaSkOAjdNt+pW2XrIuBdrjTgLb6AGNI=;
        b=dnlRhe48cXgVBpQKf4PcOYxqkgWUpVq8ciy/pR3nxQW+aLy4+dCYX271tWQcrI/k/V
         KFdXN1K1buejgDA77dKA4p3AekVCipmNTryKMZGz/3ximAOT25ud1EO5uAbrK0qjQ8c7
         X4KtD6PcMXMyqfGRM+ngnrj32lsnWd1NVNDfDsfr+oajbonLx8bxlCLQSFDghRRHnwxn
         2RI9+4Y2jWWLcbtVlkrR5TXdmPbCydedrGa24dKrNN4e+5xLsEL0uTmV5IggEdNzA3nr
         zRZ3Tf7kaRp+I00jLqyLU/fUvEEPehfCwUGoO3qL8vwpF3aBcVIlDX56j+8l86+5Btsr
         j8FQ==
X-Gm-Message-State: AOJu0YwkADpoWDn+9+Z5vCOZVlm/ebs1OEjUn+1uztxxfy7wP3oXiLwz
        NWY/+krDzDYrxK1YNGNqRSnZog==
X-Google-Smtp-Source: AGHT+IEtalJG8pX6banZkhaaoATYu+MOlnUwfrgLZsuZnTqCMNuD+zfYSnsUqzy95EXaR+swJ9L4Yg==
X-Received: by 2002:a05:6830:16c6:b0:6d9:a843:5cac with SMTP id l6-20020a05683016c600b006d9a8435cacmr3835218otr.24.1702430321334;
        Tue, 12 Dec 2023 17:18:41 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id cy26-20020a056830699a00b006d9a339773csm172548otb.27.2023.12.12.17.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:18:40 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v12 0/5] riscv: Add fine-tuned checksum functions
Date:   Tue, 12 Dec 2023 17:18:37 -0800
Message-Id: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG4GeWUC/23S207DMAwG4FdBvaYods5c8R4IoSROWYS2Tu2og
 GnvjjshViFf2lI+x7987uY6tTp3j3fnbqpLm9t44ALw/q4ru3R4q30jbnSoUKugTD8eT23fvut
 r2dXyPn/se8pgLIaQCkLH745THdrnFX1+4XrX5tM4fV1nLLB2fzV0grZAr/qovVWQmcX0NLVln
 NuhPJRx363ggjckKishyEgp5Gyg7I3OAqK3iJcQvSJWIWlDkbwWELNBACTEMOJ9KZgoVlYExG4
 RKeHFrj+JNgdM6K2vAuK2iJiJYwRMcmVwUBwEAfFbJEqIZ0S54kkRkSUnIOEPAYVisIGRoWYPC
 ggwkIDEDaLFYCMjNSkI1cWMGAUE1E3hWeK18Tp9MjFY73OOTmRgw4C4EaxX6/lKojVD1Q7+MZf
 L5Qd1Blb+bAMAAA==
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <david.laight@aculab.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702430319; l=7032;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hhrQzOtg29ilpnF0KqwhibO8LcaAh9ruxtpwYWLHGNc=;
 b=XoufOpIR6z8mIBryhXj6xk4SWqhN7kb6JFgC2RK/ZTBO8uYSu0xoLXh/Olwt1UFEQMsnoNm6Q
 BkdAF/8ERcLCC0Ux9oeJdejUuoyUmeaPcFMZNo/fngO9+DieF9abykK
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each architecture generally implements fine-tuned checksum functions to
leverage the instruction set. This patch adds the main checksum
functions that are used in networking. Tested on QEMU, this series
allows the CHECKSUM_KUNIT tests to complete an average of 50.9% faster.

This patch takes heavy use of the Zbb extension using alternatives
patching.

To test this patch, enable the configs for KUNIT, then CHECKSUM_KUNIT.

I have attempted to make these functions as optimal as possible, but I
have not ran anything on actual riscv hardware. My performance testing
has been limited to inspecting the assembly, running the algorithms on
x86 hardware, and running in QEMU.

ip_fast_csum is a relatively small function so even though it is
possible to read 64 bits at a time on compatible hardware, the
bottleneck becomes the clean up and setup code so loading 32 bits at a
time is actually faster.

Relies on https://lore.kernel.org/lkml/20230920193801.3035093-1-evan@rivosinc.com/

---
    
The algorithm proposed to replace the default csum_fold can be seen to
compute the same result by running all 2^32 possible inputs.
    
static inline unsigned int ror32(unsigned int word, unsigned int shift)
{
	return (word >> (shift & 31)) | (word << ((-shift) & 31));
}

unsigned short csum_fold(unsigned int csum)
{
	unsigned int sum = csum;
	sum = (sum & 0xffff) + (sum >> 16);
	sum = (sum & 0xffff) + (sum >> 16);
	return ~sum;
}

unsigned short csum_fold_arc(unsigned int csum)
{
	return ((~csum - ror32(csum, 16)) >> 16);
}

int main()
{
	unsigned int start = 0x0;
	do {
		if (csum_fold(start) != csum_fold_arc(start)) {
			printf("Not the same %u\n", start);
			return -1;
		}
		start += 1;
	} while(start != 0x0);
	printf("The same\n");
	return 0;
}

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
To: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
To: David Laight <David.Laight@aculab.com>
To: Xiao Wang <xiao.w.wang@intel.com>
To: Evan Green <evan@rivosinc.com>
To: linux-riscv@lists.infradead.org
To: linux-kernel@vger.kernel.org
To: linux-arch@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

---
Changes in v12:
- Rebase onto 6.7-rc5
- Add performance stats in the cover letter
- Link to v11: https://lore.kernel.org/r/20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com

Changes in v11:
- Extensive modifications to comply to sparse
- Organize include statements (Xiao)
- Add csum_ipv6_magic to commit message (Xiao)
- Remove extraneous len statement (Xiao)
- Add kasan_check_read call (Xiao)
- Improve comment field checksum.h (Xiao)
- Consolidate "buff" and "len" into one parameter "end" (Xiao)
- Link to v10: https://lore.kernel.org/r/20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com

Changes in v10:
- Move tests that were riscv-specific to be arch agnostic (Arnd)
- Link to v9: https://lore.kernel.org/r/20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com

Changes in v9:
- Use ror64 (Xiao)
- Move do_csum and csum_ipv6_magic headers to patch 4 (Xiao)
- Remove word "IP" from checksum headers (Xiao)
- Swap to using ifndef CONFIG_32BIT instead of ifdef CONFIG_64BIT (Xiao)
- Run no alignment code when buff is aligned (Xiao)
- Consolidate two do_csum implementations overlap into do_csum_common
- Link to v8: https://lore.kernel.org/r/20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com

Changes in v8:
- Speedups of 12% without Zbb and 21% with Zbb when cpu supports fast
  misaligned accesses for do_csum
- Various formatting updates
- Patch now relies on https://lore.kernel.org/lkml/20230920193801.3035093-1-evan@rivosinc.com/
- Link to v7: https://lore.kernel.org/r/20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com

Changes in v7:
- Included linux/bitops.h in asm-generic/checksum.h to use ror (Conor)
- Optimized loop in do_csum (David)
- Used ror instead of shifting (David)
- Unfortunately had to reintroduce ifdefs because gcc is not smart
  enough to not throw warnings on code that will never execute
- Use ifdef instead of IS_ENABLED on __LITTLE_ENDIAN because IS_ENABLED
  does not work on that
- Only optimize for zbb when alternatives is enabled in do_csum
- Link to v6: https://lore.kernel.org/r/20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com

Changes in v6:
- Fix accuracy of commit message for csum_fold
- Fix indentation
- Link to v5: https://lore.kernel.org/r/20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com

Changes in v5:
- Drop vector patches
- Check ZBB enabled before doing any ZBB code (Conor)
- Check endianness in IS_ENABLED
- Revert to the simpler non-tree based version of ipv6_csum_magic since
  David pointed out that the tree based version is not better.
- Link to v4: https://lore.kernel.org/r/20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com

Changes in v4:
- Suggestion by David Laight to use an improved checksum used in
  arch/arc.
- Eliminates zero-extension on rv32, but not on rv64.
- Reduces data dependency which should improve execution speed on
  rv32 and rv64
- Still passes CHECKSUM_KUNIT and RISCV_CHECKSUM_KUNIT on rv32 and
  rv64 with and without zbb.
- Link to v3: https://lore.kernel.org/r/20230907-optimize_checksum-v3-0-c502d34d9d73@rivosinc.com

Changes in v3:
- Use riscv_has_extension_likely and has_vector where possible (Conor)
- Reduce ifdefs by using IS_ENABLED where possible (Conor)
- Use kernel_vector_begin in the vector code (Samuel)
- Link to v2: https://lore.kernel.org/r/20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com

Changes in v2:
- After more benchmarking, rework functions to improve performance.
- Remove tests that overlapped with the already existing checksum
  tests and make tests more extensive.
- Use alternatives to activate code with Zbb and vector extensions
- Link to v1: https://lore.kernel.org/r/20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com

---
Charlie Jenkins (5):
      asm-generic: Improve csum_fold
      riscv: Add static key for misaligned accesses
      riscv: Add checksum header
      riscv: Add checksum library
      kunit: Add tests for csum_ipv6_magic and ip_fast_csum

 arch/riscv/include/asm/checksum.h   |  93 ++++++++++
 arch/riscv/include/asm/cpufeature.h |   2 +
 arch/riscv/kernel/cpufeature.c      |  30 ++++
 arch/riscv/lib/Makefile             |   1 +
 arch/riscv/lib/csum.c               | 326 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/checksum.h      |   6 +-
 lib/checksum_kunit.c                | 284 ++++++++++++++++++++++++++++++-
 7 files changed, 738 insertions(+), 4 deletions(-)
---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie

