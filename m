Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F27F3623
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjKUShU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjKUShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:37:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E710CF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:37:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15255C433C9;
        Tue, 21 Nov 2023 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700591823;
        bh=xBeqzteKzjRFD7AK4f9XGIWZHMzDuTSTe3bPhMPVydE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XW+n6C08SNh+kInRoEGKqDrPEzsmS4/A230SA1t1ygBldR47hQJaz0mYmCkCFf3p0
         VrlzzKWr2unKQkxS6rU6CxyBKOq0P0Lp5flZeYXdFimOWl4kV+FpiFji8iVt8Rt+8A
         cHtXR8Vb+F6VjpGZI3o8NDdtV8Igl4BtI5oHyRVrP7milTrTWKXU8xJuavzoe3gjzL
         RuIxdCWCnwiUlQhcZQK62gh3kKt95dBx1SBBZSOyt+BIfFDbGN5z/+GheND+w3YSzi
         FlGBrovDFtly2OWiWeSgTl3voaQ5JsTVvHXdlOm8Z0MuYaezO9iYSPqUKozVF5kscx
         wvJh13DDHuRbA==
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
Subject: [PATCH 7/9] x86/pci: Comment pci_mmconfig_insert() obscure MCFG dependency
Date:   Tue, 21 Nov 2023 12:36:41 -0600
Message-Id: <20231121183643.249006-8-helgaas@kernel.org>
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

In pci_mmconfig_insert(), there's no reference to "addr" between locking
pci_mmcfg_lock and testing "addr", so it *looks* like we should move the
test before the lock.

But 07f9b61c3915 ("x86/PCI: MMCONFIG: Check earlier for MMCONFIG region at
address zero") did that, which broke things by returning -EINVAL when
"addr" is zero instead of -EEXIST.

So 07f9b61c3915 was reverted by 67d470e0e171 ("Revert "x86/PCI: MMCONFIG:
Check earlier for MMCONFIG region at address zero"").

Add a comment about this issue to prevent it from happening again.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index b36c10e86505..459e95782bb1 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -786,6 +786,10 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 		return -EEXIST;
 	}
 
+	/*
+	 * Don't move earlier; we must return -EEXIST, not -EINVAL, if
+	 * pci_mmconfig_lookup() finds something
+	 */
 	if (!addr) {
 		mutex_unlock(&pci_mmcfg_lock);
 		return -EINVAL;
-- 
2.34.1

