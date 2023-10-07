Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6207BC992
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbjJGSYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGSYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:24:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82720BC;
        Sat,  7 Oct 2023 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QMmmdka+5r7TnWgQ+zRWrvp3h9M2Ione/vlBDmKezJY=; b=Brg9Yo1VWlk5XfNL843e/POx5h
        qm+gnZ/1DEEN9vP3mSkDoZTD8QOvddRbrrPCdCnQdDfVsmas3NkZ3uUSwRWuvrwiOI4TPOzPDbrJf
        gsN9q1pFxkAn8pYECarc5RQCBw85lkUdK2V/9Ii0SqapsFsKDmfNqT1ClFxx0ACgU4mhkKquatWUh
        XQrEH7kAkP2RqHSZGZXfm+Hy5RlL0vd9F6VIOrfibELoYt50gkCLAUkll9ur5VYXGXywFkgBARt7l
        0QMtyHzFg7nN2bAPvKZFeay1IFIoIEiP5zLaeyFrmopy7ZL08W4DaaYTLxGzGiI4A1NXZg/a66MP8
        QeUJUVZw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qpBym-007nvV-2e;
        Sat, 07 Oct 2023 18:24:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org
Subject: [RFC PATCH] ssb: relax SSB_EMBEDDED dependencies
Date:   Sat,  7 Oct 2023 11:24:43 -0700
Message-ID: <20231007182443.32300-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
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

This is a kconfig warning in a randconfig when CONFIG_PCI is not set:

WARNING: unmet direct dependencies detected for SSB_EMBEDDED
  Depends on [n]: SSB [=y] && SSB_DRIVER_MIPS [=y] && SSB_PCICORE_HOSTMODE [=n]
  Selected by [y]:
  - BCM47XX_SSB [=y] && BCM47XX [=y]

This is caused by arch/mips/bcm47xx/Kconfig's symbol BCM47XX_SSB
selecting SSB_EMBEDDED when CONFIG_PCI is not set.

This warning can be prevented by having SSB_EMBEDDED not depend on
SSB_PCICORE_HOSTMODE, although some parts of SSB use PCI.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Buesch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org
---
Comments, thoughts?

I also tried changing arch/mips/bcm47xx/Kconfig's BCM47XX_SSB to
	select SSB_EMBEDDED if PCI
but that results in build errors.

 drivers/ssb/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -134,7 +134,7 @@ config SSB_SFLASH
 # Assumption: We are on embedded, if we compile the MIPS core.
 config SSB_EMBEDDED
 	bool
-	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
+	depends on SSB_DRIVER_MIPS
 	default y
 
 config SSB_DRIVER_EXTIF
