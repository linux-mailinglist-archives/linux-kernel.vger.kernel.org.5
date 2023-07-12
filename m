Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9770B750F84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjGLRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjGLRUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A71980;
        Wed, 12 Jul 2023 10:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 235586182C;
        Wed, 12 Jul 2023 17:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1086C433C8;
        Wed, 12 Jul 2023 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689182417;
        bh=3gPj2OLmTQiKQXAQaSmLuzHQbyixVTI9hSntm0pe89c=;
        h=From:Date:Subject:To:Cc:From;
        b=S/8oTBEQaVAolENbbe7Jf9UDWVskfQYIgG38pt/JjHUBsc5xLqN2jhbv2YJrJGuXL
         zHII+fYTNpd5+9TSUEdAJqt132sxqFvOyLhwPfsg5NK0oEU+D9MGjIjqWLak7Bo7LO
         +6/qU084uj6npi5eDboG6VpB214VFUxHHjQfkt0ZFfSZ0jprWmvFi22Zgk8vkxmSXJ
         apghrB6KVousvQl/aAxNU4sWQH7U0BunuKUqchg5nOofTCBQR/mi83z0DweuG33Ip4
         XUIcGBPV+HLTLzk+H+Cvxtvnm+JRHp1KEsAgK/M1hfFV/D9PCir67wEhCi02Sc6Bcj
         27Gvi5xX71cnQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 18:19:59 +0100
Subject: [PATCH] pinctrl: sunxi: Add some defensiveness for regulators
 array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-pinctrl-sunxi-boudns-v1-1-85f37de79b9f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL7grmQC/x3MMQqAMAxA0atIZgOtUopeRRzURg1IlEZFkN7d4
 viG/19QikwKbfFCpJuVd8mwZQHTOshCyCEbKlPVxluLB8t0xg31kodx3K8gio0bZxeGOhjvIKd
 HpJmff9v1KX06IFsyZgAAAA==
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3gPj2OLmTQiKQXAQaSmLuzHQbyixVTI9hSntm0pe89c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkruDOruL4nOFfNlPL6CqLv3/eOKtVcuXRUpj+b72M
 ISUrRpuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK7gzgAKCRAk1otyXVSH0L4jB/
 wMyfEW/O45XvRvUxKZxYqTo73x4AuL9rRWlESg7ixOG3fYoEUmsKI5eW3zmfmxl0w/dxt1Tf7LjcRm
 MJBOrT9UKa4Eqcgqt8muv27avkgpnx7ZOTAJHGAu4XQ78cx7xafEYrESk3AL4rRj0D397nVhUXkclQ
 YLPyvKUxjAeOOcSjZV8721BIdc9YbQmqVqXE8odc/Qx6n5rS2ill0LfVibKAliubIarNjTN3fQIN16
 ZNedeTo17S2IMEBEz40VAnfmqVlQtLrcYrdJcHfk6Of1Sk+zvrpCXzFNGqVDz6/Rc1yKUSLwx8Gd8l
 COLL69wcEODbn5HsDoh72IpGkaq6y4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sunxi pinctrl has a fixed size array it uses to store regulators used
in the driver. There is currently nothing that ensures that the number of
elements in the array is large enough to map the regulators defined by the
individual SoCs. While this is currently the case having an explicit check
in there will make life easier for anyone debugging memory issues that
manifest in the driver so let's add one.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 1dc1882cbdd7..1d1cd3d6d379 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -848,6 +848,9 @@ static int sunxi_pmx_request(struct pinctrl_dev *pctldev, unsigned offset)
 	char supply[16];
 	int ret;
 
+	if (WARN_ON_ONCE(bank_offset >= ARRAY_SIZE(pctl->regulators)))
+		return -EINVAL;
+
 	if (reg) {
 		refcount_inc(&s_reg->refcount);
 		return 0;

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230711-pinctrl-sunxi-boudns-95bf5da3d075

Best regards,
-- 
Mark Brown <broonie@kernel.org>

