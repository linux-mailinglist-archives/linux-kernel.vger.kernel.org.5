Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8379380BFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjLKDFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjLKDFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:05:17 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BDF9D;
        Sun, 10 Dec 2023 19:05:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vy9Z.J._1702263918;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0Vy9Z.J._1702263918)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 11:05:19 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, yu.c.zhang@linux.intel.com,
        tabba@google.com, xiaoyao.li@intel.com
Cc:     pbonzini@redhat.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] KVM: Move kvm_gmem_migrate_folio inside CONFIG_MIGRATION
Date:   Mon, 11 Dec 2023 11:05:18 +0800
Message-Id: <20231211030518.2722714-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guanjun <guanjun@linux.alibaba.com>

'kvm_gmem_migrate_folio' is only used when CONFIG_MIGRATION
is defined, And it will triggers the compiler warning about
'kvm_gmem_migrate_folio' defined but not used when CONFIG_MIGRATION
isn't defined.

The compiler complained like that:
arch/x86/kvm/../../../virt/kvm/guest_memfd.c:262:12: error: ‘kvm_gmem_migrate_folio’ defined but not used [-Werror=unused-function]
  262 | static int kvm_gmem_migrate_folio(struct address_space *mapping,
      |            ^~~~~~~~~~~~~~~~~~~~~~

Fixes: a7800aa80ea4 (KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory)
Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 virt/kvm/guest_memfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 16d58806e913..62bb8a1a47d1 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -259,6 +259,7 @@ void kvm_gmem_init(struct module *module)
 	kvm_gmem_fops.owner = module;
 }
 
+#ifdef CONFIG_MIGRATION
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
 				  struct folio *dst, struct folio *src,
 				  enum migrate_mode mode)
@@ -266,6 +267,7 @@ static int kvm_gmem_migrate_folio(struct address_space *mapping,
 	WARN_ON_ONCE(1);
 	return -EINVAL;
 }
+#endif
 
 static int kvm_gmem_error_folio(struct address_space *mapping,
 		struct folio *folio)
-- 
2.39.3

