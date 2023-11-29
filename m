Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102557FD4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjK2LEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjK2LEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:04:23 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9686510F4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:04:29 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28583d0fd4eso7774909a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701255869; x=1701860669;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHKVfUcrvedQuYjVIJG0JaQ1Y+WO8duVjqK6pcr1+kE=;
        b=lmOEgwCFRq8gXar42PkvRYyVYnbZJ4v/4EdUL/JypLbUhx5Sq/SKLT6fw2Aq2/7Lxq
         /jq3xpRxThzuoVj8dgTklSpa0A3VFY36FdQHA5ld3ZyOVpbHL4sPf7R1fIMiPitNqfO2
         nRw9oprW5CaH9Q++2FNxVJox0fFBstWe2YwgKh8xhcZUsltmCKETwYji0IhT7jIJU1y0
         pntdQFDw32MUJN+kTZuG7+Ige4ydey3L6qID2ZMARuy7WWBHruvyNuYc34Izy7EuArUJ
         EUzRCH4cRVwar/VTmCkBTfqqkmy77Dh74UkYBvjrShD+7K8jUMT6r3NEU1O3iGnbfk1L
         LTqQ==
X-Gm-Message-State: AOJu0YzucbnayvGxQ4tOzyfWNDe1g1bdOuXkPYQVGdqOUuYSEEjEWM19
        B9z7Teykc2PhH/2h19u0a5YgpjHIzUZQHqPs6c0bhn58YiBZkzk=
X-Google-Smtp-Source: AGHT+IEJeYU3aCo+Dpk94wESYcLE+IzMeWvBKF3UBeJs01fmhoc678eI0raM8HvQjWyHZ51V18rBlHKBD0gcExVvaOBsWI9LKqAp
MIME-Version: 1.0
X-Received: by 2002:a17:90b:2409:b0:280:c8f2:8ae1 with SMTP id
 nr9-20020a17090b240900b00280c8f28ae1mr3681467pjb.9.1701255869108; Wed, 29 Nov
 2023 03:04:29 -0800 (PST)
Date:   Wed, 29 Nov 2023 03:04:28 -0800
In-Reply-To: <000000000000efc64705ff8286a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c01a51060b487f55@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init
From:   syzbot <syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
index 606b1b2e4123..d0b5a5dd7410 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1788,10 +1788,10 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					  lockdep_is_held(&local->hw.wiphy->mtx));
 
 	/*
-	 * If there are no changes, then accept a link that doesn't exist,
+	 * If there are no changes, then accept a link that exist,
 	 * unless it's a new link.
 	 */
-	if (params->link_id < 0 && !new_link &&
+	if ((sta->sta.valid_links & BIT(params->link_id)) && !new_link &&
 	    !params->link_mac && !params->txpwr_set &&
 	    !params->supported_rates_len &&
 	    !params->ht_capa && !params->vht_capa &&
-- 
2.43.0

