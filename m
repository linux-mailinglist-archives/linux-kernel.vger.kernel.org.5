Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358E8798DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbjIHSYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbjIHSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:23:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF6146BF;
        Fri,  8 Sep 2023 11:21:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1308BC43215;
        Fri,  8 Sep 2023 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197198;
        bh=rePj2G1W6HD98eg3roMIAWwNsbsRxFEcBbIR5habVuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUPINFEdCtkZpM8OHsoluWxTKJUWB1c71B2Jtbb+ygxapKkmFem/qymOUhEhdR0iP
         HFYyHyM6Yj1QL4i428ha52uChwI5TlWk+IU9gsk8dt5VvaaStJI3ka7Q3FqWw05DTd
         FZbR/1VKJl1oThX5rDV8weUwJWgLbItvCL6gn5RlT3bjf6QE3e6A+SM0iFq4RK43ih
         WDV1xv0NHsdNVCp/Wy7RodY7gD93DY8J7REapxjD6P9PfnTjSBvHCNmFmqE8TnFSKg
         MOHQHm+F6yx9WkMZNrfJQt97F4qm4U1t0A0nDBLZYQTG96GQi3CQsN6XKjfVlBqE8K
         8QRyZUSoCCRuQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+b2645b5bf1512b81fa22@syzkaller.appspotmail.com,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/15] wifi: mac80211_hwsim: drop short frames
Date:   Fri,  8 Sep 2023 14:19:16 -0400
Message-Id: <20230908181920.3460520-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181920.3460520-1-sashal@kernel.org>
References: <20230908181920.3460520-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
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

[ Upstream commit fba360a047d5eeeb9d4b7c3a9b1c8308980ce9a6 ]

While technically some control frames like ACK are shorter and
end after Address 1, such frames shouldn't be forwarded through
wmediumd or similar userspace, so require the full 3-address
header to avoid accessing invalid memory if shorter frames are
passed in.

Reported-by: syzbot+b2645b5bf1512b81fa22@syzkaller.appspotmail.com
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index c3c3b5aa87b0d..6eb3c845640bd 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3693,14 +3693,15 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	frame_data_len = nla_len(info->attrs[HWSIM_ATTR_FRAME]);
 	frame_data = (void *)nla_data(info->attrs[HWSIM_ATTR_FRAME]);
 
+	if (frame_data_len < sizeof(struct ieee80211_hdr_3addr) ||
+	    frame_data_len > IEEE80211_MAX_DATA_LEN)
+		goto err;
+
 	/* Allocate new skb here */
 	skb = alloc_skb(frame_data_len, GFP_KERNEL);
 	if (skb == NULL)
 		goto err;
 
-	if (frame_data_len > IEEE80211_MAX_DATA_LEN)
-		goto err;
-
 	/* Copy the data */
 	skb_put_data(skb, frame_data, frame_data_len);
 
-- 
2.40.1

