Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08300800355
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377547AbjLAFwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377566AbjLAFv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:51:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294921734
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fEQIY/PD10m5ObiwbCiBSgJ8pMG7R2h3xIOqhN7l6kY=; b=J3Y6GAJ8b2oKbSPrhjOIfHQA5z
        ImDO/K6arjtQ4MeyJZbODC2wIvwGdwobigg0d7koHXiI285IKzDXOvvLAEiUtbz73HQksa4L9dz1a
        rbud8kJONWbL6jLjU5+BLFPn4basQoDFn77APeRKK3chzNkFZfL+iwOALbnb8FrJE9/vS5g4EYynI
        hNCDFecI41pWNIzOrke/THoFn4XNPUb1zQfUEtVIVweqtOBzqrhW1Q9a3CoAnGYhmTV5Bcr9U7pq1
        AtRD4rDoaTIorlge6PNb7qc0VYFbwQWEQwQ4rciHSmTZOSuCmYTaWTazOQYQTXbLz3dKcyLKi1BcS
        P+V9ZSEA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8wRU-00CiyY-06;
        Fri, 01 Dec 2023 05:52:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Alistair Popple <alistair@popple.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/44x: select I2C for CURRITUCK
Date:   Thu, 30 Nov 2023 21:51:59 -0800
Message-ID: <20231201055159.8371-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors when CURRITUCK=y and I2C is not builtin (=m or is
not set). Fixes these build errors:

powerpc-linux-ld: arch/powerpc/platforms/44x/ppc476.o: in function `avr_halt_system':
ppc476.c:(.text+0x58): undefined reference to `i2c_smbus_write_byte_data'
powerpc-linux-ld: arch/powerpc/platforms/44x/ppc476.o: in function `ppc47x_device_probe':
ppc476.c:(.init.text+0x18): undefined reference to `i2c_register_driver'

Fixes: 2a2c74b2efcb ("IBM Akebono: Add the Akebono platform")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202312010820.cmdwF5X9-lkp@intel.com
Cc: Alistair Popple <alistair@popple.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/44x/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -173,6 +173,7 @@ config ISS4xx
 config CURRITUCK
 	bool "IBM Currituck (476fpe) Support"
 	depends on PPC_47x
+	select I2C
 	select SWIOTLB
 	select 476FPE
 	select FORCE_PCI
