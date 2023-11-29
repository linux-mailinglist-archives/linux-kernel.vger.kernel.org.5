Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD4E7FCD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376860AbjK2C71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376821AbjK2C70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:59:26 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9346A1AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:59:32 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c27822f1b6so6385419a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701226772; x=1701831572;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+nqvps7RQa/bT52x24V0OlfulXRXPxkZVat7dV0IRs=;
        b=HN0ZSRVktqmJJv7sQOb3rkEBAnFuiCCeO2xHr2DeaipA8jta++kp8NUMGdBcdUQFGC
         NY7w9yLk+vTKQN4NWoqt0bmbN2CpaxpSrqowt6AH9oZ2bqKoiY+Nh37N0/LoE/Nmh3aP
         9/J3lw26K9vl8fDNPYLflUT6xxme5fAZYqv6sA8NfeZYQrt5HjTiHnwrXSSx/gvr/uJM
         Jfr6faBUhLY0tMHjx2W/d+Y+/clQJwerLzvQ5Spu1eRpTuSVOig1IxON6ffyRABhSsnh
         KNdho96aFq7V56cH1+Q+Iwd/Qk4Vi1E/lbGwq0mhdIMcemWSL0ze9JW3RaD5fkj5vpOs
         OT1Q==
X-Gm-Message-State: AOJu0YyK3X708SKMdzMaKsUMkKgNKQFoOg+ugRL2PNyM7j/3wELotChm
        TqTr+mRdKbYbMqRPI9xY9FqSdX2Ox9MniQpFA2ylThOQoAcGE+k=
X-Google-Smtp-Source: AGHT+IEiPtCBad/xipE1rh2FRwoRJGIEK0i6nm/Kga7P5myI2uNw6MKmR5L9/dCwLnv6jMEmnfYtOx9lO+IZAr940o5ipf2laML4
MIME-Version: 1.0
X-Received: by 2002:a63:f454:0:b0:5c5:ffa7:ed6d with SMTP id
 p20-20020a63f454000000b005c5ffa7ed6dmr306262pgk.4.1701226772135; Tue, 28 Nov
 2023 18:59:32 -0800 (PST)
Date:   Tue, 28 Nov 2023 18:59:32 -0800
In-Reply-To: <0000000000003d77e6060af9f233@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f8636060b41b90f@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
index 606b1b2e4123..13d52452a124 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1796,7 +1796,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	    !params->supported_rates_len &&
 	    !params->ht_capa && !params->vht_capa &&
 	    !params->he_capa && !params->eht_capa &&
-	    !params->opmode_notif_used)
+	    !params->opmode_notif_used && 0)
 		return 0;
 
 	if (!link || !link_sta)
@@ -1817,6 +1817,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	} else if (new_link) {
 		return -EINVAL;
 	}
+	printk("b, %p \n", rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf));
 
 	if (params->txpwr_set) {
 		link_sta->pub->txpwr.type = params->txpwr.type;
@@ -1868,6 +1869,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      params->opmode_notif,
 					      sband->band);
 	}
+	printk("e, %p \n", rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf));
 
 	return ret;
 }
@@ -1982,6 +1984,10 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->listen_interval >= 0)
 		sta->listen_interval = params->listen_interval;
 
+	printk("b, stp: %d, sa: %d, src: %d\n", 
+			test_sta_flag(sta, WLAN_STA_TDLS_PEER), 
+			test_sta_flag(sta, WLAN_STA_ASSOC), 
+			test_sta_flag(sta, WLAN_STA_RATE_CONTROL));
 	ret = sta_link_apply_parameters(local, sta, false,
 					&params->link_sta_params);
 	if (ret)
@@ -1996,6 +2002,10 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->airtime_weight)
 		sta->airtime_weight = params->airtime_weight;
 
+	printk("a, stp: %d, sa: %d, src: %d\n", 
+			test_sta_flag(sta, WLAN_STA_TDLS_PEER), 
+			test_sta_flag(sta, WLAN_STA_ASSOC), 
+			test_sta_flag(sta, WLAN_STA_RATE_CONTROL));
 	/* set the STA state after all sta info from usermode has been set */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) ||
 	    set & BIT(NL80211_STA_FLAG_ASSOCIATED)) {

