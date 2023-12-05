Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89893805C31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjLERLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjLERLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:11:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1388E1BE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:11:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C9BC433C7;
        Tue,  5 Dec 2023 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796284;
        bh=uQ8NO0YEvmWRTXpfKA698SVu/8BUZMEaJADM8AXng0A=;
        h=From:To:Cc:Subject:Date:From;
        b=QLLFSIeoQ9Rb8Oq5nr1rquMQbHONSD/WqnFsmDNi22I7HaHcC+2iOL+HW8hgkm+8s
         i+U9FVet2uN+P9vsr5aOKuCagl9KFtHCcm5CcZaim8kJyN5a19ZinbYwEBGVZHkDTk
         gK7FU4MOj/xJxtCmCm4tslm8be9OfkwDzuXWENseaVcwZW3DIBSoAN1yMTFiDECu2T
         NUJ462V1FpxI0Oh52aU0l8YB1D7lHAWdlL3FmCKDP4MKr1JL44KJcGDNb5qKElQVgl
         aabUDbjQLzwy66ymRpfGdP7ZBuaXM6Q+l1Jeuie1hmUrA6tslrtulFT3bPB+ylyta/
         MzcEP4pV0Z+Yw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/7] PCI: Improve enumeration logging
Date:   Tue,  5 Dec 2023 11:11:12 -0600
Message-Id: <20231205171119.680358-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is based on Puranjay Mohan's work at
https://lore.kernel.org/all/20211106112606.192563-1-puranjay12@gmail.com/
which updated BAR resource logging to consistently use "BAR 0" instead of a
mix of "BAR 0", "reg 0x10", etc.

I added:

  - More BAR resource log updates
  - Device type (PCIe Root Port, Switch Port, etc) to initial message
  - Bridge info logging in logical order (bridge before downstream)

Bjorn Helgaas (5):
  PCI: Log device type during enumeration
  PCI: Move pci_read_bridge_windows() below individual window accessors
  PCI: Supply bridge device, not secondary bus, to read window details
  PCI: Log bridge windows conditionally
  PCI: Log bridge info when first enumerating bridge

Puranjay Mohan (2):
  PCI: Update BAR # and window messages
  PCI: Use resource names in PCI log messages

 drivers/pci/iov.c       |   7 +-
 drivers/pci/pci.c       |  85 ++++++++++++++--
 drivers/pci/pci.h       |   2 +
 drivers/pci/probe.c     | 218 ++++++++++++++++++++++++----------------
 drivers/pci/quirks.c    |  15 ++-
 drivers/pci/setup-bus.c |  30 ++++--
 drivers/pci/setup-res.c |  72 +++++++------
 7 files changed, 286 insertions(+), 143 deletions(-)

-- 
2.34.1

