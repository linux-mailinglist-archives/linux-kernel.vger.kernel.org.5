Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B457D81D1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344802AbjJZLcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E771AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698319885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nJbwl958YvMAt8AOX88IKj5/m57DLKb+0w4F53bET/o=;
        b=PHgjGQ0iqi2dXNgSlS0fxYzk5/fRqKBWyItO8WgcFayp1ncO65KDkUSPIswy584MaGktvZ
        w45oCjo+HVYUqQQqfkQc7fQ4sf+/WD1M6lu36dUwhzn9yaxxkWcQQGn+yMvax7uZpuI9J1
        pYgmR/kiJM4oAML/KYdgj7Sn01+z1Ps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-wxelN0EVNUeqOSyCIXCWMw-1; Thu, 26 Oct 2023 07:31:17 -0400
X-MC-Unique: wxelN0EVNUeqOSyCIXCWMw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAC53811E7B;
        Thu, 26 Oct 2023 11:31:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DB75492BE7;
        Thu, 26 Oct 2023 11:31:15 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
        bcain@quicinc.com
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] hexagon: Remove CONFIG_HEXAGON_ARCH_VERSION from uapi header
Date:   Thu, 26 Oct 2023 13:31:14 +0200
Message-ID: <20231026113114.195854-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uapi headers should not expose CONFIG switches since they are not
available in userspace. Fix it in arch/hexagon/include/uapi/asm/user.h
by always defining the cs0 and cs1 entries instead of pad values.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Based-on: <20231025073802.117625-1-thuth@redhat.com>

 Compile tested only (with CONFIG_HEXAGON_ARCH_VERSION set to 2
 and with CONFIG_HEXAGON_ARCH_VERSION set to 4)

 arch/hexagon/include/uapi/asm/user.h | 7 +------
 arch/hexagon/kernel/ptrace.c         | 7 +++++--
 scripts/headers_install.sh           | 1 -
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/hexagon/include/uapi/asm/user.h b/arch/hexagon/include/uapi/asm/user.h
index 7327ec59b22f..abae6a4b5813 100644
--- a/arch/hexagon/include/uapi/asm/user.h
+++ b/arch/hexagon/include/uapi/asm/user.h
@@ -56,15 +56,10 @@ struct user_regs_struct {
 	unsigned long pc;
 	unsigned long cause;
 	unsigned long badva;
-#if CONFIG_HEXAGON_ARCH_VERSION < 4
-	unsigned long pad1;  /* pad out to 48 words total */
-	unsigned long pad2;  /* pad out to 48 words total */
-	unsigned long pad3;  /* pad out to 48 words total */
-#else
+	/* cs0 and cs1 are only available with HEXAGON_ARCH_VERSION >= 4 */
 	unsigned long cs0;
 	unsigned long cs1;
 	unsigned long pad1;  /* pad out to 48 words total */
-#endif
 };
 
 #endif
diff --git a/arch/hexagon/kernel/ptrace.c b/arch/hexagon/kernel/ptrace.c
index 125f19995b76..905b06790ab7 100644
--- a/arch/hexagon/kernel/ptrace.c
+++ b/arch/hexagon/kernel/ptrace.c
@@ -74,7 +74,7 @@ static int genregs_set(struct task_struct *target,
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
 {
-	int ret;
+	int ret, ignore_offset;
 	unsigned long bucket;
 	struct pt_regs *regs = task_pt_regs(target);
 
@@ -111,12 +111,15 @@ static int genregs_set(struct task_struct *target,
 #if CONFIG_HEXAGON_ARCH_VERSION >=4
 	INEXT(&regs->cs0, cs0);
 	INEXT(&regs->cs1, cs1);
+	ignore_offset = offsetof(struct user_regs_struct, pad1);
+#else
+	ignore_offset = offsetof(struct user_regs_struct, cs0);
 #endif
 
 	/* Ignore the rest, if needed */
 	if (!ret)
 		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-			offsetof(struct user_regs_struct, pad1), -1);
+					  ignore_offset, -1);
 	else
 		return ret;
 
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index c3064ac31003..f7d9b114de8f 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -74,7 +74,6 @@ arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
 arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
 arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
 arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
-arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
 arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
-- 
2.41.0

