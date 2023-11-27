Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28BF7F9C40
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjK0JEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0JEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:04:37 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F94111
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a0064353af8so967283566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701075881; x=1701680681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rn3FqN0gmZL0Ari6o42HZwHfSuSPYS/sbuJSeG1c90A=;
        b=iZsU6h/HsVq3YS2w4Nj4fMq137jbfL1HGWcW7eD+HSMg6KGqUGF7+p4FROQSJVE7Ui
         p9bhJ/c9gTwZuRcTx2J5A5bU6+cZguvvK2YjYnQO9vufsbsg8rpc9Jtla3wVlCLuNBpW
         NM8rcK6Yp9h19/SkTk1Em/51RW733LoG5CTMd9ssFlAK7f8vI+1Y7ZDSOO7zIl/WnNYk
         nGbKvAnCDrKG11Y5nZqClFz3KpyGxMY2cJ9slB5YKWsLdhSR3VrYy4ilX/+yC6HtKfax
         DFrhVcszV2ICPejkiZAq87DGCjPBX+bi+/bo1OA46DN6PHtfxm5Q2oJZS0n++lzU7zuV
         guNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075881; x=1701680681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rn3FqN0gmZL0Ari6o42HZwHfSuSPYS/sbuJSeG1c90A=;
        b=OrtZYY0hxAtNuwSZoRq1SmeG2lSREE2QSWxcSgCtgkpuP9hAdWgrgjQYJt1ZuAxhZh
         gmgH5Suuq4sGqflqH+UK4CHIK0t+SaI8ul8E7JXTznE1x5vZq8X0WsCqzbTUgGefj9xR
         fI7jA1gMvoJVlFQ5wljcDffHzpnG9gckpqD5cB+3DeOImKWZctXy1chzWuXcNA/0h1XQ
         TgBtUVOMK/Zhg09dR3+fKupwYVR7WYCEz5KzvDSIpd5kJlDGGC2WW/SYBU6VkxqHlwaf
         s3CAVlAmBPBzMtuCt9eSMAKn5CKV6uU0Qhy++mMEEM11+QCLUz2KKa3PWS0bYNiM9nHq
         8P9Q==
X-Gm-Message-State: AOJu0Yxsy3oAslceHAF2zPIiqHDOA2yO2xZq7blvq6LQYYqwqL48YarT
        9uuLEdxWmnO+WAJveMY9VQGQcg==
X-Google-Smtp-Source: AGHT+IFufwrQhoJGAA86CiHpYk2HWGHa6HKsgjsjfk1ABg3nn/EADfsaGSESbFlko4QIO5GKSmIpWA==
X-Received: by 2002:a17:906:49:b0:a0d:fcfb:aa33 with SMTP id 9-20020a170906004900b00a0dfcfbaa33mr3221731ejg.9.1701075880653;
        Mon, 27 Nov 2023 01:04:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id ay14-20020a170906d28e00b009fad1dfe472sm5456539ejb.153.2023.11.27.01.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:04:40 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        robh@kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/6] net: ravb: Fixes for the ravb driver
Date:   Mon, 27 Nov 2023 11:04:20 +0200
Message-Id: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds some fixes for ravb driver. Patches in this series
were initilly part of series at [1].

Changes since [1]:
- addressed review comments
- added patch 6/6

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (6):
  net: ravb: Check return value of reset_control_deassert()
  net: ravb: Use pm_runtime_resume_and_get()
  net: ravb: Make write access to CXR35 first before accessing other
    EMAC registers
  net: ravb: Start TX queues after HW initialization succeeded
  net: ravb: Stop DMA in case of failures on ravb_open()
  net: ravb: Keep reverse order of operations in ravb_remove()

 drivers/net/ethernet/renesas/ravb_main.c | 58 ++++++++++++++----------
 1 file changed, 35 insertions(+), 23 deletions(-)

-- 
2.39.2

