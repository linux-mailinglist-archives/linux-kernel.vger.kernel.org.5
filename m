Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A04798D46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjIHSVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344063AbjIHSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E52D42;
        Fri,  8 Sep 2023 11:18:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669D3C3277C;
        Fri,  8 Sep 2023 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197040;
        bh=u9dEwrOvXbjzBfCMU9FaZiUDZQVrozxBy7cifxEB0KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Amxtyo3mcgIXUzcUvxpzMHqLHcB3lD3ZSjekn0lI6hRQ5fY2tBpC8VTBVDCVNpENT
         MYez+LGaS9CZJtxLT8NOXCtH4XqyJzGX9j+/de6y8i7LE4pDxD85ePL7aGYEf4Pgqb
         8TOOOOneQwKKCRMHR20xj+lP75zbQkUeh4M7RlQPeHzwMLwbe8b8aewV7Nm7/kXOiO
         EU4PhdcyrLBr6onlGEJgSq5A94TbE/ey7HMZHYs1tSiCAFN9y+lVeYGgFHB6eA9a3M
         6WOWBzlEbdeRm2iZKTdeH2bdnMC/NJRsoOxtXnCgFqG8AyMbDWkrErrjw1r6LmnrHU
         1jS2Mn3GGvaKA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 32/41] wifi: cfg80211: ocb: don't leave if not joined
Date:   Fri,  8 Sep 2023 14:15:46 -0400
Message-Id: <20230908181555.3459640-32-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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

