Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7B7AAC55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjIVIP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjIVIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:15:27 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCB5E77
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=pHJcS4UElq8U7kAaQXym1rTExhuP+pYyemAHmyY2Czw=; b=icSGGA
        Gfx3nv8ST6SL5e7NRDXsWtKNN50lhY7mgiTjey35koSVNpgWQ00ZyDw6P1wD2S3X
        Wijo4LbPdMVGmv47f30bvqsvhF96yYBk/RoRaI9V1Xp2UDUCgdt02CMIrxbd2ugm
        MpK22LQenJwGNdH9wzL89eBaGiqZXFicglg/UwNjlYdiaON8tpE8m8kt7NPLkTyQ
        lgQqsUVbJSWIK7dN822qesVkAujBLCOb36Q0bXRtBeNVY4Ti2fA7Nhv11H7LTokK
        rxKchCoFolOSNWHNbpWxwAlRHoJN1efSK7IE+ogk7ZEbMrEtkrmkNr5afuTTOFSY
        4l4XAGc7lEazAReA==
Received: (qmail 1310986 invoked from network); 22 Sep 2023 10:04:29 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 10:04:29 +0200
X-UD-Smtp-Session: l3s3148p1@DQrODu4FesIujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] media: dvb-frontends: drop check because i2c_unregister_device() is NULL safe
Date:   Fri, 22 Sep 2023 10:04:20 +0200
Message-Id: <20230922080421.35145-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922080421.35145-1-wsa+renesas@sang-engineering.com>
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only. Please apply to your tree.

 drivers/media/dvb-frontends/m88ds3103.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index cf037b61b226..26c67ef05d13 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -1920,8 +1920,7 @@ static void m88ds3103_remove(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "\n");
 
-	if (dev->dt_client)
-		i2c_unregister_device(dev->dt_client);
+	i2c_unregister_device(dev->dt_client);
 
 	i2c_mux_del_adapters(dev->muxc);
 
-- 
2.30.2

