Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7002B7F5DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjKWLWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345019AbjKWLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:05:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E668D71
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:05:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDFCC433CD;
        Thu, 23 Nov 2023 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737548;
        bh=e+QnAKFOR6wNf8AU7caaDk1G44zPUvTIPn9eqgvKtVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PspJpNl8eiPdZ9teU9sgGRq0899Z4qRquTRTMB3ArIInHB3Up/Nd1jNAK52qGJfw6
         VwcSqNBj6wKq0fD5yXgSW27a59XD7QLOvPbuIspPpPRBkcfND/tpUKYcFGCF7v8Zsa
         dgDyTwQGndIV8yWAWF26tuIPGfQKRXj1NO3DcnqV310BwDabCzlQwn1lCiuBVbFjHA
         Z86z4PLYiZf9MHHOZgmqB8KbDB4rO/oWM3+PqBPki4n8eLgoRQ6LCVS7VPSNlti2tC
         3KF5z4FbFLm2GWjTZYrI/5XmCiH2J5bKlvwiwgrOPc4LVeIRCaHUi1/MBiIDKhPy5d
         Oiwg9eBSopTGQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 4/6] x86: sta2x11: include header for sta2x11_get_instance() prototype
Date:   Thu, 23 Nov 2023 12:05:04 +0100
Message-Id: <20231123110506.707903-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123110506.707903-1-arnd@kernel.org>
References: <20231123110506.707903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

sta2x11_get_instance() is a global function declared in asm/sta2x11.h,
but this header is not included before the definition, causing a warning:

arch/x86/pci/sta2x11-fixup.c:95:26: error: no previous prototype for 'sta2x11_get_instance' [-Werror=missing-prototypes]

Add the missing #include.

Fixes: 83125a3a189e ("x86, platform: Initial support for sta2x11 I/O hub")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/pci/sta2x11-fixup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 7368afc03998..8c8ddc4dcc08 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -14,6 +14,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/swiotlb.h>
 #include <asm/iommu.h>
+#include <asm/sta2x11.h>
 
 #define STA2X11_SWIOTLB_SIZE (4*1024*1024)
 
-- 
2.39.2

