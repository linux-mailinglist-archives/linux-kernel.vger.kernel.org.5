Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDACC7EDBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbjKPHFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:05:52 -0500
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AB21B8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:05:46 -0800 (PST)
Received: from mail.nppct.ru (localhost [127.0.0.1])
        by mail.nppct.ru (Postfix) with ESMTP id 73F881C0D6D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:05:43 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :date:subject:subject:to:from:from; s=dkim; t=1700118342; x=
        1700982343; bh=r+9tuCaKj8z7l88YvQQmxGoZqfy8tYSwR5OFdGbttls=; b=r
        zZJHm/uSBj9GVJhFwEh0tY9SoO0Y0j3hpO+zfrWwlsXquFDANT3yd+MAW9dqc6xP
        GSDVKSW0st0qXuqrTo70wP9+FoZ/fXY6mTc9FYRpdHwwqha0cmDc/lFvcB52jw2O
        nx6RvGsN2h/CXbxMtiQJY8lx7ZyIi2go4R4wVG8Hpo=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
        by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ltcwhwVN0syL for <linux-kernel@vger.kernel.org>;
        Thu, 16 Nov 2023 10:05:42 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
        by mail.nppct.ru (Postfix) with ESMTPSA id 09FCF1C0883;
        Thu, 16 Nov 2023 10:05:41 +0300 (MSK)
From:   Andrey Shumilin <shum.sdl@nppct.ru>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Andrey Shumilin <shum.sdl@nppct.ru>, linux-kernel@vger.kernel.org,
        khoroshilov@ispras.ru, ykarpov@ispras.ru, vmerzlyakov@ispras.ru,
        vefanov@ispras.ru
Subject: [PATCH 2/2] procfs.c: Increasing array size
Date:   Thu, 16 Nov 2023 10:05:36 +0300
Message-Id: <20231116070536.38122-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum size in bytes of the port->base and port->base_hi
variables is 20 bytes per variable, since they are copied in
decimal notation. Two more characters are \t and \n.
A maximum of 42 bytes can be written to a buffer variable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/parport/procfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index bd388560ed59..9b894f7cb581 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[44];
 	int len = 0;
 
 	if (*ppos) {
-- 
2.30.2

