Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694F98062B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346590AbjLEXFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346549AbjLEXFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:05:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E571CD45
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701817516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zI2EQGzuy4/i38sKyTTPT4IeppHHa6FP6X9uU+Zh4lQ=;
        b=Ps4GGRf29+R3oZuPRQTLey+AyxWsZtp5zv5YDkzSDTOoQN0qdwtJGe8qE/XqBglqt9DTYh
        fuOhJD4jMvQiHiZBNOdMfl/hCoJkgHc4yFJxsvMgaqCQTYSlqTFgtXX2uY18ZAkbpSPsYk
        aUUR2M7Ff98+7TVFP6LKT/DDx39SwHw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-bJ7NQHHbPPmBFmcmcypx2A-1; Tue, 05 Dec 2023 18:05:14 -0500
X-MC-Unique: bJ7NQHHbPPmBFmcmcypx2A-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-423f2e9ed5dso2229331cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 15:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701817514; x=1702422314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI2EQGzuy4/i38sKyTTPT4IeppHHa6FP6X9uU+Zh4lQ=;
        b=YLvPnj3xDCyeQqu4xmNcxtSorusKJLYNcx5EfDoeujVIwtNtyXqjksOg/HpUzxbscL
         sS1TuAzxjFGFwMU8tdKdMpalUr8p0HvzEFAY81BRgxPagCBd84YhL8SoAbF+vl6ZRjes
         2XUtOTytTJcDq1Q5V1Cz7fLYWHdHij5aGIeERg5kuLxKnRpfaqH+X/s1mtvbIIkVTvaH
         dlU1Z2SJLMWgVYPz1ZHLNJPfATRsPwAXgejg3gSrSgFxw4qa5gNSUjGywEqrbKVowH/q
         CNFb37P6Tjweutut+1WlegMrlu5+o1z1vPHmNn+iCy/FI2J5nwWHMtz0jbMIQ9pzCdKP
         tnfQ==
X-Gm-Message-State: AOJu0YxGFfC+uxzHS0d46QfMtlkh5bOFDHeWfcaFPvcMJdCJX/y4L00P
        lx0L4sthKWc1KKuKljWnVR1FHtjt/nycHZdA38UYeTok6K/Nz1Ud28CUuTnpeSGqBu6NFeM1ejZ
        mSjxuhYx232PMsy0esz+9wmtn
X-Received: by 2002:a05:622a:86:b0:425:4043:29f0 with SMTP id o6-20020a05622a008600b00425404329f0mr2448048qtw.107.1701817514109;
        Tue, 05 Dec 2023 15:05:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUSJuhRYxsGAPkig1kIfC+X2795y9odDvO7Hg/W6OVnwyPHPYbjuRFxQWNgF7b5jamRX1D4w==
X-Received: by 2002:a05:622a:86:b0:425:4043:29f0 with SMTP id o6-20020a05622a008600b00425404329f0mr2448032qtw.107.1701817513875;
        Tue, 05 Dec 2023 15:05:13 -0800 (PST)
Received: from [192.168.1.164] ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id df15-20020a05622a0ecf00b00423da75b0f4sm5504430qtb.71.2023.12.05.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:05:13 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Tue, 05 Dec 2023 17:05:10 -0600
Subject: [PATCH 2/3] soc: qcom: pmic_pdcharger_ulog: Move TRACE_SYSTEM out
 of #if protection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-pmicpdcharger-ulog-fixups-v1-2-71c95162cb84@redhat.com>
References: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
In-Reply-To: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As specified in samples/trace_events/trace-events-sample.h:

    * Notice that TRACE_SYSTEM should be defined outside of #if
    * protection, just like TRACE_INCLUDE_FILE.

Fixes: 086fdb48bc65 ("soc: qcom: add ADSP PDCharger ULOG driver")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/soc/qcom/pmic_pdcharger_ulog.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.h b/drivers/soc/qcom/pmic_pdcharger_ulog.h
index 9d5d9af4fbe4..152e3a6b5480 100644
--- a/drivers/soc/qcom/pmic_pdcharger_ulog.h
+++ b/drivers/soc/qcom/pmic_pdcharger_ulog.h
@@ -3,14 +3,14 @@
  * Copyright (c) 2023, Linaro Ltd
  */
 
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pmic_pdcharger_ulog
+
 #if !defined(_TRACE_PMIC_PDCHARGER_ULOG_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_PMIC_PDCHARGER_ULOG_H
 
 #include <linux/tracepoint.h>
 
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM pmic_pdcharger_ulog
-
 TRACE_EVENT(pmic_pdcharger_ulog_msg,
 	TP_PROTO(char *msg),
 	TP_ARGS(msg),

-- 
2.43.0

