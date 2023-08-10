Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6608777BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjHJPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjHJPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:12:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224532694
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:12:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso1527673e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691680375; x=1692285175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Atb0jrTiyZhB6Vba51W4Bj3vyiqmbf0UlTzWhJceDM4=;
        b=r7C9lnpMgM4Js8CG5h1thqpG4k+iWowsNEeDSDDiLm888xblWp7LiXr6tzMlVODlOt
         4m+d+Ni4XLkVm51w7O1TaEm265a2br61qqr4fcZAK2YmTjVXZsFMxn+Pys/Eh6jIqKeP
         viMzwOFfEx8SP6bSCPSVcWYwB6XqBma/gIyJ2y3qK5v1ggGespboZ8Efoadeaq6EpRqR
         yynWNOCe9dw8/r8lJcFxWOkwv/vFsB71SoL+bhAgZ704LDdWdxXsZyMpNWdABGdptRHE
         G8au4PIjfAJDPN33RorGMXNYmLFBQcZ5nffRo7w3eCrGckfLX8ojAdlGMqdFIv9aGlJj
         czig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691680375; x=1692285175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Atb0jrTiyZhB6Vba51W4Bj3vyiqmbf0UlTzWhJceDM4=;
        b=jpj90J+mi3alSkUHWpaNbxJUQ4jR94UJtvnKeKNz3+kRmfDdaulmKRlF72D58VGAr7
         ky/uzXc+zUcsZI8+9/mOL+fK4Z6JrRQxR6KVNIDVpfhOU/ZZk0tMTuYNcFxZ+RaV+WLV
         FrkkRMquxaZy8aChvFBDIB/NGvYHqesb1TB/pR8n2wlFaNdNoo3RwDPUwLnOT9tfytNj
         7zCk45mtVTIY9gWE9bXUIR5c39EQIA0AsrP3sTmEDEU3nkrkcIP6/HbrUl5FSfgHDUbs
         c8XSvv2Ylsf3qDasFdAYWLzCx/IEPzpgqNg1Zc7mLBO3kYnq8UBUCFRE+htjVxDLTZv2
         lwew==
X-Gm-Message-State: AOJu0Yy6O//w1lPfZ5wjnD+gCQuadLlhYmMo0P5vavO/BrZeIuovzdqF
        Q8alv54hrjnSodVx0KEZjd1yPg==
X-Google-Smtp-Source: AGHT+IELhKUyC2Ck6DRpg9YZOxR7vxC4ZUjcUDDjABEw+6deoYPNnB//97RRqPn1xIXH1Cq1Cu/obA==
X-Received: by 2002:a05:6512:4013:b0:4fb:8771:e898 with SMTP id br19-20020a056512401300b004fb8771e898mr2355684lfb.15.1691680375326;
        Thu, 10 Aug 2023 08:12:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003fe29dc0ff2sm2416242wmi.21.2023.08.10.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 08:12:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/3] samsung: drivers for v6.6
Date:   Thu, 10 Aug 2023 17:12:48 +0200
Message-Id: <20230810151250.220202-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.6

for you to fetch changes up to eecff3319287179032600eeec5fa357a53ae0fe1:

  MAINTAINERS: mfd: Un-support Maxim and Samsung PMIC drivers (2023-07-28 10:39:41 +0200)

----------------------------------------------------------------
Samsung SoC driver changes for v6.6

Minor cleanup of headers and maintainer entries for Samsung SoC drivers.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      MAINTAINERS: samsung: Un-support cpuidle and clock drivers
      MAINTAINERS: mfd: Un-support Maxim and Samsung PMIC drivers

Rob Herring (1):
      soc: samsung: Explicitly include correct DT includes

 MAINTAINERS                         | 10 +++++-----
 drivers/soc/samsung/exynos-chipid.c |  1 -
 drivers/soc/samsung/exynos-pmu.c    |  2 +-
 drivers/soc/samsung/pm_domains.c    |  3 ++-
 4 files changed, 8 insertions(+), 8 deletions(-)
