Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F5B78DDAE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbjH3Sww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbjH3IiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:38:14 -0400
X-Greylist: delayed 586 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 01:38:08 PDT
Received: from mail.confident.ru (mail.confident.ru [85.114.29.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA941B7;
        Wed, 30 Aug 2023 01:38:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.confident.ru (Postfix) with ESMTP id 8399B3FC067D;
        Wed, 30 Aug 2023 11:28:19 +0300 (MSK)
X-Virus-Scanned: amavisd-new at mail.confident.ru
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.confident.ru 475B03FC0A73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=confident.ru;
        s=54152002-4729-11E9-BD92-62EA33CD6873; t=1693384099;
        bh=0aND6cMRox2YbjYV2xzlH/w1FyrsJAgkQ36rhVlOZeM=;
        h=From:To:Date:Message-Id;
        b=e1P1860VN55yzZ6M8slBYiV8aDbB7lZJUAOnc7DLcQrKnUht3yA7CEJOcB9cLDfZd
         Uf4jWbWKYqh8HIDk9tSnJGTVHA9cd6KUfcxCkhYjWXFO0VsNefyvaEuNY92AKtmf0o
         kgmqSZqBbSpp9WehvMMIUxWsbjRQny0EeSOKn8P2udOFTm9cHCBFKVahWpHU0fNkVH
         01R+QE/ogA4SchhLZbWqXlNoMy26HwQ0lLU0AqebV57zaUs91dgH0/MSw/FYv+teuc
         N0vi+GKxuaF+7GLGvs0oT3xBjoIE9dDp6LypKdXE/I9lrF7oKpCH4NMpszNmHzb8xA
         MZHquW1TZwNHQ==
From:   Rand Deeb <deeb.rand@confident.ru>
To:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru,
        Rand Deeb <deeb.rand@confident.ru>
Subject: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Date:   Wed, 30 Aug 2023 11:27:59 +0300
Message-Id: <20230830082759.23336-1-deeb.rand@confident.ru>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ssb_calc_clock_rate(), the value of m1 may be zero because it is
initialized using clkfactor_f6_resolv(). This function could return
zero, so there is a possibility of dividing by zero, we fixed it by
checking the values before dividing.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <deeb.rand@confident.ru>
---
 drivers/ssb/main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 0a26984acb2c..e0776a16d04d 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -903,13 +903,21 @@ u32 ssb_calc_clock_rate(u32 plltype, u32 n, u32 m)
 		case SSB_CHIPCO_CLK_MC_BYPASS:
 			return clock;
 		case SSB_CHIPCO_CLK_MC_M1:
-			return (clock / m1);
+			if (m1 !=3D 0)
+				return (clock / m1);
+			break;
 		case SSB_CHIPCO_CLK_MC_M1M2:
-			return (clock / (m1 * m2));
+			if ((m1 * m2) !=3D 0)
+				return (clock / (m1 * m2));
+			break;
 		case SSB_CHIPCO_CLK_MC_M1M2M3:
-			return (clock / (m1 * m2 * m3));
+			if ((m1 * m2 * m3) !=3D 0)
+				return (clock / (m1 * m2 * m3));
+			break;
 		case SSB_CHIPCO_CLK_MC_M1M3:
-			return (clock / (m1 * m3));
+			if ((m1 * m3) !=3D 0)
+				return (clock / (m1 * m3));
+			break;
 		}
 		return 0;
 	case SSB_PLLTYPE_2:
--=20
2.34.1

