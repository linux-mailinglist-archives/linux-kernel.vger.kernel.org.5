Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F7798176
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjIHFOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjIHFOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:14:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F161997
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:14:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf5c314a57so13416325ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 22:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694150054; x=1694754854; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/a46APqCOn2UBYLl+3vM5GiJlv00SujJdiThpnMY9u8=;
        b=m+fLG4PcKUoyo1T8Yvjsi1DNr7+W/+AVqMZJp2Ofki/pKFcHrZIielhTGyAYMuRlX2
         SGkUC4a0mucctXVC2wLaOafDfD7pfq0ZkH1KcvQEwMSlVvDHiXX0UiPp1J90qm9vyh9v
         IxULy7PKyP+MmTdXQshwzfwqoCjMSYa0lHAL+6gufJDa7DrTq0jrNEC/V+H12GIx7jgZ
         iBCqeRd1gQaCSqD7mjFqxlJYa8pq6ZHjh1SZ+8piv5Jh48tTbAA3YoAPIa4JSS+GvC8t
         nV1KBW/wm1k8r4t8juHxVjPMDf8M3oaO9phIMV6l86sEzHIqtkp0Fm0BYTGl3Mb7vmp5
         lORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694150054; x=1694754854;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/a46APqCOn2UBYLl+3vM5GiJlv00SujJdiThpnMY9u8=;
        b=OxaAEx8QX2bp+2ZKsBgF6vm5DB/Wc040U7knS3OI1YwoekQWTfvA4iJwfl5s9jzWEj
         kZs8/b7e9BoG0wOmtCMpUUibSdMGv0hKUQf0X0Skk1Oawc+xbJzGZV5ZQqitQlJ+d4Hj
         FY1rmpmeavVCrAcId7rY7ei2X59ENIpQN44LztmrZl1FVy6bmcDuc+s73mGWc8e8H3+a
         CchYtTWzcknzTs635fdgcRQCWwlPi9AqwOLwIKiUuqRXeVMNR/h1vzPl7tOYMjPMXhyd
         r8n12VeUgjZs+sqBEMT1NZTB9EtJDrhqTjd9GP6jYG6HufN3yQinkQfpPPRHda7c7iYQ
         2YBw==
X-Gm-Message-State: AOJu0YzvQTpe8Q3uIGwF2mrXCLXT5AfQcWdlvMoOEeC9s1Q1BA/p1R8q
        xO9YusUrVfqJrT0M297ZHydzcw==
X-Google-Smtp-Source: AGHT+IHujgbMM9DgjN+STeVv4CWjHBT7RgXxHsWcHil+Pw1TmXDbknKLDXT2gfzOP8AzMjzeKIVzjA==
X-Received: by 2002:a17:902:b18c:b0:1b2:1b22:196 with SMTP id s12-20020a170902b18c00b001b21b220196mr1621335plr.48.1694150054292;
        Thu, 07 Sep 2023 22:14:14 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090274c500b001a5fccab02dsm616482plt.177.2023.09.07.22.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 22:14:13 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/5] riscv: Add fine-tuned checksum functions
Date:   Thu, 07 Sep 2023 22:14:03 -0700
Message-Id: <20230907-optimize_checksum-v3-0-c502d34d9d73@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJut+mQC/23N3wqCMBTH8VeRXbfYH6ezq94jItxx5SF0stmox
 HdvShCEl98fnM+ZSLAebSCHbCLeRgzo+hRylxFo6/5mKTapiWBCMs1y6oYRO3zbC7QW7uHR0cb
 wXAmtaxCcpLvB2ys+V/N0Tt1iGJ1/rS8iX9avJooNLXLKaCVLxbhJrKiPHqML2MMeXEcWMIofU
 jG1hYiEADSF0o0pc2n+kHmeP9/95E76AAAA
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
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
      riscv: Checksum header
      riscv: Add checksum library
      riscv: Vector checksum header
      riscv: Vector checksum library
      riscv: Test checksum functions

 arch/riscv/Kconfig.debug              |   1 +
 arch/riscv/include/asm/checksum.h     | 180 +++++++++++++++++++
 arch/riscv/lib/Kconfig.debug          |  31 ++++
 arch/riscv/lib/Makefile               |   3 +
 arch/riscv/lib/csum.c                 | 301 +++++++++++++++++++++++++++++++
 arch/riscv/lib/riscv_checksum_kunit.c | 330 ++++++++++++++++++++++++++++++++++
 6 files changed, 846 insertions(+)
---
base-commit: af3c30d33476bc2694b0d699173544b07f7ae7de
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie

