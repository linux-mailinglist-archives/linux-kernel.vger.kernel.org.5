Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A897EA401
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjKMTwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjKMTww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:52:52 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB833D6E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc3bb4c307so36539625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1699905169; x=1700509969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvj1Hf+89Ipd0B+JPWYx1UIQKsIrGquSXWrNNU7zN0c=;
        b=LiuuEAALgu7XsRXijGyx8tAOCfwxR8zzhBUzvuHdxLodscOAA9AkEQa0F1PohQLVLN
         r/3fYd05l+hzs803mlcihBmmeWPvl3y38PVF16luSkJRGajRscoqAp+Y0LvByjGcVWpY
         JKbfmjE5ROdMyLP0XiaFDwHMhAk+EdkfY3FEJmmyLwbZ7mQnsS4AVPjGPy1q0J7Y80rv
         Nzrg7Q0sv2dF1/DYv+Fin/hbX7AHNv9X61a0hgWxwYaiKIdvNEaBPfOZNwD0vUJF7ORB
         qisSPK6htxc+ZCZXYHV5ozz3IQQjget+NWt2BfdS/BEUQptRiof2Ur3QPeDNEk+Bg6fS
         R4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905169; x=1700509969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvj1Hf+89Ipd0B+JPWYx1UIQKsIrGquSXWrNNU7zN0c=;
        b=BVprG7ywBmBZwe2RXyFrkm2Lm6attJc6dul5aFQY29eoRiSSx/frQc3LH9dWKmK/mh
         JDi4tPsumCMDCA8QJO4etC6Y4PtExJR8csdnMgPO3PxKp4eYxBTdtqJ47VVgYTzqgof+
         /ICJm3zxFTE5QO7MVGdKg/tDAtmTGvfqR0+daV2wXQBJ28nzTvxjJN4CxXbp5eGj4G2o
         DDkNlNKSxVj7kZqjtyDYqP5zDkxZBVOnOvnbnWa3NnOEubxFpQwCUUWvHfmFDopM/B3v
         F/EhevxG9Lcil5ZvWLtguO4NxDSMmSky3mWjOqvUk4tiMgxArrWxZ3AqSXrEECHMa2HT
         imBA==
X-Gm-Message-State: AOJu0YwiLuy6gvkhQscMcoCiB+uCA5m6K1rokpL5V+cXe2E03bvEfndn
        rgVncfSK8srEyDMHzS/ypkv/XV8tTqZmjk8ArDc=
X-Google-Smtp-Source: AGHT+IHwyZx1HcevurmBWNFO/eV7PqrhMrIEPukPhKQVUlur/AgKI0X0WUVPHxZajPSnCoGPBjOmdQ==
X-Received: by 2002:a17:902:ac8f:b0:1cc:b460:e6cc with SMTP id h15-20020a170902ac8f00b001ccb460e6ccmr271139plr.12.1699905169316;
        Mon, 13 Nov 2023 11:52:49 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001c9d968563csm4395815plz.79.2023.11.13.11.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:52:48 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/7] Staging: rtl8192e: Rename variable bSendDELBA
Date:   Mon, 13 Nov 2023 11:59:04 -0800
Message-ID: <20231113195910.8423-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113195910.8423-1-tdavies@darkphysics.net>
References: <20231113195910.8423-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable bSendDELBA to send_del_ba to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 4af8055d2489..c0058d2be6d1 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -27,31 +27,31 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
 {
 	struct ba_record *admitted_ba = &pTxTs->TxAdmittedBARecord;
 	struct ba_record *pending_ba = &pTxTs->TxPendingBARecord;
-	u8 bSendDELBA = false;
+	u8 send_del_ba = false;
 
 	if (pending_ba->b_valid) {
 		deactivate_ba_entry(ieee, pending_ba);
-		bSendDELBA = true;
+		send_del_ba = true;
 	}
 
 	if (admitted_ba->b_valid) {
 		deactivate_ba_entry(ieee, admitted_ba);
-		bSendDELBA = true;
+		send_del_ba = true;
 	}
-	return bSendDELBA;
+	return send_del_ba;
 }
 
 static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *ts)
 {
 	struct ba_record *ba = &ts->rx_admitted_ba_record;
-	u8			bSendDELBA = false;
+	u8			send_del_ba = false;
 
 	if (ba->b_valid) {
 		deactivate_ba_entry(ieee, ba);
-		bSendDELBA = true;
+		send_del_ba = true;
 	}
 
-	return bSendDELBA;
+	return send_del_ba;
 }
 
 void rtllib_reset_ba_entry(struct ba_record *ba)
-- 
2.39.2

