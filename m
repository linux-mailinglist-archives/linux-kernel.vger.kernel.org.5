Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EDF75C711
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGUMqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGUMql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:46:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9664F10CB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:46:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b89600a37fso12208265ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689943600; x=1690548400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zQgah8l1vKz74ZiyPPiZTC9+SEnB68j607ayO7edRA=;
        b=EkR48rlCylKbWRyFGflFdiqz4VIXbJ7CclwjpysY78JPhboowbWw+4rpIoQ9EOPWIY
         fM6cR/amj4Tk3yZRF4YEaXw7CpzYUaKus3T13xcAwdlX27Kou9JDn07P9ziFxSikGvNP
         otmr58g46bhRm2e/7nal98SnDUsxCdvk61luPL2Q2mgg0PdD3UZ7qL4L9088RabwNQZt
         r28hrukJyebHETVTr3mYywphyQqEYyRRsbMiZBL4zMpV5TneC4icWDb0i/sOoPrECc7P
         PKswr+06l25z8TAS31OVBm+SvsxK9nIltz1o4PQFp8vCO/cBUura6C8eJxFhmSU/8PVM
         oFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943600; x=1690548400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zQgah8l1vKz74ZiyPPiZTC9+SEnB68j607ayO7edRA=;
        b=craS0XqjhOfqc2O1V/w3mBNrD1Bv1HlpvuPbVR58H7GbTj1fvW8P4GOjsD8AlamB16
         KByTEhfoBeS297W/qJSFzKovB+SR0yQN1YkZtoEBV7tAunc/jjxYyr/bjtttwZqcvdJp
         YlFuaddV79sw3s91ekHgJFckvAyu/k6daObRWTEphNY6wydXjtkxIc/iSpINJEigxjUl
         lQrMwFvIDSheeAtJrnDz0G3UhsKQZkJBoir6dEONfgiw8Thfvx2+00/zeOWWbjalWmCg
         85AG+Qxb2pkzSOr0mNMlHEcZmxqA0UYscBsh9g/1XWiIkS9YKcYDV0GdATKMeuBLWSic
         02Uw==
X-Gm-Message-State: ABy/qLYinQTwuX6IPwcIn2nkE6RkJtNb4fO6ZTiU6P2Oh0tioRBxKv22
        7ZLQMi5XU7tFzlg4fWiSRTGg
X-Google-Smtp-Source: APBJJlF9JdPD5C4imn3/JC07LHYN8fPCwKjzTPD9OhuV0sgWEIRjyjoaQDYqpNMs1s4AwAldwbJb3g==
X-Received: by 2002:a17:902:cec3:b0:1b8:59f0:c748 with SMTP id d3-20020a170902cec300b001b859f0c748mr1683432plg.2.1689943600114;
        Fri, 21 Jul 2023 05:46:40 -0700 (PDT)
Received: from localhost.localdomain ([117.206.118.181])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001bb3dac1577sm3385540plj.95.2023.07.21.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:46:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] OPP: Couple of smatch warning fixes
Date:   Fri, 21 Jul 2023 18:15:41 +0530
Message-Id: <20230721124543.63520-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

This series has a couple of fixes spotted by smatch tool in the OPP core.
This is on top of v6.5-rc1, so could be merged separately.

- Mani

Manivannan Sadhasivam (2):
  OPP: Fix potential null ptr dereference in
    dev_pm_opp_get_required_pstate()
  OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()

 drivers/opp/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.25.1

