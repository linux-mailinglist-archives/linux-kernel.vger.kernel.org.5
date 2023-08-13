Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7877A8DB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjHMQHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjHMQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816435AE;
        Sun, 13 Aug 2023 09:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98B3763849;
        Sun, 13 Aug 2023 16:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABEEC433C7;
        Sun, 13 Aug 2023 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942790;
        bh=elW1jLJwVWJkgpd8haFuvCKQa8FvWco5uNliWRgube0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLNEzDd2yxFtBq6nQed/OaqooYNHb87sVqFfIDm0rbVo3IkwJNYbmNcZKe9E4rvOv
         VN3Mvfr75gJ4r03tr5IsKPm16BxjhWd7j7oIRjr95LKAyCqBxY7A2kX3OKsYG2i2VD
         r/HlqH7+H2NgIKpR64X60W6N3t9UxAPjyO8M6fXKkCadBVAEt2FoS9lzxWeuHEwhis
         aS/PZTvB2f1Sb9iTRlpwl7ABzFbGWv06NDTaznYnZRR3EP5uhR71zOEDmXzUODmxWM
         e0SIm52zCJe7qfskSyE8KeqgihNY+Km8SQyc34GdN46bZYw5hlFqlBNm8of4ApbRBH
         N0faHD0WdUaEg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nikolay Burykin <burikin@ivk.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/31] media: pci: cx23885: fix error handling for cx23885 ATSC boards
Date:   Sun, 13 Aug 2023 12:05:37 -0400
Message-Id: <20230813160605.1080385-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Burykin <burikin@ivk.ru>

[ Upstream commit 4aaa96b59df5fac41ba891969df6b092061ea9d7 ]

After having been assigned to NULL value at cx23885-dvb.c:1202,
pointer '0' is dereferenced at cx23885-dvb.c:2469.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Nikolay Burykin <burikin@ivk.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/cx23885-dvb.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-dvb.c b/drivers/media/pci/cx23885/cx23885-dvb.c
index 45c2f4afceb82..9b437faf2c3f6 100644
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -2459,16 +2459,10 @@ static int dvb_register(struct cx23885_tsport *port)
 			request_module("%s", info.type);
 			client_tuner = i2c_new_client_device(&dev->i2c_bus[1].i2c_adap, &info);
 			if (!i2c_client_has_driver(client_tuner)) {
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			if (!try_module_get(client_tuner->dev.driver->owner)) {
 				i2c_unregister_device(client_tuner);
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			port->i2c_client_tuner = client_tuner;
@@ -2505,16 +2499,10 @@ static int dvb_register(struct cx23885_tsport *port)
 			request_module("%s", info.type);
 			client_tuner = i2c_new_client_device(&dev->i2c_bus[1].i2c_adap, &info);
 			if (!i2c_client_has_driver(client_tuner)) {
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			if (!try_module_get(client_tuner->dev.driver->owner)) {
 				i2c_unregister_device(client_tuner);
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			port->i2c_client_tuner = client_tuner;
-- 
2.40.1

