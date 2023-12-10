Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB0380BBF5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjLJP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjLJP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:26:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E6C106
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c2d50c0adso6103485e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702222000; x=1702826800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x27vCUpD2eYMWgYKl63p6rruFTypQyGCnQHgn4PVIcE=;
        b=eO7wJzrPDX0s6bLCjO0+wCr0LEqwKFUoqohd6qD3mcaB3jinTLWbGPoiDVIc5X2TNw
         XUn7ugqqP75Yv4C2euChXFB///cr6SnPJWp12vd35z2joZ3y+U8wvFiLF+kDVgJfLDhk
         PlWZipQQyQn203ORovJ7hr1VPBonKIwbjj+tGNjshbldW45VQ0EzWd7jE/40Gow/SJDm
         qUpEOjyO0s8wj/vzc/Zpz6HcZ9GKHrvkyPeoopySW+0yppDtS/E1E2TwWeK0eaFMmhJ7
         lfLgosEnkMTDOSg09TObXNHtAvwC6+7tSSnaL57zS7+w4jD16P90zrqyuGPVTLbrBAfw
         WwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702222000; x=1702826800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x27vCUpD2eYMWgYKl63p6rruFTypQyGCnQHgn4PVIcE=;
        b=Rsk9PXtQHL9LkDTS6XT93ydWTcQbKsn3w61Fi7so/Wmzeq68mnusOKm6mmKQnFjqKv
         8P3YOaUouR2/cr3wtdRaj8jTwC0/spJUqvEOpBYAr3QrW2t5YwrT7hDgzFAo/Zl4uyUr
         dXVr+2Vh35Ly3+LU/xpU8J+OAqzCcFaTImam/6ED/LItIcPDONsq/aZ4xZUabXDE41QL
         Igv28cvQN//4+QPEPNhRVNmrVcHd4SfucifLePYBv6unxUceAn+TQidvd5Z3VEzRFj0z
         VvSeX+kupN1x/vfxBDUUNOH04KHzUwtV8Xw2aadiW8hjejXCztENIU7PE3U5kLDS76sd
         CbNQ==
X-Gm-Message-State: AOJu0Yz1r/y8lCEWjr4HB7SVD2XmktMBv7daDmCsPA8C/KY7Z6M+Ki7+
        e5nfzt3QfxS/sKzh0ILfiaig7bkMiDc=
X-Google-Smtp-Source: AGHT+IF31uLVQkwuqXW9FQ67nNYdTNzAXw9J7VWuE5x35tRZB11V4Tbb2i9IxCBKrUs7L/0zp2zzbA==
X-Received: by 2002:a05:6000:4026:b0:333:50f2:5757 with SMTP id cp38-20020a056000402600b0033350f25757mr3500662wrb.5.1702221999797;
        Sun, 10 Dec 2023 07:26:39 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b0033609584b9dsm6265939wrq.74.2023.12.10.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:26:39 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:26:38 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Remove variable ForcedAMPDUMode
Message-ID: <5bf740a2da78ec3b54249a30cbee70301b37e7eb.1702212003.git.philipp.g.hortmann@gmail.com>
References: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ForcedAMPDUMode is set to 0 and unchanged. Therefore all equations result
accordingly and ForcedAMPDUMode can be removed. As a result label
FORCED_AGG_SETTING is unused and can be removed as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h |  1 -
 drivers/staging/rtl8192e/rtllib_tx.c  | 21 ++-------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 0664eb86bada..d249062e7b66 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -113,7 +113,6 @@ struct rt_hi_throughput {
 	u8 CurrentAMPDUFactor;
 	u8 mpdu_density;
 	u8 current_mpdu_density;
-	enum ht_aggre_mode ForcedAMPDUMode;
 	u8 forced_ampdu_factor;
 	u8 forced_mpdu_density;
 	enum ht_aggre_mode ForcedAMSDUMode;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index a2ae68cc13f5..0fa6f674a844 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -303,13 +303,13 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			} else if (!ts->disable_add_ba) {
 				TsStartAddBaProcess(ieee, ts);
 			}
-			goto FORCED_AGG_SETTING;
+			return;
 		} else if (!ts->using_ba) {
 			if (SN_LESS(ts->tx_admitted_ba_record.ba_start_seq_ctrl.field.seq_num,
 				    (ts->tx_cur_seq + 1) % 4096))
 				ts->using_ba = true;
 			else
-				goto FORCED_AGG_SETTING;
+				return;
 		}
 		if (ieee->iw_mode == IW_MODE_INFRA) {
 			tcb_desc->ampdu_enable = true;
@@ -317,23 +317,6 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			tcb_desc->ampdu_density = ht_info->current_mpdu_density;
 		}
 	}
-FORCED_AGG_SETTING:
-	switch (ht_info->ForcedAMPDUMode) {
-	case HT_AGG_AUTO:
-		break;
-
-	case HT_AGG_FORCE_ENABLE:
-		tcb_desc->ampdu_enable = true;
-		tcb_desc->ampdu_density = ht_info->forced_mpdu_density;
-		tcb_desc->ampdu_factor = ht_info->forced_ampdu_factor;
-		break;
-
-	case HT_AGG_FORCE_DISABLE:
-		tcb_desc->ampdu_enable = false;
-		tcb_desc->ampdu_density = 0;
-		tcb_desc->ampdu_factor = 0;
-		break;
-	}
 }
 
 static void rtllib_query_ShortPreambleMode(struct rtllib_device *ieee,
-- 
2.43.0

