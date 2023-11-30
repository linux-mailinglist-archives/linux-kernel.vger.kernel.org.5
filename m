Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F887FEDDC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345149AbjK3L37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbjK3L3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:29:42 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07381736
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:29:31 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9cb021d5bso6284481fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701343770; x=1701948570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7b0ctZB3CE38lmBqwtgKLVcx66/DGir1aEMPMaEabH0=;
        b=xrqFx3vg3Ibx4bpkv7/4/C1d1Dt0mS7SqaOnUHzLukJ2OzMaxnyARUQInMuncrHi0K
         bw/8tSG2M7dnbay1ZXEWWD9jrYFH07aFyMxb0iyai8XN8gHbkisDQm4CSaFMgA+NF/hp
         JG04UEpy92iabPWXEE29rGH0crCv2eZ4WeAhNVloEjAvVTMjv3+eh/s3wmInwlc1lmUq
         C8Q1rPsal2DemFMDE9R5J4tjnBLfntvML/nRfrFZPw7lV0W9ujyY/M3+5c+jQgjtPwS1
         REvrWSt7Aw/5q8Zdk5xQYHDV6QUMJxDYCPJuwpjRwtYlwzj15DgYq9Y3OLCQkHddTwRb
         XxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343770; x=1701948570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7b0ctZB3CE38lmBqwtgKLVcx66/DGir1aEMPMaEabH0=;
        b=JPUVPAZluvSX6YtOOkeU00F2yuRPRKvXFbW7d37jh7K0I6HBuOArU8Yk+Vjnnx+pu/
         DVf+NmxuVkwhnZwwWhxWgJkMlx9Rw39cQ0FtVKDMkZVv7qgkj+S/yWj7RJqZy0hyNqBv
         cUuVU2xtxNuADiaqAlC2Uf3x5PwaF0D78qE9cM4IHUnT2p1tVWvdn3RtANjEkHOAAgEK
         x5DvEmQHr7gIUy03/iZyC8+eLklGflMz5sYC/+Oxq/6EtMKSJXbFs/IM3Lo0825h95mf
         4jPea13C6yoE0iB9TjrKf1L3IbBk6Z1azZISukp04EydC0nMYAwETNWgKoUwIlOk1BTm
         RLIA==
X-Gm-Message-State: AOJu0YyLJ0xwh+aDDFrIcOvNQ4bgQJpl9Ri6P3c/mYc87D7wuF4LDdQW
        1PKaSa6O7KyIoqpz0xqxoXNDcQ==
X-Google-Smtp-Source: AGHT+IH6IbA/kyxQtBUcbHuHxAbxWUMG9Zg32mPrWbotuU2rIkBPL9Lmpdf737cOWxT8yoLNLJ/fEA==
X-Received: by 2002:a2e:9e55:0:b0:2c9:cf5d:af56 with SMTP id g21-20020a2e9e55000000b002c9cf5daf56mr714828ljk.31.1701343769906;
        Thu, 30 Nov 2023 03:29:29 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e6a0f000000b002c871393f61sm118960ljc.72.2023.11.30.03.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:29:29 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.7-rc4
Date:   Thu, 30 Nov 2023 12:29:28 +0100
Message-Id: <20231130112928.64992-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a pmdomain fix intended for v6.7-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.7-rc2

for you to fetch changes up to 0cb19e50a911aaadf49eed120392e429d6e1fa0c:

  pmdomain: arm: Avoid polling for scmi_perf_domain (2023-11-27 16:28:20 +0100)

----------------------------------------------------------------
 - arm: Avoid polling for the scmi_perf_domain

----------------------------------------------------------------
Ulf Hansson (1):
      pmdomain: arm: Avoid polling for scmi_perf_domain

 drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
