Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167027FB383
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjK1IEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbjK1IEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:04:38 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79888B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:43 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9b5e50c1fso2819971fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701158682; x=1701763482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GaCi7MNIPGT9+tD1rM21toDEAvF+iDVLhsRo7ZOX2i4=;
        b=U+csMIZujBDPysW/zmszUJjRh4s0vrfg9Kx/9rW/o3+h46v4hR0riLxhqHDAOfn/5x
         z+5usbueUC0ZqL5CfKctquJoMOJaKzBjEJlaXEVxwJSQtWu7MQX87TMi9kz4e32Yshn1
         zBQnWxR98fPJsJ/omGh5cEcF7QeJJ+Si4YbQQM/ZA8CBc6NsWmY/mztGuo3LV6dkHgCL
         Gw3nTKzYiwaXEYxTIjm71J+ZW7nOHppzwQOjYCTDujOfyMG7lGEpBsJTSkn0ZtH6hBqp
         M5hKvljo9Xxh6e2pq75egmc8Z4RSLiJ7fF5tnux+doCNwcCZ0zPi1zKZT6RGmQ83ZBxm
         9OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158682; x=1701763482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaCi7MNIPGT9+tD1rM21toDEAvF+iDVLhsRo7ZOX2i4=;
        b=UnEmNblaWTO91fn0ziEmC7ETwo7+lY5ivmXjs9NY49TY3zbqIzrVaNnhHjqWnjDb0v
         T6PWI/UsCaZrVmEe4+BftG3gJt+yNUB0Kum4jqIkU1S3DzzdFsqQWxGpvSyQrAisVhPD
         uV2dzm5fakH8xjow1FNpOIx3UPjWcsmjowOAkjqk3lUtXYGdahNUot1B4pE1DPFQVWyV
         l7vE+NYt/KeHMtMj0kT1nyXVj0BesdSXQZclg/3libZ8m//6Ux0aUe0M20pmnBEcQddl
         Qz8ac9/RRZ3LL9DQkcX1n6pdrM8Z1oIUWznTz3TfdYuUrk/l8ddZkBJSNGyvMj6x0z6m
         DrFQ==
X-Gm-Message-State: AOJu0Yx/JIcG823ixPbCC+S9SlUNWyONTZatYW/xAgg6lypVJQzSxElJ
        Th8dmIZl+Ecpdx3ErxkDXuU7Qw==
X-Google-Smtp-Source: AGHT+IFupqCloqdm4FE8Tx5uAcS4dvEx98WbGIFZN7Av0v5UdK2HaqKN22m3rm9Y1YXwBSX0CyEHVw==
X-Received: by 2002:a2e:9c92:0:b0:2c0:21b6:e82e with SMTP id x18-20020a2e9c92000000b002c021b6e82emr9739886lji.4.1701158681562;
        Tue, 28 Nov 2023 00:04:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm1127534wmq.2.2023.11.28.00.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:04:41 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        renesas@sang-engineering.com, robh@kernel.org,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] net: ravb: Fixes for the ravb driver
Date:   Tue, 28 Nov 2023 10:04:33 +0200
Message-Id: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds some fixes for ravb driver. Patches in this series
were initilly part of series at [1].

Changes in v2:
- in description of patch 1/6 documented the addition of
  out_free_netdev goto label
- collected tags
- s/out_runtime_disable/out_rpm_disable in patch 2/6
- fixed typos in description of patch 6/6

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

