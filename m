Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5C788AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbjHYOIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbjHYOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA22D65
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3082c771so735076b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972389; x=1693577189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA6Tm2kwkGXqxyYc7/1C4cf4CRJysy9kcmoHpsNSe5c=;
        b=H/HjUBizQqV6KkG7sKqXRhwSxx+ieTwJlZdxRhh+v94ULQFRZEiz158JCBchpZnB7c
         w6cDUZTNTP1UF1uSEeQsdJc1R0Nko1gnMpeMEJMZ20S9DPPSAzft6Vq4FKvRGrAuiBG0
         0LZ8qaGjmCvW3YQgERlL+eNfncTzideVtyPH3iOgFyS3oP0uxjrLbmOb4ZXCZ5ai4gjt
         dCWvynfWdpKL6zU7cN5vdmyqbtRGOVdWUT9BQAX5Mzh1bv81x6N5EAZmpTtXmnfehMlE
         8dQ8fK6En8LkJTAVLolInkh6y4TfZ7O9yXQvqDocl1vnDCYwv86jeH70mb0xFSgWnC3y
         0aZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972389; x=1693577189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA6Tm2kwkGXqxyYc7/1C4cf4CRJysy9kcmoHpsNSe5c=;
        b=fWe5tCzlYjYDaiSyMBMgDJmuM9EDlJd+DSmauISSWFaMi4pAU4dbMo7SCmzPG2/xhf
         vV+75y7ohHgGqxW4OVNiIeGwiTulF9pUBzeLLXIZmE13wAHwHKQ7W4VbXJcZkmp1nyws
         IjT7TMOVuC6uzFEEZSdMF3oRlBLN3ai+zDXh6L/9cEjPPb2NowJI4YWT75h9bAmM8Fkl
         pMNtk1C9oIblJsBVEEpRFLoSgHxM2YVA8S3Ez+Qs/iiVz3VcZ3bBXmi7IgrN0H21Gozt
         Q2k4idD8Di7QJvGiQ/KagB+p1kSuKHugzWQgKH7Lw/3/MDiUMIwHPJuZBpjGlNRW8kaA
         V2BQ==
X-Gm-Message-State: AOJu0YyuHwmzGiVzIVc8L93IrlMAeOi24BHoXZ/wPM5UrlnLeuQKhOFN
        p4HWjsWYNtUFPwK82Sct0PTL/AHYchQ939VTFq15IQ/Q
X-Google-Smtp-Source: AGHT+IHrH5+zMu4tyX2X/oRuZzH9gWY9XNa9o5EzpCZtD85cf37iNnxMgbl+QGWrnqBdjTHjzt8nRg==
X-Received: by 2002:a05:6a20:7346:b0:13f:13cb:bc50 with SMTP id v6-20020a056a20734600b0013f13cbbc50mr28019628pzc.25.1692972388667;
        Fri, 25 Aug 2023 07:06:28 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:28 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 12/16] Staging: rtl8192e: Rename variable pTS in function AddReorderEntry()
Date:   Fri, 25 Aug 2023 07:08:43 -0700
Message-ID: <20230825140847.501113-13-tdavies@darkphysics.net>
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

Rename variable pTS in function AddReorderEntry() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No Changes
v2:No Changes
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 8a4029f26835..1d41f62fa346 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -435,12 +435,12 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 	return 1;
 }
 
-static bool AddReorderEntry(struct rx_ts_record *pTS,
+static bool AddReorderEntry(struct rx_ts_record *ts,
 			    struct rx_reorder_entry *pReorderEntry)
 {
-	struct list_head *pList = &pTS->rx_pending_pkt_list;
+	struct list_head *pList = &ts->rx_pending_pkt_list;
 
-	while (pList->next != &pTS->rx_pending_pkt_list) {
+	while (pList->next != &ts->rx_pending_pkt_list) {
 		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
 		    list_entry(pList->next, struct rx_reorder_entry,
 		    List))->SeqNum))
-- 
2.41.0

