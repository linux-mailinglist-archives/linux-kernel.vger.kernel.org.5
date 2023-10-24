Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB29E7D4B06
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjJXIxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJXIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:53:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D224B172C;
        Tue, 24 Oct 2023 01:52:46 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:52:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698137565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lS1Bbe/z0U0icdz60j0w4WUA/D2ksSJYKyfO95quWrM=;
        b=ArY7IDPOixc5JG7+NbR8XOV6whtERyE6OztxH6tl3VKxYsX2+ngdsYR4osRKzseEqXFwn7
        6SGNpNyOLVOKjTjxQYot+wOJb66F31U0Vtd55pX0mFjsDIw/l6KvU2KIkNmGtWPnqvm4Th
        h9ubDkiSi+u9l9VctDPR8JuArsHqDFmmUpgJj+Z67yMHwiIAR8byZlGHpoqVoIueQR5kvq
        k5WtQ7xempEYGy1JD1mYpdcZYiuOADIshCJq7YW6wzBiTLAZaWA2DlglCtRFN9qTP5Zl+l
        MQNdBncx/1ykl3s80BS1tkrjdWQrW/eO/L+hDIhX5cw/uA8qz8ZfxHXQbGUI4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698137565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lS1Bbe/z0U0icdz60j0w4WUA/D2ksSJYKyfO95quWrM=;
        b=ZbMfJczIEKE0r8OZbD3RLXqjZVjo64sv9bS2+oRtElem72wF8d7oF8hwoROv4FXUNMDCBj
        64D3Zp70ybc0d0BA==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Don't filter out non-function
 symbols from readelf
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230724234734.zy67gm674vl3p3wv@treble>
References: <20230724234734.zy67gm674vl3p3wv@treble>
MIME-Version: 1.0
Message-ID: <169813756439.3135.10447231132133711820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     180af1a5bdaf8d4964837a46a9fce8c3a7fd2d97
Gitweb:        https://git.kernel.org/tip/180af1a5bdaf8d4964837a46a9fce8c3a7fd2d97
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 02 Oct 2023 17:57:47 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 23 Oct 2023 08:35:01 -07:00

scripts/faddr2line: Don't filter out non-function symbols from readelf

As Josh points out in 20230724234734.zy67gm674vl3p3wv@treble:

> Problem is, I think the kernel's symbol printing code prints the
> nearest kallsyms symbol, and there are some valid non-FUNC code
> symbols.  For example, syscall_return_via_sysret.

so we shouldn't be considering only 'FUNC'-type symbols in the output
from readelf.

Drop the function symbol type filtering from the faddr2line outer loop.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20230724234734.zy67gm674vl3p3wv@treble
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20231002165750.1661-2-will@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 0e73aca..a35a420 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -260,7 +260,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
+	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage
