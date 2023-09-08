Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09470798CD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbjIHSSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343939AbjIHSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:18:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C2B1FE1;
        Fri,  8 Sep 2023 11:17:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3A3C116B3;
        Fri,  8 Sep 2023 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196913;
        bh=v5r4k8U0DLGb0mXAvVkpUeh3vSlveuQG9MwHS2kHWDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPkwgsi/qn1vNpXJcbP4xtFnNJcmO1A9m5XEFiSWoHT9UVfkfwx69KJ8z7sDTMlKZ
         WHILo2BPJgzGW4wxdJ/cuKkIFC4cP0wyxK+ejneXQBO0Pmgtk8mAJNvwVZhxV+Eosd
         WuZQBKEUbXa4iD+Vt/OTmUPPMPu/rlprrCLBEZ7aq4XC82N5LTm/9Uj3PR+dBLVrps
         q8WzDWb5TtdWIdFYiGyFc7ar9TIh1jO+pA635kXPSL6qvHjQDG3kO3mSp5JTikyJTR
         lUc2UDIMxHFXF4SL5cRtC6AjbzGMuW26Gux5JAretKe+WWN8aerqPB8sVLPp0dFuBu
         yWrEWQ3zr13qQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 38/45] Revert "wifi: mac80211_hwsim: check the return value of nla_put_u32"
Date:   Fri,  8 Sep 2023 14:13:19 -0400
Message-Id: <20230908181327.3459042-38-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 1b78dd34560e9962f8e917fe4adde6f2ab0eb89f ]

This reverts commit b970ac68e0c4 ("wifi: mac80211_hwsim: check the
return value of nla_put_u32") since it introduced a memory leak in
the error path, which seems worse than sending an incomplete skb,
and the put can't fail anyway since the SKB was just allocated.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index dd516cec41973..23307c8baea21 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -582,9 +582,8 @@ static int mac80211_hwsim_vendor_cmd_test(struct wiphy *wiphy,
 		 */
 
 		/* Add vendor data */
-		err = nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 1);
-		if (err)
-			return err;
+		nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 1);
+
 		/* Send the event - this will call nla_nest_end() */
 		cfg80211_vendor_event(skb, GFP_KERNEL);
 	}
-- 
2.40.1

