Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090727F3610
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjKUSgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjKUSgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:36:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF6E9E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:36:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0859FC433C7;
        Tue, 21 Nov 2023 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700591810;
        bh=iUIz/SwdoSJeQb7e6Gxw95AuLdR6o8t7aa9vIVBVcl8=;
        h=From:To:Cc:Subject:Date:From;
        b=pikMlQn3Oj8RTANE4jzV/LDOk/isKXa2rIbLdcmxJsx1Fd84N6Hs23H/1PtdFQFa8
         jgm2HYGPtOPCohu0G0EcSrk+wmjSoKhI2SSZSlLwYUgAFbq5s3uVlQ6Fb94yZuKjEn
         ctjlmkItYi2GuBXgRx9B9PlNgdUGVh8kVnGAx7nBQJ4+Ise7fvComSyuG5Ipfir0AF
         C/WCfYG1QbW5bVVM7sOv8HHqfd23Mqbjx/NmZgX3a+9g9j4sHZcOQ2r8uaGVSF/p8g
         ZuUIX8EX1iErDf3MtAH6CGVW/d5mZ5M02Xoa24W59Zd9SIB12WzOOQKDa/nSXJl59V
         PnK80iVt2d6Cg==
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
Subject: [PATCH 0/9] x86/pci: Work around lack of ECAM space reservation
Date:   Tue, 21 Nov 2023 12:36:34 -0600
Message-Id: <20231121183643.249006-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The ECAM space described in the ACPI MCFG table should be reserved via a
PNP0C02 _CRS method, per PCI Firmware spec (r3.3, sec 4.1.2).

Some platforms (at least Supermicro X9DRi-LN4+, HP Proliant ML30 Gen9) do
not include these PNP0C02 reservations, and at the same time, they *do*
include that space in the PNP0A03 host bridge windows, which makes it
available for assignment to PCI devices.

In this case, we treat the ECAM space as valid (after fd3a8cff4d4a
("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space")), but
there was no actual reservation to prevent assignment to PCI devices.

This series adds that reservation to prevent assigning ECAM space to PCI
BARs, adds more debug logging, changes "MMCONFIG" to "ECAM" to match the
spec terminology, and cleans up some coding style.

I propose to merge this via the PCI tree for v6.8.

Bjorn Helgaas (9):
  x86/pci: Reserve ECAM if BIOS didn't include it in PNP0C02 _CRS
  x86/pci: Reword ECAM EfiMemoryMappedIO logging to avoid 'reserved'
  x86/pci: Add MCFG debug logging
  x86/pci: Rename 'MMCONFIG' to 'ECAM', use pr_fmt
  x86/pci: Rename acpi_mcfg_check_entry() to acpi_mcfg_valid_entry()
  x86/pci: Rename pci_mmcfg_check_reserved() to pci_mmcfg_reserved()
  x86/pci: Comment pci_mmconfig_insert() obscure MCFG dependency
  x86/pci: Return pci_mmconfig_add() failure early
  x86/pci: Reorder pci_mmcfg_arch_map() definition before calls

 arch/x86/pci/acpi.c            |   3 +
 arch/x86/pci/mmconfig-shared.c | 178 ++++++++++++++++++---------------
 arch/x86/pci/mmconfig_32.c     |   2 +-
 arch/x86/pci/mmconfig_64.c     |  42 ++++----
 4 files changed, 120 insertions(+), 105 deletions(-)

-- 
2.34.1

