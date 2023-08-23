Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72C27855CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjHWKqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjHWKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:45:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEFA10E0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:45:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so4567400f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692787508; x=1693392308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIu4eWCkEOSVtI8FoLJRLwwONGivM5mrULXtY5Z5HVI=;
        b=iR1HQqxeBsupmS+Favm4zTSidm2aT6bx7ajaAl8rBuLII87IivTUcR2VWpznpsDE+R
         MCfdnWtCmOsEpUaFAl5mFZdQSr8nzotudFoQksQixrFdAXdx+r+oGFa8gWcd6vfaQqsH
         cVvlFANnHEouAyGGiZvq3xN0gruYNTynKcNGRwn4atmVlAZ8QnqQypDcdx2Qqc2Z0EWz
         RjY67jKMvacBJSfoIgHgxlCjphiFK106NYNXL14qgECQ67n5RjKd9cLiE7X+L30ngvis
         eil+bTCkEjRUoc1+IzIpjGuQFZp/chrfKSJ2Q6nrTaVUdpR94GxUzhjg/lx22O4He6hQ
         rQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787508; x=1693392308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIu4eWCkEOSVtI8FoLJRLwwONGivM5mrULXtY5Z5HVI=;
        b=kmnmuxRhIC0dOrUz8PO311TI5hrgabvdY8EAiuQFc+rbgUEhDCWUZ0fhWmp47+BDst
         FHYJyRymp+fZC1ilKQ71GzCuAeaL4ZV/gGV1gw7EOv90TwXXNkxtQWAShKXYEfGUnbpu
         mhgLDSTLqMnviQubv4SMJSh9DebpFbILp4NigPgygwMs9BZZG468rDag+ky9RI94JL01
         kCEiTLjhuLIheSXNLJdUqeHurnQRq87u881io39fST9RJiigvYjcTFsgtz6yx7T3yaWK
         rRErbQnWhXkRzxmSezLAXhTrd4DiUwecCA/pSYseaQwlm8h0j4+IE3yHPThnUUjbJcTn
         QPuQ==
X-Gm-Message-State: AOJu0YyjUVnnMlz4f5dJDaM3OmpypTdXr6wboYyBn/NKWBO7fU91VjFS
        7O99kSERK3BNVi3QVyXkfrNLcg==
X-Google-Smtp-Source: AGHT+IETgiaFMcrE1JfWFkGdddTyYkNG6PjtSRuCyiFhrM+u1c/VD06R+stwPw8nbB17oeoE3yvOFQ==
X-Received: by 2002:a5d:6949:0:b0:319:7471:2965 with SMTP id r9-20020a5d6949000000b0031974712965mr9485144wrw.21.1692787508218;
        Wed, 23 Aug 2023 03:45:08 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0031c5dda3aedsm6281213wrq.95.2023.08.23.03.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:45:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/15] media: qcom: camss: Comment CSID dt_id field
Date:   Wed, 23 Aug 2023 11:44:44 +0100
Message-ID: <20230823104444.1954663-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/media/platform/qcom/camss/camss-csid-gen2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 6ba2b10326444..cee50fc87e9de 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -352,6 +352,11 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 		phy_sel = csid->phy.csiphy_id;
 
 	if (enable) {
+		/*
+		 * A value caled 'CID' gets generated internal to CAMSS logic
+		 * which is a concatenation of [vc:6 | dt_id:2] hence we reuse
+		 * the least significant two bits of the VC to 'stuff' the CID value.
+		 */
 		u8 dt_id = vc;
 
 		if (tg->enabled) {
-- 
2.41.0

