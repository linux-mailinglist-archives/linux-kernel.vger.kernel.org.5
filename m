Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7879770070
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjHDMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHDMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:46:24 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1276EA;
        Fri,  4 Aug 2023 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1691153175; bh=9xhxTfJsmP/j0QZixW+WVMVjURciT9Pau9sHFu6Fvd8=;
        h=From:To:Cc:Subject:Date:From;
        b=b21yVI5CZNtOHjmWB1AUq9p/kDLAABoY5Reuq3s+UwOtrDGrFsw89mBXf52l/mlAp
         triEWHjAz8gIgP8BiJtSVwhoPm4I32B1AlW16midUARZdZ48MloENkTA48r2gK1/Gd
         K+MA52aK0xA5a6pxaW0klYo2qUmgrSTwGuMVfwbk=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E16BC600A6;
        Fri,  4 Aug 2023 20:46:12 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Song Liu <song@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-raid@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH v3 0/3] raid5, raid6: Accelerate RAID math with LoongArch SIMD
Date:   Fri,  4 Aug 2023 20:46:08 +0800
Message-Id: <20230804124611.2051048-1-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Hi,

Seeing the LoongArch port recently (finally!) gained the ability to use
the vector units, I've subsequently ported the RAID5/6 math to LSX and
LASX (which are LoongArch's 128-bit and 256-bit SIMD extensions), with
nice speedups observed. They are reasonably straight-forward conversions
of existing code, and I hope the comments I put in there are helpful
enough for anyone not familiar with LoongArch assembly to get a rough
picture of how things work here. Performance numbers are included in
each commit's commit message.

This series needs [1] ("LoongArch: Allow usage of LSX/LASX in the
kernel") as a prerequisite, or the vector context would likely get
corrupted by the vector-unaware kernel_fpu_{begin,end} calls. I tested
the changes on top of next-20230731 with the raid6test build fixes [2]
applied, but the series should apply cleanly to v6.5-rc4 (or maybe any
other tag) too; it doesn't depend on the raid6test fixes.
The base-commit and prerequisite-patch-id info is available for
minimally recreating a working configuration for both the kernel and
raid6test tool.

[1]: https://lore.kernel.org/loongarch/20230722072201.2677516-1-chenhuacai@loongson.cn/
[2]: https://lore.kernel.org/linux-raid/20230731104911.411964-1-kernel@xen0n.name/

Changes in v3 (no functional change):

- coding style tweaks to the recovery code
  (Patch 2 is not touched because it is much more resembling the
  original int.uc code before unrolling.)
- more detail in the commit message of Patch 3

Changes in v2 (no functional change):

- minor commit message tweaks
- changed comment style from // to /* */ throughout

WANG Xuerui (3):
  LoongArch: Add SIMD-optimized XOR routines
  raid6: Add LoongArch SIMD syndrome calculation
  raid6: Add LoongArch SIMD recovery implementation

 arch/loongarch/include/asm/xor.h      |  68 ++++
 arch/loongarch/include/asm/xor_simd.h |  42 +++
 arch/loongarch/lib/Makefile           |   3 +
 arch/loongarch/lib/xor_simd.c         |  93 +++++
 arch/loongarch/lib/xor_simd.h         |  46 +++
 arch/loongarch/lib/xor_simd_glue.c    |  71 ++++
 arch/loongarch/lib/xor_template.c     | 110 ++++++
 include/linux/raid/pq.h               |   4 +
 lib/raid6/Makefile                    |   1 +
 lib/raid6/algos.c                     |  16 +
 lib/raid6/loongarch.h                 |  38 ++
 lib/raid6/loongarch_simd.c            | 422 +++++++++++++++++++++
 lib/raid6/recov_loongarch_simd.c      | 515 ++++++++++++++++++++++++++
 lib/raid6/test/Makefile               |  12 +
 14 files changed, 1441 insertions(+)
 create mode 100644 arch/loongarch/include/asm/xor.h
 create mode 100644 arch/loongarch/include/asm/xor_simd.h
 create mode 100644 arch/loongarch/lib/xor_simd.c
 create mode 100644 arch/loongarch/lib/xor_simd.h
 create mode 100644 arch/loongarch/lib/xor_simd_glue.c
 create mode 100644 arch/loongarch/lib/xor_template.c
 create mode 100644 lib/raid6/loongarch.h
 create mode 100644 lib/raid6/loongarch_simd.c
 create mode 100644 lib/raid6/recov_loongarch_simd.c


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
prerequisite-patch-id: 85d08a9828893250ae78dbca9d6e6f8dac755f61
prerequisite-patch-id: fe0bba41e0bbc676454365ed16fb13fc0aac6ee0
prerequisite-patch-id: 84ef8212b74e696ce019255bbfd9679d7516f7f7
prerequisite-patch-id: b1f8fc4e4acdaff7f821a9fcbd063475178e037b
prerequisite-patch-id: 82aacbf27f249fdefe40dd6bcc712e5795256926
prerequisite-patch-id: ae4e026e18f92ffcc93f6b135a3bd48fbdded39a
-- 
2.40.0

