Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7B77CDBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344651AbjJRMgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344518AbjJRMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:36:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D710F;
        Wed, 18 Oct 2023 05:35:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso10049875e9.0;
        Wed, 18 Oct 2023 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632557; x=1698237357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+z2DeuWbLpI7AEzz9he/oetq9pODDYK4Bo2MZwm1LlY=;
        b=kznUucxN6CW1QLdzL9Q9cLnndx4jBo8J/iAytD6q6kEyJCUN/o6yzcImP3lQvZ93ri
         9130pjTDDxhA0Q5Cxm+Im2vENF2tlQRlIEEYdsDcdcnI1+PNwAA/r7XtUbPHQqmGf9+J
         yMSsQ84WSU+imrHsKbuaRRtoBFyjJ0RX1sxpjJ1M+52XiguiPbfrmRZR410lKLkTO8Ni
         yNJp8gItC0nb3NFnfTS1WQluVdenO/nLWGbtybqpaCW6pZbpfXgFFPVCAOhU2f+DFZ6B
         FTk6y7xQ8V4wg5M3VcnALZTprrM7z6xZtexIGYpxRi7XKAXRoar85wb1T7TTXl+Ztp4C
         u/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632557; x=1698237357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+z2DeuWbLpI7AEzz9he/oetq9pODDYK4Bo2MZwm1LlY=;
        b=OwGgJ/iA//+hhTRhZxry9khxURYndmFIsZhV6sipskl/LaN2tt37N3T9w0NrbxV2J9
         sn8yqmN3kh0+3w4uMRkImNtEjNOMWDnKDmLzMYCJR+mrOP6hrm+3Amd2hbQVXyW4uHlf
         3bZYBz6WqBpISBCe7/unXn9Wm70DgMR7dFDIbM/2uMieiG8ApraHJUYnRZNDiAVa3V+U
         Saiu8w9pLl54kvv3shKnuKuSHpDX9A7BuYJCpYKUFj0+fs8A1uc0z722eAPc1kijb/88
         tNP6/CHRqkkTBJ3Y1npaP1BacHQDIAYJQExskQb8f8sqPKoX3pm3uCHALlT//ud1FRhb
         Moyw==
X-Gm-Message-State: AOJu0Ywy9/hXPi71bkDBwbcssCGNyBAbAe1lxwaMcVpVJ6jEDIB0equH
        CG2S/xDBHIwNIcbC99Va7kE=
X-Google-Smtp-Source: AGHT+IHi7O1ZsGGb+3ZGVPAoATB5PmPAZWxpAXGDGRKLUdLuB4yOu6xE3tV0+2ka93mWmWLL4vJhfw==
X-Received: by 2002:adf:9b95:0:b0:31f:fc9a:a03 with SMTP id d21-20020adf9b95000000b0031ffc9a0a03mr4367013wrc.20.1697632556892;
        Wed, 18 Oct 2023 05:35:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q28-20020adfab1c000000b003248a490e3asm2048211wrc.39.2023.10.18.05.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:35:56 -0700 (PDT)
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
Subject: [net-next PATCH v4 0/4] net: stmmac: improve tx timer logic
Date:   Wed, 18 Oct 2023 14:35:46 +0200
Message-Id: <20231018123550.27110-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Changes v4:
- Fix W=1 warning for missing define of pending_packets
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
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 40 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.c     |  2 +-
 include/linux/netdevice.h                     | 23 +++++++++++
 net/core/dev.c                                |  2 +-
 6 files changed, 59 insertions(+), 18 deletions(-)

-- 
2.40.1

