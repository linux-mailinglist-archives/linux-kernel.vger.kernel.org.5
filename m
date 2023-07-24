Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2375E769
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGXB1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGXB1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0056A448F;
        Sun, 23 Jul 2023 18:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D70660F30;
        Mon, 24 Jul 2023 01:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1430C433BD;
        Mon, 24 Jul 2023 01:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161807;
        bh=+LwtARwstwHYhoUrcmgWERRg9mxIE9XuQgcVongl07E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+7MAWDImZY4fBhvaSyVvO4DtNWikxrfAhP5F7GQriC7FQ9AHpEjA900yjc2irs4+
         bk6cz9g6KHwnqzo9LNWdpQeK7I9YwVMJDK3gLbae2HTeJVgNqHbGeuFwNLeQck+cfm
         uim+BWpUGMxncgTvPSLnNCorkuVJhBNCT9wEeAVSKVcrFY8UUgw8ErERmEPEqx7TYb
         0iSJrflgpTJLUKcBc+oesOG4RQogJ+FVmCucDelAWHb+obb+3a2vbXs8LKSsGfC4dA
         Y4ZhlE+OeMeqbQiPJnYWWX98iFMNcYCKPbWKPBwAxquQF5hXiuM45qOsc4f7EvWIWX
         gN6D4auGRpz1A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, macro@linux-mips.org,
        paulburton@kernel.org, jhogan@kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 39/41] MIPS: dec: prom: Address -Warray-bounds warning
Date:   Sun, 23 Jul 2023 21:21:12 -0400
Message-Id: <20230724012118.2316073-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 7b191b9b55df2a844bd32d1d380f47a7df1c2896 ]

Zero-length arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace zero-length array with flexible-array
member in struct memmap.

Address the following warning found after building (with GCC-13) mips64
with decstation_64_defconfig:
In function 'rex_setup_memory_region',
    inlined from 'prom_meminit' at arch/mips/dec/prom/memory.c:91:3:
arch/mips/dec/prom/memory.c:72:31: error: array subscript i is outside array bounds of 'unsigned char[0]' [-Werror=array-bounds=]
   72 |                 if (bm->bitmap[i] == 0xff)
      |                     ~~~~~~~~~~^~~
In file included from arch/mips/dec/prom/memory.c:16:
./arch/mips/include/asm/dec/prom.h: In function 'prom_meminit':
./arch/mips/include/asm/dec/prom.h:73:23: note: while referencing 'bitmap'
   73 |         unsigned char bitmap[0];

This helps with the ongoing efforts to globally enable -Warray-bounds.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/323
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/dec/prom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dec/prom.h b/arch/mips/include/asm/dec/prom.h
index 1e1247add1cf8..908e96e3a3117 100644
--- a/arch/mips/include/asm/dec/prom.h
+++ b/arch/mips/include/asm/dec/prom.h
@@ -70,7 +70,7 @@ static inline bool prom_is_rex(u32 magic)
  */
 typedef struct {
 	int pagesize;
-	unsigned char bitmap[0];
+	unsigned char bitmap[];
 } memmap;
 
 
-- 
2.39.2

