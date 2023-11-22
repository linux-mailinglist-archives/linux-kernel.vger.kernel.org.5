Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE217F4B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbjKVPvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjKVPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:50:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1C10EB;
        Wed, 22 Nov 2023 07:50:30 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6167A276;
        Wed, 22 Nov 2023 16:49:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700668197;
        bh=uilUL/CQsGPrrLqlIQUCAs9mt6Z3Ge5A5dVOnCwLOH8=;
        h=From:Subject:Date:To:Cc:From;
        b=pKEFlqZ6tZyPJKdJPQ2vpW0utUX81Kc4bcsr5Q7jTyzuRrN5ENrYrZoYWg4RPNx7m
         qk+N6xUD+YulmxPAPSqMJ0pwXluuvSc/KHK1evbW+B4mAZwMZiRPa+un+SpKCotjZ2
         rGI5QAYRrDe3Ephui0Z3EhxkI1qA1BpaZaFsRWfE=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/2] media: rkisp1: Fix memory leaks
Date:   Wed, 22 Nov 2023 17:50:06 +0200
Message-Id: <20231122-rkisp-fixes-v2-0-78bfb63cdcf8@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8jXmUC/22MQQ7CIBBFr9LMWkwZQiquvIfpAmGwE2NpGNNoG
 u4udu3y/Z/3NhAqTALnboNCKwvnuQEeOgiTn++kODYG7NFojajKg2VRid8kKuDgbPApeovQjKX
 QfjThOjaeWF65fPb4qn/r/86qVa+0syefzKDJuAtH8pLnW/YlHkN+wlhr/QJrEkERrQAAAA==
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Yichong Zhong <zyc@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Allon Huang <allon.huang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Tommaso Merciai <tomm.merciai@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=778;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=uilUL/CQsGPrrLqlIQUCAs9mt6Z3Ge5A5dVOnCwLOH8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlXiM+yWSEQjnzVopQU/vU15HIG5yo5Ka7LV1xp
 NJTFvoLROyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZV4jPgAKCRD6PaqMvJYe
 9f9OD/9KTCA0JW6Wlg2TCo5NrOiPtGYya55O0RsHyI7KES2PUlXXdCtR+J5tQxqD9ordIK1uC+d
 LcnCwl0P+lpLDXrRyLoSdF762OfRFtHbz1x4EcnORDkmKKATPxHfIcIFFtC9nLcdGnwRkacAVj5
 2AnoRI1i5FrfbT/6jRde4dnELZAxNnt5zid6ICLlmF7GKUN+tk6w602rpka8jtnif7dbPQGpRHb
 wbhzK9bJnHRbyDmOc9HFm9ELcVPxpP5+XFk+xWQ4gDBQ6e7mMA3LXOLLHBWJ3EqyJwHiRPY/wwX
 VyHnZQLvpE1Ibu1wKEPN2tDhbDRbRbEdpLu2Iu8Xp4fsSOTbRsUdo/s++CIZJ6Iy6Yf35AwUrvo
 J2T++IS8Gs8qFy7gt6WdkdoXShSrp25VkWHZ+z90jtO6bs8zNuRlbWcsmpSv3n4HhlS6BPxMBuH
 ntXPwxMInEo/nLR01cq+T8QzOeNsXss3s0oD5AN7wG7aJ2LsYuwtdKpEJnyqBB3TwL1ebn+SrUl
 +Gcc6q7H+tPc4Sen0FcoyiqGR2GsO2IVc6r0A8p4nO5fYXScGypVzzzT8PjdUeyxG37xlwrfMfu
 Djlemo0wFtnO0HgTeqfSodEDhmHNKR9uR3F8y51M+ZjsL2vPJK2LVYvzB/fYKhv7h+sZNEXr5k6
 ol+NnYTyQ8BB+5g==
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

Fix two memory leaks in rkisp1 driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- Fix error path code for rkisp1_probe()
- Add Rbs
- Link to v1: https://lore.kernel.org/r/20231122-rkisp-fixes-v1-0-1958af371e39@ideasonboard.com

---
Tomi Valkeinen (2):
      media: rkisp1: Fix media device memory leak
      media: rkisp1: Fix memory leaks in rkisp1_isp_unregister()

 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 6 +++++-
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)
---
base-commit: 1865913dd590ca6d5e3207b15099a1210dd62f29
change-id: 20231122-rkisp-fixes-c2795cafda52

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

