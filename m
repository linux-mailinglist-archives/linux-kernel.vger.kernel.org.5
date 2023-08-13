Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59BE77A8B6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjHMQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjHMQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:04:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B121717;
        Sun, 13 Aug 2023 09:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A586365A;
        Sun, 13 Aug 2023 16:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D20C433C8;
        Sun, 13 Aug 2023 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942607;
        bh=FYW91m020kBBNeUmgboDzHpwcLT4wR5HvrIdu5ZOBZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAmCkPvmNayAEM30rNi8YWnjDImQI3EvGmMegAK9cQOIMlSwII76cT3w1uHoHq+qt
         QeSehZ535PMWftOrR/j66krK9HBVcX/GNFRIxs0CZAg2f5y+KGxywdHAQ7jhlKaMiF
         B5dz+ngNW6tp7Nxm/O5L1Ma6S/3Cv27m0yvsyVJTS1MxA8iAXLMHJWgReeXJAM8jhS
         Y7Gnc5ogrBT10l6UZ0pj/1JURaCem7egpAlcjYBqo+5biAenRusMtWOh/83AWxrTyc
         B4/uQEcQxB13n5ogWV3RVcoF005+u9O6zRkUDtqT4LEtgKvO/CUbwBoxIp102JQhn7
         /RsUu6ZElpYkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jane Jian <Jane.Jian@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, evan.quan@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, kenneth.feng@amd.com, Feifei.Xu@amd.com,
        candice.li@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 37/47] drm/amd/smu: use AverageGfxclkFrequency* to replace previous GFX Curr Clock
Date:   Sun, 13 Aug 2023 11:59:32 -0400
Message-Id: <20230813160006.1073695-37-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jane Jian <Jane.Jian@amd.com>

[ Upstream commit 4a37c55b859a69f429bfa7fab4fc43ee470b60ed ]

Report current GFX clock also from average clock value as the original
CurrClock data is not valid/accurate any more as per FW team

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index f7ac488a3da20..503e844baede2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1305,7 +1305,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_vclk1_frequency = metrics->AverageVclk1Frequency;
 	gpu_metrics->average_dclk1_frequency = metrics->AverageDclk1Frequency;
 
-	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_gfxclk = gpu_metrics->average_gfxclk_frequency;
 	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
 	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
 	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
-- 
2.40.1

