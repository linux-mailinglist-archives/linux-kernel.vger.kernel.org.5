Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48E7F3629
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjKUShY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjKUShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:37:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C5CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:37:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA569C433C7;
        Tue, 21 Nov 2023 18:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700591825;
        bh=3Izh/8YivRbhQV8XlIsV2wimO/ukDV888NfvTAlrLdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkqMSfp4QvHraguZpfhrbsvGogT0mgl0KOjBBDILIekYojqExQ9KVG9PhsHPt9H8y
         DfmLCOjeV9MMba0Ac/3YXGWaxT4T8hRNns2R1y3+5ISLTmmoaNnNP3FkLnX9jJk0kw
         v6SMoXIjGBsN+wc5Tt+P7mqpmB+3DtewO/ZRr8XIBjkYoq0DHWhXuqZsPuLe6209wp
         Z3XILl/fzd+z3F/XqqBYyv15lKzS8ioSvjHeOykGj4tupcqw3v2zMKubyUYoPr8bX8
         xuDlgq/lCIDo/bn8KaDfhJ8xWlgO7jL+11KQylE/u2yoQnStcYG4YWk1SP2sz1rG9P
         TCRI4xoxo6ugg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Tomasz Pala <gotar@polanet.pl>,
        Sebastian Manciulea <manciuleas@protonmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 8/9] x86/pci: Return pci_mmconfig_add() failure early
Date:   Tue, 21 Nov 2023 12:36:42 -0600
Message-Id: <20231121183643.249006-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121183643.249006-1-helgaas@kernel.org>
References: <20231121183643.249006-1-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

If pci_mmconfig_alloc() fails, return the failure early so it's obvious
that the failure is the exception, and the success is the normal case.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 459e95782bb1..0cc9520666ef 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -102,14 +102,15 @@ struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
 	struct pci_mmcfg_region *new;
 
 	new = pci_mmconfig_alloc(segment, start, end, addr);
-	if (new) {
-		mutex_lock(&pci_mmcfg_lock);
-		list_add_sorted(new);
-		mutex_unlock(&pci_mmcfg_lock);
+	if (!new)
+		return NULL;
 
-		pr_info("ECAM %pR (base %#lx) for domain %04x [bus %02x-%02x]\n",
-			&new->res, (unsigned long)addr, segment, start, end);
-	}
+	mutex_lock(&pci_mmcfg_lock);
+	list_add_sorted(new);
+	mutex_unlock(&pci_mmcfg_lock);
+
+	pr_info("ECAM %pR (base %#lx) for domain %04x [bus %02x-%02x]\n",
+		&new->res, (unsigned long)addr, segment, start, end);
 
 	return new;
 }
-- 
2.34.1

