Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6627549D8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGOPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGOPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:37:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991932D7B
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:37:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso4767909e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689435474; x=1692027474;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+djRnUBFZhHAwtTKh2Fe3WK0yWfTrmhbES8+t2drAg=;
        b=F/WKXblS2846S3vhtFpEb05kbGFFIlENzJ3Y4pcrfI+SbTk2Y4XjeUHeOmPFoQ6m1O
         x80D1f1lE/oBOzx4W4O1p6tc67btDVnx+2hRulVnDMTiwRXyZQAf9uTj6ZZUtuQ0hAI6
         yfHqyBm4seFNzJXZZK2fZloLVhR8leFeT9tBIW4yX2I/LTStYE2adgLNut/y49pqkE35
         MGh8Nro99t/oT8bcG+4SdhtWqUs4KCesMWHLWoD3CjvFEDu/0xpQAYX8BmgCqP4l9nMu
         1U424Wh7sGKB1YCW3gbgD3V6rlXd60Ajl9A14Wi0fImrx5I7WNAlfiNMlZ2/PcB00GN7
         EHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689435474; x=1692027474;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+djRnUBFZhHAwtTKh2Fe3WK0yWfTrmhbES8+t2drAg=;
        b=fLzFZTlpxzERtQj6l43Gv2uSWc58078bncRsx9EIKuyfNFRdGYFdCxT8d0nlZ1m5+H
         UOhlBqQ2viPSxDIovNlwdvBJHJlmrP2uN5noanixiyZOEMTKTpKLfBetPmALo+k7mC0u
         VxVQL0XrDP9zKYqFDuZ6JcFddEVrm8RUeIgMo+oC2wJHQhd3XsIjM2I6wZ70hXqPscvn
         Uy7wbj1nR/bCWgXUsXOvbrCvFejOjA96LNeHrWY4/vsgsYv9qrfEDPs8uFjZFqOLIGUl
         MDOSv1ErWCiUGOwGUJOGINN78N53dVPdI7dEIi2RCIO9v5iZj5pXNWqlwjjuzuWr+ad3
         Sj5A==
X-Gm-Message-State: ABy/qLapKZ/ws0zvz851diQXSkDECPFc+E16kh3yreYqRtw8XHaPVzQV
        pjbwgjd3rlSaWMFkGThONEXpOw==
X-Google-Smtp-Source: APBJJlGnvRzysI6qYnA0eg/NVocOpM6/Wa4ri3O3mzrcMONorQKIeHbh9d9MmdlI//c6wMp6j9RuFg==
X-Received: by 2002:a05:6512:3f6:b0:4fb:9f93:365f with SMTP id n22-20020a05651203f600b004fb9f93365fmr6291643lfq.38.1689435473901;
        Sat, 15 Jul 2023 08:37:53 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2511e000000b004fbdeca7b79sm1925808lfb.247.2023.07.15.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 08:37:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 15 Jul 2023 17:37:52 +0200
Subject: [PATCH v2] media: camss: Intepret OF graph connections more
 sensibly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-camss_grpah-v2-1-57d9d5e49038@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE+9smQC/32NQQrCMBAAv1L2bCRJ00o9+Q8pso1Js1CTsqlFK
 f270Qd4nIFhNsiOyWU4VxuwWylTigX0oQIbMI5O0L0waKlr2SojljSTFRYfOd9GnjGIuvMdGn8
 yWloo3YDZiYEx2lDK+JymImd2nl6/0bUvHCgvid+/76q+9t9iVUKJxpuhUW2tpMfLRBE5HROP0
 O/7/gEKWGVNyAAAAA==
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689435472; l=1614;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IWx/Y65eu/NJcdTnG8aoRNmX5OhoUqPGvpZUr4ZM0kY=;
 b=YaoNNiOpYTAMnAIVRNlPWQcOOz1V+Rx9Cdsp/R84UIJLHhRbIeCqOvBhq1+8s3SEE9pgg6i/M
 jrYxMVUClulDsZVtzq87Uxvi5GyMWV97Pakq5etA31OhcYG6QKxXGTW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all endpoints of camss have to be populated. In fact, most of the
time they shouldn't be as n-th auxilliary cameras are usually ewaste.

Don't fail probing the entire camss even even one endpoint is not
linked and throw an error when none is found.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Use if-else instead of the ternary operator (Bryan)
- Drop "RFC"
- Link to v1: https://lore.kernel.org/r/20230614-topic-camss_grpah-v1-1-5f4b516310fa@linaro.org
---
 drivers/media/platform/qcom/camss/camss.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 1ef26aea3eae..8b75197fa5d7 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1084,9 +1084,8 @@ static int camss_of_parse_ports(struct camss *camss)
 
 		remote = of_graph_get_remote_port_parent(node);
 		if (!remote) {
-			dev_err(dev, "Cannot get remote parent\n");
-			ret = -EINVAL;
-			goto err_cleanup;
+			of_node_put(node);
+			continue;
 		}
 
 		csd = v4l2_async_nf_add_fwnode(&camss->notifier,
@@ -1105,7 +1104,10 @@ static int camss_of_parse_ports(struct camss *camss)
 		num_subdevs++;
 	}
 
-	return num_subdevs;
+	if (num_subdevs)
+		return num_subdevs;
+
+	return -EINVAL;
 
 err_cleanup:
 	of_node_put(node);

---
base-commit: 7c2878be573282a9961c359b806ccf70afe1a6b6
change-id: 20230614-topic-camss_grpah-39f9a4f7420c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

