Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D269F7EF31E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbjKQM6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKQM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:58:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A71D56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:58:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B366AC433C7;
        Fri, 17 Nov 2023 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700225893;
        bh=4vLoS7Dg99+l1hsNwr7XqzGIdn2mfLkaWWkevVLZdC0=;
        h=From:To:Cc:Subject:Date:From;
        b=nJsYwnM19NZA3/abngyX+NI6XrCZmiSo3hPPOokeyAhcrpCG3T8hERDKegVlXdxjq
         Sf6jNUZSvoHRgwFef5s9Hsxg7Gz9PK6e0b3YJZq9DrBT84tQZ6vqBt7qj3SAxFfeaQ
         5pmyPUw3EheWFYHgOFqmTvgJRRUupjCPIebsaksfRdy2AMx+7mBnaGoQNX1d3WiuaM
         /5y1omWc2vIa4jEpsx8HFet+iVg7FCRf74N8Ve1yjEZRY+EFwGpG7y8saB1Juv2k9F
         Y7XTkIDKYgz0uGrKHCxZK27asn6qAfhtlLEA8oBm1BQ7VrRJFeLkuYCyEP3a6zr4qV
         pfMmdyO9V6wsA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] riscv: compat_vdso: install compat_vdso.so.dbg to /lib/modules/*/vdso/
Date:   Fri, 17 Nov 2023 21:58:07 +0900
Message-Id: <20231117125807.1058477-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
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

'make vdso_install' installs debug vdso files to /lib/modules/*/vdso/.

Only for the compat vdso on riscv, the installation destination differs;
compat_vdso.so.dbg is installed to /lib/module/*/compat_vdso/.

To follow the standard install destination and simplify the vdso_install
logic, change the install destination to standard /lib/modules/*/vdso/.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index a74be78678eb..5cbe596345c1 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -146,7 +146,7 @@ endif
 endif
 
 vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
-vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
+vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
 
 ifneq ($(CONFIG_XIP_KERNEL),y)
 ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
-- 
2.40.1

