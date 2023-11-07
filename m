Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B437E3BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjKGMKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjKGMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:09:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E220269E;
        Tue,  7 Nov 2023 04:08:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F29C433D9;
        Tue,  7 Nov 2023 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358903;
        bh=rjyDa/JzWevqiRTvkRQBMVxrkWCq/sYG2ae5ELikHhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvWQ+2hBtHd+pukQuICO6mjQlZdTT/kScdXcfAlsBvWpA3fReNOl4fqf4NSd2T9vM
         DR5i+bp+HHiArup7eOsb52dO+DwZSoQ+sd8BfUHvpw0Jtq7uks9p5Uf3v35WmQauHi
         IFmtk0oMI6tipyq9LtrfoIDjRhZvxdTKsTqSShHFPEvsdSlNuRXbxYtSrzKTwuWe+H
         b4F12mSDPXy0lFHzIUmycTfZPNraXbB4V31OVF+fQqqUntNyH0h3aJ9KbNVIhcCN4F
         Ua3THxgJmSF3F8WhrsrdBCgxIfIYNfiRnBls69plkAUfziZc+8jxfcm+ur5emLZqxE
         HWZLMtZ8ZezmA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        miriam.rachel.korenblit@intel.com, emmanuel.grumbach@intel.com,
        ilan.peer@intel.com, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/31] wifi: iwlwifi: mvm: fix size check for fw_link_id
Date:   Tue,  7 Nov 2023 07:06:10 -0500
Message-ID: <20231107120704.3756327-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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

From: Gregory Greenman <gregory.greenman@intel.com>

[ Upstream commit e25bd1853cc8308158d97e5b3696ea3689fa0840 ]

Check that fw_link_id does not exceed the size of link_id_to_link_conf
array. There's no any codepath that can cause that, but it's still
safer to verify in case fw_link_id gets corrupted.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231017115047.3385bd11f423.I2d30fdb464f951c648217553c47901857a0046c7@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index ace82e2c5bd91..a15e2c6caa242 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -61,7 +61,7 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID) {
 		link_info->fw_link_id = iwl_mvm_get_free_fw_link_id(mvm,
 								    mvmvif);
-		if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
+		if (link_info->fw_link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf))
 			return -EINVAL;
 
 		rcu_assign_pointer(mvm->link_id_to_link_conf[link_info->fw_link_id],
@@ -245,7 +245,7 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	int ret;
 
 	if (WARN_ON(!link_info ||
-		    link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
+		    link_info->fw_link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf)))
 		return -EINVAL;
 
 	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
-- 
2.42.0

