Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A9F76F83F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjHDDLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHDDKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:10:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63BE5B94
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:07:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe11652b64so2718514e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 20:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691118466; x=1691723266;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d8AfrAY2ZGogCZnT9pjHagxUiEJXfq8HDQdgAefjNa0=;
        b=YGRo1eUfG9G7kRGOEjZ+7NoTA4rrjEDVVR+TetxIZiZZa5VsGyi9CTmIW93z7HHM2Q
         MEcDwbZ3EIdulRzTK9HB5kFoqsnvo6Q28KCv+pFiWzzFAS8oyC5/Fz9Pq5fwPy1bXM6O
         Sbakd4AHZxedXK7An7OslMvpfKEBcQxeaxTmuzvet/FZN5r8RhYMfju6SrEbC3/NweIF
         CG5vbsquWWnEdg3TMFM6PuMz83aHQGe9H9RJyTlbjrxV7tk14odjWDTtHk+/R5gNSTlK
         q8noRZF4JU6i2c4jot2r5L4JmUDNwRjKh3o/bx+I3z5g1uAtbcdfyE7OxzAftgA/WKJH
         4SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691118466; x=1691723266;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8AfrAY2ZGogCZnT9pjHagxUiEJXfq8HDQdgAefjNa0=;
        b=V/pyKboIuGbDEbclsoBx4hd2AzFwVc5VglAslIVQXNnxzFnbAe0ruIJ2WoDrdrbq25
         W//AAY2TdXeyI0UiMrJM+w5RiL3wZ+9//lmwTjnpgYSJLtX043x5RYXOykjg8ZR7M8bU
         QE02sfZilQc/4SFVoQlp1va7fGvL6N+L7d2IUl1m2X3Ssrb5JLlSfxK/KJXg0fmhq2Vc
         fczQWIZ7hNPvouXTR3TY4zmHebER7WX7tUE7qvRGr1D68zsih6kxNdNke2nTsvIcx8aR
         NpfK32OFD9jePlxO3GgcSV99sGVu7ItbJo7mWLm491L0BNE1JeZuBe7JJjOIaae+RgBq
         J2eg==
X-Gm-Message-State: AOJu0YzHF+5WgVhvoywBNjpqo14p/fitgmkpYFKOVHorWrBf/o4p/541
        Rks/OH4VvFwxRu6ZG7DEledxQ5Nd50a93Lqlr65E
X-Google-Smtp-Source: AGHT+IEqNunxQUqBpOT9oFHZJRvMLIfY+kP6NYcf4dY3x9ci1li3qv1UVhkhpZD5GfPLyxsn6u1BdIqwlGVGGd2bug8=
X-Received: by 2002:ac2:4242:0:b0:4f8:5d0f:c779 with SMTP id
 m2-20020ac24242000000b004f85d0fc779mr285207lfl.40.1691118466227; Thu, 03 Aug
 2023 20:07:46 -0700 (PDT)
MIME-Version: 1.0
From:   Da Xue <da@libre.computer>
Date:   Thu, 3 Aug 2023 23:07:34 -0400
Message-ID: <CACqvRUZRyXTVQyy9bUviQZ+_moLQBjPc6nin_NQC+CJ37yNnLw@mail.gmail.com>
Subject: [PATCH] net: phy: meson-gxl: implement meson_gxl_phy_resume()
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After suspend and resume, the meson GXL internal PHY config needs to
be initialized again or the carrier cannot be found.

Signed-off-by: Luke Lu <luke.lu@libre.computer>
Reviewed-by: Da Xue <da@libre.computer>

---
 drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index bb9b33b6b..c4a07e6f7 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device *phydev)
  return 0;
 }

+static int meson_gxl_phy_resume(struct phy_device *phydev)
+{
+ int ret;
+
+ phy_clear_bits(phydev, MII_BMCR, BMCR_PDOWN);
+ ret = meson_gxl_config_init(phydev);
+ if (ret)
+ return ret;
+
+ return 0;
+}
+
 /* This function is provided to cope with the possible failures of this phy
  * during aneg process. When aneg fails, the PHY reports that aneg is done
  * but the value found in MII_LPA is wrong:
@@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] = {
  .config_intr = smsc_phy_config_intr,
  .handle_interrupt = smsc_phy_handle_interrupt,
  .suspend        = genphy_suspend,
- .resume         = genphy_resume,
+ .resume         = meson_gxl_phy_resume,
  .read_mmd = genphy_read_mmd_unsupported,
  .write_mmd = genphy_write_mmd_unsupported,
  }, {
--
2.39.2
