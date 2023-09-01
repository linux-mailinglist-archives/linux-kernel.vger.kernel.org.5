Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD4D78FDFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349672AbjIANEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbjIANEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:04:40 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B539210F6;
        Fri,  1 Sep 2023 06:04:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id EF7731866782;
        Fri,  1 Sep 2023 16:04:22 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dad7jqbU_Blo; Fri,  1 Sep 2023 16:04:22 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 9E92A1865E84;
        Fri,  1 Sep 2023 16:04:22 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dpsgIrz02uZS; Fri,  1 Sep 2023 16:04:22 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.23])
        by mail.astralinux.ru (Postfix) with ESMTPSA id ADACD1866136;
        Fri,  1 Sep 2023 16:04:21 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] clk: cdce925: change condition in cdce925_clk_round_rate
Date:   Fri,  1 Sep 2023 16:03:59 +0300
Message-Id: <20230901130359.20561-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid division by zero add check if
divider is zero.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 19fbbbbcd3a3 ("Add TI CDCE925 I2C controlled clock synthesizer dri=
ver")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/clk/clk-cdce925.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 96ac90364847..d903cdc3ad7d 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -441,7 +441,7 @@ static long cdce925_clk_round_rate(struct clk_hw *hw,=
 unsigned long rate,
 	unsigned long l_parent_rate =3D *parent_rate;
 	u16 divider =3D cdce925_calc_divider(rate, l_parent_rate);
=20
-	if (l_parent_rate / divider !=3D rate) {
+	if (divider && l_parent_rate / divider !=3D rate) {
 		l_parent_rate =3D cdce925_clk_best_parent_rate(hw, rate);
 		divider =3D cdce925_calc_divider(rate, l_parent_rate);
 		*parent_rate =3D l_parent_rate;
--=20
2.30.2

