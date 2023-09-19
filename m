Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B980C7A5E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjISJwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjISJwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:52:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2278F1;
        Tue, 19 Sep 2023 02:52:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31fe3426a61so4484106f8f.1;
        Tue, 19 Sep 2023 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695117127; x=1695721927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9GTFmeV/EvnfETMNwPDcGK8R8Ka2xMUzQavnbL/9JU=;
        b=FuMsnxRRP/EEVypsxJxsP6lUWTSCp4NqTiQJ2nfj65eWMMh2i4rfQyVQAqYBWPNSIr
         rL0z5wxU2dBoGmVIN+bki+Sov0EengJVhOqnkpSXTzn5yc7cG/tteVzghIBlAtGdg8Vn
         qx2sUuseeait4HoEcqex5Wq96TjA0YVI8BVO9CNsQnt13MKjz6zwmoxjis3GWzx/Pnwq
         eyposhUbg3K8hjpExR/B1uO54qImTmpSxUGjJMHPuix0Utynbh0/QyTy+xS/Ih7NYO+E
         fkOe3xgtIRlQJQTIoDz24OWrVPIloD40ReOFoSTcUScAT7t9vrxLp/xwB5amadqq7emA
         f2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695117127; x=1695721927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9GTFmeV/EvnfETMNwPDcGK8R8Ka2xMUzQavnbL/9JU=;
        b=Th8FEnqjyLjFev+bCXwoC2gGHNdAuNsdgXj0PX7xAYUgVpoteD+vXhZVyJDPXRWLbg
         hGvkdF0CwRYrK6Nf8kPUizwOeRQsHDM5GoT8CgJidM+5pOI3XDA1JiLV8wQMkPufP153
         MIcKDm4Yk46gx2eG7rHpttNjrYUW7cXikFJTqGStPYW0gkB75mgdu31/lpU/nCDmvrX2
         N4C9RcFQWWm1vbdUppSs5ZASKaMvTDztxhh27ztttnZ/AvpERY/JA+iOsex71J4Az3PG
         hgfp+C/Gwhd7K6sRVXbDLBwED7JzCX7B4lmlGRZANvRy3Q8tLVlhxxGkDB6DOMryG/RK
         Ng8Q==
X-Gm-Message-State: AOJu0Yxug0uIRG+Cmdip7MBL4jQQAsgHreZUwmaicbEOAXVO9qwGhCdx
        OPq7r0js7oQXw05ic9a0VgidbVVc/XsMphjZ
X-Google-Smtp-Source: AGHT+IE1EeLCPjpp+AXIFpbF/nRxGjd1pR3+gE3AJcM2Glipz4CkCgE5tGRL+MdphG6QCcqPday1FQ==
X-Received: by 2002:a5d:678f:0:b0:31c:6697:6947 with SMTP id v15-20020a5d678f000000b0031c66976947mr10470011wru.69.1695117126737;
        Tue, 19 Sep 2023 02:52:06 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5052000000b0031ad5470f89sm10335659wrt.18.2023.09.19.02.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:52:06 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: cfg80211: make read-only array centers_80mhz static const
Date:   Tue, 19 Sep 2023 10:52:05 +0100
Message-Id: <20230919095205.24949-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array lanes on the stack, instead make
it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 net/mac80211/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index ba14f570cda7..f3fd66d30b84 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -309,7 +309,7 @@ ieee80211_tdls_chandef_vht_upgrade(struct ieee80211_sub_if_data *sdata,
 				   struct sta_info *sta)
 {
 	/* IEEE802.11ac-2013 Table E-4 */
-	u16 centers_80mhz[] = { 5210, 5290, 5530, 5610, 5690, 5775 };
+	static const u16 centers_80mhz[] = { 5210, 5290, 5530, 5610, 5690, 5775 };
 	struct cfg80211_chan_def uc = sta->tdls_chandef;
 	enum nl80211_chan_width max_width =
 		ieee80211_sta_cap_chan_bw(&sta->deflink);
-- 
2.39.2

