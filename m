Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15B178BC09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjH2AX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjH2AX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A613E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lQ2jfoEoAOPZV5xJTc2ZtmivxP98noeI/ZYLd2mIOgE=; b=aGgde6YKSAEfan7rSeC7IIe+Fd
        qqyZK92oFC5kDFHOXR+V3tXy8SXdE/NHihUFm/jxMzP9WqY/5X++i3bnFxRVKGE8b4YaTVS7Lfw9l
        /Y1ArMT2R4lWiZq3d71xSQZfDg8p6DrByzRnoUWgL6XP6SlAod3PfE8/sXJRwy4lBTQ7S7eXt/Xbk
        bHYZr3SKt4gS8U1aNc/GPLzIqDOlmRRqVhEXzG4B2lZKXrLw5h6esaBeByBoUtLw6iiD+7wXjore6
        Jnlfd/M52i5uSCj3b42XefmfzlyNbYvczsu8RNWjnfvfChZorV474nuZQ6PVFnDauZt4mq7uuvk4Y
        fyIxwEVA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qamVw-00AUqf-31;
        Tue, 29 Aug 2023 00:23:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Qing Zhang <zhangqing@loongson.cn>, Hui Li <lihui@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: [PATCH 2/2] Loongarch: KGDB: fix build when CPU_HAS_LBT not set
Date:   Mon, 28 Aug 2023 17:23:23 -0700
Message-ID: <20230829002323.28303-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors when CONFIG_CPU_HAS_LBT is not set:

loongarch64-linux-ld: arch/loongarch/kernel/kgdb.o: in function `dbg_get_reg':
arch/loongarch/kernel/kgdb.c:154:(.text+0xc7c): undefined reference to `_save_lbt'
loongarch64-linux-ld: arch/loongarch/kernel/kgdb.o: in function `dbg_set_reg':
arch/loongarch/kernel/kgdb.c:229:(.text+0x13a4): undefined reference to `_restore_lbt'

Fixes: 8968eb010689 ("LoongArch: Add basic KGDB & KDB support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Qing Zhang <zhangqing@loongson.cn>
Cc: Hui Li <lihui@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/kernel/kgdb.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff -- a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
--- a/arch/loongarch/kernel/kgdb.c
+++ b/arch/loongarch/kernel/kgdb.c
@@ -150,7 +150,8 @@ char *dbg_get_reg(int regno, void *mem,
 	}
 
 	/* Handle LBT registers */
-	if ((regs->csr_euen & CSR_EUEN_LBTEN)) {
+	if (IS_ENABLED(CONFIG_CPU_HAS_LBT) &&
+	    (regs->csr_euen & CSR_EUEN_LBTEN)) {
 		_save_lbt(&current->thread.lbt);
 
 		switch (regno) {
@@ -211,7 +212,8 @@ int dbg_set_reg(int regno, void *mem, st
 	}
 
 	/* Handle LBT registers */
-	if ((regs->csr_euen & CSR_EUEN_LBTEN)) {
+	if (IS_ENABLED(CONFIG_CPU_HAS_LBT) &&
+	    (regs->csr_euen & CSR_EUEN_LBTEN)) {
 		switch (regno) {
 		case DBG_FTOP:				/* Process the ftop */
 			memcpy((char *)&current->thread.fpu.ftop, mem, reg_size);
