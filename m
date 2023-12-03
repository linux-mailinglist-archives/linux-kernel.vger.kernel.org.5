Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3B802287
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjLCK0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjLCKZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:25:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E8FD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:25:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08552C433CA;
        Sun,  3 Dec 2023 10:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701599139;
        bh=/G/U1jJhbg6VKWyteRfH6C1mvYApP8yrSi62PoEqI9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ru11GhM84CbNOelG13KOP1EoEqrb8+Wvlvslrb7HO888VE7rXPv8gGZNWGla1cS2c
         /vzIfuDA7nv5eCPMlO/dUbAT1l2/8dSPRLuyq1q7qHSx6xZU4pyZRzeXpOABc7hasb
         GrVzvInmpj19XxroKZTs8Ulwp20rJyHa6ejUCPLhjztl7s4S7SIoesFrougAlvMqis
         O+DVF79EGrgNWxMnJF37ZTdwifA++f2ylh+huqAlQCjyc+QT5Bvv9yKHhzV2r/Qq1o
         P9pt2ypmlUV9rXAv/HTjBE1K+VhMnBe13AzN8iEBtsT7aMWQxBNKYvn3qlollSvI3v
         IAswBND4PDQnw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 5/6] kconfig: remove unreachable printf()
Date:   Sun,  3 Dec 2023 19:25:27 +0900
Message-Id: <20231203102528.1913822-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203102528.1913822-1-masahiroy@kernel.org>
References: <20231203102528.1913822-1-masahiroy@kernel.org>
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

Remove the unreachable code detected by clang.

  $ make HOSTCC=clang HOSTCFLAGS=-Wunreachable-code defconfig
    [ snip ]
  scripts/kconfig/expr.c:1134:2: warning: code will never be executed [-Wunreachable-code]
          printf("[%dgt%d?]", t1, t2);
          ^~~~~~
  1 warning generated.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index 81ebf8108ca7..a290de36307b 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -1131,7 +1131,6 @@ static int expr_compare_type(enum expr_type t1, enum expr_type t2)
 	default:
 		return -1;
 	}
-	printf("[%dgt%d?]", t1, t2);
 	return 0;
 }
 
-- 
2.40.1

