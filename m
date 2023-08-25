Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D4E787F58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjHYFhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjHYFhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:37:22 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D2F198E;
        Thu, 24 Aug 2023 22:37:19 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RX7xl3YrDz9sbM;
        Fri, 25 Aug 2023 07:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1692941835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtWNv86caywaEjwkohWs7vAaLBc1+BjOtBhmNdab+kQ=;
        b=LG9UBsKqOdgerrl9ZSTlYYJMPV7TR0xfA8XVmV5w0WgciQAtaR81Q7SkccExCNQ5PLrBjJ
        V93VXat6yB8Ox97X2rvzi2mGxyvAezSdAljZ0BqSK4fskRQwxOvp54t6NwrltIwWL9EAgy
        d4h4VJhgj2utNexNEHsa4XQrG3nwlFWHQDNsUl9C3jOovOlm88UDCJw0Ly3dnEV81aFTci
        a9ZqisdWAPR2iCBa/i8WJJZFPyOFufL8DOLzeQlaP802IkiF7++cpNopubYtRvE8uq2GwT
        yrN2/CRw3Xp/P8/D4/sh/AeXiCQus4HzQD948HRj81ddyYdhU1anXaWNo1xWAg==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Fri, 25 Aug 2023 07:36:38 +0200
Subject: [PATCH 2/3] clk: sunxi-ng: a64: keep rate of pll-mipi stable
 across parent rate changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-pll-mipi_keep_rate-v1-2-35bc43570730@oltmanns.dev>
References: <20230825-pll-mipi_keep_rate-v1-0-35bc43570730@oltmanns.dev>
In-Reply-To: <20230825-pll-mipi_keep_rate-v1-0-35bc43570730@oltmanns.dev>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Ondrej Jirman <x@xnux.eu>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=zvqbUzAjOYwvk01SnxhIMjoc57Uv6Z82bewdgKFVkGA=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk6D3/p5Vr8PmaxXx3YvNoCgTBhkxHsGUS++j05
 QkLFWRynMSJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZOg9/wAKCRCaaaIIlErT
 x6A8C/9laYi7uMdpPfGT4cEdfSPWzp/olospIp/RZ7V6kkvJgaNGwYq70JKvfZLou03/1Mq9Fkb
 f3v0knivK0Vb8eYtPwl0g94hJp5UcQqZAFL9nGqX8bKz54brnriMyI1tp2LhBT6mMwisSkfWVLJ
 zhy0ublVtldseV9rqWdyrNRnAnj72ycrFmZpcWabADZDrYY4XwziwFMfD8EMoxq0lsn06pSVpKv
 gcEif70O6HXzmle+IRwUI2twW1ann6RJgm7GqkU7BbmmOixFaQ/eDRjqRFTT2dnZblNcP1ceDKf
 rzY+udlH7xcBL5ZE63JubDUt4D2yg3Kx6GlHWBQ5rr5pM70D9oOEDyxTBZGX3/kNpPuy8oCzR+Z
 sAY+IrPCnrNvGiRgiE8FNMc9zEV5F32eWwpOqf7S63NQiSfDP6T72cmtup00nJ/2QaUL7ZCnsUt
 zWc5Cj3KvY1NgjWukfkTcRC+v60m0Z0cQIJ26Q2CMgevyriWW1r+toyPYhQDUMeJyIN1M=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RX7xl3YrDz9sbM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the clock rate of Allwinner A64's pll-mipi even when the parent
(pll-video0) changes its rate. This is required, to drive both an LCD
and HDMI display, because both have pll-video0 as an ancestor.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 8951ffc14ff5..d22094ce1d66 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -180,7 +180,8 @@ static struct ccu_nkm pll_mipi_clk = {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
 					      &ccu_nkm_ops,
-					      CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
+					      CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT |
+					      CLK_KEEP_RATE),
 		.features	= CCU_FEATURE_CLOSEST_RATE,
 	},
 };

-- 
2.41.0

