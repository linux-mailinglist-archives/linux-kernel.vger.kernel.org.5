Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E51787F56
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjHYFha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjHYFhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:37:18 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B00198E;
        Thu, 24 Aug 2023 22:37:14 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RX7xd5McCz9sVh;
        Fri, 25 Aug 2023 07:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1692941829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=raND4v3dGybD2pwR1R6rFbF7+8fbr2do4bPMeBjRsOY=;
        b=Buplbt0gjtUak1iEx+X+aMeOErM/LZGyp2nUpGKci865AOTJ6lqtJ58vjPGvevC45XWDBv
        7atvRWZhjKP38GAt9vSv3cARQbo48+a75Y0n0iR6Y71kj/i3fMGHSBijr71V5FSwER6GvI
        UwGNeF8KZ92YOb+P3NBxXdGHp8ZlAcMpeI/GbzuF8YK/1R6+mTXYHcE9L3bz+Rn+D/5H5f
        0/7bi9gVh3LCDvtTU/T1ZZbE2kFQTfkisvHrUtXLWJncLUFMgETTOjiXQnpjJeN9w4nW4o
        0Dt+W74guViHZQ6eZnmcgArZrTUVGGVJVGfBQYFVvKHS7xj6lZ7WYHcLoWS9mA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Subject: [PATCH 0/3] Make Allwinner A64's pll-mipi keep its rate when
 parent rate changes
Date:   Fri, 25 Aug 2023 07:36:36 +0200
Message-Id: <20230825-pll-mipi_keep_rate-v1-0-35bc43570730@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQ96GQC/x3MQQqAIBBA0avErBNMi6KrRIjYWENWohGBePek5
 Vv8nyBiIIwwVgkCPhTpOguaugKz6XNFRksxCC4kH0TLvHPsIE9qR/Qq6BsZ11LzRXZ9ayyU0Ae
 09P7Tac75A+BiGU1kAAAA
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
        Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2979; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=JMuBxwJiUoYL4s/aSZd2Q/iqhb52ZQ6LgFc8dVJKLuk=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk6D3/HKxkcw/h/IrlclfYMC+/z+GqQTlVuhUqD
 MptvmVeGQWJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZOg9/wAKCRCaaaIIlErT
 x8ztC/0ZU6MRcwRuNfK9kP6ePsAGRWZZmm956pntap0kH7VSYErzh7wAwehys3nBF54oR7os7xS
 UZMfWbC1/uH3vjweHxUa0xWZ/RZnhbWKPYNSx1y3olhtr3+a5+vJo3jCr7uECQp3ez3cG+oclJj
 FjQ2EPqe7V9vR2vlxSwU/cfJR9AsfQdB/DxpCvFngEBWqjxqBc3zvGzsI1CnrxE44gqE8LKpZUw
 jSBz+6gmNMiwkzdayL40xU2+ltHqTw5Z4nbK2cjKGm1I53WhZc8MQ2FUiwY8V4dfCYsPntLDXsM
 Eyk9OsGYa70V3FBBY9OJHXbgyBU+znhjRDRCC2KwXZ8noqUu2+tvzTE+wfKYCizMc/XwMdVHIG1
 gFSKQ2dPnBNH9kJhwknWqKVhlDF6kBfNlmahf9gNTiJo/gIhypxiPy8JmA1gIAUwe0GxRPaS7IP
 fTv2nVSj7YE+MreXv3mLY+/v8zZU6r0bGAjwqRtAmnysHnZVXf27Q8deGTngPPySCccvk=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RX7xd5McCz9sVh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to make the Allwinner A64's pll-mipi to keep its rate when
its parent's (pll-video0) rate changes. Keeping pll-mipi's rate is
required, to let the A64 drive both an LCD and HDMI display at the same
time, because both have pll-video0 as an ancestor.

PATCH 1 adds this functionality as a feature into the clk framework (new
flag: CLK_KEEP_RATE).

Cores that use this flag, store a rate as req_rate when it or one of its
descendants requests a new rate.

That rate is then restored in the clk_change_rate recursion, which walks
through the tree. It will reach the flagged core (e.g. pll-mipi) after
the parent's rate (e.g. pll-video0) has already been set to the new
rate. It will then call determine_rate (which requests the parent's
current, i.e. new, rate) to determine a rate that is close to the
flagged core's previous rate. Afterward it will re-calculate the rates
for the flagged core's subtree.

PATCH 2 & 3 demonstrate how the new flag can be used for A64's pll-mipi.
By setting this flag, it is no longer required to get an exclusive lock
when setting tcon0's rate, because the rate will be restored when its
parent's (pll-mipi) rate is restored.

This work is inspired by an out-of-tree patchset [1] [2] [3].
Unfortunately, the patchset uses clk_set_rate() in a notifier callback,
which the following comment on clk_notifier_register() forbids: "The
callbacks associated with the notifier must not re-enter into the clk
framework by calling any top-level clk APIs." [4] Furthermore, that
out-of-tree patchset no longer works with the current linux-next,
because setting pll-mipi is now also resetting pll-video0 [5].

Thank you for considering this contribution,
  Frank

[1] https://github.com/megous/linux/commit/4124e115de82797f604808aaa5caad4512a9a1ed
[2] https://github.com/megous/linux/commit/edc93fd70ee759fd989664fcb85996cb48a006e6
[3] https://github.com/megous/linux/commit/40f5fc5b08b21142931662147d039ec217c9ba2f
[4] https://elixir.bootlin.com/linux/v6.4.11/source/drivers/clk/clk.c#L4578
[5] https://lore.kernel.org/linux-kernel/20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev/

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
Frank Oltmanns (2):
      clk: keep clock rate when parent rate changes
      clk: sunxi-ng: a64: keep rate of pll-mipi stable across parent rate changes

Icenowy Zheng (1):
      drm/sun4i: tcon: parent keeps TCON0 clock stable on A64

 drivers/clk/clk.c                     | 48 ++++++++++++++++++++++++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c |  3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c    | 15 +++++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h    |  1 +
 include/linux/clk-provider.h          |  2 ++
 5 files changed, 65 insertions(+), 4 deletions(-)
---
base-commit: c539c5c0a7ccafe7169c02564cceeb50317b540b
change-id: 20230824-pll-mipi_keep_rate-0a3a0d3574cf

Best regards,
-- 
Frank Oltmanns <frank@oltmanns.dev>

