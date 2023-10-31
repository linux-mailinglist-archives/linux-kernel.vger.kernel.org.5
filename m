Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF67DC5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjJaFfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJaFfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179A2BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so5294150b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730483; x=1699335283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVf1TCOQjv+Cr6JcAc0RWqhLliUBptkMGzKk4XZFEzo=;
        b=Wt4lOXehFMrApNcOqOPs3a/T8ngflIObyAoYyT9gGehKeDDx0aXI8TiYUmi5+eMO+s
         SyXnqdTPfVMD7SVDscroNv9HkMR3VebdNPn4ZhVS2TvFR0pW6MbYd5N+y55Th7ghRJ8c
         ErlfZMAzPx2W1AkGTiSEc/hMgRTjg6TBuXSlSJTY6WBHrJnhznALj47wmOcgCJ+s9XdL
         Yd1xNPeFrV5TnpZmF1evrUJ8xTMESNXu42kcj5xpEz0bkP67kBZM6u5FfCFr+1Yvm3Ou
         qJiyWKfuou0FeXoEWLVflfUZcaDZvdOnBoPg1CcZMO49V0P2ECxxyKdep8+lumvAqI5+
         4ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730483; x=1699335283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVf1TCOQjv+Cr6JcAc0RWqhLliUBptkMGzKk4XZFEzo=;
        b=MeddOgLpXrEnuhfJtlUXj+sAyKaoFizstn37M/FQcFttO45ZSZMvuX+LpXvUFdMoS+
         vIFW73UN/tYhB249w8gqn28VvWlw1lZZC5qEKZnxZErbe9P8ZPTUQpZFeNQy7QGuON9F
         NZyu14fjwoTYSVpx03uXqc5Cw2WrYq6gAjXiqm9aOs2Z7JVJs63hShnuXfrI9m9PDw1u
         g+jRMDEyjRR9DALz30395gUHXTffAo7p3GJEeJJ0iHvFKqZrthOJLoEl87at38XbzLST
         pXK6jH677bx5Iq1kDyHaLCHRe1CjZWsgWdkc5SpSAfhsRrKxbzkvzej8p15aIGGJNekL
         qrWw==
X-Gm-Message-State: AOJu0YycS6FwvGahJ0pDVUE3JraiNjDc/l0ZF5O85Y+/yTLmvwNn7aZW
        r1rxmne87BoohwQg7KeRe9M=
X-Google-Smtp-Source: AGHT+IFXGFhUU/M369Fhb4bNhxFN6VDO2lvFSFxyKfCqDasScfLG3d+NlkJEFUVueSzAX0VpF7b+Rw==
X-Received: by 2002:a05:6a20:8c19:b0:161:2607:d815 with SMTP id j25-20020a056a208c1900b001612607d815mr10667430pzh.24.1698730483544;
        Mon, 30 Oct 2023 22:34:43 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:43 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 01/11] staging: vt6655: Type encoding info dropped from variable name "qwBSSTimestamp"
Date:   Tue, 31 Oct 2023 11:04:24 +0530
Message-Id: <977e5e538610d28dce6a02a6d475ee336fc0899c.1698730318.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698730318.git.opensource206@gmail.com>
References: <cover.1698730318.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable name "qwBSSTimestamp" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 8 ++++----
 drivers/staging/vt6655/card.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 350ab8f3778a..59a788b7e268 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -280,7 +280,7 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
  *  In:
  *      priv            - The adapter to be sync.
  *      rx_rate         - data rate of receive beacon
- *      qwBSSTimestamp  - Rx BCN's TSF
+ *      bss_timestamp   - Rx BCN's TSF
  *      qwLocalTSF      - Local TSF
  *  Out:
  *      none
@@ -288,15 +288,15 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
  * Return Value: none
  */
 bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
-		    u64 qwBSSTimestamp)
+		    u64 bss_timestamp)
 {
 	u64 local_tsf;
 	u64 qwTSFOffset = 0;
 
 	local_tsf = vt6655_get_current_tsf(priv);
 
-	if (qwBSSTimestamp != local_tsf) {
-		qwTSFOffset = CARDqGetTSFOffset(rx_rate, qwBSSTimestamp,
+	if (bss_timestamp != local_tsf) {
+		qwTSFOffset = CARDqGetTSFOffset(rx_rate, bss_timestamp,
 						local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
 		qwTSFOffset =  le64_to_cpu(qwTSFOffset);
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 19689a291f5b..cda969b06fce 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -55,7 +55,7 @@ void CARDvSafeResetRx(struct vnt_private *priv);
 void CARDbRadioPowerOff(struct vnt_private *priv);
 bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
 bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
-		    u64 qwBSSTimestamp);
+		    u64 bss_timestamp);
 bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 			  unsigned short wBeaconInterval);
 
-- 
2.34.1

