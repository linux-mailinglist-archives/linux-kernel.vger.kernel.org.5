Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D07B58DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbjJBQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbjJBQ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:58:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA9B3;
        Mon,  2 Oct 2023 09:58:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05865C433CC;
        Mon,  2 Oct 2023 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265880;
        bh=y6877j2bTNQK/NlDbP64SUFTPt4nOaXWX04vbP+P73g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hmy8ZejQMQr9mppLprDw2FZUxnXL+GWtTdfc5nxI8WF7LrtdYXmB8aPOcC1PYcs9n
         EI4Kg0gqqHVkF+v1KN2+CEtMfxb/+iWB19vFi1NDZONKB461wxPKUHdKSeQDoOYxLS
         /KA7mrChpNt2Rvi1LPGfKgTjMSMPnmtiWvJMNQekpdf2ayWMbE0Tc5ncFh4vqLZU6K
         +s62izIU3+M4JJKZXJRlWVoTnUYQW3V1vChjWCN38WSUF0vbUgJlRh0nGTBs7BDVV9
         DsR+fqXIef71qsHr2IXBy031ChUI51Wl3o3Wqo/dFO4mR9pIpTCWFgTao2uiv6b2Vi
         KPRTgl6Ye96Ww==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 1/3] scripts/faddr2line: Don't filter out non-function symbols from readelf
Date:   Mon,  2 Oct 2023 17:57:47 +0100
Message-Id: <20231002165750.1661-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231002165750.1661-1-will@kernel.org>
References: <20231002165750.1661-1-will@kernel.org>
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

As Josh points out in 20230724234734.zy67gm674vl3p3wv@treble:

> Problem is, I think the kernel's symbol printing code prints the
> nearest kallsyms symbol, and there are some valid non-FUNC code
> symbols.  For example, syscall_return_via_sysret.

so we shouldn't be considering only 'FUNC'-type symbols in the output
from readelf.

Drop the function symbol type filtering from the faddr2line outer loop.

Cc: John Stultz <jstultz@google.com>
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20230724234734.zy67gm674vl3p3wv@treble
Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 0e73aca4f908..a35a420d0f26 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -260,7 +260,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
+	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage
-- 
2.42.0.582.g8ccd20d70d-goog

