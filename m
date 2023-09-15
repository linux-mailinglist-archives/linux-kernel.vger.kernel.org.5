Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581A37A1492
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjIODtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIODtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:49:46 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF7196
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:49:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5774b3de210so1301606a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694749781; x=1695354581; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIiYP19fFZbc0l4Ho3T5W+k2kEX//fiFsZ6CGgO3BzE=;
        b=mw1Kw1RbkmCp3pitqfTe9HLSDE9z6nV7AwQNwICTUKTdLepmLgfxfYjNOI8nysKsgd
         7VtxlsNMNzqeJ9Wv/WEvmeI3C/ThGyBWVaQMUKH3HjFsyA0j8Mn4zyzT2j0IhZFUW2QJ
         EN8+9VMKImIMF9epdFkpx83Ie5GcYkGzPJu8zMRvNSoz753AgYIwur17qppVyfyVD9EC
         LOZMxIGPktE/SLFnDvnj1xZNknxkmvoCjf3vWySif+8hkj6QJuHPi25Zjfb7FZOfBLzK
         dXD2jwhUekDCI6lwGknfr7MSrLdNiOm9G9zUPsDK4M2Xgf4PWJVWd/0PWYLvbijEguGG
         shKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749781; x=1695354581;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIiYP19fFZbc0l4Ho3T5W+k2kEX//fiFsZ6CGgO3BzE=;
        b=ATiGY9tj7yqi2sKPEG8/vKsZMMp10rALO/QW8bIzQFsOpyayunI7dDSrPULOuGYmY0
         ERVw6qf434XMi9GU1GzOjOYmqXc8Vj6F1jBw2FarcRM7+rTDkoHUmjDRFzYqEt2pDJRM
         N13PNPe4K58B2DlZDy+W61hrza+e9779rBOn68VMSXxKkmMnJFuVuJtN3DL6rvf6m6zQ
         meA+dxZu3jZmSdwPQ8eGYWN8mhJngZvC77LUcUwTiIqqmxWV0vUFNw0/B+WJ1EDzCH8f
         jHkZb0/ttKqmJZhig1W/KT0DOl5Y8skTdCCcVCdhMckqxan+QDzE+FA6ZrBpCEKwNJg4
         MmWA==
X-Gm-Message-State: AOJu0Yx8tMnUQED+lRPrHbxEMZX/Vcs1ZSiqk37NG3noZreqOJ68QWUy
        zFpVssWyRmHf54folAAJleC9VtuU3tk3FOlAvsc=
X-Google-Smtp-Source: AGHT+IGzfdXXD1ISJxQVDssN13Obc1tgu78IHKhnPBozJdR4PLgUpl4EFv8EUgnNwjaMJCyzg/HqBg==
X-Received: by 2002:a05:6a20:1057:b0:14e:6c19:60f6 with SMTP id gt23-20020a056a20105700b0014e6c1960f6mr603039pzc.50.1694749781484;
        Thu, 14 Sep 2023 20:49:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090adac500b002739282db53sm3881409pjx.32.2023.09.14.20.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:49:41 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v5 0/4] riscv: Add fine-tuned checksum functions
Date:   Thu, 14 Sep 2023 20:49:36 -0700
Message-Id: <20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFDUA2UC/23N0YrCMBCF4VeRXBtJJolp92rfQ0TaSbSDtJFEg
 6703TcVYWXJ5X9gvnmy5CP5xL5WTxZ9pkRhKmHWK4ZDN508J1eagQAlGqF5uFxppB9/wMHjOd1
 G7nqpDTRNhyBZubtEf6T7y9ztSw+UriE+Xi+yXNa3BtuKliUXvFXWCNkXFrrvSDkkmnCDYWQLm
 OEPaYWpIVAQRLc1jeutVn0FUZ+IrSFqQYwAp7RrnVUVRH8gUtYQXRBrEaFzrS/KP2Se51+mClS
 ohAEAAA==
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each architecture generally implements fine-tuned checksum functions to
leverage the instruction set. This patch adds the main checksum
functions that are used in networking.

Vector support is included in this patch to start a discussion on that,
it can probably be optimized more. The vector patches still need some
work as they rely on GCC vector intrinsics types which cannot work in
the kernel since it requires C vector support rather than just assembler
support. I have tested the vector patches as standalone algorithms in QEMU.

This patch takes heavy use of the Zbb extension using alternatives
patching.

To test this patch, enable the configs for KUNIT, then CHECKSUM_KUNIT
and RISCV_CHECKSUM_KUNIT.

I have attempted to make these functions as optimal as possible, but I
have not ran anything on actual riscv hardware. My performance testing
has been limited to inspecting the assembly, running the algorithms on
x86 hardware, and running in QEMU.

ip_fast_csum is a relatively small function so even though it is
possible to read 64 bits at a time on compatible hardware, the
bottleneck becomes the clean up and setup code so loading 32 bits at a
time is actually faster.

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
To: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
To: David Laight <David.Laight@aculab.com>
To: linux-riscv@lists.infradead.org
To: linux-kernel@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

---
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
Charlie Jenkins (4):
      asm-generic: Improve csum_fold
      riscv: Checksum header
      riscv: Add checksum library
      riscv: Test checksum functions

 arch/riscv/Kconfig.debug              |   1 +
 arch/riscv/include/asm/checksum.h     |  91 ++++++++++
 arch/riscv/lib/Kconfig.debug          |  31 ++++
 arch/riscv/lib/Makefile               |   3 +
 arch/riscv/lib/csum.c                 | 198 ++++++++++++++++++++
 arch/riscv/lib/riscv_checksum_kunit.c | 330 ++++++++++++++++++++++++++++++++++
 include/asm-generic/checksum.h        |   5 +-
 7 files changed, 655 insertions(+), 4 deletions(-)
---
base-commit: af3c30d33476bc2694b0d699173544b07f7ae7de
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie

