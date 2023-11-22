Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B217F4D10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjKVQmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjKVQmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:42:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F21D1FE7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:41:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEAEC433C9;
        Wed, 22 Nov 2023 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700671318;
        bh=7EKdU32WWa/sEoS6u1uS+G0T8qjltebPy5sZKOAuHMU=;
        h=Date:From:To:Cc:Subject:From;
        b=DIO7SJYfX8czGIfPUzI7CtRQbOjHEu0W3xEqzylbNEJqlliAVA+b2ypsBO2aF4s3D
         9QFpRCnzTSqp6WXSFYlfOnq1G1O1kpaOmgLN/kbHkJEp/75G1j62tLjFSz3nFgHJRM
         WE/1Hr2iv5PZN2ueDWHBY2EKoFl5TVwwHVNwR5JwUf8WGwBoSz3neK+tJ1IedsUL1O
         5tF64A8FjIkMZo4WDt3dzadVFdaZYOfV0qzOR6KMAIgb2tYfcqqFRshT5Ac2p8/Inm
         r5B4leRabnQmOdMyh4d59TiwiptzWznKTJBwzYZ9FMsGMMbDS4JIY74NiMr0zH+3Hp
         hm0RP8z6xuh8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0168840094; Wed, 22 Nov 2023 13:41:54 -0300 (-03)
Date:   Wed, 22 Nov 2023 13:41:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools: Disable __packed attribute compiler warning due
 to -Werror=attributes
Message-ID: <ZV4vUuxBILOC3j73@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Namhyung, I had to cherry pick this from perf-tools-next as I noticed it
was also failing when trying to build perf-tools/tmp.perf-tools + your
header sync series + Ian's ARM files missing in MANIFEST for the
detached tarball build.

With these patches I managed to complete 'make -C tools/perf build-test'
+ 'perf test' + my suite of perf build containers.

- Arnaldo

----

Noticed on several perf tools cross build test containers:

  [perfbuilder@five ~]$ grep FAIL ~/dm.log/summary
    19    10.18 debian:experimental-x-mips    : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
    20    11.21 debian:experimental-x-mips64  : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
    21    11.30 debian:experimental-x-mipsel  : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
    37    12.07 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
    42    11.91 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    44    13.17 ubuntu:18.04-x-sh4            : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    45    12.09 ubuntu:18.04-x-sparc64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
  [perfbuilder@five ~]$

  In file included from util/intel-pt-decoder/intel-pt-pkt-decoder.c:10:
  /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h: In function 'get_unaligned_le16':
  /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:13:29: error: packed attribute causes inefficient alignment for 'x' [-Werror=attributes]
     13 |         const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);      \
        |                             ^
  /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:27:28: note: in expansion of macro '__get_unaligned_t'
     27 |         return le16_to_cpu(__get_unaligned_t(__le16, p));
        |                            ^~~~~~~~~~~~~~~~~

This comes from the kernel, where the -Wattributes and -Wpacked isn't
used, -Wpacked is already disabled, do it for the attributes as well.

Fixes: a91c987254651443 ("perf tools: Add get_unaligned_leNN()")
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/7c5b626c-1de9-4c12-a781-e44985b4a797@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/asm-generic/unaligned.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
index 156743d399aed223..2fd551915c2025ee 100644
--- a/tools/include/asm-generic/unaligned.h
+++ b/tools/include/asm-generic/unaligned.h
@@ -8,6 +8,7 @@
  */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wpacked"
+#pragma GCC diagnostic ignored "-Wattributes"
 
 #define __get_unaligned_t(type, ptr) ({						\
 	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-- 
2.41.0

