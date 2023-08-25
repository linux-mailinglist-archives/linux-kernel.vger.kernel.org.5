Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1D788BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbjHYOfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343823AbjHYOfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:35:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CAD1FFA;
        Fri, 25 Aug 2023 07:35:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so1526371e87.1;
        Fri, 25 Aug 2023 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692974128; x=1693578928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=As3WpBwN84GV3HiC8Gn/35+z04ACfRVFYleEb0kw7gc=;
        b=byn136xZe9WNh4itpN3fR7fIUK0DEPSnKhH9T060BVPFq74asHHjWfKwqwdQI1d1UT
         XH6sIXQ72ZOa68ItbQflRgqb7Gv3kNnvWsMSvMSE4m4FFt2OShIm/3TyXmZdxCWczyk5
         W0v8nFL788jvqFybOHR4XUtTicrimw+S5Sj3UqgordUgyXzhhnQwZ12bIsjaeq/do0NY
         t5qesaHOUCH9NKtlHeqjWnTs5POIIjWsRJoJPl3kQZJDJXr4xzsB0Rq/nOd0k1PEpbf7
         sA/eddEyozymSbEhGg/t1RkKtMSmSFivTNfPBCobRAzZyGBQP3kV+ZiFTvCuTIiznfh2
         DkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692974128; x=1693578928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=As3WpBwN84GV3HiC8Gn/35+z04ACfRVFYleEb0kw7gc=;
        b=TNNsxsfslIa5nWXK1WdMcvAz83MsYI17v05mOU7YOQ18WwW7v9PBQqINptq3uqtgJK
         h6+kxnRb3RHUyhIRhatMKvCwojfnKYWM6rVe2vfieNyTjYjhifIbRoaFnKkVhXpNl5gv
         4uKUnD/zZGa0Q7UADsMKY1iGTtn+4XJi4A9ji4K92J+x02E4kUC48zQN4RRZ3iWWEoaU
         v3ObqZ9M1kcSlVmMcskvpizhHeV8nslhc0CdZbTgqXNziCMTB7FJZjcVCy4cpjwBA89u
         QHLLM67OohSAsTbpiWaWlzNP/Uv/jCawo4y75HHap3hXqhSSrjoW4DpYRJRCww31K1Gw
         fJpw==
X-Gm-Message-State: AOJu0Yw+3Ishi7wxlabVPFx6ApS+6lBxKu31S2s2PHVM/5tFvuAgDUDB
        DBCd5gnDa0F1EiD/LA5cWIlmef+h2Hrfija3vl4=
X-Google-Smtp-Source: AGHT+IEPbbB/U7qcrlqk0xzPL8EzjIDrygU1VBarOCjB2I/2aouHlNgJ/88UBDf54Q/Ror43bkdbJw==
X-Received: by 2002:a05:6512:2397:b0:4fb:8585:eefe with SMTP id c23-20020a056512239700b004fb8585eefemr19969494lfv.57.1692974127590;
        Fri, 25 Aug 2023 07:35:27 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id z1-20020ac25de1000000b004fddbd29457sm310118lfq.7.2023.08.25.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:35:26 -0700 (PDT)
From:   Sergey Khimich <serghox@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v1 0/1] mmc: sdhci-of-dwcmshc: Add CQE support
Date:   Fri, 25 Aug 2023 17:35:24 +0300
Message-Id: <20230825143525.869906-1-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is implementation of SDHCI CQE support for sdhci-of-dwcmshc driver.
For enabling CQE support just set 'supports-cqe' in your DevTree file
for appropriate mmc node.

Also, while implementing CQE support for the driver, I faced with a problem 
which I will describe below.
According to the IP block documentation CQE works only with "AMDA-2 only"
mode which is activated only with v4 mode enabled. I see in dwcmshc_probe()
function that v4 mode gets enabled only for 'sdhci_dwcmshc_bf3_pdata' platform data.

So my question is: is it correct to enable v4 mode for all platform data
if 'SDHCI_CAN_64BIT_V4' bit is set in hw?

Because I`m afraid that enabling v4 mode for some platforms could break
them down. On the other hand, if host controller says that it can do v4
(caps & SDHCI_CAN_64BIT_V4), lets do v4 or disable it manualy by some
quirk. Anyway - RFC.

Thanks in advance, Sergey.


Sergey Khimich (1):
  mmc: sdhci-of-dwcmshc: Add CQE support

 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 154 +++++++++++++++++++++++++++-
 2 files changed, 154 insertions(+), 1 deletion(-)

-- 
2.30.2

