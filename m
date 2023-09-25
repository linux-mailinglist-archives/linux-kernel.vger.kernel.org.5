Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9377ADC44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjIYPs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjIYPri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373271B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so57795415e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656849; x=1696261649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKTR9FGAJbp1Nit0RKPxQtBceNed5p1nXP0aMRVoGew=;
        b=fHa419QvOcMY3fX1MkE/QRM/XI/th837ZFDNaLME2XfJn65nuWG0W1GjL9Mh7toEMO
         xfDltwaBv+WgSYDIGDKJFFdxvfFjfep96BwPItoeXfLnj/QigJSIerF1H5lJVm2jYZSY
         hzYvBjJWMS5mBAAAc2CVtaCmlxFvfOuGRdPT4CWmFmJqaYkJACXsd04pAeIfxYNZ/EMj
         QOx81lZQ6WqitIKgim1Z0ldwGloM7v/xp8z9vwWHGZjKmLXT9nDWzRQ9Mep2egV5d18W
         5Wr07w03xPpP9IMmU3Ztdqc9dR++CnPz5nywekPUqpE9UaxXCfASOVF3gCQDoD8Qy8i+
         KL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656849; x=1696261649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKTR9FGAJbp1Nit0RKPxQtBceNed5p1nXP0aMRVoGew=;
        b=wv9/u3hnBV8t63kwyu+o8pcHZQzW9xcsSabWcWAHcozeY1EQrVZv/6MV8yimQeGV2M
         4eTlzGOr/BncLRuxjNpw/tCCG10AwYTj06pQ6Q2wymQXV0urJviYFGxw1TJ6PrT7jEBF
         p0sL50ZpfIPJ0FHizxDI3oYMYUNIwrjawk56PZuOV04WmOKR1s7osswtyO9/UTfiJE7L
         ATm3KAr7E/0MllyBYb8YIbOqyMEodksow24ZUvqz86aoowjFYlWEymSiwwV/D2RhZFnv
         6Gu80GPKd4auSZZKAM/xY4A+oXC/yTdoAOECyqJqk+Hd2aK91TRW4JkCeLe5KJUy3IzW
         livQ==
X-Gm-Message-State: AOJu0YxD8833UK9Of5CisCC9zHL5iUJBRgVNkdJwNG0ic2Kc2NBKh1/z
        wLjyEVkggl81/uM0lO9x0JIf3A==
X-Google-Smtp-Source: AGHT+IFKeZu788gHWgsRongPTtFe1L8P+ypwnDHQNU1kHF/IJhSKZslu+Zrp5iqyGWbQVXRGeB/6pA==
X-Received: by 2002:a7b:c456:0:b0:405:2d23:16d9 with SMTP id l22-20020a7bc456000000b004052d2316d9mr5885861wmi.21.1695656849715;
        Mon, 25 Sep 2023 08:47:29 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:29 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 17/17] media: qcom: camss: Comment CSID dt_id field
Date:   Mon, 25 Sep 2023 16:47:07 +0100
Message-ID: <20230925154707.837542-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
References: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Digging into the documentation we find that the DT_ID bitfield is used to
map the six bit DT to a two bit ID code. This value is concatenated to the
VC bitfield to create a CID value. DT_ID is the two least significant bits
of CID and VC the most significant bits.

Originally we set dt_id = vc * 4 in and then subsequently set dt_id = vc.

commit 3c4ed72a16bc ("media: camss: sm8250: Virtual channels for CSID")
silently fixed the multiplication by four which would give a better
value for the generated CID without mentioning what was being done or why.

Next up I haplessly changed the value back to "dt_id = vc * 4" since there
didn't appear to be any logic behind it.

Hans asked what the change was for and I honestly couldn't remember the
provenance of it, so I dug in.

Link: https://lore.kernel.org/linux-arm-msm/edd4bf9b-0e1b-883c-1a4d-50f4102c3924@xs4all.nl/

Add a comment so the next hapless programmer doesn't make this same
mistake.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid-gen2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 6ba2b10326444..791f27b18c394 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -352,6 +352,18 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 		phy_sel = csid->phy.csiphy_id;
 
 	if (enable) {
+		/*
+		 * DT_ID is a two bit bitfield that is concatenated with
+		 * the four least significant bits of the six bit VC
+		 * bitfield to generate an internal CID value.
+		 *
+		 * CSID_RDI_CFG0(vc)
+		 * DT_ID : 28:27
+		 * VC    : 26:22
+		 * DT    : 21:16
+		 *
+		 * CID   : VC 3:0 << 2 | DT_ID 1:0
+		 */
 		u8 dt_id = vc;
 
 		if (tg->enabled) {
-- 
2.42.0

