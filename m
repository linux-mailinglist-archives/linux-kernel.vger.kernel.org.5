Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890A87FCD2B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376877AbjK2DGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjK2DGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:06:47 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A1119A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:06:49 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6cdd1ac2b53so247442b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701227209; x=1701832009;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+nqvps7RQa/bT52x24V0OlfulXRXPxkZVat7dV0IRs=;
        b=SyLYC6kU6F3/ylFxHT2QpWjmTL+ORLqhCeJ7t7IsUDk0Be1YxbqYx1Ld8OFh+rxDku
         6+O/1AnpHAUrAUmw1OlMkqfcvuiwlxgUoViV4kR/m52WQpiSzI/+e6qAmipa0M+Fiwh8
         QWPXg2Qvan7tVDQUC+SsAv67IgXa6sXru8IuOXQ+6luWgRJBfi894INPavPPNT/Ve3lm
         Mgmh+Q9cG0ohW7NbJYJSlvicUEQKW/Xt1uFcAHGiG5iCRT800ZLW1IfMrspX4L3j6hcJ
         DHDAatJnFmh/6ZgYlxg692O5eBBTkOPW4W9KjIzE/CkEg1I3Xyypw5JhmiOJ8mczeNoc
         wkfA==
X-Gm-Message-State: AOJu0Yz89oB0Fja9GxIZN2NGn+x4pdvI3lOqrGPwftcYr7C9Qibtv2og
        nl5sshaVt6Vi3HqXTbyhoRUYBV4fAVbKc8BQEqa9CbE+h50vGww=
X-Google-Smtp-Source: AGHT+IHRQux5cAz4UECody9NaRYU8Bk23/JUP3NsgjMpB9/Pm+jDjq47YAUjGMMkY4AHhDcGopUpR4bdk/xZiBNv++P710E6r0Yo
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:9398:b0:6c2:bca7:640b with SMTP id
 ka24-20020a056a00939800b006c2bca7640bmr4600134pfb.3.1701227209056; Tue, 28
 Nov 2023 19:06:49 -0800 (PST)
Date:   Tue, 28 Nov 2023 19:06:48 -0800
In-Reply-To: <000000000000efc64705ff8286a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a6c1c060b41d3f6@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init
From:   syzbot <syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

