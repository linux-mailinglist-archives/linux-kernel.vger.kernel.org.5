Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65576E80F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbjHCMQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbjHCMQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:16:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF5B1;
        Thu,  3 Aug 2023 05:16:25 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 06090EEA;
        Thu,  3 Aug 2023 14:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691064918;
        bh=X/zAB0Jj0qtm9fUujGG3j4YnlOSerudhleIY+ZFE7Pk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pDakRJGS/sF3EpPJcPIuJYXGMRiWHbk47Puxtkb+cID4P0jbPwXt+fCWVbVM99tDd
         zrcb22Zcbs+nG8/mXPTqdZIksgQswYnA1o6yP3mB2EYFcvqsL7tNF5bIt30Dyu2T3O
         afAsozyQqTDxm5oQniH+C0rxCdRjOLlES7PuwntM=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 03 Aug 2023 15:15:47 +0300
Subject: [PATCH v2 3/3] media: i2c: ds90ub960: Fix PLL config for 1200 MHz
 CSI rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-ub9xx-uninit-vars-v2-3-512570ecb798@ideasonboard.com>
References: <20230803-ub9xx-uninit-vars-v2-0-512570ecb798@ideasonboard.com>
In-Reply-To: <20230803-ub9xx-uninit-vars-v2-0-512570ecb798@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=958;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=X/zAB0Jj0qtm9fUujGG3j4YnlOSerudhleIY+ZFE7Pk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBky5qTlwogM7bSwQkRLy7uH14HFuTygXBUZ/UFm
 RoihrGzwX+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMuakwAKCRD6PaqMvJYe
 9WjID/sEMMwT0p0hDZLH8aL8mh3obRi+owyf43NC174eD0THUq+pyJoTCff0+maEGVri/JvL+EA
 V3NfvuysUJnQ9hbw/iNVqrEAcoRH9nbfePhp919njbqbYOEb5hTN3BdrFPpWvuOsxBdM6e/ub3J
 o/kSPmhgBAv7aS+CnxUHq3gkVBgVXrVasIhrq7VugEBbmZosK1iAvkaRixzSVbjsvqkA0lI8+yD
 BHGasMrR/bZtrk5OEvmNzNPOeNluC4HQxx3bCdKjqZUnYsXb9bZLrP7+C4xmuh+C4kw5Ia3qo2s
 Dm6MBemKuiDkOCj5bD7yPkKowOQP2eFWjYZfMMb0fFwIk8sVgFh3YKPNWHOvztH97vHjafH721o
 j5N8b1KW84wyOqTn0LxxueJOlJVIyWsdhkBS+UrMb6D+igCesY0R1CYR6wqI8AaJDuBL/DZHPe8
 54X+JVz3D8Vxp0ccGUArl+pHIH/7jbZjET9TOK/2Cd50PGzNNhJ1IvHhzpgh4RQUEoxer8fDxI8
 UGhfZQWAU15ryf/qsRFCfqXSj7RV+1TjyEw3DGmZeIcOwLzcPqDxjRNsvq6TAVfSh7i5t0xPh4W
 Rhsef5JJjz1NyJ8z4IUWXs/qfaJzCuDEPq4ryeN9Rwwxy8UbImfWQKpQhGxMj2vyoLJGU9XkY+Z
 6ujGJUociowXRIw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports:

drivers/media/i2c/ds90ub960.c:1788 ub960_init_tx_ports() error: uninitialized symbol 'pll_div'.

This is caused by 'pll_div' not being set for 1200 MHz CSI rate. Set the
'pll_div' correctly.

Fixes: afe267f2d368 ("media: i2c: add DS90UB960 driver")
Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Closes: https://lore.kernel.org/all/8d6daeb1-b62a-bbb2-b840-8759c84f2085@xs4all.nl/
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/i2c/ds90ub960.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index 4833b39b9178..4ab45e326d80 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -1763,6 +1763,7 @@ static int ub960_init_tx_ports(struct ub960_data *priv)
 		break;
 	case MHZ(1200):
 		speed_select = 1;
+		pll_div = 0x18;
 		break;
 	case MHZ(800):
 		speed_select = 2;

-- 
2.34.1

