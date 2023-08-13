Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7F77A876
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjHMQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjHMQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:02:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC8419A9;
        Sun, 13 Aug 2023 09:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88050625CA;
        Sun, 13 Aug 2023 16:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37242C433C8;
        Sun, 13 Aug 2023 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942443;
        bh=7Khc9vfFBkIaBOHJP+OeyEeGfiAB6ghqHA9PLGdGa4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHpVETYKqgjDfn9hbQksyadYE1cHmJfsRQQxK+frMP96yINbEcyNkwI/7Yi3ypu2U
         HVZeGF3Dn/zUHbVgNDl8yJM26xhL4ivFtyQGdABRX1EAMOXvedT8+60VcrUkT/gXmx
         Wrtx7ohV1xPUwTJuqGb1EEahDfk1cikEgvA0h1PhPizDXEa14i60JnvY7RVGHe1RFa
         DwGjDwhdVC8FKkFxmkL9wLfMIW7M+inCT1hte2fFAsRogv3Tve5eZxsoF/dw1MrVcx
         XjFXL9+N3MxquO0LkIP2TapkYeAHOIpd+XGGa47N0vZvZkc/Se5cAfrrSt2hLdASmo
         Nub2mUwVUd9cQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nikolay Burykin <burikin@ivk.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/47] media: pci: cx23885: fix error handling for cx23885 ATSC boards
Date:   Sun, 13 Aug 2023 11:59:00 -0400
Message-Id: <20230813160006.1073695-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 8fd5b6ef24282..7551ca4a322a4 100644
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

