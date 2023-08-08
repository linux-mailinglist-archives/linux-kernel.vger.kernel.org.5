Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95E7756F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjHIKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHIKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:20:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7B41FDF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:20:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe5eb84d8bso22888225e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691576439; x=1692181239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsYLfemCDR3/R1OmOhG/J3IN0SL/2dsEeDv4LiZM2ak=;
        b=QeyVH5qvWhQI6SNu04rR8TU75B5jlX7waD+AxXoTZUGBLl02NVKTSfDztBgpLL9fFW
         xD4wuWN2AhAvmxKQd8KAiIZHrNDwhcbmJpQ1dg4gN442dbw08a6BhnRQit7hbnJ7zI0R
         WScQcU6R6WVcj1sN19cV+3mEo7lNbfYsX31zdwbl/UwpzoQzeKi4TpabUOlLRa67PN1h
         /N/dycbaf8GT7hFiLYrHWsXmnny2wLkSaQPDIDuBasR2SLCrN9AroskYqzRcC5vmkmr3
         JkQAXyZ8aBNLQ5kpVU99rS8oi21Zy1gRuzweDmzD4EnmwQPiQQeSTEBVQdeaE1eR77RU
         OiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576439; x=1692181239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsYLfemCDR3/R1OmOhG/J3IN0SL/2dsEeDv4LiZM2ak=;
        b=GK42PHWgPzVX3kZkw7jqXf9lxHk1PhUSxo9D0XyBYdmqckG9gMQXFUN6zFlatVOIzy
         uqsugpDVVnHH6NXfl60wldQhDRV8+H5ZTvYqA0/961Y39xquXXFNuHMnT39U4F/LjdHl
         vp5D7tZF23lcMHCRPhPFd1R82FNMl1y3kyavzyT4LsAhabg1iHcZF8SU2JptviwBIzGI
         GG0OcQF5K4gfJ4stBTM3YPesa0lPhhSyFpiyMPIGzXNdTChBcfFjmCC31sRAaE/mUO4c
         eiOBA+StXzLjLpsiGGHNKsZNzk3rt6g6nHUY2tQJ+JQxmyvwsuH7pAMpnK6maV+SKONh
         GFAg==
X-Gm-Message-State: AOJu0YzBHywyeP0wl/lDr83TrS7UQj7RD+D3Qgt9kCEkaG/6v4eLZ+X9
        0cl3eALhNTM9UD5aoDVtfJM=
X-Google-Smtp-Source: AGHT+IE5wchFXx9HMqNH7ff60Rs2b0MNZRBtR1xt/ZEPu2aDA2yeCx4egWKx+Vp7x8pZRMcKghEwEQ==
X-Received: by 2002:a7b:c3d1:0:b0:3fb:b34f:6cd6 with SMTP id t17-20020a7bc3d1000000b003fbb34f6cd6mr1761740wmj.41.1691576438805;
        Wed, 09 Aug 2023 03:20:38 -0700 (PDT)
Received: from archdev (pa5-84-91-151-142.netvisao.pt. [84.91.151.142])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c210a00b003fc02e8ea68sm1555616wml.13.2023.08.09.03.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:20:38 -0700 (PDT)
Received: by archdev (Postfix, from userid 0)
        id E7B0E1A3960; Wed,  9 Aug 2023 00:14:25 +0100 (WEST)
From:   Diogo Silva <diogompaissilva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Diogo Silva <diogompaissilva@gmail.com>
Subject: [PATCH] staging: wlan-ng: cfg80211.c: removed unnecessary parenthesis to match coding style
Date:   Wed,  9 Aug 2023 00:13:20 +0100
Message-ID: <20230808231424.3270-1-diogompaissilva@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023080951-escalate-unnamed-e6d4@gregkh>
References: <2023080951-escalate-unnamed-e6d4@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parenthesis around some conditions to comply with
the checkpatch coding style.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 471bb310176f..57c16afe8773 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -247,7 +247,7 @@ static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
 
 	memset(sinfo, 0, sizeof(*sinfo));
 
-	if (!wlandev || (wlandev->msdstate != WLAN_MSD_RUNNING))
+	if (!wlandev || wlandev->msdstate != WLAN_MSD_RUNNING)
 		return -EOPNOTSUPP;
 
 	/* build request message */
@@ -351,8 +351,8 @@ static int prism2_scan(struct wiphy *wiphy,
 		msg2->bssindex.data = i;
 
 		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
-		if ((result != 0) ||
-		    (msg2->resultcode.data != P80211ENUM_resultcode_success)) {
+		if (result != 0 ||
+		    msg2->resultcode.data != P80211ENUM_resultcode_success) {
 			break;
 		}
 
@@ -459,11 +459,11 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	/* Set the authorization */
-	if ((sme->auth_type == NL80211_AUTHTYPE_OPEN_SYSTEM) ||
-	    ((sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC) && !is_wep))
+	if (sme->auth_type == NL80211_AUTHTYPE_OPEN_SYSTEM ||
+	    (sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC && !is_wep))
 		msg_join.authtype.data = P80211ENUM_authalg_opensystem;
-	else if ((sme->auth_type == NL80211_AUTHTYPE_SHARED_KEY) ||
-		 ((sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC) && is_wep))
+	else if (sme->auth_type == NL80211_AUTHTYPE_SHARED_KEY ||
+		 (sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC && is_wep))
 		msg_join.authtype.data = P80211ENUM_authalg_sharedkey;
 	else
 		netdev_warn(dev,
-- 
2.41.0

