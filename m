Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D46378595A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjHWN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjHWN3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E3E7F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bdcade7fbso711755866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797298; x=1693402098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4VOdQ2+Ao+ekB1JFBvNQB0H78lSGJ9EZdf+PWj6TOY=;
        b=gILCvwDGfzItGitSj/gZqHvAZ9FgqtMkmmmKlx5xMTFGvRVCEK+9G373o9UO7m0dpQ
         eBIpRJZ1xumU03g0rrGhdytsZiP8QZvY3McDtCHeshncg09EucSHhRAza2O3aTOkBn4g
         XBm4peW61xiHnf90XsK4KCBF1mjF0Dl8cFJd4kp4r7CNHc/8AlbDA4PUnE6hHxtZtQMf
         ZdREW0ChYZ4Kd7MbjyMSDmcZv3O8/QHmy5aeJcZwW+RNWOxWnvlPQ8O0/lh1vj1XyfhV
         TKn7Jtd31TqgE8fxSvMi2zYXA6qJ421jgr1kJG+Pszw5i+4VzAewbY2/X4lWRA/7Y4yN
         6xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797298; x=1693402098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4VOdQ2+Ao+ekB1JFBvNQB0H78lSGJ9EZdf+PWj6TOY=;
        b=DHaaSh2QaJYJdoXGEIAAlK6OpCcebdK/r1lwA/OjtKHF5aE+XWqFDZXKZ4RbFSQeNx
         +AgNBxAqKJKgTjbbT0C/wsa6enx9Tq41FygJNaRPiZcwipCyoKddS8wKSvwtBq5uZZr0
         7Ot2Y0rgiU8CmiWkDQlV9C8afDA/Myv/jG9ppMz9Qy/6KFVcjl/c6f3aWvJkGndFHhvk
         iQ8/fHQ1Kv3jHOtxg14XoL74SzkOfVk1i6o++P1Z61ugMLgo9wR1nAQXC0lN3LH3E0Jd
         peOM+lRuxxZXaxCISBqx07Q/3Cn1djHBBTJ7a9RHMXTyH9SsMELVdGIEExSrsjJIAYDO
         Q+gQ==
X-Gm-Message-State: AOJu0YyB3ThXPETDQ2XcZhDx+gikO9aHaMXG3tDHTnQhYqpnEGda+07J
        Q+p7sx/6GCmcA/JNL0egsg0ItA==
X-Google-Smtp-Source: AGHT+IFWbWLIaooEswcBpFue5dxlNZf+pV3TIjoIKl4VWXhDOgZPY0W75+4tHEthGovi68ifAbxmVQ==
X-Received: by 2002:a17:907:b11:b0:99e:1e9:fea4 with SMTP id h17-20020a1709070b1100b0099e01e9fea4mr9849599ejl.51.1692797298516;
        Wed, 23 Aug 2023 06:28:18 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:17 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 20/22] nvmem: core: Return NULL when no nvmem layout is found
Date:   Wed, 23 Aug 2023 14:27:42 +0100
Message-Id: <20230823132744.350618-21-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=BoZNOrDNjdXu5QHSoe17fPZxRgh0XuK1bafndIgFVaI=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glJ+CXTdAdw8D3jnuqh8he37SRJuv2kMK6OE mmh3VcPM8WJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSQAKCRB6of1ZxzRV Nz0jCACeaCTEbWcy1Dpu4IdiCi4POouWUcx4AQIhlZtMmqHy5rEih5G3aFVro7ucDMSXmta1yJR WPYtpnd7roZ8UpUvw0yrEnpZGCi9IRbgvl22ZE9EYwpMCqdcZwM2tJ9nlkeotqwfAYY4i3N/lA5 DzNNKYM0kc7LXMQUh3HC+5cZ88/8LwZpoLBI05+wGp9pYeWAGSGF76gug5bxwd4t0SqWnmuTN1d hKle7mYk+n2AAig6x2RaossGCQqp9xhX6mkd2f5FxguLjSBS5VCFN11X8INx56dI8LXYHkEmlNC hEIFwnpHHTEwVnfp49BgTyWfADblr/zUwlvx53R6TB3lZ883
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Currently, of_nvmem_layout_get_container() returns NULL on error, or an
error pointer if either CONFIG_NVMEM or CONFIG_OF is turned off. We
should likely avoid this kind of mix for two reasons: to clarify the
intend and anyway fix the !CONFIG_OF which will likely always if we use
this helper somewhere else. Let's just return NULL when no layout is
found, we don't need an error value here.

Link: https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
Fixes: 266570f496b9 ("nvmem: core: introduce NVMEM layouts")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202308030002.DnSFOrMB-lkp@intel.com/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/nvmem-consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index fa030d93b768..27373024856d 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -256,7 +256,7 @@ static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 static inline struct device_node *
 of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return NULL;
 }
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
-- 
2.25.1

