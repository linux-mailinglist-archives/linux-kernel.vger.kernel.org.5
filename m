Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8848A76308B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjGZIzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjGZIzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:55:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B4F2695
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:48:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso9196785a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690361296; x=1690966096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBt6LabizIPlGKQw7TnJxCRLQnfQUO6NlY0tbyWu7+M=;
        b=WCBv0DeY0PiKsTPetO22VSX3HdQmMlsw/msR2qHb9PdpkvZ5LJ2duWV9dNTPu45izc
         lqtwn3XVOu4SHNEQxE7ee13sC+RoIGaPV6DoLXZE+uobutKPYyw7qYNTGiaFdAIUTZeg
         L7ir9j2etXNQ/FfJrN5QkImu904ZO9XQlRy1c6RmxN8kq+u5Hx9PQfJ1ZwCzSxg+fYAD
         ygecbWaJaLfA6b0Xcc5Q2sIOEkUyZ90wpzI1Pqb40+rFbP3udiOkTe08Hui9AUgCTQA6
         gRMuLm6ui0E6AFAZ5nm3Ve//FOCTgAQd7RYL+Rs1aMY0nQMiJVHbH0mXfO8oEDt8xWjG
         Re0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690361296; x=1690966096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBt6LabizIPlGKQw7TnJxCRLQnfQUO6NlY0tbyWu7+M=;
        b=gMcfLGF8KUgZCKJOlz4tJUm8VRVli2iq3Z70EsvMa6vQfpgFBq4+hNFLbZIxkeP+dm
         3z6Qf1vReK8OaEkxacQZ2IRWkRNpziB+ij6v2D+dqG40eUMtQyrZ5qvatkj4w52S1aDq
         pgLVoKpXlCKB4nWfYD46s42j8WlKk6moSgMZ637tA8dGjdhXBYH/2GbpVoTLXcDZDh41
         Tpl4McoTekV6qAYQ6oC5GxLavz3/DL+gB5hFKTKkQXSyYGkXrBWt7pBT60oDCniw9x7Z
         1AZaBJH9J21UUhtwDKScdUf09XkF1pH/9HbHNnjejTuVl+3CfXrxi0fqUPsKtgw3YmpU
         AR0A==
X-Gm-Message-State: ABy/qLay2b3hekkW8fD07qhgyXuW/pOBO2RYL+jgiZUtzL097+ANvHIW
        7kdt2LzgIjKVp6anhtiMZ2GFhA==
X-Google-Smtp-Source: APBJJlEtwc0nAd/v1e2LQoPdUChw3xWAxiQ1w6NNikuEi4EKj3d0tYxESZEY6zC9Qdyb6DWkEZwbPA==
X-Received: by 2002:aa7:cd5a:0:b0:522:5778:ee2d with SMTP id v26-20020aa7cd5a000000b005225778ee2dmr1127763edw.19.1690361295341;
        Wed, 26 Jul 2023 01:48:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n23-20020a056402515700b00521da86cbcdsm8494107edd.7.2023.07.26.01.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 01:48:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [GIT PULL] memory: fixes: Tegra drivers for v6.5
Date:   Wed, 26 Jul 2023 10:48:11 +0200
Message-Id: <20230726084811.124038-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

Two fixes for current cycle.

Best regards,
Krzysztof


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-fixes-6.5

for you to fetch changes up to faafd6ca7e6e7100d21d3f43ec17674f36c9f843:

  memory: tegra: make icc_set_bw return zero if BWMGR not supported (2023-07-25 22:09:20 +0200)

----------------------------------------------------------------
Memory controller drivers - fixes for v6.5

Two fixes are needed for Tegra194 memory controllers caused by the same
Tegra PCI commit merged in v6.5-rc1.  The Tegra PCI requires now
interconnect from the memory controller, which was set only for
Tegra234, but not for Tegra194, causing probe deferrals.  Expose some
dummy interconnect provider for Tegra194, to satisfy PCI driver needs.

----------------------------------------------------------------
Sumit Gupta (1):
      memory: tegra: make icc_set_bw return zero if BWMGR not supported

Thierry Reding (1):
      memory: tegra: Add dummy implementation on Tegra194

 drivers/memory/tegra/mc.c       | 37 +++++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  1 +
 drivers/memory/tegra/tegra234.c | 27 +++------------------------
 include/soc/tegra/mc.h          |  3 +++
 4 files changed, 44 insertions(+), 24 deletions(-)
