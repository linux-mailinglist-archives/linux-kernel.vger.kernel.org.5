Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C47BEE42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378910AbjJIW0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378880AbjJIW0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:26:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9279D;
        Mon,  9 Oct 2023 15:26:17 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-98377c5d53eso861535066b.0;
        Mon, 09 Oct 2023 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696890376; x=1697495176; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNp5QN+Wa5gSGqFJs+wkBFIMdPrKF+F1qBOYA4/HLBM=;
        b=Iht0jWInlER29aQNJaZ0jnftDItjzIrOTTfQ7pdAxNara2YFqslY3Sfq9uAie8hqf1
         xpJcvhEq7t29Ck00AcT6tIEyHY2PZa53e7VMzhEYVRus9vP76szsCESQWO+e3bR2TpYZ
         ghPJvmbOVyY2y86+kj6UhVyREf2wCuTUCFm2lXpVmPzA9tSSTGgkQAQhjG/JQYFPXqDZ
         qv3JxZlDcUKwws5extxsrGsprJrrrViPoc1zxJo9P19ECvs3pdqy0O9JB7OZmyOWc6Ov
         0RftRtwD/VtBcvtYhohh0euLv/dTTl9nu5exXxWn7Ndhz/Zo3EZJz4s90IdoDnBpEmHc
         fVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696890376; x=1697495176;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNp5QN+Wa5gSGqFJs+wkBFIMdPrKF+F1qBOYA4/HLBM=;
        b=pDv0u3xAMTPV6AR1QeckVcBgBGVPSWASgWnjPLCCCQhlnTrrHHljyRPPuqysshjAUj
         Q1kRxRx7qpmM3hbimg22jlqR75h1vZgWbov6X3rfBj9xUHUpIxvNH/cNjagSFWQdyG83
         RhH4/C8lUbFW/hx6P+MLU9qISR1r8IrSYkPt3kSBxnGxEdVOvTNjVzM/8MlIWKwxrp3G
         YSLkTPKrJsCz+iTvGMNuIOt9rTi0N0jhq9y4440a8v2p2bXbzpexrYzevc6WzGpYxWEl
         OFAdRcFNR529xNmz59Q3OZfmneD22kJALm8L3EC1Nvgv1p9MuVmXz4X+r01SvSgC7gXV
         k9tQ==
X-Gm-Message-State: AOJu0YzhXkX9C/FzGI0iGj27r4bferakuukxuIP0rpmUt/+m7cDZvv6L
        AYW4p9XpF6lUl+ooEWTWX9E=
X-Google-Smtp-Source: AGHT+IEXBZp6MNn5Iz0ZdFKMXIs3oPFYXzJVz9SzxV9sEy1dPEadJNRGycTF+Pwpu4r1dnqq7/zVSQ==
X-Received: by 2002:a17:907:78d1:b0:9b3:264:446 with SMTP id kv17-20020a17090778d100b009b302640446mr15240204ejc.0.1696890376063;
        Mon, 09 Oct 2023 15:26:16 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-0d7c-652f-4e74-10b8.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7c:652f:4e74:10b8])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709066bd800b0099ddc81903asm7311487ejs.221.2023.10.09.15.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 15:26:15 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Tue, 10 Oct 2023 00:26:14 +0200
Subject: [PATCH v2] net: usb: dm9601: fix uninitialized variable use in
 dm9601_mdio_read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAV+JGUC/42OWw6DIBREt2L4Lg3gq/ar+2iMAbnoTQoYoKaNc
 e9FV9DPM5OcmY1ECAiR3IuNBFgxoncZxKUg4yzdBBR1ZiKYKDljHU1+wZFq2zWMD2+HDtNgNfo
 hgNRU8rrjN2OUbgzJDiUjUBWkG+fDYmVMEI5iCWDwcw4/+8wzxuTD9/yx8iP9d3LllFNd6batQ
 VRQqsdkJb6uo7ek3/f9B61zopHjAAAA
To:     Peter Korsgaard <peter@korsgaard.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
Cc:     netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696890374; l=1805;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=tuSpdfIOLwv7wtHY5W9nhbDUxC1QdO8MYoXpwOuuSqE=;
 b=Ai7OsMH7iPyecSWDeP+Mdw3y4XBpnq183Zav9G1vJ1tx14o4CErwsZh5oPsgU6MM4uM3Zq+Fo
 AHoFWK1Pkm7BUwyCk4C68GAbXkn6nw2mH1+29wwNde4BnUVQk0MxV5j
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found an uninit-value bug triggered by the dm9601 driver [1].

This error happens because the variable res is not updated if the call
to dm_read_shared_word returns an error. In this particular case -EPROTO
was returned and res stayed uninitialized.

This can be avoided by checking the return value of dm_read_shared_word
and propagating the error if the read operation failed.

[1] https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-and-tested-by: syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
---
Changes in v2:
- Remove unnecessary 'err == 0' case
- Link to v1: https://lore.kernel.org/r/20231009-topic-dm9601_uninit_mdio_read-v1-1-d4d775e24e3b@gmail.com
---
 drivers/net/usb/dm9601.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 48d7d278631e..99ec1d4a972d 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -222,13 +222,18 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 
 	__le16 res;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(dev->net, "Only internal phy supported\n");
 		return 0;
 	}
 
-	dm_read_shared_word(dev, 1, loc, &res);
+	err = dm_read_shared_word(dev, 1, loc, &res);
+	if (err < 0) {
+		netdev_err(dev->net, "MDIO read error: %d\n", err);
+		return err;
+	}
 
 	netdev_dbg(dev->net,
 		   "dm9601_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",

---
base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
change-id: 20231009-topic-dm9601_uninit_mdio_read-a15918ffbd6f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

