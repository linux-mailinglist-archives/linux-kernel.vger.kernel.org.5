Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AFF7A052A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbjINNMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbjINNMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:12:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87DB1FD4;
        Thu, 14 Sep 2023 06:12:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3D7C433CD;
        Thu, 14 Sep 2023 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694697154;
        bh=ryVlOrDaoRgntnJXWPI3E7+mf/qDBDaxMn5hmEwKnuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvbcY6MF+vDO55aFOcSpYn72XwI1Mzgfy0qmQ109sGU/5cF/I/RENkA2xjQ2L4GRT
         dCVwSJH+TAGtdGStoqDG9/YmTAJg3Uru9UuUbvSc9gXyxdHvFn5Oql0P2btAMyI5GF
         Ida5b4gBA4PAg10AOp7wHD8w/78/45gwIQWGmeY8Or2QT6hhvtfuixcB8ViuJrX9H6
         6k3NV4EtPU2dgBczU2bAxkVl6bgaOY5U/A/f18ze5fntrcZ/Q8IiFWTjZVf7NegJsz
         KPnyR8ioMiuN2IeoTgipKYb/TF9cfRRi6mLNv4PzKabkDxj/God0+wF6N+hsNW48qn
         WxnZ4uWO+3BDw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v4 1/3] scripts/faddr2line: Don't filter out non-function symbols from readelf
Date:   Thu, 14 Sep 2023 14:12:23 +0100
Message-Id: <20230914131225.13415-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230914131225.13415-1-will@kernel.org>
References: <20230914131225.13415-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
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
2.42.0.283.g2d96d420d3-goog

