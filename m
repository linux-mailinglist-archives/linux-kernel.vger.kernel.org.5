Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF9F7A234C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbjIOQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjIOQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:10:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A372701
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40472fef044so4424235e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794167; x=1695398967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYrZWmR9ibcpEx9K+dr8dK7clI/EvOdBCBQrgTnJvTM=;
        b=A2an78DD7NRhX70jEjuxU/SRTTz3ciqO2Svan9Aa8vsoQUhJ3ZUE9z9gmOTQcsvsHq
         +RIN65oSogkG73ODKCKP3CTMKQtGu+yub79Gs/fC4dVSCYbDFCnVr8Kl/K0X5zeLE++f
         Da6CmvmJ+cZirLl0qPFuzo8wQEQn4rtEiWIImBeU3PGPTU9tkYFsNgeb6oXDmja5mRnG
         +xED+QtJ+D3aHdyoIooBzUtv38gwnYwjwjgzzhlxrP4Aq5/cWg5/Umxol2Ypu9Mes2Bd
         V4/mPCqK6g+2uK7utUFF4yNvUTqv0b4vIrWcq4KtAhyHprt1KE1KWXUCWGui9qrZzA5K
         Nlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794167; x=1695398967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYrZWmR9ibcpEx9K+dr8dK7clI/EvOdBCBQrgTnJvTM=;
        b=iC6GaN7aaZvKL5qx2oyZ3IRT8IaGsXV7B4tHo0sCT7RzeNGSrbZk0PlRg8JnvZBqZn
         FrpfqEwkjhwF4SSlEKuCiUPDoxU8rcmQwNVzR95MrjDc10SpVGzapsv6JYq/5L1fetS9
         4ey3t9Z1uwQ883Z886ArhMWKlOjlPq0iGlwNyXzy0nOo4xuu2QjUBrmpqvjSW5v1WDEk
         69WCkegBXt0m2V0ABh7q6tKwgdCN/rH3cnJHWraRW/G7nC2h21uIw8Zv/jpNjTBgT4cM
         TWYQ/6N/dO4LAyetDqUnNUNjHDMbHFwr1UsvVcV6HAA0NfgYb204f+18Ir1aEv5LwcPJ
         h2BQ==
X-Gm-Message-State: AOJu0YyovV8Xl8q18lNeN6cfpcW+gQoXTO2A8cdM/ObSu6AbOn0zUcK/
        pqbrAkslV5SFpJvDtm7H3XUEatzA0PF6WA==
X-Google-Smtp-Source: AGHT+IERri93rYEDEreWdnSc19Cfvd4qaU1YamBg/Iz5qjCc1rmMNuQgLxbzfA7Bdzt0u3+bDqzLdw==
X-Received: by 2002:a05:600c:3ba3:b0:401:c392:d28d with SMTP id n35-20020a05600c3ba300b00401c392d28dmr1906777wms.2.1694794166885;
        Fri, 15 Sep 2023 09:09:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003fc16ee2864sm4994907wml.48.2023.09.15.09.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:09:26 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:09:25 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/16] staging: rtl8192e: Remove struct rtllib_hdr_4addrqos
Message-ID: <e146191ec1781a3989b318316fe9d8cdb330a52a.1694792595.git.philipp.g.hortmann@gmail.com>
References: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace struct rtllib_hdr_4addrqos with struct ieee80211_qos_hdr_4addr to
avoid proprietary code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h    | 12 ------------
 drivers/staging/rtl8192e/rtllib_rx.c | 18 +++++++++---------
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e73292201e3a..24060c9722e6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -679,18 +679,6 @@ struct rtllib_pspoll_hdr {
 	u8 ta[ETH_ALEN];
 } __packed;
 
-struct rtllib_hdr_4addrqos {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	__le16 seq_ctl;
-	u8 addr4[ETH_ALEN];
-	__le16 qos_ctl;
-	u8 payload[];
-} __packed;
-
 struct rtllib_info_element {
 	u8 id;
 	u8 len;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 265a718a20a4..cf98b020194b 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -94,13 +94,13 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 	unsigned int seq = WLAN_GET_SEQ_SEQ(sc);
 	struct rtllib_frag_entry *entry;
 	struct ieee80211_qos_hdr *hdr_3addrqos;
-	struct rtllib_hdr_4addrqos *hdr_4addrqos;
+	struct ieee80211_qos_hdr_4addr *hdr_4addrqos;
 	u8 tid;
 
 	if (((fc & RTLLIB_FCTL_DSTODS) == RTLLIB_FCTL_DSTODS) &&
 	    RTLLIB_QOS_HAS_SEQ(fc)) {
-		hdr_4addrqos = (struct rtllib_hdr_4addrqos *)hdr;
-		tid = le16_to_cpu(hdr_4addrqos->qos_ctl) & RTLLIB_QCTL_TID;
+		hdr_4addrqos = (struct ieee80211_qos_hdr_4addr *)hdr;
+		tid = le16_to_cpu(hdr_4addrqos->qos_ctrl) & RTLLIB_QCTL_TID;
 		tid = UP2AC(tid);
 		tid++;
 	} else if (RTLLIB_QOS_HAS_SEQ(fc)) {
@@ -163,13 +163,13 @@ static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
 	unsigned int seq = WLAN_GET_SEQ_SEQ(sc);
 	struct rtllib_frag_entry *entry;
 	struct ieee80211_qos_hdr *hdr_3addrqos;
-	struct rtllib_hdr_4addrqos *hdr_4addrqos;
+	struct ieee80211_qos_hdr_4addr *hdr_4addrqos;
 	u8 tid;
 
 	if (((fc & RTLLIB_FCTL_DSTODS) == RTLLIB_FCTL_DSTODS) &&
 	    RTLLIB_QOS_HAS_SEQ(fc)) {
-		hdr_4addrqos = (struct rtllib_hdr_4addrqos *)hdr;
-		tid = le16_to_cpu(hdr_4addrqos->qos_ctl) & RTLLIB_QCTL_TID;
+		hdr_4addrqos = (struct ieee80211_qos_hdr_4addr *)hdr;
+		tid = le16_to_cpu(hdr_4addrqos->qos_ctrl) & RTLLIB_QCTL_TID;
 		tid = UP2AC(tid);
 		tid++;
 	} else if (RTLLIB_QOS_HAS_SEQ(fc)) {
@@ -356,13 +356,13 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 	u16 *last_seq, *last_frag;
 	unsigned long *last_time;
 	struct ieee80211_qos_hdr *hdr_3addrqos;
-	struct rtllib_hdr_4addrqos *hdr_4addrqos;
+	struct ieee80211_qos_hdr_4addr *hdr_4addrqos;
 	u8 tid;
 
 	if (((fc & RTLLIB_FCTL_DSTODS) == RTLLIB_FCTL_DSTODS) &&
 	    RTLLIB_QOS_HAS_SEQ(fc)) {
-		hdr_4addrqos = (struct rtllib_hdr_4addrqos *)header;
-		tid = le16_to_cpu(hdr_4addrqos->qos_ctl) & RTLLIB_QCTL_TID;
+		hdr_4addrqos = (struct ieee80211_qos_hdr_4addr *)header;
+		tid = le16_to_cpu(hdr_4addrqos->qos_ctrl) & RTLLIB_QCTL_TID;
 		tid = UP2AC(tid);
 		tid++;
 	} else if (RTLLIB_QOS_HAS_SEQ(fc)) {
-- 
2.42.0

