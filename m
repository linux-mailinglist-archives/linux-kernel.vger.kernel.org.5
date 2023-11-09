Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847997E727C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbjKITxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjKITxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:53:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5693C1B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:53:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB511C433C8;
        Thu,  9 Nov 2023 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699559598;
        bh=K0AUQAMTIJSKGYrpxLpGFIhw+V6BY/dYaUiQAhNcbNo=;
        h=Date:From:To:Cc:Subject:From;
        b=qNM1OXn2sVzVmbd9yIKcxVqr4XPMp8yxwyryPiQqHElXVebxUYepeYvFZZcdv5lxk
         iMOtim6A9wkSSnJrTM4Ayq50vyovktKObS0+5aB0tYwAwPeq9OtINhMuKjIFSbchEp
         ULR6MecJ5xUoLBp40WeEpGNekywep0KKH3rD8qYic6R0whiG0gcuU4y/XYoPRBXgFF
         8UzRY69H6isCyWl5GErWK1BCe3sbCdMRM3ON2k4+YXaFY4VLrGSt1QDQbjQM17nK+N
         luBGP2PINNnnibwF5DGrKbTNrGxoPs9xDVrM9NkC05PDqXZkuWzR/qP7Db8hhMGUtO
         crH8s/cQ929wg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7856440094; Thu,  9 Nov 2023 16:53:15 -0300 (-03)
Date:   Thu, 9 Nov 2023 16:53:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools: Disable __packed attribute compiler warning due
 to -Werror=attributes
Message-ID: <ZU04q6UZvbJn8OoT@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

