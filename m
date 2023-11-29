Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B067FD596
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjK2L0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjK2L0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:26:18 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C628484
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:26:24 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5bddc607b45so8416908a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257184; x=1701861984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRCbDzkJjqw/peb5Cau6WPXEZMKv8NJWgSNl7p7vJB0=;
        b=o0vjimTehSjzUixlnPJiG0zJPfMGH85HgTisy9wmBeVpdCxc4WrjUn2iXPwDAc4ocN
         FGkbbk1HDgLeU3aRGDggpx7aJDq9poBHJE16R6okcbADs9ArPXCjYGnsk445wDsm3zFh
         V62kQL28RDg1YzNT/hH9TR32HCz8laf9zGF9/r4jz52Y/Ufsk0g606FLc/4vrq6LcZ96
         0GGKX8kA0M5CmyommZdGIuqt/HVebwNSJ3wqNPLpOQkZetcXVKL2WjCNNdFpQFVvQ/Qf
         7/OOT0VBeDwZEMkwgJlz4zZhZ06AtHED613D5St6s73FYovxagRhkpWOTbq5xNqqPj7Q
         1oaw==
X-Gm-Message-State: AOJu0Yxp+pkaogde6DTB7J3j3Xt2J7LBINRFda0QR4p3Qax1JVUI99Y3
        0XttWPDVBKrNsGU35XGYl7wNUcKY9zWLxLKveAZgZe3b6C71TCU=
X-Google-Smtp-Source: AGHT+IGsX7ES79jcEPAO0I4cEzOUE3QvyVyPn5c/503t2fxnq6heyP491cwTlVyyAdzSRB4I53NQJTmKCOk1ukKzCrnihnaVlJS8
MIME-Version: 1.0
X-Received: by 2002:a63:5a1b:0:b0:59c:fc70:1ca0 with SMTP id
 o27-20020a635a1b000000b0059cfc701ca0mr3094364pgb.10.1701257184222; Wed, 29
 Nov 2023 03:26:24 -0800 (PST)
Date:   Wed, 29 Nov 2023 03:26:24 -0800
In-Reply-To: <000000000000efc64705ff8286a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023cb42060b48ce99@google.com>
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
+	if (params->link_id >= 0  && !new_link &&
 	    !params->link_mac && !params->txpwr_set &&
 	    !params->supported_rates_len &&
 	    !params->ht_capa && !params->vht_capa &&
-- 
2.43.0

