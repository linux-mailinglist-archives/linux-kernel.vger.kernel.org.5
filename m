Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7737EF5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbjKQQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbjKQQKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:10:51 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D7E6;
        Fri, 17 Nov 2023 08:10:47 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGABSU119464;
        Fri, 17 Nov 2023 10:10:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700237411;
        bh=F/1wswiAY1XblJ8zuw53T70Bg/cif/hAR2h+0LkgMdM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ouR0t1e0TfiMtAgC61F+w3go10AW+3lXJXXwhGuS+F/5saDJt2beKZHMmk+bOLgTd
         PretWxm9eimqr0NZfLfNDmNkAOocZZmjrM+mQ7PP2ehLF3fvwOM7dagYsjhI8RyklN
         AicFpZ/E6T6d3YlfIO2i+XVjqkeM+4gBXwCaFcR8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHGABaH070305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 10:10:11 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 10:10:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 10:10:10 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGA8GK004950;
        Fri, 17 Nov 2023 10:10:09 -0600
From:   Andrew Davis <afd@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 1/5] kernel/reboot: Deprecate register_restart_handler()
Date:   Fri, 17 Nov 2023 10:10:02 -0600
Message-ID: <20231117161006.87734-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117161006.87734-1-afd@ti.com>
References: <20231117161006.87734-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are now two ways to add a handler to the restart_handler_list.
Two ways to do the same thing is bad design, so let's unify on using
the new method register_sys_off_handler() everywhere.

Reasons:
 * The other register_*_handler functions take a callback, this old
   API takes a notifier_block, which makes it confusing with the
   register_*_notifier class of functions.
 * register_sys_off_handler (new API) is a more unified API allowing for
   registering several system off types.
 * The new API has more helpers built around it now, including devm and
   platform helpers.
 * The new API manages the struct notifier_block for us, simplifying using
   code.

Mark register_restart_handler() as deprecated to try to warn off new users
while we finish converting the remaining existing users.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 include/linux/reboot.h | 8 ++++++--
 kernel/reboot.c        | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index c4cc3b89ced1f..c5fff3157b191 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -46,8 +46,12 @@ extern int unregister_reboot_notifier(struct notifier_block *);
 
 extern int devm_register_reboot_notifier(struct device *, struct notifier_block *);
 
-extern int register_restart_handler(struct notifier_block *);
-extern int unregister_restart_handler(struct notifier_block *);
+/*
+ * This function is deprecated, use register_sys_off_handler(SYS_OFF_MODE_RESTART)
+ * or devm_register_restart_handler() instead.
+ */
+extern int __deprecated register_restart_handler(struct notifier_block *);
+extern int __deprecated unregister_restart_handler(struct notifier_block *);
 extern void do_kernel_restart(char *cmd);
 
 /*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 395a0ea3c7a8a..768ce97829f41 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -189,6 +189,9 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
  *
  *	Currently always returns zero, as atomic_notifier_chain_register()
  *	always returns zero.
+ *
+ *	This function is deprecated, use register_sys_off_handler(SYS_OFF_MODE_RESTART)
+ *	or devm_register_restart_handler() instead.
  */
 int register_restart_handler(struct notifier_block *nb)
 {
-- 
2.39.2

