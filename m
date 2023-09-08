Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4872B798D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjIHSUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjIHSTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E609D269D;
        Fri,  8 Sep 2023 11:18:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AEAC4163D;
        Fri,  8 Sep 2023 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196899;
        bh=lTFHdvOXYprreICOKnPUdyyw0ENV4id4PnV79YcPrjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCzwIgBWi4PJECEhEi/sABz5gd3ZIZ/H+dTaU3+usNVoDcrA6QMxCJb/8DXtyEtlu
         MoBijezZzosAFFs1YSWALxKOOj+A/uvOB+2df1zZrr5gHCuLGbS1qoHuMkcTuChQQu
         16zMtkdqP9so43yDanptqVXqXHwRDk86XDShWnGOzvSHzFAxUIb1NP8XFw1VxZ4W0C
         3FVpS0u0y5sGqbovLzJD+3w9wXl/QS1gfU2Gwya87s9PlWdcZWNQ8Y4h9KxCQqkgQ0
         /PjldvZuGJpzaixPl9X79cDe0CJ96MjZCgCWpcQXoQ74FmtuvKukzM3OMbqmblqP7A
         zToAWoMMfEVIw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        mukesh.sisodiya@intel.com, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 31/45] wifi: iwlwifi: pcie: avoid a warning in case prepare card failed
Date:   Fri,  8 Sep 2023 14:13:12 -0400
Message-Id: <20230908181327.3459042-31-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit 057381ddac0593c6e4ca8f58732830d8542b9c4e ]

In case CSME holds the NIC and SAP connection is already established,
iwl_pcie_prepare_card_hw() during iwl_pci_probe() will fail
(which is fine since CSME will release the nic later when asked with
a SAP message). In this case tring to grab nic access to read the
crf ids will fail with a warning.
Avoid the warning by only trying to read the crf ids in case prepare
card succeeded.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230822103048.9b026fa7b97e.I12bea7e6eef54eeeaf916b68d71583e92ff310fd@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 73c1fb3c0c5ec..bc83d2ba55c67 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1132,12 +1132,6 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 	else
 		sd_reg_ver_addr = SD_REG_VER;
 
-	if (!iwl_trans_grab_nic_access(iwl_trans)) {
-		IWL_ERR(iwl_trans, "Failed to grab nic access before reading crf id\n");
-		ret = -EIO;
-		goto out;
-	}
-
 	/* Enable access to peripheral registers */
 	val = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
 	val |= ENABLE_WFPM;
@@ -1157,9 +1151,6 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 		 iwl_trans->hw_crf_id, iwl_trans->hw_cnv_id,
 		 iwl_trans->hw_wfpm_id);
 
-	iwl_trans_release_nic_access(iwl_trans);
-
-out:
 	return ret;
 }
 
@@ -1351,6 +1342,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ret)
 			goto out_free_trans;
 		if (iwl_trans_grab_nic_access(iwl_trans)) {
+			get_crf_id(iwl_trans);
 			/* all good */
 			iwl_trans_release_nic_access(iwl_trans);
 		} else {
@@ -1360,7 +1352,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
-	get_crf_id(iwl_trans);
 
 	/*
 	 * The RF_ID is set to zero in blank OTP so read version to
-- 
2.40.1

