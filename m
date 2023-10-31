Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB77DD890
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbjJaWpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjJaWpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:45:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD8F5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:45:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5056059e0so88567381fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698792336; x=1699397136; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Soi9bdc5kWd4li1fMLa0FWIu2YUGtC28KzHNxVYSHqk=;
        b=cVCeTWTZnL7SHP+D16KUxvBKzD/KZJD9KnuOWSuaDwiBKUsT+wf68AoVKQbwTcrSvB
         qTpA3oHjDvpIKMWWH5q6YeEDo1v1yXofETLkAqewYETzqwLUJgjN9BUVSiBzhsG6Yq03
         d2tf2dAb+MkvfAxAbj4uv3AqEsJM+0dKj0l5yyXyh9yaWhZoFMESxn0w4WAnBsehSfA4
         ahAqjJ5DSxQWo8SvkcWFtat6gkDrtVXQEcp5Bnf2HbeSGKQxed46p2Gc4B8Vvzyq3hBV
         kIjB7mMR7jmUCKL+WEU5LHBVYnJr7PtJfBQm5I+7Ox9SHk0caMT4kIWs61LYUI+oKqI3
         sfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698792336; x=1699397136;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Soi9bdc5kWd4li1fMLa0FWIu2YUGtC28KzHNxVYSHqk=;
        b=tRloBXW8LS/5oyZ67uUyT4bBxlN+fVW9zamArgvRE2rmcxfaLGs8XoitSAdzX5ZxFG
         x47BRjUp8jWrFnNSDvBILe3CDH+O1bqH06VRfwNkkHvzGJICr20CltYgfITcsAYrumYA
         AutIIVSoZi26qBdgSI0tMowor8SygaU7M/9U3HM7Xb09sYD90dNR0wdU+2ZjhVV5+Ja9
         TXwhLfYwJKIBZG1XBN9fVb9KKxCid5f/IToNvOMxX0+Q2CY2zcb1XpFiVSuvLBAu3Zbd
         yhkfYz5gWIbvdxEGgmAhESQaaFq9xZeRJ+gFrcEfwz+u6rSlutzlhl9638NJ+l/peCYR
         kPDg==
X-Gm-Message-State: AOJu0YzlVJu6oRc+OjL208TcjrRkR2dapDay85gJSEWhPeZCVCpYJ2Nc
        aezwBmPLx3TpN5ZECPaU2c3/jg==
X-Google-Smtp-Source: AGHT+IGPznEGLGzU6iFpaDcchCiVWqFLM9xyWUYU6KiMgcFlh2YdEeuJahDu+93Y44rEpZxbOtgknw==
X-Received: by 2002:a05:6512:3c91:b0:507:a04c:76e8 with SMTP id h17-20020a0565123c9100b00507a04c76e8mr13028194lfv.46.1698792336166;
        Tue, 31 Oct 2023 15:45:36 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id i12-20020a0565123e0c00b004fb7848bacbsm39613lfv.46.2023.10.31.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 15:45:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Oct 2023 23:45:33 +0100
Subject: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIyDQWUC/3WNywrCMBBFf6XM2kgeJLWu+h/iIm2mbaAkMilBK
 f13Q1YquLxz55y7Q0LymODa7ECYffIxlKBODYyLDTMy70oGyaUSXLZs8k9G23pRxtDAsNVycLr
 jYrRQmAdheai+GwTc4F6Oi09bpFfdyKJWf3RZMMGcNtp1XGulbb/6YCmeI81VleUHrvgvLguOx
 qDAqXWDk1/4cRxvLXtRgO8AAAA=
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that the "LuCI" web UI was not working properly
with a device using the RTL8366RB switch. Disabling the egress
port tagging code made the switch work again, but this is not
a good solution as we want to be able to direct traffic to a
certain port.

It turns out that packets between 1496 and 1500 bytes are
dropped unless 4 extra blank bytes are added to the tail.

1496 is the size of a normal data frame minus the internal DSA
tag. The number is intuitive, the explanation evades me.
This is not a tail tag since frames below 1496 bytes does
not need the extra bytes.

As we completely lack datasheet or any insight into how this
switch works, this trial-and-error solution is the best we
can do. FWIW this bug may very well be the reason why Realteks
code drops are not using CPU tagging. The vendor routers using
this switch are all hardwired to disable CPU tagging and all
packets are pushed to all ports on TX. This is also the case
in the old OpenWrt driver, derived from the vendor code drops.

Modifying the MTU on the switch (one setting affecting all
ports) has no effect.

Before this patch:

PING 192.168.1.1 (192.168.1.1) 1470(1498) bytes of data.
^C
--- 192.168.1.1 ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1048ms

PING 192.168.1.1 (192.168.1.1) 1472(1500) bytes of data.
^C
--- 192.168.1.1 ping statistics ---
12 packets transmitted, 0 received, 100% packet loss, time 11267ms

After this patch:

PING 192.168.1.1 (192.168.1.1) 1470(1498) bytes of data.
1478 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.533 ms
1478 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.630 ms

PING 192.168.1.1 (192.168.1.1) 1472(1500) bytes of data.
1480 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.527 ms
1480 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.562 ms

Also LuCI starts working with the 1500 bytes frames it produces
from the HTTP server.

Fixes: 9eb8bc593a5e ("net: dsa: tag_rtl4_a: fix egress tags")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Do not pad out to 1518 bytes, just add 4 bytes to the
  tail consistently when the package is bigger than 1496
  bytes. Use a combination of __skb_pad() and __skb_put().
  This works fine.
- Add tail in the first if-clause and pad to 60 bytes
  in the else-clause since they are mutually exclusive.
- Edit comments and commit text.
- Link to v2: https://lore.kernel.org/r/20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org

Changes in v2:
- Pad packages >= 1496 bytes after some further tests
- Use more to-the-point description
- Provide ping results in the commit message
- Link to v1: https://lore.kernel.org/r/20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org
---
 net/dsa/tag_rtl4_a.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index c327314b95e3..9c7f8a89cb82 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -41,9 +41,21 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 	u8 *tag;
 	u16 out;
 
-	/* Pad out to at least 60 bytes */
-	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
-		return NULL;
+	/* Packets over 1496 bytes get dropped unless 4 bytes are added
+	 * on the tail. 1496 is ETH_DATA_LEN - tag which is hardly
+	 * a coinicidence, and the 4 bytes correspond to the tag length
+	 * and this is hardly a coinicidence so we use these defines
+	 * here.
+	 */
+	if (skb->len >= (ETH_DATA_LEN - RTL4_A_HDR_LEN)) {
+		if (unlikely(__skb_pad(skb, RTL4_A_HDR_LEN, false)))
+			return NULL;
+		__skb_put(skb, RTL4_A_HDR_LEN);
+	} else {
+		/* Pad out to at least 60 bytes */
+		if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
+			return NULL;
+	}
 
 	netdev_dbg(dev, "add realtek tag to package to port %d\n",
 		   dp->index);

---
base-commit: d9e164e4199bc465b3540d5fe3ffc8a9a4fc6157
change-id: 20231027-fix-rtl8366rb-e752bd5901ca

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

