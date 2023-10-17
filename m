Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC077CC5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbjJQOeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjJQOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:34:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B9A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:34:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5FAC433C8;
        Tue, 17 Oct 2023 14:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697553254;
        bh=6chpSi2cSFs/mmCxw/PjMVSCy+uwdZlMJRYapzy+Luc=;
        h=From:To:Cc:Subject:Date:From;
        b=F4ZSSv2/78hTJu0ofr6DFeZvK5j4SEBNVinMTlcRldItDBIuqBGz1oBMNziBelz/u
         Bf6jcfKWZht7H9Nlp19X9O8nLpvF1UlAOtAKJuygWX4TSqPNnY6jLCO1qsZ/d7mk5n
         tDB/RawtoxVzupBFoqLei7/BmWAwVjzo5nh4gUXTpD1ZzG+vHU6uxyL3GHk+cKyDBA
         MVu3ZBW0xB44gUJ0cAkeY9dNoKCVZAd/aVV0rEXHxeHVhiTqc/3XrsaYFvGGwbYgrj
         BsI0KyEpP4x5cErkZ9TdHah6RnNVZNt+CvCNJydf9eOtbUiPa/3w63fqWDAJ0NYAAS
         On4R7yFoqHAdg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] buildid: reduce header file dependencies for module
Date:   Tue, 17 Oct 2023 16:33:58 +0200
Message-Id: <20231017143408.2876181-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The vmlinux decompressor code intentionally has only a limited set of
included header files, but this started running into a build failure
because of the bitmap logic needing linux/errno.h:

In file included from include/linux/cpumask.h:12,
                 from include/linux/mm_types_task.h:14,
                 from include/linux/mm_types.h:5,
                 from include/linux/buildid.h:5,
                 from include/linux/module.h:14,
                 from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
                 from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
                 from arch/arm/boot/compressed/decompress.c:60:
include/linux/bitmap.h: In function 'bitmap_allocate_region':
include/linux/bitmap.h:527:25: error: 'EBUSY' undeclared (first use in this function)
  527 |                 return -EBUSY;
      |                         ^~~~~
include/linux/bitmap.h:527:25: note: each undeclared identifier is reported only once for each function it appears in
include/linux/bitmap.h: In function 'bitmap_find_free_region':
include/linux/bitmap.h:554:17: error: 'ENOMEM' undeclared (first use in this function)
  554 |         return -ENOMEM;
      |                 ^~~~~~

This is easily avoided by changing linux/buildid.h to no longer depend on
linux/mm_types.h, a header that pulls in a huge number of indirect dependencies.

Fixes: b9c957f554442 ("bitmap: move bitmap_*_region() functions to bitmap.h")
Fixes: bd7525dacd7e2 ("bpf: Move stack_map_get_build_id into lib")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/buildid.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 3b7a0ff4642fd..8a582d242f067 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -2,10 +2,11 @@
 #ifndef _LINUX_BUILDID_H
 #define _LINUX_BUILDID_H
 
-#include <linux/mm_types.h>
+#include <linux/types.h>
 
 #define BUILD_ID_SIZE_MAX 20
 
+struct vm_area_struct;
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
-- 
2.39.2

