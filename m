Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D927C8619
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjJMMtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjJMMtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:49:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A261CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:49:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40651a72807so21269895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697201346; x=1697806146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RD1+psGJavjlbvAsvM/ymtJYhrE+StFSszclFnViCqk=;
        b=A0lTc6X1zdpf939x/P3h4BE9SaArVD/bTAUKke+cAAcynWryplCSSWGbTs8ozq0LbJ
         jwC0KF3H1fd/gwCZLm+r5hLheL6MeoGv9i2mG27LhPP3AOb5HVDuD8kHLeW+KsKwXMSb
         ir/Q9GFA6p8ThhOq2R2jZO8qfpTHAPzZINSEOJ0b6gOOwbuH35n/ACehlOdGmy5QIpCU
         ubECQlW9CdZJAU1fmkIxjkgCCS+RmDugfJEP4Hu/UlzL+qdSGGFHL34B5amb2e7YeIAT
         cSDXVGnXHT706ErEYWA43LHfVUUX2TzBAOjcRG0NH9ynRodawGMaAtpBEeqq2okakoqV
         hrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697201346; x=1697806146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RD1+psGJavjlbvAsvM/ymtJYhrE+StFSszclFnViCqk=;
        b=R3W2Qh2Gd7ms9c9krGfN+qz537T7LvYLyLX+pSo2IUWOn4j3kgJdj7ZIBMXnWEWlFb
         y1ObIYtctEFWBpKPvE72TcGF8wmwENgvA4PSOiFE3n6FBbRFSSkBw3tRsivrpBa0tiz7
         hQNaPeYfGPEkx1T1Rs80MW2l4DSrR6aks/zmGgdhIUkXs+JGBK2ZI5plU/pmqIp3Ef2/
         GSemL4MCga8IZ39gAwJ0QCzEpnNdn4zsBp3G3SVpYwaNdQbO4970u3BtC/FAYeMeNJ8/
         94DdSYfj78PesFmGARV3dUw1/lBasT6fk59Vk6W1n/7eE/ubF6agrMWx+lAQHanH1Hw+
         BKDA==
X-Gm-Message-State: AOJu0YxQ7oheAXp1YDPC57OxWsNZqLjmUyOOZBJrHxGW9fxEsDh45hK2
        GXIIn7AWiOsdbUHMUXZ7sN5CWg==
X-Google-Smtp-Source: AGHT+IF54huxf7dde1KWHvmsDTifccuSHzOgUltiB3F36VOxPTTRYtt0svyxtS6VLHP7t+EUZnxZIA==
X-Received: by 2002:a1c:7917:0:b0:405:3d27:70e8 with SMTP id l23-20020a1c7917000000b004053d2770e8mr22824382wme.36.1697201346509;
        Fri, 13 Oct 2023 05:49:06 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0032d81837433sm8035438wra.30.2023.10.13.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:49:06 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] nvmem: fixes for v6.6 
Date:   Fri, 13 Oct 2023 13:49:01 +0100
Message-Id: <20231013124904.175782-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=384; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=1qG0LL0y3gK0QzWh3m0hRU9MU2RIU+zUuB+xUWXv6dk=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlKTzAPsWHD1xL+nswNdK23vtW+tPBaH4MPpU74 f8KI7D10JeJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZSk8wAAKCRB6of1ZxzRV N9jMB/0cxNVmcj9RRTfBywV56wmUV65uYxkb2Hsm+ci2hNLgBvfuDg6VqECPCXdl+wOmXSex3Yg 2yrROORYqk6VP9JLeQ00yKOCjtxjJYwjhxeUrZYFkd1FRM2orneazau/dxIv8Iq/ozZS31DFQ3K 5Cv5LWDGlEvrpDZzwx8seVCj/9u/uF56gecm4sGUAt73zoxBu1/SwqMOacc6BFpzN1tbGccj3pI eWrsdm3VaES0XLP92L9lS9ZQzU/H2j606lJX4pB1VDTXc8hQUy+5YPD4PCUNz2aJf3NMDpj8JNX bvB4aHR0tX+RrTQ18W4NoS+aRsKrJriqz3mlzjgasyaWTakO
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are some fixes in nvmem mostly around imx register count.

Can you please apply them for v6.6

thanks,
Srini



Peng Fan (3):
  nvmem: imx: correct nregs for i.MX6SLL
  nvmem: imx: correct nregs for i.MX6UL
  nvmem: imx: correct nregs for i.MX6ULL

 drivers/nvmem/imx-ocotp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

