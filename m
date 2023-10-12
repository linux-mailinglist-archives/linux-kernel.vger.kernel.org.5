Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1097C7973
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443006AbjJLW14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442949AbjJLW1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:27:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E5CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:27:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8b2eec15d3so2158161276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697149673; x=1697754473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rZYpAvmIgIMiNPsdg/lY35j3EeR/rUqwRQrzCZkd3d0=;
        b=z0hOqJQAGcLilxNgiHT9cMELbFMFkG17er1m8n/oQ8MsVcVffzAje5T4EpZKz8d+cv
         vsx3Qb6bz2QKuV0JWv5QDQ174OzMuXM+6vZDhBAwc7Sf5RxtZmokXG3qA8uEBdNC6Nv2
         w3KUTbjj156Hck9EMxBGBM1JnDXKNuAJ4cUrvz8Js73DKWPkH4mQTxdwAGK9nfPblTv+
         RM7L0tOanYbNO7+drkC2XzL2V+MsOL0dURSX3Uy9hmr+v9Y1AzjqJxbTV4Yvwedjcz+a
         /hvVT+9/Qmsyrom9EzDM3gFhwfo9D04cFR0VgtWYHQzNiRp9xApV0n8NUEHAQmD/dZUq
         DI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149673; x=1697754473;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZYpAvmIgIMiNPsdg/lY35j3EeR/rUqwRQrzCZkd3d0=;
        b=DSKRbVq1v6Mz9LrGjBPe4NKJAVnFVTvR+qk1AfQ/Vwfbmw4eFvI95SAY5mLKrXqeAA
         sWIlE1sp4r+4CABCFcnWMuftIKmzu7Fj6ZeRlcFNMev3PFK8dqyk1Qahrz1LmHkTz3f3
         ok4fAuNcH8NQ+QmTdl5AAo+Q1J99RdScl4LTDJZQrleGN+k3cRFEIUjvzgUwpBZzp9vZ
         wKWSe8Z6lap955Twgn0dcWm+9s+50+PtHW4PgkCIwhidmIDckuzMxobj1GKKNj8joSkW
         QMWN0ehkSAa397+/l7x9TKXToAzlqhLtyYLv1G+u3ocPa3Mn8AqBbZYqofM7D/bf32YD
         BaOA==
X-Gm-Message-State: AOJu0YzI3D2sgyK0mNTtnfrZew8qbpqw5gSu/7H98YtApCY/3SOXcKxm
        t32ls1il+A9MaMjaTyC1duF89DwgFmqbROyzng==
X-Google-Smtp-Source: AGHT+IGvsAhFHjxwUVFZUgMRL3+/P7L3Q3QaP/2sCXzGdan8GAMGU0q90XgVFJVBfLiIRlvUoZwcR9p9tY0tNTEHNw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:8a0d:0:b0:d81:582b:4661 with SMTP
 id g13-20020a258a0d000000b00d81582b4661mr526282ybl.8.1697149673145; Thu, 12
 Oct 2023 15:27:53 -0700 (PDT)
Date:   Thu, 12 Oct 2023 22:27:52 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOdyKGUC/x3NMQqAMAxA0atIZgO2IopXEQdtU81gLYmIIt7d4
 viW/x9QEiaFvnhA6GTlPWaYsgC3TnEhZJ8NtrK1qYxFPSS6dKMXPkkUIx2Y1ht1U4cO28aH0LX zNDc15EgSCnz9g2F83w8DaSpFcAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697149672; l=1565;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=5QhySr/Q36zDeZ98j7zPXD0GUeZwX1jIeAwMYdxCyJY=; b=KrpFlNS4TYnLFKZYhQfQ//GmLAMKDMsDyCpew83lBGhmjSjQwft46M0mgguiqwpB6z88nBcuU
 Ds7ihe1nXe0DZ4uk2R64dfZCwG7NdZ7DIULPlIejpSdriFk3YldG2FT
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>
Subject: [PATCH] net: phy: smsc: replace deprecated strncpy with ethtool_sprintf
From:   Justin Stitt <justinstitt@google.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this dedicated helper function.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/phy/smsc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index c88edb19d2e7..1c7306a1af13 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -507,10 +507,8 @@ static void smsc_get_strings(struct phy_device *phydev, u8 *data)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(smsc_hw_stats); i++) {
-		strncpy(data + i * ETH_GSTRING_LEN,
-		       smsc_hw_stats[i].string, ETH_GSTRING_LEN);
-	}
+	for (i = 0; i < ARRAY_SIZE(smsc_hw_stats); i++)
+		ethtool_sprintf(&data, "%s", smsc_hw_stats[i].string);
 }
 
 static u64 smsc_get_stat(struct phy_device *phydev, int i)

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-phy-smsc-c-75dff87bab53

Best regards,
--
Justin Stitt <justinstitt@google.com>

