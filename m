Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEAD7B71CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjJCTeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjJCTeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:34:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF89B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:33:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b27f99a356so44431566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361637; x=1696966437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65qY9p1JHLXsscBYDiGb2B/qb5l0KlsXBI1MwO5lht4=;
        b=JV9lLg0oEE2f6wPIcl2o+uLSphbiiWkl9Q4y2NvcZhN1iky1tL1tjKS7McOwP2z7vL
         Ra6OAIAoxkTW4dlzYOtbUCgsKIU9EZeO98Ct/yRDSde7Ugb7BWvm4WgZcKuSnJvyoZ4b
         s+76ljhkVE8ulTrKF4f6Rs+nxreH4kazNcNm2D5zncnMliCDIlsJUfJ4gLmCnW6bo1Ka
         3BHhQ2vSSAeUJl3i0CFzKtw5nLiTChC/5zxZr+PA7AKKWStyikjCQxytUPNgo2WBYRBR
         IPZunHxzueCYKY/8HB7zeTUrcPSNAIN9jY9Ci5SCFfAnimUB4TCLHrljxnVNqWt6EKsv
         64MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361637; x=1696966437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65qY9p1JHLXsscBYDiGb2B/qb5l0KlsXBI1MwO5lht4=;
        b=N34Q+dLASrSmrjCqifTv0Qlri6ZG+pPW5U62ScdRUHV2xpOWS7QEeC8ipzCawf/Fz7
         r7uVH0iCddIVCCZYMvDZmuqiWvbtuSn3qiJHnS03ODDmnDXnbsSzspCiGcZzZGPxNqus
         ApSX77M4oEXRqULVdfAXMoJyCCbeWZ056mTG3cj4atyNSX5bn00Zj5V/RWjeGcmvlX9B
         amY40I2Zcx0JQbyuf3Qx9Dj/kFboRSARkKBqQ6EpXhJXisZhefbtI112YCI71a47srDJ
         5+3ANV8XvG/Kr19+XCGdBb6BUDVgL+zDkQkJVbnBG1Yg7hmWWkcbpYIa/Pj008RIFozb
         Ps4A==
X-Gm-Message-State: AOJu0YzlZ4G1LSVmyl9iCR1NW2Aw2ncbEVBT6MovypU0rf9hI0lLXPQ+
        LUN9XjI24xnI7n6JKiGP4SrR4961FA8=
X-Google-Smtp-Source: AGHT+IFm0kslgEQE8tTlmftu25T7l4uOUCBmcDzctq6F4trkmT85/5QpkQC8MDJIQln4FY8tpQR5jQ==
X-Received: by 2002:a17:906:2c9:b0:9a6:5340:c331 with SMTP id 9-20020a17090602c900b009a65340c331mr136764ejk.2.1696361637066;
        Tue, 03 Oct 2023 12:33:57 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id mb15-20020a170906eb0f00b00993470682e5sm1526372ejb.32.2023.10.03.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:33:56 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:33:55 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: rtl8192e: Remove constant variable
 fltr_src_sta_frame
Message-ID: <1a37a8be464bb25531657aa7c868201676d7abb6.1696360404.git.philipp.g.hortmann@gmail.com>
References: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable fltr_src_sta_frame as it is set to 0 and unchanged. The
equation results accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 --
 drivers/staging/rtl8192e/rtllib.h            |  1 -
 drivers/staging/rtl8192e/rtllib_rx.c         | 10 ----------
 3 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 9c872819969a..f15f73be41a2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -741,8 +741,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
 	priv->rtllib->net_promiscuous_md = false;
 	priv->rtllib->intel_promiscuous_md_info.promiscuous_on = false;
-	priv->rtllib->intel_promiscuous_md_info.fltr_src_sta_frame =
-								 false;
 	priv->rtllib->ieee_up = 0;
 	priv->retry_rts = DEFAULT_RETRY_RTS;
 	priv->retry_data = DEFAULT_RETRY_DATA;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index a02e8c976ca0..748ae8d35c1a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1177,7 +1177,6 @@ struct rt_pmkid_list {
 
 struct rt_intel_promisc_mode {
 	bool promiscuous_on;
-	bool fltr_src_sta_frame;
 };
 
 /*************** DRIVER STATUS   *****/
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index a7b6f837024d..1086dd0809be 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -956,16 +956,6 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hd
 		return -1;
 	}
 
-	/* Filter packets sent by an STA that will be forwarded by AP */
-	if (ieee->intel_promiscuous_md_info.promiscuous_on  &&
-		ieee->intel_promiscuous_md_info.fltr_src_sta_frame) {
-		if ((fc & IEEE80211_FCTL_TODS) && !(fc & IEEE80211_FCTL_FROMDS) &&
-		    !ether_addr_equal(dst, ieee->current_network.bssid) &&
-		    ether_addr_equal(bssid, ieee->current_network.bssid)) {
-			return -1;
-		}
-	}
-
 	/* Nullfunc frames may have PS-bit set, so they must be passed to
 	 * hostap_handle_sta_rx() before being dropped here.
 	 */
-- 
2.42.0

