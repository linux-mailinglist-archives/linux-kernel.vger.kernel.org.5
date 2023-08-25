Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA00B788AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbjHYOIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbjHYOHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D04D213C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a1af910e0so783103b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972392; x=1693577192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8uZGn2rcr8NpmsddpOyVm5Sphf/55sH0+4L2Cu0FSA=;
        b=AKdRlJEYU6psAoEVGBsYYok8ix5lDY0otfHYW812fh6kToF4lXC4NDFUDMowtOKUVt
         e9O1qn3LeA8iRzyrVLUjGCI3jqrMD/UOQCrxw7A7m0mTHVFblAYwfbBKOdiwGItquHD7
         j+nSEOf8Ol+cmv17brgTKvB6fKeytR81LPXmU5u4CzHrhx//STuP6YHKLzd05EoWV/cf
         3MKzQrD2yg+t1V9fM1kdmH/SyQZlD63sPyUrT+E7TyEEWsvYtb/i9bh8H/kMcmxbDDwS
         +37jUkqwtW7lzmLUsNLSOJx0tGCgVibiOPnueP6qnJAp3nMfrZIMpmxFrgDCH0YFrAjx
         /Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972392; x=1693577192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8uZGn2rcr8NpmsddpOyVm5Sphf/55sH0+4L2Cu0FSA=;
        b=IWDzjpMWR5TXEJtc9DKXRKNjcx8CTTVpoecLnu2nEv/gCmCvdtdvrEOkBeEAXgBC0L
         naoWUT1zEqkOh4c5EU9+uaym4lWB6AqpEi/lSZmPQ5N6sDdVnyG5Bt4PuHo9RtVEojQM
         DxPAahm4kbKFcUYqhyZyQK0+Wjoo9yNgVTrQug++PCa+UIi1JXT0DBGGAMB7msAXAbvb
         slPs2dTkjMxuudcSRqG+YhMMh8ig7rhw1NFkECGhLSojtVMj+V3KAJuPEk+otMbYf+de
         73+Y17fScKMkJ6JnnJRSWH0Ht+RwCavLmEO9l78RfAOrrwhnMOPxJqBJfEIr9GMcjxAf
         fYEw==
X-Gm-Message-State: AOJu0YyEaDGaDKopkI18rSMqBxSi3xRHbHw3asxCQiwK75wwAqRvz4Zs
        1ttlyOA0j8psFHmMH/7CAlpJjw==
X-Google-Smtp-Source: AGHT+IEo7LTkz1ucBHQ9GfN2n8Hk4OLNSZrioh3z59fcp535MkMdKBvKRvasUZb9/5nRsDRNLBSirw==
X-Received: by 2002:a05:6a00:22c1:b0:686:f84d:a4ec with SMTP id f1-20020a056a0022c100b00686f84da4ecmr18251315pfj.27.1692972392134;
        Fri, 25 Aug 2023 07:06:32 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:31 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 16/16] Staging: rtl8192e: Rename variable pTS in function rtllib_rx_InfraAdhoc()
Date:   Fri, 25 Aug 2023 07:08:47 -0700
Message-ID: <20230825140847.501113-17-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825140847.501113-1-tdavies@darkphysics.net>
References: <20230825140847.501113-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTS in function rtllib_rx_InfraAdhoc() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No Changes
v2:No Changes
 drivers/staging/rtl8192e/rtllib_rx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 491789ebcc08..53ec4f077bd8 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1280,7 +1280,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
 	struct lib80211_crypt_data *crypt = NULL;
 	struct rtllib_rxb *rxb = NULL;
-	struct rx_ts_record *pTS = NULL;
+	struct rx_ts_record *ts = NULL;
 	u16 fc, sc, SeqNum = 0;
 	u8 type, stype, multicast = 0, unicast = 0, nr_subframes = 0, TID = 0;
 	u8 dst[ETH_ALEN];
@@ -1386,7 +1386,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 		&& (!bToOtherSTA)) {
 		TID = Frame_QoSTID(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
-		GetTs(ieee, (struct ts_common_info **)&pTS, hdr->addr2, TID,
+		GetTs(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
 		      RX_DIR, true);
 		if (TID != 0 && TID != 3)
 			ieee->bis_any_nonbepkts = true;
@@ -1425,10 +1425,10 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	}
 
 	/* Indicate packets to upper layer or Rx Reorder */
-	if (!ieee->ht_info->cur_rx_reorder_enable || pTS == NULL || bToOtherSTA)
+	if (!ieee->ht_info->cur_rx_reorder_enable || ts == NULL || bToOtherSTA)
 		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
 	else
-		RxReorderIndicatePacket(ieee, rxb, pTS, SeqNum);
+		RxReorderIndicatePacket(ieee, rxb, ts, SeqNum);
 
 	dev_kfree_skb(skb);
 
-- 
2.41.0

