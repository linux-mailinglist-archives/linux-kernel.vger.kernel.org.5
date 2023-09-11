Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62BC79AEAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358861AbjIKWNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbjIKNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:14:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81160E40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:14:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so5711384a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694438073; x=1695042873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRNeftuB+INOMHeCbSOiUEWxB5DnzuRjYAHI6QDDXkA=;
        b=Vigeez2weEsges0RIcdXWa/U3nqvHSmFBU3YWORDkgLIXIrVtgQEDbDBi5p8hdEGZ/
         aG9mtTIJjVQnbUtD6frCGm9NzTxya9/DvEI+PPu1WhySMzhZ0BaAJpwRgcbmogXuA5tg
         S8Wpe2KCRPTBgDkXaw+J+J3FvvUM1Hdu3pVXosrlYWFUy8PSZiNXQFTJVEpayQFxjSyr
         kinkI/nGFoQM+Qfw5360zji+JpPziGYF3OcfzwbTJ3obIXJbBWk+41i+We4yyaun+LOu
         w4V4crhu5UP8a/9+DH+PWu1cKc0cZ/NMOGNaROCkRkPmAbaYRmbQSzwo/IUrWZY6I+QF
         uK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438073; x=1695042873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRNeftuB+INOMHeCbSOiUEWxB5DnzuRjYAHI6QDDXkA=;
        b=oL3FkwhPNVq+JFck9LnHoL3Orf7gioxtlISWHY9chbBQ/gXtqvrgJaqCUYEc93u0aE
         6CIsCvPyP1U9Idat+yfPVlWUwb6w5ieT2U7+UxPCJwg6BdPko9b+ust1Bxgz/NWMA16p
         KXWuMRZMsA/AGXHZROYS5zyUua7g39/xjwKE37TxxkK62f36M3LiuzM0DLTLYVZhG8de
         qkcGbsBAFYIKEp4h6pDuRWVIf3Vy5w8W3oRnrUn9xDjEZ2dd1Prk30lZHZyYo/phepk8
         RttbAgc2OB5qXnD7DtkUxyyHks5M3zPaKlyX0cDIW189c7cHaNFYeY/1fO4T0EaCs+zV
         tlkw==
X-Gm-Message-State: AOJu0YwlOHzn6wfR5UP+HCJoh8u2MhEYzHIyp7ntF/3+dAm9sK9NsN5s
        BSQn7lbFUMeuDF6tchJPmsX7lQ==
X-Google-Smtp-Source: AGHT+IHlCK86n0VeHZ+HtSrI9mh5xjoWNZuc9ZOAbu0C2O0EAitiz9ZVW48URQEVox9KobL72BbK+w==
X-Received: by 2002:a17:906:5347:b0:9a9:e41c:bcb5 with SMTP id j7-20020a170906534700b009a9e41cbcb5mr9086672ejo.76.1694438072876;
        Mon, 11 Sep 2023 06:14:32 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id kt8-20020a170906aac800b00988e953a586sm5313648ejb.61.2023.09.11.06.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:14:32 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/17] media: qcom: camss: Comment CSID dt_id field
Date:   Mon, 11 Sep 2023 14:14:11 +0100
Message-ID: <20230911131411.196033-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
References: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
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
2.42.0

