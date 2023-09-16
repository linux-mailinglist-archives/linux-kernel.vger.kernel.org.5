Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC17A2E04
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 07:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjIPFHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 01:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjIPFHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 01:07:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8218A19AE;
        Fri, 15 Sep 2023 22:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vCIxxdvf/dqUjZgY4hxlo2HkzPv50wadYLt6wlCZc9g=; b=ZiSeVCm5t5xoyb+HL4zuwKrIOy
        0PkBGMWL/UFQtBrmvbLEigH+WgLa0v0WO/4ZIYfmhri3dpCNd+CWJ1E8VsAQfG+GFs0BezQm1lJYG
        DCvYIf16UMTB38nbnyOnXBQ6TZZYXs0kW6rfouTuROwBHyssvVNpqmC/zUNEYlgsOACk69oOhaIFL
        3XSj64Nc8isU5I8TljRqPBKhWB5w53quULjNJcveZVQDviZcAHMADvNu53sxKMeE1ZdiTiHdENm6b
        MFcvVEKJzXsvD9pU85NYdmiGtF21GSyinSyT2ub7DlWqjSNhLcWAiFpPhIm9oFDiVzxGUrjPEUsld
        iz8R712g==;
Received: from [2601:1c2:980:9ec0:e65e:37ff:febd:ee53] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qhNWK-00BxBO-1l;
        Sat, 16 Sep 2023 05:07:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Roger Quadros <rogerq@ti.com>,
        Md Danish Anwar <danishanwar@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH] net: ti: icss-iep: add dependency for PTP
Date:   Fri, 15 Sep 2023 22:07:01 -0700
Message-ID: <20230916050701.15480-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PTP_1588_CLOCK=m and CONFIG_TI_ICSS_IEP=y,
there are build errors when referencing PTP functions.
Fix this by making TI_ICSS_IEP depend on PTP_1588_CLOCK_OPTIONAL.
Also, since TI_ICSSG_PRUETH selects TI_ICSS_IEP and selects don't
follow dependencies, make the former also depend on
PTP_1588_CLOCK_OPTIONAL.

Fixes these build errors:

aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
icss_iep.c:(.text+0x234): undefined reference to `ptp_clock_index'
aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_exit':
icss_iep.c:(.text+0x634): undefined reference to `ptp_clock_unregister'
aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_init':
icss_iep.c:(.text+0x1848): undefined reference to `ptp_clock_register'

Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202309151207.NPDMiINe-lkp@intel.com
Cc: Roger Quadros <rogerq@ti.com>
Cc: Md Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/ti/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -189,6 +189,7 @@ config TI_ICSSG_PRUETH
 	select TI_ICSS_IEP
 	depends on PRU_REMOTEPROC
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.
@@ -200,6 +201,7 @@ config TI_ICSSG_PRUETH
 config TI_ICSS_IEP
 	tristate "TI PRU ICSS IEP driver"
 	depends on TI_PRUSS
+	depends on PTP_1588_CLOCK_OPTIONAL
 	default TI_PRUSS
 	help
 	  This driver enables support for the PRU-ICSS Industrial Ethernet
