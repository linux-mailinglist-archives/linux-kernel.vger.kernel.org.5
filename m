Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880E37AB2AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjIVN3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjIVN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:29:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFBC198
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so2047965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389371; x=1695994171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvA1NhHU9wJadRFvynpx4VWVmQWw3BozI/MwraHbSoM=;
        b=EJX4TusEf5RigbrqseBFyHa1D3bfTmHVz8YXXHtccuFJq1iQbgt/E2mOQ5NYCWdSMa
         7Enj9UHtW0asdsb7E22d5ccwWelhZTJH3JaE1PJaJolNzYZASwX2htwAZG2+6AIJiAHc
         H4T5DB/sHIzWz6qT9zvir2KPbeH3QQ1J48n2W5Qzz+zdAUZ6GKRq3E8cuWpEfdeg6Hrm
         rfQU9EBZVTSFPFDogPe9T23IqoPsX8S+KrR6GzIaPcxiT84OyGs7VCaitTaHfmU3qOFz
         Cn9dkuyOU8npPKTFe4mmxRKGsHzPvGU7Xkavu+YWD46MsMDXWG63Fmfd9jP6X9KqzULG
         xhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389371; x=1695994171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvA1NhHU9wJadRFvynpx4VWVmQWw3BozI/MwraHbSoM=;
        b=o8EuKWImVjmwM9xkUaPEwjYVefEjUgmRgZc0s3R1KXQ4l8C5FwHWJXLBP5PY0PJQup
         UJZ/vrT0fcx+qEDrSUeUOzDA/mVH/aJ5uPOoa0+5MsdP97AWL8yfuLcC0p9nTTaFCGRU
         4WHl4GOASgIRxUXY06vkmnzNPLO6LZkcMgvqqBdTEpPR1tjpeq5YL6i1btiyUbcWUAlr
         SqWZPocCcLuROLbgMoYlvLT7IsrW5DLRmYY48vCPX60VWNJJrLyAo9q3I4y2lv3pjweY
         Se6EHK4Z0PGf/y0KDUKKVNAmEOdDuCfJ7q4ORXBRoGeONi5ZAK4uvy7zScjQnhtcwp9u
         6uEg==
X-Gm-Message-State: AOJu0Yw6WMkKmXNfW+akAsTq4AT1wpUykvdJDrvjn+iXmIFSG7q8oqBR
        dLf5c8jfVswojXKgO+ZS7jw=
X-Google-Smtp-Source: AGHT+IEniLWtAPga448LSVQoAKXwyP5aeYgyiMzuiODW6HLhdZzfHgDiUZm2Btw7IYjhooFgjvjpRw==
X-Received: by 2002:a05:600c:cc8:b0:401:c07f:72bd with SMTP id fk8-20020a05600c0cc800b00401c07f72bdmr7905417wmb.4.1695389370547;
        Fri, 22 Sep 2023 06:29:30 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b003feea62440bsm1161020wmb.43.2023.09.22.06.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:29:30 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:29:28 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging: rtl8192e: Remove mode IW_MODE_ADHOC from
 rtllib_rx.c
Message-ID: <5400c68e17b86b1170ac997fae3fe1fb09220af8.1695387832.git.philipp.g.hortmann@gmail.com>
References: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unsupported mode IW_MODE_ADHOC from rtllib_rx.c and all related
functions and structs.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h         |  9 ----
 drivers/staging/rtl8192e/rtllib_rx.c      | 38 -------------
 drivers/staging/rtl8192e/rtllib_softmac.c | 65 -----------------------
 3 files changed, 112 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 2a2eec192198..7dde428313c9 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -466,13 +466,6 @@ enum _REG_PREAMBLE_MODE {
 
 /* this is stolen from ipw2200 driver */
 #define IEEE_IBSS_MAC_HASH_SIZE 31
-struct ieee_ibss_seq {
-	u8 mac[ETH_ALEN];
-	u16 seq_num[17];
-	u16 frag_num[17];
-	unsigned long packet_time[17];
-	struct list_head list;
-};
 
 /* NOTE: This data is for statistical purposes; not all hardware provides this
  *       information for frames received.  Not setting these will not cause
@@ -1676,8 +1669,6 @@ void rtllib_txb_free(struct rtllib_txb *txb);
 /* rtllib_rx.c */
 int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 	      struct rtllib_rx_stats *rx_stats);
