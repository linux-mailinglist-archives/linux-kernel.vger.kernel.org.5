Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0778798D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbjIHSWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbjIHSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:21:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7FC2127;
        Fri,  8 Sep 2023 11:19:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BDEC4339A;
        Fri,  8 Sep 2023 18:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197149;
        bh=KbOkRZBJWdPdvM1++c8dlbDo15VKmvAQvE2M+aTA8Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=csA/El9QbffXUTIFnAhPcJAQTBo8IF7vgHCFf9+ENSze2GzFaG4eoOVa2QRKaK7wg
         zf0XaIvr6BDQTc7xLgINW6ZDcmvcl+KnZAygJ2tDbCqdJwr2esN8DHy57U4ADBZIB5
         GdDeNKq+HQt/yrcHBbBMqOnimV9kJwcP1oNbSZRlMf2WJLlMk2VPvzvFgydO6O3itK
         WyS9R8XDUIZcXsbndNPhRXLt/C3ecxXBpjIULURn92z70PuQRtwXm18tapkSfWZMsF
         LrxwR3q0yyIdznLMVCLTvfVJtxjysy/FeC1qI1lGmrEYUlTqT5Spcaxn4xiyW+GLc9
         lMdrSSfikSKGQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/26] wifi: cfg80211: reject auth/assoc to AP with our address
Date:   Fri,  8 Sep 2023 14:17:59 -0400
Message-Id: <20230908181806.3460164-21-sashal@kernel.org>
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

[ Upstream commit 5d4e04bf3a0f098bd9033de3a5291810fa14c7a6 ]

If the AP uses our own address as its MLD address or BSSID, then
clearly something's wrong. Reject such connections so we don't
try and fail later.

Reported-by: syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/mlme.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 581df7f4c5240..e7fa0608341d8 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -277,6 +277,11 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 	    ether_addr_equal(req->bss->bssid, wdev->u.client.connected_addr))
 		return -EALREADY;
 
+	if (ether_addr_equal(req->bss->bssid, dev->dev_addr) ||
+	    (req->link_id >= 0 &&
+	     ether_addr_equal(req->ap_mld_addr, dev->dev_addr)))
+		return -EINVAL;
+
 	return rdev_auth(rdev, dev, req);
 }
 
@@ -331,6 +336,9 @@ int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 			if (req->links[i].bss == req->links[j].bss)
 				return -EINVAL;
 		}
+
+		if (ether_addr_equal(req->links[i].bss->bssid, dev->dev_addr))
+			return -EINVAL;
 	}
 
 	if (wdev->connected &&
@@ -338,6 +346,11 @@ int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 	     !ether_addr_equal(wdev->u.client.connected_addr, req->prev_bssid)))
 		return -EALREADY;
 
+	if ((req->bss && ether_addr_equal(req->bss->bssid, dev->dev_addr)) ||
+	    (req->link_id >= 0 &&
+	     ether_addr_equal(req->ap_mld_addr, dev->dev_addr)))
+		return -EINVAL;
+
 	cfg80211_oper_and_ht_capa(&req->ht_capa_mask,
 				  rdev->wiphy.ht_capa_mod_mask);
 	cfg80211_oper_and_vht_capa(&req->vht_capa_mask,
-- 
2.40.1

