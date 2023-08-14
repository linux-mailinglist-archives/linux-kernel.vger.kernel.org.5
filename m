Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BDC77BE77
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjHNQyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjHNQyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:54:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38610F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so7303627e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032037; x=1692636837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4VOdQ2+Ao+ekB1JFBvNQB0H78lSGJ9EZdf+PWj6TOY=;
        b=ezh3viEPMRHRHs9dvh9/izH9sVU1xX3spWYGYEuexLl5mImtEpNxpluipzIrkNqYvP
         E2RvyFDSBg0yz2jlK81CHc/ssVVqqceN7n1hUskagw4Poj5sVXHMHNIwYPPwEnTD/OYr
         /IqdpiR1DR1W2rH//3TNnP5CDlpR907ATzLjHGpWXY2eUhL5yjAd6EgckWFXrOGSK67r
         gw1HbjfLUliH9GbUVApx+dN5+kIlO0lveCj/go40CSMgwuYEGkP2RqtSHCWv/H5Ol6fP
         mpeCevluXsgJAPhL2LJ5SKe7Y9xB8rkq4ankdXJWn0memftbI5wBLnpIkBeNAGISxI7Q
         A5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032037; x=1692636837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4VOdQ2+Ao+ekB1JFBvNQB0H78lSGJ9EZdf+PWj6TOY=;
        b=JSfFeOFb00ARN1PAly9514zNc3BO4PWJHMe880awIEGJAtlIEubwKeqFqgoB5uHHlE
         Whrt608r02TPTFs1YmKyDewKQeEX0Idcq2x9sX9QRZ/qTvClFXQ3Bo4IgSapVU+QHbHG
         tkVpZnoE1K8j5lhTm7U/8LiEJdy0pzo4NxIhFKFprdAG+8hnZPi2xd1uAEPIdW0W2PdF
         /L2widsJ7OmiEh/aqs1sVdVMcxKkKLNJyNNmzPhQynSvhPwsImdXJqPz+DvBKsfXuYzm
         FxBKSjRyjuSGcIcptsa9IQittLTMVh1Glck0JWmDGhf05v8z6rbL3v145DdazZKXv+gL
         rlPQ==
X-Gm-Message-State: AOJu0YzyWBSTM4hzvAEVcHMKiQi7DYqAftn6Gib9h07kOtrCVDhWvHYt
        JWsvPGZodPGAgo0ss3XUZLmZVQ==
X-Google-Smtp-Source: AGHT+IHHHi+cEVFU40QYPjryFguF3JjeX7b1sXYBuf6orOH+KEqMNWfNHpZiOsdeHm3e5dTGCh5Z5A==
X-Received: by 2002:a05:6512:4002:b0:4fd:da65:d10 with SMTP id br2-20020a056512400200b004fdda650d10mr8601126lfb.36.1692032037190;
        Mon, 14 Aug 2023 09:53:57 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 20/22] nvmem: core: Return NULL when no nvmem layout is found
Date:   Mon, 14 Aug 2023 17:52:50 +0100
Message-Id: <20230814165252.93422-21-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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

