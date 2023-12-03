Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFDC802255
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjLCJtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjLCJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:49:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE16ADA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:49:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D96FC433CA;
        Sun,  3 Dec 2023 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701596998;
        bh=2DvonXnTe7s/F9D7y3v/KBQpYELTPDsU5vhrOaqP0pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGbXL9/YNvdZ3anDtwiwLsyBey9CwF9Zt9CsaYDGb8EKVE3wrJB/WhDBRGjY1Uxxs
         Tn5B7LbKOvQkSogqXHVf/+u/ag2wpVX9EBYkBYcIh7SKaoAnySjiJN+YOVd2U9Ps58
         YJRWdgzIaWA7WEVAG0xWQoEMLHmFMTVPLWjouvzxYsFX3xOctviP0fdgEJUnbfFDpM
         al/hCwPCuju0DP+lZOFjGzUYR65MIAj8fHRrC2gQFSlr8wdvyZnYJ8y6l0KsQ25mvc
         OOm9BamZlQDMJIerOt4X3z45JEQeKLjd51OACKQb610rvMHLUrXHD8l64l3XLp/7DG
         X54qRPJZ1vv+Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 3/4] modpost: remove unneeded initializer in section_rel()
Date:   Sun,  3 Dec 2023 18:49:33 +0900
Message-Id: <20231203094934.1908270-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203094934.1908270-1-masahiroy@kernel.org>
References: <20231203094934.1908270-1-masahiroy@kernel.org>
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

This initializer was added to avoid -Wmaybe-uninitialized (gcc) or
-Wsometimes-uninitialized (clang) warning.

Now that compilers recognize fatal() never returns, it is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Split into a separate patch

 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c13bc9095df3..3233946fa5f6 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1421,7 +1421,7 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 
 	for (rel = start; rel < stop; rel++) {
 		Elf_Sym *tsym;
-		Elf_Addr taddr = 0, r_offset;
+		Elf_Addr taddr, r_offset;
 		unsigned int r_type, r_sym;
 		void *loc;
 
-- 
2.40.1

