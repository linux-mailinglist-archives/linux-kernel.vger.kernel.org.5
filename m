Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E96798D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbjIHSWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbjIHSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:21:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43C2116;
        Fri,  8 Sep 2023 11:19:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF950C433CD;
        Fri,  8 Sep 2023 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197151;
        bh=u9dEwrOvXbjzBfCMU9FaZiUDZQVrozxBy7cifxEB0KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNtplmLSmAG0+H4Uob6/GTu/Snkde286SocE8gnVae02Kub1+jMTpOPbB0YkgExAt
         ZA4+OAS8OWYJ7REUgNhUbIkwCjRirq1n2sSPmsCu4ngyLUVS1+JxCX5NA29DQ7IIaB
         81QPTt/neGTgAPLGHONSguESqp0Z+Obs2MHgraBXxQCKMSdvU8ney/jLdfu8/h8SMz
         cCiGpLtskkqNcTLmwC/EMjuKos91pgDHXwKqEvea0kcHc5aPWcDq6M1jTcTAQ31OUr
         SFrV0n9IOq/UeMjBpjawJixS3RV+WPdT2om7OBoQ6EPcWtVAHetM17xkRhMbGabKtf
         dFDeFvfd7I46A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 22/26] wifi: cfg80211: ocb: don't leave if not joined
Date:   Fri,  8 Sep 2023 14:18:00 -0400
Message-Id: <20230908181806.3460164-22-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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

[ Upstream commit abc76cf552e13cfa88a204b362a86b0e08e95228 ]

If there's no OCB state, don't ask the driver/mac80211 to
leave, since that's just confusing. Since set/clear the
chandef state, that's a simple check.

Reported-by: syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/ocb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/ocb.c b/net/wireless/ocb.c
index 27a1732264f95..29afaf3da54f3 100644
--- a/net/wireless/ocb.c
+++ b/net/wireless/ocb.c
@@ -68,6 +68,9 @@ int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->leave_ocb)
 		return -EOPNOTSUPP;
 
+	if (!wdev->u.ocb.chandef.chan)
+		return -ENOTCONN;
+
 	err = rdev_leave_ocb(rdev, dev);
 	if (!err)
 		memset(&wdev->u.ocb.chandef, 0, sizeof(wdev->u.ocb.chandef));
-- 
2.40.1

