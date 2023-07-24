Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6524775E78C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGXB2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjGXB1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFFE46A4;
        Sun, 23 Jul 2023 18:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0139860F4E;
        Mon, 24 Jul 2023 01:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20BBC433CC;
        Mon, 24 Jul 2023 01:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161855;
        bh=+LwtARwstwHYhoUrcmgWERRg9mxIE9XuQgcVongl07E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deo0sZ4Nn0TYRLkWg+52cBbgobhMeS1HgDGJOVjH9HTjqB06TXu99ciAe8XsHRmWT
         EeJgMre3JCfzImHsVkUyz4TDO+TbLenar2p58hS10wf0nFodJxC7TM0JpfiEiTjiok
         pAU1l6G73fG/Zqhg5hM/WZDA1lVc23cYGw98qHj5IydxDeMcuhfsKmNH7AeEolcDZv
         euHiuYuSCXqdW6UNYPiX5z5N1ViC1vilO5pbvhL2QNXXQtYzFKArB1l7O+1bvPULDY
         qMeIp3heMLuOLtDDT6G0lx6iNnb02jbWPkXfgpCjxjy7VsmCUxxgR6XvivWyMseN3u
         HZ9/f9QE7Ed8g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, macro@linux-mips.org,
        linux-mips@linux-mips.org
Subject: [PATCH AUTOSEL 5.15 21/23] MIPS: dec: prom: Address -Warray-bounds warning
Date:   Sun, 23 Jul 2023 21:23:32 -0400
Message-Id: <20230724012334.2317140-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012334.2317140-1-sashal@kernel.org>
References: <20230724012334.2317140-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
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

