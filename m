Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7D78B343
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjH1Ohq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjH1OhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:37:20 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC908CC;
        Mon, 28 Aug 2023 07:37:17 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 9882B1868CFF;
        Mon, 28 Aug 2023 17:37:14 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UxFglozsGboL; Mon, 28 Aug 2023 17:37:14 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 46D921868ACA;
        Mon, 28 Aug 2023 17:37:14 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XGCoCzZOAfKh; Mon, 28 Aug 2023 17:37:14 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.169])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 8A3051868CE4;
        Mon, 28 Aug 2023 17:37:13 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Chas Williams <3chas3@gmail.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] idt77252: remove check of idt77252_init_ubr() return value
Date:   Mon, 28 Aug 2023 17:36:46 +0300
Message-Id: <20230828143646.8835-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idt77252_init_ubr() always returns 0, so it is possible
to remove check of its return value

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2dde18cd1d8f ("Linux 6.5")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/atm/idt77252.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index e327a0229dc1..2c8e0e6cf4b9 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -2296,13 +2296,7 @@ idt77252_init_tx(struct idt77252_dev *card, struct=
 vc_map *vc,
 			break;
=20
 		case SCHED_UBR:
-			error =3D idt77252_init_ubr(card, vc, vcc, qos);
-			if (error) {
-				card->scd2vc[vc->scd_index] =3D NULL;
-				free_scq(card, vc->scq);
-				return error;
-			}
-
+			idt77252_init_ubr(card, vc, vcc, qos);
 			set_bit(VCF_IDLE, &vc->flags);
 			break;
 	}
@@ -2586,9 +2580,7 @@ idt77252_change_qos(struct atm_vcc *vcc, struct atm=
_qos *qos, int flags)
 				break;
=20
 			case ATM_UBR:
-				error =3D idt77252_init_ubr(card, vc, vcc, qos);
-				if (error)
-					goto out;
+				idt77252_init_ubr(card, vc, vcc, qos);
=20
 				if (!test_bit(VCF_IDLE, &vc->flags)) {
 					writel(TCMDQ_LACR | (vc->lacr << 16) |
--=20
2.30.2

