Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAC7BC854
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbjJGOcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjJGOcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:32:41 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69620BA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 07:32:39 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id p8M7q9ALBzRICp8M7qMa0a; Sat, 07 Oct 2023 16:32:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696689156;
        bh=MjiCcPHgIztJA3fnnekG+6x6iUsfkXWEmL8zOsP0oyA=;
        h=From:To:Cc:Subject:Date;
        b=aaTGehvocX9wx7mzR++6IjvE/DnvOr1TK37GENxTG7UcuGGj71s15N9fuweFAnxxI
         ESKXegYY0HxgSvoQRDsUPvuPSW94PdhLG0UFGRucogB/jIThA0DThR8TbAWUEhnqIl
         26R7DE6KcGns2SgqBf9EnJQky6wt4TVQnHPjiSiRPCBw5yI0xWJ6jnblqxZwpIn0Qt
         FOWsYidbppIjC6EYKl+1Hkda0hbZqfdw0FgIVGY/Dzwt7D4JpP6DCAGUPFxSUmlFAI
         AhAlenwT1BDhFtdxtXbNTiZUZ2RB8kvdPktkfqSoBnmQL+Q8GANy/OroO97bNapOIh
         RC2t7Cv91bz3Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Oct 2023 16:32:36 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] VMCI: Annotate struct vmci_handle_arr with __counted_by
Date:   Sat,  7 Oct 2023 16:32:34 +0200
Message-Id: <56bef519d982218176b59bbba64a3a308d8733d5.1696689091.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a work done in parallel of what is currently worked
on by Kees Cook.

My patches are only related to corner cases that do NOT match the
semantic of his Coccinelle script[1].

In this case, something similar to struct_size() is implemented in
handle_arr_calc_size().

Note that I'm slightly unsure on how things will behave in regards to the
krealloc() in vmci_handle_arr_append_entry().

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
---
 drivers/misc/vmw_vmci/vmci_handle_array.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_handle_array.h b/drivers/misc/vmw_vmci/vmci_handle_array.h
index 96193f85be5b..b0e6b1956014 100644
--- a/drivers/misc/vmw_vmci/vmci_handle_array.h
+++ b/drivers/misc/vmw_vmci/vmci_handle_array.h
@@ -17,7 +17,7 @@ struct vmci_handle_arr {
 	u32 max_capacity;
 	u32 size;
 	u32 pad;
-	struct vmci_handle entries[];
+	struct vmci_handle entries[] __counted_by(capacity);
 };
 
 #define VMCI_HANDLE_ARRAY_HEADER_SIZE				\
-- 
2.34.1

