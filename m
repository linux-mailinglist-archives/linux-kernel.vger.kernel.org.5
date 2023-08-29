Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B8178C5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjH2Neu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjH2Ndg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC781AD;
        Tue, 29 Aug 2023 06:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F55065762;
        Tue, 29 Aug 2023 13:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95750C433C7;
        Tue, 29 Aug 2023 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315968;
        bh=z8hGr64k/pjOOppG6gKNJcJ3LaKsf7JLeIMOkGvVbyU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ha86a3TdJliVqazo09SSZciUdFk9bmnlY9A8fNohOqDAK6rEqu3Wtc1nFbmOUGzph
         92+l1g2LgS6/Rdfonw0vSDZ2rXbxIN3m4lNICHNxagjD2ifJmAGj4U80z6Fn2fCGz4
         gThOLlC0Q8VS50CkXL6Wdq7fWn+ZfjkOh4LYtjMRyFbF6XluLizRI0FsI0K4o+lLfW
         R7pTDG+mdFE87vUP4JofFdPYxQFXR4l5WlNkKsN+nG/vyjK3fRmVppVZe1w0P/IKvp
         RgfaOxLogWeQwmtQdbgAR4BfQkBN8r2gLrbvaafJNHy+SFWb1MHaJBWfi2gvujX5Hv
         wI910/MV7Sfkw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/15] wifi: cfg80211: remove links only on AP
Date:   Tue, 29 Aug 2023 09:32:31 -0400
Message-Id: <20230829133245.520176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.49
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

[ Upstream commit 34d4e3eb67fed9c19719bedb748e5a8b6ccc97a5 ]

Since links are only controlled by userspace via cfg80211
in AP mode, also only remove them from the driver in that
case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230608163202.ed65b94916fa.I2458c46888284cc5ce30715fe642bc5fc4340c8f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/util.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 39680e7bad45a..f433f3fdd9e94 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007-2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <linux/export.h>
 #include <linux/bitops.h>
@@ -2479,6 +2479,13 @@ void cfg80211_remove_links(struct wireless_dev *wdev)
 {
 	unsigned int link_id;
 
+	/*
+	 * links are controlled by upper layers (userspace/cfg)
+	 * only for AP mode, so only remove them here for AP
+	 */
+	if (wdev->iftype != NL80211_IFTYPE_AP)
+		return;
+
 	wdev_lock(wdev);
 	if (wdev->valid_links) {
 		for_each_valid_link(wdev, link_id)
-- 
2.40.1