-void rtllib_rx_probe_rq(struct rtllib_device *ieee,
-			struct sk_buff *skb);
 int rtllib_legal_channel(struct rtllib_device *rtllib, u8 channel);
 
 /* rtllib_wx.c */
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index cba460c46285..456dd05e291d 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -375,37 +375,6 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 	}
 
 	switch (ieee->iw_mode) {
-	case IW_MODE_ADHOC:
-	{
-		struct list_head *p;
-		struct ieee_ibss_seq *entry = NULL;
-		u8 *mac = header->addr2;
-		int index = mac[5] % IEEE_IBSS_MAC_HASH_SIZE;
-
-		list_for_each(p, &ieee->ibss_mac_hash[index]) {
-			entry = list_entry(p, struct ieee_ibss_seq, list);
-			if (!memcmp(entry->mac, mac, ETH_ALEN))
-				break;
-		}
-		if (p == &ieee->ibss_mac_hash[index]) {
-			entry = kmalloc(sizeof(struct ieee_ibss_seq),
-					GFP_ATOMIC);
-			if (!entry)
-				return 0;
-
-			ether_addr_copy(entry->mac, mac);
-			entry->seq_num[tid] = seq;
-			entry->frag_num[tid] = frag;
-			entry->packet_time[tid] = jiffies;
-			list_add(&entry->list, &ieee->ibss_mac_hash[index]);
-			return 0;
-		}
-		last_seq = &entry->seq_num[tid];
-		last_frag = &entry->frag_num[tid];
-		last_time = &entry->packet_time[tid];
-		break;
-	}
-
 	case IW_MODE_INFRA:
 		last_seq = &ieee->last_rxseq_num[tid];
 		last_frag = &ieee->last_rxfrag_num[tid];
@@ -1487,7 +1456,6 @@ int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 	}
 
 	switch (ieee->iw_mode) {
-	case IW_MODE_ADHOC:
 	case IW_MODE_INFRA:
 		ret = rtllib_rx_InfraAdhoc(ieee, skb, rx_stats);
 		break;
@@ -2654,11 +2622,5 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
 		rtllib_process_probe_response(ieee,
 			      (struct rtllib_probe_response *)header, stats);
-	} else if (ieee80211_is_probe_req(header->frame_control)) {
-		netdev_dbg(ieee->dev, "received PROBE REQUEST\n");
-		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
-		    (ieee->iw_mode == IW_MODE_ADHOC &&
-		    ieee->link_state == MAC80211_LINKED))
-			rtllib_rx_probe_rq(ieee, skb);
 	}
 }
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 61afce587812..d8d9d59664ed 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -956,14 +956,6 @@ static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 	return skb;
 }
 
-static void rtllib_resp_to_probe(struct rtllib_device *ieee, u8 *dest)
-{
-	struct sk_buff *buf = rtllib_probe_resp(ieee, dest);
-
-	if (buf)
-		softmac_mgmt_xmit(buf, ieee);
-}
-
 static inline int SecIsInPMKIDList(struct rtllib_device *ieee, u8 *bssid)
 {
 	int i = 0;
@@ -1613,52 +1605,6 @@ static inline int auth_parse(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
-static short probe_rq_parse(struct rtllib_device *ieee, struct sk_buff *skb,
-			    u8 *src)
-{
-	u8 *tag;
-	u8 *skbend;
-	u8 *ssid = NULL;
-	u8 ssidlen = 0;
-	struct ieee80211_hdr_3addr   *header =
-		(struct ieee80211_hdr_3addr   *)skb->data;
-	bool bssid_match;
-
-	if (skb->len < sizeof(struct ieee80211_hdr_3addr))
-		return -1; /* corrupted */
-
-	bssid_match =
-	  (!ether_addr_equal(header->addr3, ieee->current_network.bssid)) &&
-	  (!is_broadcast_ether_addr(header->addr3));
-	if (bssid_match)
-		return -1;
-
-	ether_addr_copy(src, header->addr2);
-
-	skbend = (u8 *)skb->data + skb->len;
-
-	tag = skb->data + sizeof(struct ieee80211_hdr_3addr);
-
-	while (tag + 1 < skbend) {
-		if (*tag == 0) {
-			ssid = tag + 2;
-			ssidlen = *(tag + 1);
-			break;
-		}
-		tag++; /* point to the len field */
-		tag = tag + *(tag); /* point to the last data byte of the tag */
-		tag++; /* point to the next tag */
-	}
-
-	if (ssidlen == 0)
-		return 1;
-
-	if (!ssid)
-		return 1; /* ssid not found in tagged param */
-
-	return !strncmp(ssid, ieee->current_network.ssid, ssidlen);
-}
-
 static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 			      int *aid)
 {
@@ -1688,17 +1634,6 @@ static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	return le16_to_cpu(response_head->status);
 }
 
-void rtllib_rx_probe_rq(struct rtllib_device *ieee, struct sk_buff *skb)
-{
-	u8 dest[ETH_ALEN];
-
-	ieee->softmac_stats.rx_probe_rq++;
-	if (probe_rq_parse(ieee, skb, dest) > 0) {
-		ieee->softmac_stats.tx_probe_rs++;
-		rtllib_resp_to_probe(ieee, dest);
-	}
-}
-
 void rtllib_sta_ps_send_null_frame(struct rtllib_device *ieee, short pwr)
 {
 	struct sk_buff *buf = rtllib_null_func(ieee, pwr);
-- 
2.42.0

