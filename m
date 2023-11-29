Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4407FCDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjK2EES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjK2EER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:04:17 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF5D1707
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:04:23 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cfc15e4af2so55659705ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701230663; x=1701835463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+xuGQuRt3RZE4sxNa8ytrFaFhczzuPrB/Uw+MWmp7I=;
        b=aZACyOYDQUPKj8ej8PNIaKir2pdpUI6FORvWqI6h0IP9d063POlZwroIaxM2wlPw2t
         WREKxTPL9KbMTP10aJ6DuZlR6GLN0i+hEQ0bBXT//7xU+Aw8DfEm8jCaviudqekkuX/k
         nY9v1R2FI7d49LB8F5uK3ggyJ+FEGOao66Rz3KcXtwlP564PSod31vfwQ2dGrtWf+hXl
         MmLt4Pi0u3rlY/i7rhwIUT2LxSV3YmYg4l09HxQZUjSyBWGiQgbwiJ9c3Ud7aaNqlROy
         +kaVl55pbplVnxgB7K+lnMTZ7IJVjZv1Sd1C9L5gJ9/chq1cWQ3ZN2f99vzHlgPGbBAk
         Vwxw==
X-Gm-Message-State: AOJu0YzqVR2ow2zFZmbFW5HhnSYEJczM+bYws/pJpOL6Lbdh2dBql3jc
        q1ClF/hOx0cUH9X/Q76Sl39+1niGaBq/8G1ShLSa+/IscAlrAJQ=
X-Google-Smtp-Source: AGHT+IFjwCmf38f6G5IH3dPDdKHFgfAbTskLJ6oH8lT5k3199iWjA1YYO3gufmVZ+hi5ju/7ymQvcibUkWte/cuU7jBmU+fbHtAF
MIME-Version: 1.0
X-Received: by 2002:a17:902:8646:b0:1cf:e030:4a8 with SMTP id
 y6-20020a170902864600b001cfe03004a8mr1203763plt.6.1701230663328; Tue, 28 Nov
 2023 20:04:23 -0800 (PST)
Date:   Tue, 28 Nov 2023 20:04:23 -0800
In-Reply-To: <000000000000efc64705ff8286a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e78c9060b42a17c@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init
From:   syzbot <syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [wireless?] WARNING in rate_control_rate_init
Author: eadavis@qq.com

please test WARNING in rate_control_rate_init

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6e2332e0ab53

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 606b1b2e4123..e97ed85b7723 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1787,22 +1787,12 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		rcu_dereference_protected(sta->link[link_id],
 					  lockdep_is_held(&local->hw.wiphy->mtx));
 
-	/*
-	 * If there are no changes, then accept a link that doesn't exist,
-	 * unless it's a new link.
-	 */
-	if (params->link_id < 0 && !new_link &&
-	    !params->link_mac && !params->txpwr_set &&
-	    !params->supported_rates_len &&
-	    !params->ht_capa && !params->vht_capa &&
-	    !params->he_capa && !params->eht_capa &&
-	    !params->opmode_notif_used)
-		return 0;
-
+	printk("%p, %p, %d\n", link, link_sta, new_link);
 	if (!link || !link_sta)
 		return -EINVAL;
 
 	sband = ieee80211_get_link_sband(link);
+	printk("%p\n", sband);
 	if (!sband)
 		return -EINVAL;
 
@@ -1812,11 +1802,23 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 			memcpy(link_sta->pub->addr, params->link_mac, ETH_ALEN);
 		} else if (!ether_addr_equal(link_sta->addr,
 					     params->link_mac)) {
+			printk("%s\n", __func__);
 			return -EINVAL;
 		}
 	} else if (new_link) {
 		return -EINVAL;
 	}
+	/*
+	 * If there are no changes, then accept a link that doesn't exist,
+	 * unless it's a new link.
+	 */
+	if (params->link_id < 0 && !new_link &&
+	    !params->link_mac && !params->txpwr_set &&
+	    !params->supported_rates_len &&
+	    !params->ht_capa && !params->vht_capa &&
+	    !params->he_capa && !params->eht_capa &&
+	    !params->opmode_notif_used)
+		return 0;
 
 	if (params->txpwr_set) {
 		link_sta->pub->txpwr.type = params->txpwr.type;
@@ -1982,6 +1985,10 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->listen_interval >= 0)
 		sta->listen_interval = params->listen_interval;
 
+	printk("b, stp: %d, sa: %d, src: %d\n", 
+			test_sta_flag(sta, WLAN_STA_TDLS_PEER), 
+			test_sta_flag(sta, WLAN_STA_ASSOC), 
+			test_sta_flag(sta, WLAN_STA_RATE_CONTROL));
 	ret = sta_link_apply_parameters(local, sta, false,
 					&params->link_sta_params);
 	if (ret)
@@ -1996,6 +2003,10 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->airtime_weight)
 		sta->airtime_weight = params->airtime_weight;
 
+	printk("a, stp: %d, sa: %d, src: %d\n", 
+			test_sta_flag(sta, WLAN_STA_TDLS_PEER), 
+			test_sta_flag(sta, WLAN_STA_ASSOC), 
+			test_sta_flag(sta, WLAN_STA_RATE_CONTROL));
 	/* set the STA state after all sta info from usermode has been set */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) ||
 	    set & BIT(NL80211_STA_FLAG_ASSOCIATED)) {

