Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94F97C93D7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjJNJac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 05:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 05:30:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6BBF;
        Sat, 14 Oct 2023 02:30:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso3039731fa.1;
        Sat, 14 Oct 2023 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697275827; x=1697880627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVgxHCn/B7V074W174vEDwqS68k37Kzh+EyWr5cIE3M=;
        b=a5n1L684NdmB7DzIzSgpOgLXdlAIAD+DND0RpDFATQCCm0pZlu4l+w/fkh9PwmLhQE
         7sDo0N02AbHWB3N9QxSIVfmspXdSgE6G/8b9F8iLsLJ3UFIWp1QLUv02Jcst+OpMSAG4
         aMxxk8ELPKHK/+aJ6qu3TjeyOofVkY6KnHboYNHqjE0CFuBmOyQriR+V91l8NX3SXUGz
         0Pkh8GrLdV7ErFw2uDlA137i7EF4gy2zJDUjJW1hN7QNm8hhDn9iGfS6Avthw3QAp/aq
         4sbw2COLWxaKnQDAikXwS6YoCBipqY0bys2rRALtmuGCB36KI3wdWVfRSg7gQaBYIqwu
         +uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697275827; x=1697880627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVgxHCn/B7V074W174vEDwqS68k37Kzh+EyWr5cIE3M=;
        b=jWHXB2moOXs647FzREq6X+Q22ajIoHfQ+ebmWTFvLTY3T9A4OwcAK0xVP3Em21DbAx
         uKgqAqzkEYmX3JGwZ0kztvVhbUvMf771PYSw3S/dV0OgRjwIMkLEAzCcyR5v4ooWbu0H
         2ykRZOGJCjufwju2px+TXLv92FHARrDN3LJLNrivMncWIZy+z2mGJCM9Y1F5BRXi8zxp
         c6ZiE63TOj7ZCd1tbtmI52LoeidLUKHQi0ONcHIvkD8WfDtx+Jdi9SG7a45CsZkhGT+3
         ZDyUnZSAbyD18J731WFCrqBDzw27sNVe970ZuVi6E5h0NUMJ4naagjjMXwb6DhlmGpN9
         /ECQ==
X-Gm-Message-State: AOJu0YxBaWs18i+rVY+E7HS5dpMk8vZs3UylVKw6Z5DanPamskOQF+O+
        eBW3tTi0vDrjYJvKvOiZpQg=
X-Google-Smtp-Source: AGHT+IGJJJQm7yfJhqss5S4XY8Bm6bfFs0fCEocRUTeiHfSNoKjAzN8d4DstSYgAxtzxjhfGDA7Lxg==
X-Received: by 2002:a05:6512:695:b0:503:28cb:c087 with SMTP id t21-20020a056512069500b0050328cbc087mr37064060lfe.29.1697275826447;
        Sat, 14 Oct 2023 02:30:26 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u12-20020adff88c000000b0032d9a1f2ec3sm3691564wrp.27.2023.10.14.02.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 02:30:26 -0700 (PDT)
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
Subject: [net-next PATCH v3 0/4] net: stmmac: improve tx timer logic
Date:   Sat, 14 Oct 2023 11:29:50 +0200
Message-Id: <20231014092954.1850-1-ansuelsmth@gmail.com>
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

Changes v3:
- Fix compilation error for missing comma
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

