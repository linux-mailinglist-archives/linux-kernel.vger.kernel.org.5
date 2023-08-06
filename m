Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8DD771526
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHFNHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHFNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:07:35 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861F19A7;
        Sun,  6 Aug 2023 06:07:33 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RJfr24qVTz9sZT;
        Sun,  6 Aug 2023 15:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/AP7UiU8qhdUXkhdNLxJOtFL/gExqBQUGjN0bV4ALI=;
        b=NENAiv+rv+bGTCS8/iJADXEEDcGEYw/IlD0GwW2bCoGqHzmz1qSJiHWBr8KhCcZ8inb7Nv
        gOB8O2gVpkgjP4veo/0trrRA55n7iJRBMGFZTQNJSo+LiC7RXOY3Y7el9aaJ2Q5K9ueCAZ
        GlrZ3Il5klGJBaiAazti/UA1eriTMslZdUkgFmBKnkLwo1eMTCNWqC4Mrh6vmztXuFrSDV
        y+jq0Nxoum0xEJ8hwe4ukEev0x8nmMtrRsjZRalyrY89K5C5PTS9m0+afUvJtp0FOiatUf
        P2LrbTbDVZJ4DKkOQUeyjmhmrfds3BzZYeRt/56nYhSMg1vDrpiA7mX4Fjh47Q==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:48 +0200
Subject: [PATCH v5 03/11] clk: sunxi-ng: a64: allow pll-mipi to set
 parent's rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-3-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=852; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=MYgMUXDylKq1ueF0/z4NSPOcrbzoRllAat6F65tgrPA=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sHnloZRzJuGt3lvpsh+p8RC+xhWEURHdKBN
 Cyakv5yFkeJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bBwAKCRCaaaIIlErT
 xx9TC/9IjZMxKzcUHZQpldwWSgz3YyRgiJUWBEb4yLsRg+uH495gGDtLLPm/VDHU4YJXV2cfNjj
 PtC0D3pvGs0GKCzkRdCAWkHGDd//slD27POHpv4LAl1b8veUjfYpClFR21LVRLFGsQsY7OVPjQc
 PpRBNX1MQK2zAOO0bOSAfnL9sYxmq7IyKzuDHgtlhZAitFa1aZGQ6k2gMYPfVNlb/Y5zNSBIUCe
 IJic5jNPoJriaJJ5UkHS/UFOPiLWSwH+5H16zSppXD/SlF5rCkDw9nPPTQyVSHp0MyTGZsgHd6a
 N5BRZ2pTtJFt1fxgpks5ngy0TX/NH9UHsVD9d59ao3oX74MYw7eMs2cmHE6ghFIY1OG807OriXn
 u+vY/ktseClX4tsg00Iu1yCow9wjLlTjYpRa140TQHhH88mGGEKz7BN9BdPVjnkG2ToetPdhaSI
 Lt9zP3qfirhiJAw4CeBRmbP9PzgAgbQv1WZDycyfT509/ElaLMrwSvm9E5I8l+VbukN6g=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nkm clock now supports setting the parent's rate. Utilize this
option to find the optimal rate for pll-mipi.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 41519185600a..a139a5c438d4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -179,7 +179,8 @@ static struct ccu_nkm pll_mipi_clk = {
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-					      &ccu_nkm_ops, CLK_SET_RATE_UNGATE),
+					      &ccu_nkm_ops,
+					      CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
 	},
 };
 

-- 
2.41.0

