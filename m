Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9351978CCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbjH2TbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbjH2Taw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:30:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C48DCC2;
        Tue, 29 Aug 2023 12:30:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so6641925a12.1;
        Tue, 29 Aug 2023 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693337429; x=1693942229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0chbqgFoPu5hLjZ0pYy8BZSRXOqFZISxsKn/hfcspos=;
        b=c1sCNlmNyVG0LRQkCmOTH1fpys80OK0w9aOJmZd1coOP7IUqUefe8WIQ5ftMZkchO0
         d0KZCZi1Lv8ol56gy8uYGItO6CB3DdtH6KUNVFuX4BbRritwTQ4+Kbp3/khKdTp4sO6h
         rA8aent812GfIyOlT94Gtvm4IQaeqj7HjPv1aoaxk59N/RfEzUx0Yjiv2tiFuOq10x8K
         xSpD8R/ONP+dHxAnYCvgDn8hRo/f781PmyKX5c9OjxZZAHHrdCcCAVcqMVKfhY4vgpOh
         18m/MP38w9tWL6yGRpzc7KjzDNR+bCbbUdtNoJeyxfOWdZOPcUluxH5Jxnf3Bu1D7Pcx
         nhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337429; x=1693942229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0chbqgFoPu5hLjZ0pYy8BZSRXOqFZISxsKn/hfcspos=;
        b=gs2P8L6+np0I5SbB/oEVwdBRKs1q3gM+lufyQkYOPCbI6NKDBmxP+PCn4EgXt9GsA7
         2EQC8uGQKtlG2M1OryDtUV4pKl5rq2B38B8jD5mdO85t1bjO/jKZlfB63gOyNvyHO7yL
         oQv4s1gfjeRVanhoGl5ig6Cj/+zejO8WghLc8VWJXrfvTnbG2aaKwoEDU4nH9NHD2bZX
         Nn2jzsXybZRKbrEZ+DadPm9JwKLkV1CKfSlMnThGJhQa5mpmEw/JzKftxtMyDlFiqRhz
         FAAOCcPXk8xKv+LX+gWtEBEpwOJwTJDr/22XgWY/bUSPZbgK7TUsGWnOm16zgJCx2dE7
         PXKg==
X-Gm-Message-State: AOJu0Yzpwjk++H/9euCQvdkSfIBaBOYgAWqfEvhYJXzVYvQdOcS1UYZr
        LTni0qT6Y6Pc3ajZkvr8bw==
X-Google-Smtp-Source: AGHT+IFbukdtCFqmx093H961k5MnnZnzYaMmsA3mx5tW40xU76zRBR/svCJyduxqu9zd0ofIyZWGvw==
X-Received: by 2002:a05:6402:1288:b0:523:264e:eee3 with SMTP id w8-20020a056402128800b00523264eeee3mr214521edv.11.1693337428981;
        Tue, 29 Aug 2023 12:30:28 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7d3c8000000b0052544bca116sm5940902edr.13.2023.08.29.12.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:30:28 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 0/3] Some clock driver fixes for RK3128
Date:   Tue, 29 Aug 2023 21:29:55 +0200
Message-ID: <20230829192958.250248-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
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

This series fixes some clock definitions in the clock driver for RK3128.

Please see the commit messages of the individual patches for details.

Note:
These patches have been part of the pretty huge RK3128 fix-up series [0]
which I've spitted up now, as suggested.

[0] https://lore.kernel.org/linux-rockchip/20230829171647.187787-1-knaerzche@gmail.com

Alex Bee (1):
  clk: rockchip: rk3128: Fix SCLK_SDMMC's clock name

Finley Xiao (2):
  clk: rockchip: rk3128: Fix aclk_peri_src parent
  clk: rockchip: rk3128: Fix hclk_otg gate

 drivers/clk/rockchip/clk-rk3128.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
2.42.0

