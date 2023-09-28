Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93A67B1031
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjI1A6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjI1A6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:58:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B46BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 17:58:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405524e6769so64665715e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 17:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695862725; x=1696467525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jBieT6zUjTCyWMNhIJcWnE9xtuerzKjzThbkTJLWlo=;
        b=HkobCTq6/HD91PNS1jjnXl0+aO0CPzLkFUWJxDQQtUZ/P/3PaGyEFOGeinRY4x9IW1
         n3PVSschWd5+r1CmtOtwAkrNiMRoiTa2ddbnsKy/zqS4dgc4kHzqSXYW9SMoVQP946V6
         UpIXm6omO1jfdGVNBzavCaotsc743YSap1DGYRXB9u9cf0DJBA06KECIBliEBzkVbOwP
         GpKFu7Hs1dgOIqXVbO1m4wL7bqzArlWu6g6T4ozO4JMSiX5zt3HV3zsHRM31DDBO6Fe5
         zzsTzwhkgWodlQYnGtvj9PmFUjNgo0njzVtzPRhCuc78ibpuXqxXHY4gWjNZizlBZTgu
         UASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695862725; x=1696467525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jBieT6zUjTCyWMNhIJcWnE9xtuerzKjzThbkTJLWlo=;
        b=KQ3/g9gXkBgargTomfVVVWi2DOk1BxzekCDRxq+trdf6MznuDLkSlVyP+x53qnN5Wq
         N+bPxW7RDdDVFq2GA/BB/Ucv/5UHg9r3iV5p2Bj+VBJ0PwaC1IWCLNnUmB/qYIhfjRfT
         4M31qptLezIv3aRjJczAWDeS7M1MAarsvHY9QLgggTH9VWVqjzOtsntIL5IB8M3Wv8m0
         8uVQW/Eg4aRZTwac5NrqBEP16gtECUc42V7OwGIIt/wNak5RB5DbdglEHnphIW597Ldg
         NRiIulXbwVkhsdje3Q8IZWIV/i/pLXFKvRy3ft1k+EWUHiH5ePN1FHh54FemlxuZMr+Y
         KDDw==
X-Gm-Message-State: AOJu0YwoTMTcCj9mzMM/tbk9eT60Dv+rRKf+U/UTd6cpaSsI0+6sECmL
        0LSlC26p5Lsvi8MKhMpKL/2K6A==
X-Google-Smtp-Source: AGHT+IFf7HbuKg7N4zjJPv/HPvYk0iORYNOH9jloqd/iaBSWnoqm2l8JhsOfvCB2XB4pIyGbucEvrQ==
X-Received: by 2002:a05:600c:6012:b0:406:51a0:17ea with SMTP id az18-20020a05600c601200b0040651a017eamr54217wmb.10.1695862725175;
        Wed, 27 Sep 2023 17:58:45 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b00404719b05b5sm18789086wmj.27.2023.09.27.17.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 17:58:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6.1] media: qcom: camss: Comment CSID dt_id field
Date:   Thu, 28 Sep 2023 01:58:25 +0100
Message-ID: <20230928005825.1626251-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <314cee42-c235-4d2a-b4a6-4da92d2c1548@xs4all.nl>
References: <314cee42-c235-4d2a-b4a6-4da92d2c1548@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../media/platform/qcom/camss/camss-csid-gen2.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 6ba2b10326444..05ff5fa8095a8 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -352,7 +352,19 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 		phy_sel = csid->phy.csiphy_id;
 
 	if (enable) {
-		u8 dt_id = vc;
+		/*
+		 * DT_ID is a two bit bitfield that is concatenated with
+		 * the four least significant bits of the five bit VC
+		 * bitfield to generate an internal CID value.
+		 *
+		 * CSID_RDI_CFG0(vc)
+		 * DT_ID : 28:27
+		 * VC    : 26:22
+		 * DT    : 21:16
+		 *
+		 * CID   : VC 3:0 << 2 | DT_ID 1:0
+		 */
+		u8 dt_id = vc & 0x03;
 
 		if (tg->enabled) {
 			/* configure one DT, infinite frames */
-- 
2.42.0

