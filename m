Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A4E807B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377648AbjLFWmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377594AbjLFWme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:42:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A39D5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:42:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6D5C433C9;
        Wed,  6 Dec 2023 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701902560;
        bh=7cHmMbybKrcpsaIuCFsEGmwf1pycx3Ksk6fyQJF+zME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udeflMBF4LfGQE+1gMmco53gECNUhwPIYb1EpsGpaa9OW+4tQlZc2nhTHNReQ2ioE
         TLF+CbG4qCR+Ql1SjfAyEuKy5Zy1CqoNYH7lcRMrVs8i47VgeYd6ZzYhQyKe1KTqzC
         XnT9Jvzqv9HNvZLqeXPiHUX64Q1UxNKS3itjy9tqr8+/kXzP/EQ2uS9UpxWzKd+N9E
         8qO8vyGDdOaywN7EkOuRMhW6IW6cJk05deGN2H3isCvCsJQ/H4a/KeprlRygSVV1AP
         CQdJ70a3h5C+DW11ZdbfdG6euahmWVRG71FQs3KvHUaQ6Q/KETtNACDb9wfZsIfb3j
         KdFaqqi5nItfw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] PCI/AER: Use 'Correctable' and 'Uncorrectable' spec terms for errors
Date:   Wed,  6 Dec 2023 16:42:29 -0600
Message-Id: <20231206224231.732765-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206224231.732765-1-helgaas@kernel.org>
References: <20231206224231.732765-1-helgaas@kernel.org>
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

The PCIe spec classifies errors as either "Correctable" or "Uncorrectable".
Previously we printed these as "Corrected" or "Uncorrected".  To avoid
confusion, use the same terms as the spec.

One confusing situation is when one agent detects an error, but another
agent is responsible for recovery, e.g., by re-attempting the operation.
The first agent may log a "correctable" error but it has not yet been
corrected.  The recovery agent must report an uncorrectable error if it is
unable to recover.  If we print the first agent's error as "Corrected", it
gives the false impression that it has already been resolved.

Sample message change:

  - pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
  + pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 42a3bd35a3e1..20db80018b5d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -436,9 +436,9 @@ void pci_aer_exit(struct pci_dev *dev)
  * AER error strings
  */
 static const char *aer_error_severity_string[] = {
-	"Uncorrected (Non-Fatal)",
-	"Uncorrected (Fatal)",
-	"Corrected"
+	"Uncorrectable (Non-Fatal)",
+	"Uncorrectable (Fatal)",
+	"Correctable"
 };
 
 static const char *aer_error_layer[] = {
-- 
2.34.1

