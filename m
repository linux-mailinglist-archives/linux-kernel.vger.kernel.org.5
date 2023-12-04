Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6309B8031FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343810AbjLDL6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbjLDL6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890401988
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92487C433CD;
        Mon,  4 Dec 2023 11:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691057;
        bh=4ABSoMNpXusCcWYdVc/Z/1r0KMCswnYJODyq0pzAGhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIT8BTacH9XtFOb5K998EObxet0tpmzMtldqSatFkYdP4SGnNqZBjAFqqU1HrcA5M
         NlhZr6RXfYTWdTC+oSNYp67XxNgFeeVIlCBBw6PvI5hvaj68vJfCwIzjS1cz4PB7Q1
         u3Es51WnXfwdvHS9HTJtmvbq4vWabWEZnA7B/9h8KbRFZrUZ2cUE3qcgXCJ0/s9XpV
         DZkOcbSVcBAWeOoM0Ry93dLlc85Dalpjj/S9cfJ1/YQA0KuAZ036Ho834gh9QDPft/
         9K+wjJguaXKveLxXDp8jFFPCWZS6DpfthsMRwn8HuUm5N7zCmwr9ZJSbhJmWs+0c+k
         L55zu4Gx39PdA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 09/20] mips: unhide uasm_in_compat_space_p() declaration
Date:   Mon,  4 Dec 2023 12:56:59 +0100
Message-Id: <20231204115710.2247097-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
References: <20231204115710.2247097-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

uasm_in_compat_space_p() has a conditional declaration but is defined
unconditionally because of another local user, which causes a warning:

arch/mips/mm/uasm.c:421:5: error: no previous prototype for 'uasm_in_compat_space_p' [-Werror=missing-prototypes]

Make the declaration unconditional to avoid this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/uasm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 296bcf31abb5..b43bfd445252 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -193,9 +193,7 @@ struct uasm_label {
 
 void uasm_build_label(struct uasm_label **lab, u32 *addr,
 			int lid);
-#ifdef CONFIG_64BIT
 int uasm_in_compat_space_p(long addr);
-#endif
 int uasm_rel_hi(long val);
 int uasm_rel_lo(long val);
 void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr);
-- 
2.39.2

