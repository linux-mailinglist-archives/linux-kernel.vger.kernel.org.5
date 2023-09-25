Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107E97ADBF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjIYPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjIYPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:41:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E374CDE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4060b623e64so633725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656483; x=1696261283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKTR9FGAJbp1Nit0RKPxQtBceNed5p1nXP0aMRVoGew=;
        b=QrsVFyjBk4md7uG1N5IvQSP5V1erEytLEvYNHpgT3vyzTmh38XzPDdzehb+6E2LZXN
         w1D39S1mXoceUOlTWjRMW1YpKN8OaiqtYUVMjot9OEbOU1nwjcFd7+5kOoUL2/HCgmis
         aiD/537GtobJ2vJ3m30T4zbWWQFnkSeKmT6Wj2t/1mY3fLQcct55lk9FsMt1q3nxS0LM
         3fcNHpk9kV6wAxvUXVWtEDwwN1xB2lNNltONrNZD3CaQtEnnIBu9gh35zUxwVRzU9nGY
         Ou5lubkYZ3CrkWqZ7JJmqmGl3iA0c5gxFi7C1tN68DySt2ltSPFI78OBQQQkNTAkH2Fk
         meaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656483; x=1696261283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKTR9FGAJbp1Nit0RKPxQtBceNed5p1nXP0aMRVoGew=;
        b=UJcPpQ5pva24crQrcHsu2+Xa16goGl+2v+5HV/G86emOH1tUDnplTnQsiSWPv5AJ1I
         H40fiYmNgyZ2N8MqVQnitXRrFOBrG/pk9e0WjSahSj+m0zf1qHWCCp00iBFj3OBSrxMT
         wJuA+gGwOTUKqQIL49/zv/RJe5V6TdRq7Lmw00EN6Ytt1A8Qs3nxxs4iQhDvnVO/8vO2
         knBQ1/7lOEWhlYJSmgIpD+iIUFsaJS368ZKpfASUWPERh32Sv3hMPFzlC1BFAQmNN34p
         86CfmKdV7CZt94bOoKBxSB9PLbTvIOIHuQwBPnTzvnzZpzi8fKoJbSM+NZcrYaICt5Oz
         0Ayw==
X-Gm-Message-State: AOJu0YzFkJ22z/tCV228FgLLyEUwhxJ0i+l9sW9l/zppx5CjUVGaA+wP
        wnXlBz0ddA7v45uz2m1G/5H7kA==
X-Google-Smtp-Source: AGHT+IFoAhU5Cs0xvXPtG7uTV1iy0I3SOLFGewWZ+KZawkMRIs4+1nopiCEkRO25IW2QkypAJvnF3Q==
X-Received: by 2002:a05:600c:11d2:b0:405:409e:1fcb with SMTP id b18-20020a05600c11d200b00405409e1fcbmr43234wmi.5.1695656483646;
        Mon, 25 Sep 2023 08:41:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bca4f000000b003fe4548188bsm15206155wml.48.2023.09.25.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:41:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6 17/17] media: qcom: camss: Comment CSID dt_id field
Date:   Mon, 25 Sep 2023 16:40:59 +0100
Message-ID: <20230925154059.837152-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
References: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

