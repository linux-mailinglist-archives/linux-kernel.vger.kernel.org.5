Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631B7CDC22
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJRMoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJRMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:44:22 -0400
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 002A298;
        Wed, 18 Oct 2023 05:44:18 -0700 (PDT)
Received: from localhost.biz (unknown [10.81.81.211])
        by gw.red-soft.ru (Postfix) with ESMTPA id C2A903E1D84;
        Wed, 18 Oct 2023 15:44:15 +0300 (MSK)
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] media: dvb: check return value in drxj_dap_atomic_read_write_block()
Date:   Wed, 18 Oct 2023 15:44:11 +0300
Message-Id: <20231018124411.583718-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 180703 [Oct 18 2023]
X-KLMS-AntiSpam-Version: 6.0.0.2
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_from_domain_doesnt_match_to}, red-soft.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;localhost.biz:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/10/18 11:33:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/10/18 08:25:00 #22219801
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check return value of drxj_dap_write_reg16()

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 drivers/media/dvb-frontends/drx39xyj/drxj.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index a738573c8cd7..e657bb6dfa76 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -2136,9 +2136,13 @@ int drxj_dap_atomic_read_write_block(struct i2c_device_addr *dev_addr,
 
 			word = ((u16) data[2 * i]);
 			word += (((u16) data[(2 * i) + 1]) << 8);
-			drxj_dap_write_reg16(dev_addr,
-					     (DRXJ_HI_ATOMIC_BUF_START + i),
-					    word, 0);
+			rc = drxj_dap_write_reg16(dev_addr,
+						 (DRXJ_HI_ATOMIC_BUF_START + i),
+						  word, 0);
+			if (rc < 0) {
+				pr_err("error %d\n", rc);
+				goto rw_error;
+			}
 		}
 	}
 
-- 
2.37.3

