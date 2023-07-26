Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74716763CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGZQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGZQp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:45:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8F02712;
        Wed, 26 Jul 2023 09:45:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3174aac120aso3716153f8f.2;
        Wed, 26 Jul 2023 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690389925; x=1690994725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RyINUpaSQIyVJ5EZaqPGUzt+wHSb+xiB9GD+ZGRtpyo=;
        b=ZIv6MvLgL/SspksBtDLx4z7qb77Gv29cz8ffslMueuLckTHAnIxd0aHL3dpeHfTEeJ
         3MAkevbwQ5D5MnlkujwOdNBQZ//7VZW03LSVDJQjC+6v/5v7ZfVMG9piIUl49+N0MGtr
         1pIObu8biaoH4+WfDUzXYsDVf6+Pzr+cNLfKh6K/p4Z6uFibUhLxzkOTUkPKm+v3Fr0q
         A4dZjMwgWoP3D2jN9VzOyyQ4hkmstpPej3sCVVOCEZsH5m3ykEDu7ZsLzMo3hdQ0tuXU
         oS6FzAoxT/tOw0CuQiZbQK7BMmFzrMcIaJdkBPDkjung++Qa9rFbaB3Jao7fgvlAJupL
         91ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690389925; x=1690994725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyINUpaSQIyVJ5EZaqPGUzt+wHSb+xiB9GD+ZGRtpyo=;
        b=lhA0O7Xc8etDEmeKYh4Sl4eXYffLI4OcNHrnhyWriND6gajq7+asot9FFymOKXlg0x
         sXfIcM6yMZmWsgtw+0Sk1cLhEnkwPtf9A5GtEWeHrZC0X3qeTzjYRZuOYAK5vCbSDPrP
         IMaue/gVzyacGHzcOryAJaKpxctHETuAukQHt/FFp7hmwE9kT6P4B8E3LNt+id60lk5t
         JslmFYE7lrUiqIGXRKJtvOjzvGgR1pM9jgo6CFYB3lV4ZMayE11WlU9j7ElRWmS4NbvV
         TGeSW2zVDMv/SQUj8jD5wWC9jWtQMC1++uicS9XS7V5qfya2Cbty5mnrSoTGSa1vU3wU
         yvWA==
X-Gm-Message-State: ABy/qLb23gaBOk0eCtRl8kBv5NaAx9XuVnXw7OfmR0e0BtwX4DksvFoi
        D7IysDilfkuUyKtG8clePZw=
X-Google-Smtp-Source: APBJJlHVZ2wSIW+Wh2MzMPB0UbCn0yAmKqAxk1P/KDNshC1jdqCjWFnI7kHTaim05Oc3DvWD47lewA==
X-Received: by 2002:a5d:4a0e:0:b0:317:60f0:41e7 with SMTP id m14-20020a5d4a0e000000b0031760f041e7mr1625695wrq.19.1690389924450;
        Wed, 26 Jul 2023 09:45:24 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b003143867d2ebsm20390617wrn.63.2023.07.26.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:45:23 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: ethernet: slicoss: remove redundant increment of pointer data
Date:   Wed, 26 Jul 2023 17:45:22 +0100
Message-Id: <20230726164522.369206-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer data is being incremented but this change to the pointer
is not used afterwards. The increment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/alacritech/slicoss.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index a30d0f172986..78231c85234d 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -1520,10 +1520,8 @@ static void slic_get_ethtool_stats(struct net_device *dev,
 
 static void slic_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
-	if (stringset == ETH_SS_STATS) {
+	if (stringset == ETH_SS_STATS)
 		memcpy(data, slic_stats_strings, sizeof(slic_stats_strings));
-		data += sizeof(slic_stats_strings);
-	}
 }
 
 static void slic_get_drvinfo(struct net_device *dev,
-- 
2.39.2

