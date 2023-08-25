Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF70C788F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHYTFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjHYTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:04:41 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9413F2137;
        Fri, 25 Aug 2023 12:04:23 -0700 (PDT)
Received: from tundra.lovozera (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 19AE640F1DD2;
        Fri, 25 Aug 2023 19:04:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 19AE640F1DD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1692990260;
        bh=HOjQG4CO6mnS8bovh06OkveWowgxs5Vdjds2wSVYyBo=;
        h=From:To:Cc:Subject:Date:From;
        b=A4pejQaX5waupoG1rPPOAkeLrru+8B/2KDbQ4TvPAAl5gn8u4JLQKgM/2V7rjX+mv
         e1CgynrK6ktYFtiyRB9eIZu2GzdSZVKYCXJwKkRn6nju4SJRSMr4bjcENOXXyWrsD4
         LH/2ry9plKHTqwhg1YhWJrD1N32b/Q5G4p2stMaU=
From:   Mikhail Kobuk <m.kobuk@ispras.ru>
To:     Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc:     Mikhail Kobuk <m.kobuk@ispras.ru>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] ethernet: tg3: remove unreachable code
Date:   Fri, 25 Aug 2023 22:04:41 +0300
Message-ID: <20230825190443.48375-1-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'tp->irq_max' value is either 1 [L16336] or 5 [L16354], as indicated in
tg3_get_invariants(). Therefore, 'i' can't exceed 4 in tg3_init_one()
that makes (i <= 4) always true. Moreover, 'intmbx' value set at the
last iteration is not used later in it's scope.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 78f90dcf184b ("tg3: Move napi_add calls below tg3_get_invariants")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/net/ethernet/broadcom/tg3.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 5ef073a79ce9..6b6da2484dfe 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17792,10 +17792,7 @@ static int tg3_init_one(struct pci_dev *pdev,
 		tnapi->tx_pending = TG3_DEF_TX_RING_PENDING;
 
 		tnapi->int_mbox = intmbx;
-		if (i <= 4)
-			intmbx += 0x8;
-		else
-			intmbx += 0x4;
+		intmbx += 0x8;
 
 		tnapi->consmbox = rcvmbx;
 		tnapi->prodmbox = sndmbx;
-- 
2.42.0

