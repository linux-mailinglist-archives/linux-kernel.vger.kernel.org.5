Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51A47978CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbjIGQzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244691AbjIGQzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:55:18 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271B197
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:54:55 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-402d499580dso13164055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105290; x=1694710090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DBkJj6t1gRX5aZK5tJ1KyLlxRpK3N5foL763peQ1Wg=;
        b=lm9Pmk2npPKoqUlQhHTICYiMKgWCTy9if1NT3qaGI/vyr+0PPr5S4RNdd0n5m/ht8q
         zdxpP0ORw11SWDE45+uwbREiQDRcEwj7Ns45ptmzxETTKnBcL+MO4cClaCRyznDOsgOJ
         ITEuYKYdF+/nTQen3OZWiMywhBBlgNYfXXrHa/f8szxt6/06ywE9VG5UrZTansqyOCi/
         iO9QVAqrZKEDsMX7+kR2OkC+0h0HpW5lA4hLRLBVkft06bB0Ey+VEO3OSWmhvE/OkEJa
         Z90OPoh6P9x+kxQX2m2ZQeJT3+tBjQyUZF23am9iKrTeyrhUzPI0cMEz3U5dwweEIxX+
         8Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105290; x=1694710090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DBkJj6t1gRX5aZK5tJ1KyLlxRpK3N5foL763peQ1Wg=;
        b=UHdUACARyf2HGDhFFHemCXv6V/fBBrL+d3tRJ2p0SwmIvmMXW7dxoyHjafyznlx+x9
         SiMTlDeUhrRxBYgKScWjulqL+jTrzPcb0Hx1PmJ0/Z1ek1/uxmXJE+evmaddkmd0B/Ig
         unzyJJOViIh3U8WBvis1KKf2HuWc7inQJ2jtOQZugdegqhsMJcKz7YIhMBcO10vaM8wf
         1MEV7PBgCCZiF65NZ+xi8WTUsb2cBIGxooI7avVu9pV6hY9dlCTvonc1ZmMw3e/gLZMr
         SBYRf4lS1mOkeSRhIUmavZliioGYp+bd9nWyafgPXI6komef72YIfQCAlPPn/Z95C6qd
         kKBQ==
X-Gm-Message-State: AOJu0YzzLC73PnAAWoLstpFhZdv4vZ7E9cN5VrJKW59aoDL/gK9APPr+
        r3OLeQoFNmBYX4J+JE+JT78J7Cr35SYfTKss8qE=
X-Google-Smtp-Source: AGHT+IFoXG6hPmdGbK3c+YMW3n5SuKQkxSl3oJs1X+mNHJr9JBpHBciaJW/Anw6OgngsMIAc/RGSgQ==
X-Received: by 2002:a5d:4e42:0:b0:319:867e:97cb with SMTP id r2-20020a5d4e42000000b00319867e97cbmr5862684wrt.42.1694105076065;
        Thu, 07 Sep 2023 09:44:36 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm23822145wrr.49.2023.09.07.09.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:44:35 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/17] media: qcom: camss: Propagate vfe_reset error up the callstack
Date:   Thu,  7 Sep 2023 17:44:09 +0100
Message-ID: <20230907164410.36651-17-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch I had removed the returns from vfe_disable() since we
didn't trap any meaningful errors. Konrad pointed out vfe_reset() could
return an error, which is true.

Trap the vfe_reset() error code and throw it up the callstack.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 26817f9ca4f1a..256c0d8b8949d 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -438,8 +438,11 @@ static int vfe_disable_output(struct vfe_line *line)
 int vfe_disable(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
+	int ret;
 
-	vfe_disable_output(line);
+	ret = vfe_disable_output(line);
+	if (ret)
+		goto error;
 
 	vfe_put_output(line);
 
@@ -449,7 +452,8 @@ int vfe_disable(struct vfe_line *line)
 
 	mutex_unlock(&vfe->stream_lock);
 
-	return 0;
+error:
+	return ret;
 }
 
 /**
-- 
2.41.0

