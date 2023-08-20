Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AD8781BEA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjHTA6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjHTA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:18 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3D47C9DE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:19 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1a1fa977667so1377534fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492318; x=1693097118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8u8V5VjoL84uXoWIqfKyu7IJTL8pgnTcpzZ0r5UbSM=;
        b=fH0lJ4RWKDQp77MplHOb8N4wRUeYPJ4A+PEHV35da4RlxP5IgssrYV6uAoaLDNpF5o
         pS5ZFjFc4WpFBCL9/7p7zj9KFfkE+pFDe0YZ6DEGJqkL3kfxcNORHf+KfLcfWzzA93xg
         hIg/2YOTbdlbCzzbf1NGHR49WZUz98h1g2Q+v1ZvhKG97pD2brNwa4Iknm8BDB5BRNJI
         402Hua8C1plKRGg18cV35c/NCiEW1TCIqr2X/y7GAMvY0eORBH/OmvnpkIsukxDoCL2J
         yMFFtOyX/uiBqLsYJFKt3cXfD26iQd0q2KiUh67SHHvr9Rnf0PZ2UTh97mTLUAw71eMC
         e51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492318; x=1693097118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8u8V5VjoL84uXoWIqfKyu7IJTL8pgnTcpzZ0r5UbSM=;
        b=REObtK6m3aU9J6SnH39ee2tE47wVPv97VsAalx9fbE2akNLBtzmw/OcP3odgV3HCM7
         KinOvJcJc3Ylxakg81x3mWnQgHSjycdeKOgeIMsEpHaHpEp474L+06ry+2ThgaGAfSpT
         VWT5bm1woAcMl4ObPNF/QxIcUkn6D/pLIGbPP02rDvDLh+sjA7WAu2dSUv4FIf8R3nYk
         OWRdUqVTHPYXlG3EdeTtTjvf2w6/e9g3fS8HbNQzH1S4mYppaxlFej8OScJSz11PusNj
         CVi6Bos6A1fNZlLUOUcClpHhtB60oooovVoRp7r43FQjKiWT8ocvrmyg6+GGIB3YkHMc
         gReg==
X-Gm-Message-State: AOJu0Yz0eShWxFhufK9jD8w1p3cESuwQRM9Koq0tBxLCXGk7SAJIJINn
        uso577AB6S1pT8HKcwHlUcPJmw==
X-Google-Smtp-Source: AGHT+IFBcvVKMWQrklRVD6pweTUW/2Ako37DpuhY2lx/y3dGF5Z2yDk46p9FEy+0j5xqVRnA6hOsAA==
X-Received: by 2002:a05:6870:4193:b0:1c0:2e8f:17fd with SMTP id y19-20020a056870419300b001c02e8f17fdmr4817326oac.40.1692492318586;
        Sat, 19 Aug 2023 17:45:18 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:18 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v3 01/16] Staging: rtl8192e: Rename variable pRxTs in function rx_ts_delete_ba()
Date:   Sat, 19 Aug 2023 17:47:29 -0700
Message-ID: <20230820004744.278022-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820004744.278022-1-tdavies@darkphysics.net>
References: <20230820004744.278022-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pRxTs in function rx_ts_delete_ba() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v3:Resend as 16 patch series - no longer throttled by email provider, fix commit msg
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 0e3372868f97..da29163f3022 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -41,9 +41,9 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
 	return bSendDELBA;
 }
 
-static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
+static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *ts)
 {
-	struct ba_record *pBa = &pRxTs->rx_admitted_ba_record;
+	struct ba_record *pBa = &ts->rx_admitted_ba_record;
 	u8			bSendDELBA = false;
 
 	if (pBa->b_valid) {
-- 
2.41.0

