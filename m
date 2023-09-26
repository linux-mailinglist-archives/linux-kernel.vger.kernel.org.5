Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BA37AE891
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjIZJCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjIZJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:02:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D038DE;
        Tue, 26 Sep 2023 02:02:46 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c123eed8b2so137573331fa.0;
        Tue, 26 Sep 2023 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695718964; x=1696323764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+JhM+LLNrku/f6eElDwzC7/IyURkla8ZhpaB+WfkESg=;
        b=WLNd+v2pU1Tu7LOAhfljB/JhUwKEhJnRru6kd8yfBVuNI1++UhJigKFPKFiDMWPuro
         WQfQE7F5XnG2ZwXOLteXqbw/BLMSNcWqc2g3YDqY6H8NADKwNHcQQFyNtvopZNZnddoV
         sP1B8KHgW7Qp338l4cFqPGGyd4+xd+wVwfRJZuZIJD53lRWCXQCLrqjrE339ekmC4STq
         liwvEh6nNAJ4L7c0CysKH5JPYlNw+RXuxkpvWOxOVV/H8hspOBSJy0tvZdERK/atKD2D
         xxnvWKf504Q//6K9JThIxuSqPRpgpR/pzMOCmowo9gZzdCxLNoP62sal2CRJMeSU5AmI
         Wkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695718964; x=1696323764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JhM+LLNrku/f6eElDwzC7/IyURkla8ZhpaB+WfkESg=;
        b=j5R5W6t8HIDH1rBcdJLZHyyIuCaN8Jnm0RTpDftRrwJMpJPr0Ce/lC4ZTOmSKnjMFa
         z1R0BT9IT9esRvUwvxr1aYsXYAfh69HGQuxDH6lRdb6+VVESqsJqOqZSjaXD1IX55OpS
         8FYW21rjwVZbT8HHN3Oj7kBmLZwG4t5dPuRx8jJuOABOzADJEWPHg8pBunqTrieRAXp2
         MBpXGT4qGV3/x65HTo9xPN7ffVz/vKONw4/OQ51MloFjEvKqIS52ScWHHu29uSn0u/or
         7Ttb+gDSF7rPBra+tiP2Xs/6ov9aSb7xz+WvR3ZvmXQfP7GaZqnf1sYM4+HSFSHQz3T3
         ghZw==
X-Gm-Message-State: AOJu0YzedS6y2iuHZF2eWs+9jBSdPEFEqgpElPIYwWjZX3/zcV5Yyw7+
        jAcjROwsZfQ30ehgxb+eUWsj4lOVv4BE7wFb
X-Google-Smtp-Source: AGHT+IGoVku8i7CK4cqix3xEJNQOTp4BV1C9GFmep3SRLfyHh7eVJTIM2YNALVX5ta/jar3vDoerKA==
X-Received: by 2002:a2e:800c:0:b0:2bf:fbe7:67dd with SMTP id j12-20020a2e800c000000b002bffbe767ddmr8776200ljg.28.1695718964090;
        Tue, 26 Sep 2023 02:02:44 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id l12-20020a2e99cc000000b002bcedacd726sm2604353ljj.25.2023.09.26.02.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 02:02:43 -0700 (PDT)
From:   Sergey Khimich <serghox@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v2 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
Date:   Tue, 26 Sep 2023 12:02:40 +0300
Message-Id: <20230926090242.105020-1-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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


v2:
 - Added dwcmshc specific cqe_disable hook to prevent losing
   in-flight cmd when an ioctl is issued and cqe_disable is called;

 - Added processing 128Mb boundary for the host memory data buffer size
   and the data buffer. For implementing this processing an extra
   callback is added to the struct 'sdhci_ops'.

 - Fixed typo.


Thanks in advance, Sergey.


Sergey Khimich (2):
  mmc: cqhci: Add cqhci_set_tran_desc() callback
  Implement SDHCI CQE support for DesignWare SDHCI.

 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/cqhci-core.c       |   5 +
 drivers/mmc/host/cqhci.h            |   3 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 233 +++++++++++++++++++++++++++-
 4 files changed, 240 insertions(+), 2 deletions(-)

-- 
2.30.2

