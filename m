Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584A77FDB82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbjK2Pcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjK2Pct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:32:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C534D43
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:32:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD688C433C8;
        Wed, 29 Nov 2023 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271975;
        bh=IMG9YxIDr+Fl0aVREHwJe3Kp/N91o8sNpnhBkBL/3ec=;
        h=From:To:Cc:Subject:Date:From;
        b=jombYPbint8xcSYE63U6Vb+r6J/OhHwSHDwRI4LUYDP6Zo3RBxoekRSiAD2Vr9pPL
         snrYkeva4AjB/vBkxVGudlG12nPSCb4QX8uUa4Mv6ALz/svtS2Gt487tt0PSwOZB2F
         g8WmEh24o2EjEzx0/uaJkYK9r/XXOfRz9jNTNmbcfN/s5R5v8UyUu+j3oNIXj0eBF5
         yI4VSAZ099/hS5Y3rHH/DIZgDTyIUB+QcO6XW6sTEMTr+/voOzaFgPHqc6Qyw/hJL+
         /vWi5E5hFlvKgpAPQO/07ou8SaoTDJ860pl+ANdneOZP7i78EHjggJ/vps5dJra2xG
         2k8koekovXphA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: guest-memfd: fix unused-function warning
Date:   Wed, 29 Nov 2023 16:32:40 +0100
Message-Id: <20231129153250.3105359-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

With migration disabled, one function becomes unused:

virt/kvm/guest_memfd.c:262:12: error: 'kvm_gmem_migrate_folio' defined but not used [-Werror=unused-function]
  262 | static int kvm_gmem_migrate_folio(struct address_space *mapping,
      |            ^~~~~~~~~~~~~~~~~~~~~~

Replace the #ifdef around the reference with a corresponding PTR_IF() check
that lets the compiler know how it is otherwise used.

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 virt/kvm/guest_memfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 16d58806e913..1a0355b95379 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -301,9 +301,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping,
 
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
-#ifdef CONFIG_MIGRATION
-	.migrate_folio	= kvm_gmem_migrate_folio,
-#endif
+	.migrate_folio = PTR_IF(IS_ENABLED(CONFIG_MIGRATION),
+				kvm_gmem_migrate_folio),
 	.error_remove_folio = kvm_gmem_error_folio,
 };
 
-- 
2.39.2

