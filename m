Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10B77E81CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbjKJSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjKJSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCD28B3C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699612287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=knUCazqI7zdSXmyG+dXyUAX6tOCbDCPV67c1pmGbQpk=;
        b=hP3ofO+mc2CSyaIimzKZfvV2v0Y//M5mXBP6ssKGOzTEAGkjq3opGPZ0pNm//0oVcdOihQ
        zBDCp7rTb6VhTbfH/saR/uDRWvunJH6RhXRcn13WQY1Ll/W/eRNlXYSumf8dspjlW9kbqt
        D/XjBev01FbDbl0msMND33XsPAWifOk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-F5WEz2q1Mhi6Un7UOLexjw-1; Fri, 10 Nov 2023 05:31:23 -0500
X-MC-Unique: F5WEz2q1Mhi6Un7UOLexjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 809958007B3;
        Fri, 10 Nov 2023 10:31:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82C34502B;
        Fri, 10 Nov 2023 10:31:22 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] m68k: Avoid CONFIG_COLDFIRE switch in uapi header
Date:   Fri, 10 Nov 2023 11:31:20 +0100
Message-ID: <20231110103120.387517-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not use any CONFIG switches in uapi headers since
these only work during kernel compilation. They are not defined
for userspace. Let's use the __mcoldfire__ switch from the
compiler here instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Marked as RFC since I didn't test it - I'd appreciate if someone
 could give it a try on a real system.

 arch/m68k/include/uapi/asm/ptrace.h | 2 +-
 scripts/headers_install.sh          | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/include/uapi/asm/ptrace.h b/arch/m68k/include/uapi/asm/ptrace.h
index 5b50ea592e00..ebd9fccb3d11 100644
--- a/arch/m68k/include/uapi/asm/ptrace.h
+++ b/arch/m68k/include/uapi/asm/ptrace.h
@@ -39,7 +39,7 @@ struct pt_regs {
   long     d0;
   long     orig_d0;
   long     stkadj;
-#ifdef CONFIG_COLDFIRE
+#ifdef __mcoldfire__
   unsigned format :  4; /* frame format specifier */
   unsigned vector : 12; /* vector offset */
   unsigned short sr;
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index c3064ac31003..cdb04c920670 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -75,7 +75,6 @@ arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
 arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
 arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
 arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
-arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION
-- 
2.41.0

