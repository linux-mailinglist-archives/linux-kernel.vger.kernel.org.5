Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD0788AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbjHYOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343511AbjHYOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:06:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB8E269E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so820715b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972378; x=1693577178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjYzdVLvE2mBXqluKBhvaZb65T+FBQkKGDwfPiHVKB0=;
        b=WkDCH1SOSXwUGtkPwdqo3SkIUKUnH6cEeY86N+yjCVsgVz47uMOya+YAcw9JoOv6+1
         z5WzyvJWgPTpRcCjXTNZscAx1UvJcHayDO+yFojMwgnIldlehzqpc5YfXqJEBkYfalyV
         a7uUCi92Aja+pCRgNU7WIsbu7NudtptdGgDjzU/oFOBfzpOG7ft55FbLF+/U3Tj2fqU5
         IW0peGSaByHxgUMvF+W34zkAbECNIJA1Bj2qRuwH0yBdWHAEYmq1/ThEed/TILrITSEj
         I8XHlIY7NJWTN5c4OGGveeYPYSnqhuTsECSFOhMejHlNWVDz5H9BFu7XbOUlLjmNIqN0
         fUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972378; x=1693577178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjYzdVLvE2mBXqluKBhvaZb65T+FBQkKGDwfPiHVKB0=;
        b=i/HURwfnWKvDsD70VQ19V7KnZrbbGoW8HOYEHBw53waNIpqitxngbh6sEB1/1TMs+M
         VvmJAd7IENu8kcpQigGOgXPSGUX71owXGmD1PULxpuql+TbExXSQy5QNngtmyDiEdIYo
         jTtgzw1Yiha8Hj3KTe4s+1FOFxgm+kGDMzHNjZrIx5xE1TA+Hwu8A93WhfI9FqLiQ6sA
         YUBlbyQbN7uA8EH2kViZ9/oToIZrRdRR/k3xHYy32kjQY0URpO7FOCXa1tpQDDWOHOw7
         LDNWURLU3Bon7xL9k8QVi1nUdTxIAYdUbg9r2g3surXGuzD1yEPBsQevxD0Xx6wIU1Fi
         lstw==
X-Gm-Message-State: AOJu0YwVZWLTkOZywKrNIBzKSy37+X++VN0d+py3S9sRrCn7YL7omqLK
        wU9AEh7tT1SeezhKwvDxgHPD/Q==
X-Google-Smtp-Source: AGHT+IHRe9MGZncFusl59k0P+AniLXaJil8um4Amt9WTvPd3mzMDsySsYYFEmHzpaxFDALDhb9Os6g==
X-Received: by 2002:a05:6a21:8187:b0:135:4858:683 with SMTP id pd7-20020a056a21818700b0013548580683mr18727399pzb.48.1692972378192;
        Fri, 25 Aug 2023 07:06:18 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:17 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 02/16] Staging: rtl8192e: Rename variable pTS in function rtllib_rx_ADDBAReq()
Date:   Fri, 25 Aug 2023 07:08:33 -0700
Message-ID: <20230825140847.501113-3-tdavies@darkphysics.net>
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

Rename variable pTS in function rtllib_rx_ADDBAReq() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending as v4
v3:Resend as 16 patch series - no longer throttled by email provider
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index da29163f3022..03d76765e85f 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -220,7 +220,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	union ba_param_set *pBaParamSet = NULL;
 	u16 *pBaTimeoutVal = NULL;
 	union sequence_control *pBaStartSeqCtrl = NULL;
-	struct rx_ts_record *pTS = NULL;
+	struct rx_ts_record *ts = NULL;
 
 	if (skb->len < sizeof(struct rtllib_hdr_3addr) + 9) {
 		netdev_warn(ieee->dev, "Invalid skb len in BAREQ(%d / %d)\n",
@@ -253,13 +253,13 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 			    ieee->ht_info->bCurrentHTSupport);
 		goto OnADDBAReq_Fail;
 	}
-	if (!GetTs(ieee, (struct ts_common_info **)&pTS, dst,
+	if (!GetTs(ieee, (struct ts_common_info **)&ts, dst,
 		   (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
 	}
-	pBA = &pTS->rx_admitted_ba_record;
+	pBA = &ts->rx_admitted_ba_record;
 
 	if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 		rc = ADDBA_STATUS_INVALID_PARAM;
@@ -268,7 +268,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBAReq_Fail;
 	}
 
-	rtllib_FlushRxTsPendingPkts(ieee, pTS);
+	rtllib_FlushRxTsPendingPkts(ieee, ts);
 
 	deactivate_ba_entry(ieee, pBA);
 	pBA->dialog_token = *pDialogToken;
-- 
2.41.0

