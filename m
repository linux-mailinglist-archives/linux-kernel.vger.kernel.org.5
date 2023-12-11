Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7BD80C50D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjLKJpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbjLKJpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:45:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF18F1989
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:44:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE40C433C7;
        Mon, 11 Dec 2023 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702287899;
        bh=SHAWNF2VWtOl+CSyK/PRRtYXXfTpDuzOCIzIkUHqqH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJ7F8jDSTtbqwcDGmKD77O//M+4fsiq3GlAs6+Bx7z7k7fz3yF/XYA5HRFChmWm14
         1cEuBbU9CRLZy5lyTovIY0yEWDWbX1FU6HFO99ioGl6WFanTkfRQhvzysg7ArEcMOm
         AQzOGW1ORdwFAk/4dEOVOMJqhLrYdyPHAJzeGKe8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.67
Date:   Mon, 11 Dec 2023 10:44:47 +0100
Message-ID: <2023121147-turban-polish-002d@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023121147-finally-museum-8aad@gregkh>
References: <2023121147-finally-museum-8aad@gregkh>
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

diff --git a/Makefile b/Makefile
index 5d7e995d686c..c27600b90cad 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 66
+SUBLEVEL = 67
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index ee980965a7cf..e1accacc6f23 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -297,7 +297,6 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	enum nl80211_cqm_rssi_threshold_event last_rssi_event_type;
-	bool use_range_api;
 	int n_rssi_thresholds;
 	s32 rssi_thresholds[];
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 42c858219b34..b19b5acfaf3a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12574,6 +12574,10 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int i, n, low_index;
 	int err;
 
+	/* RSSI reporting disabled? */
+	if (!cqm_config)
+		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
+
 	/*
 	 * Obtain current RSSI value if possible, if not and no RSSI threshold
 	 * event has been received yet, we should receive an event after a
@@ -12648,6 +12652,18 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
+	if (n_thresholds <= 1 && rdev->ops->set_cqm_rssi_config) {
+		if (n_thresholds == 0 || thresholds[0] == 0) /* Disabling */
+			return rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
+
+		return rdev_set_cqm_rssi_config(rdev, dev,
+						thresholds[0], hysteresis);
+	}
+
+	if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_CQM_RSSI_LIST))
+		return -EOPNOTSUPP;
+
 	if (n_thresholds == 1 && thresholds[0] == 0) /* Disabling */
 		n_thresholds = 0;
 
@@ -12655,20 +12671,6 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	old = rcu_dereference_protected(wdev->cqm_config,
 					lockdep_is_held(&wdev->mtx));
 
-	/* if already disabled just succeed */
-	if (!n_thresholds && !old)
-		return 0;
-
-	if (n_thresholds > 1) {
-		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_CQM_RSSI_LIST) ||
-		    !rdev->ops->set_cqm_rssi_range_config)
-			return -EOPNOTSUPP;
-	} else {
-		if (!rdev->ops->set_cqm_rssi_config)
-			return -EOPNOTSUPP;
-	}
-
 	if (n_thresholds) {
 		cqm_config = kzalloc(struct_size(cqm_config, rssi_thresholds,
 						 n_thresholds),
@@ -12683,26 +12685,13 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		memcpy(cqm_config->rssi_thresholds, thresholds,
 		       flex_array_size(cqm_config, rssi_thresholds,
 				       n_thresholds));
-		cqm_config->use_range_api = n_thresholds > 1 ||
-					    !rdev->ops->set_cqm_rssi_config;
 
 		rcu_assign_pointer(wdev->cqm_config, cqm_config);
-
-		if (cqm_config->use_range_api)
-			err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
-		else
-			err = rdev_set_cqm_rssi_config(rdev, dev,
-						       thresholds[0],
-						       hysteresis);
 	} else {
 		RCU_INIT_POINTER(wdev->cqm_config, NULL);
-		/* if enabled as range also disable via range */
-		if (old->use_range_api)
-			err = rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
-		else
-			err = rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
 	}
 
+	err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
 	if (err) {
 		rcu_assign_pointer(wdev->cqm_config, old);
 		kfree_rcu(cqm_config, rcu_head);
@@ -18769,11 +18758,10 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy, struct wiphy_work *work)
 	wdev_lock(wdev);
 	cqm_config = rcu_dereference_protected(wdev->cqm_config,
 					       lockdep_is_held(&wdev->mtx));
-	if (!cqm_config)
+	if (!wdev->cqm_config)
 		goto unlock;
 
-	if (cqm_config->use_range_api)
-		cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
+	cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
 
 	rssi_level = cqm_config->last_rssi_event_value;
 	rssi_event = cqm_config->last_rssi_event_type;
