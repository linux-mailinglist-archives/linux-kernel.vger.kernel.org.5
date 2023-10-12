Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1767C6A80
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbjJLKIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjJLKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:08:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665E0C6;
        Thu, 12 Oct 2023 03:08:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so736704f8f.3;
        Thu, 12 Oct 2023 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697105316; x=1697710116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T61YK6EFuEDV5qJWA4z7WzFbSG37tp0bqVIjSbOkXyE=;
        b=EfJRwDutfZmXSQa9iyd1ZNe0ahj28nmmBC5iAvGupVtHkw1kg5bAo6Bp4V7478Zba0
         Ev8Gd/WrIchg4m5oPX3YH54nVFyVhGBB6zckwwA9DZMqfeQSfjhO/qwXX0JTACfwV/Ao
         riAqWVzvjOYGClHxXjebnu3FExAWf1vGnxfxnxzaGJW0IYirSn/IApsFOzY+o9jx/tKf
         PxG3qE7HcuSiFOSzoS5kFyBV+pYOHkr3FSNsYG+GbDNh3siEhyfw4VfFkTFiHetxF2YW
         R+kqbMMKruwBoF4EaJ2zKK4k9cMWuZzaxEImdZiCCCHOHJDA0Nz7DufxI8n/l4gyvThh
         pPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105316; x=1697710116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T61YK6EFuEDV5qJWA4z7WzFbSG37tp0bqVIjSbOkXyE=;
        b=K5gdyqCEMD4zEMUuqa4vA6fBJdOUQ3xvtmC8rnbnXjP2wIpEcinz3FZipiBpoQLmyG
         UVutZWIiEPmpCrtEISafzirkKGzC5TgFph/HYM6BB8OBIcNuiyKfE9ZfkHc3SDQRJzSg
         qxHwy4oGXeRuWIjNHfYsKshtekmjTh9Gf9SjoPcfV+15vNgCRrJxWXiil7lr/ceFa5cu
         HNxthYxcFz/1TSkKGyXLKiJYlBM7cT0ToQNHh/m+3zhXGgYXKwLMznO9W6M4mH2bzAzU
         ElRFt31X5n4M2HYhTnUiboRoq0hLOpptAJTqZGP0wLdxoDgOFrvHsdVUGDiUCZ9h4Xno
         IWqA==
X-Gm-Message-State: AOJu0YxMlcXEoNIF2AYUB+bjK9OxQe3/GJzdyVtv1ftjdFeaq5Fz2k2P
        qH/gJ0uG7g1Iv7zXKU3N3v0=
X-Google-Smtp-Source: AGHT+IGY5/V2HmMll0R7ee8D+XKgPX1fVMvqjMxzETQE5YP729txcGhYLYxlO8b4P76nKez6ryZjLw==
X-Received: by 2002:a5d:6447:0:b0:31f:fb5d:96da with SMTP id d7-20020a5d6447000000b0031ffb5d96damr21560136wrw.64.1697105315533;
        Thu, 12 Oct 2023 03:08:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id dj16-20020a0560000b1000b003198a9d758dsm922737wrb.78.2023.10.12.03.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:08:35 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 0/4] net: stmmac: improve tx timer logic
Date:   Thu, 12 Oct 2023 12:04:55 +0200
Message-Id: <20231012100459.6158-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This series comes with the intention of restoring original performance
of stmmac on some router/device that used the stmmac driver to handle
gigabit traffic.

More info are present in patch 3. This cover letter is to show results
and improvements of the following change.

The move to hr_timer for tx timer and commit 8fce33317023 ("net: stmmac:
Rework coalesce timer and fix multi-queue races") caused big performance
regression on these kind of device.

This was observed on ipq806x that after kernel 4.19 couldn't handle
gigabit speed anymore.

The following series is currently applied and tested in OpenWrt SNAPSHOT
and have great performance increase. (the scenario is qca8k switch +
stmmac dwmac1000) Some good comparison can be found here [1].

The difference is from a swconfig scenario (where dsa tagging is not
used so very low CPU impact in handling traffic) and DSA scenario where
tagging is used and there is a minimal impact in the CPU. As can be
notice even with DSA in place we have better perf.

It was observed by other user that also SQM scenario with cake scheduler
were improved in the order of 100mbps (this scenario is CPU limited and
any increase of perf is caused by removing load on the CPU)

Been at least 15 days that this is in use without any complain or bug
reported about queue timeout. (was the case with v1 before the
additional patch was added, only appear on real world tests and not on
iperf tests)

[1] https://forum.openwrt.org/t/netgear-r7800-exploration-ipq8065-qca9984/285/3427?u=ansuel

Changes v2:
- Add patch to move tx timer arm outside tx clean.

Christian Marangi (4):
  net: introduce napi_is_scheduled helper
  net: stmmac: improve TX timer arm logic
  net: stmmac: move TX timer arm after DMA enable
  net: stmmac: increase TX coalesce timer to 5ms

 drivers/net/ethernet/chelsio/cxgb3/sge.c      |  8 ----
 drivers/net/ethernet/stmicro/stmmac/common.h  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.c     |  2 +-
 include/linux/netdevice.h                     | 23 ++++++++++++
 net/core/dev.c                                |  2 +-
 6 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.40.1

