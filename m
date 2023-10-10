Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1B7BFF63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjJJOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjJJOeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:34:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F3991;
        Tue, 10 Oct 2023 07:34:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E72C433C8;
        Tue, 10 Oct 2023 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696948455;
        bh=fmFwrPcAyEKLEAejOhS2wgGgutJrLdVOGra4FoLn4qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JozFSRXi59nVa4+B03M7Nv3dvqf6zgLDdCWJjDCHgYl8VeNZpi2MoAy7UuH3RN+SX
         mxyDqi7otEx0M2ZeNlj5/cuFsX84sC8UlAYuD8zrkup/uJoZ/WatlaSlUNYGjXqp/Q
         sNfqQWdOcYPeQKs6B2lAwCdkLvhTuj5ELCsVmWvtVrklXDaRWYXK0ZLpjtsD0XQrV8
         TsXDx8D2tWJpYKwY2bkKOcGDTxTmyQeIC43jGy+/iqCc638Thvynf87//DwGtg2swC
         c8RXdxpUAL8+S6uFWftClcrtZceysAmYgdLLUOY1ImwbvkW7jpxPycaIMLGgZtiR3w
         dcnr6PfH9sy4g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] MIPS: lantic: Fix pcibios_plat_dev_init() "no previous prototype" warning
Date:   Tue, 10 Oct 2023 09:34:05 -0500
Message-Id: <20231010143406.974591-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010143406.974591-1-helgaas@kernel.org>
References: <20231010143406.974591-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

After bbd8810d3998 ("PCI: Remove unused includes and superfluous struct
declaration"), <linux/of_pci.h> no longer includes <linux/pci.h>, which
provides the extern declarations for pcibios_plat_dev_init() and
pcibios_map_irq() via <asm/pci.h>.

This results in these new warnings:

  arch/mips/pci/fixup-lantiq.c:13:5: warning: no previous prototype for 'pcibios_plat_dev_init' [-Wmissing-prototypes]
  arch/mips/pci/fixup-lantiq.c:24:5: warning: no previous prototype for 'pcibios_map_irq' [-Wmissing-prototypes]

Include <linux/pci.h> directly to get these declarations.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310070445.tzRBNYRC-lkp@intel.com/
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/fixup-lantiq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/pci/fixup-lantiq.c b/arch/mips/pci/fixup-lantiq.c
index 105569c1b712..8f5fb98b3984 100644
--- a/arch/mips/pci/fixup-lantiq.c
+++ b/arch/mips/pci/fixup-lantiq.c
@@ -6,6 +6,7 @@
 
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 
 int (*ltq_pci_plat_arch_init)(struct pci_dev *dev) = NULL;
 int (*ltq_pci_plat_dev_init)(struct pci_dev *dev) = NULL;
-- 
2.34.1

