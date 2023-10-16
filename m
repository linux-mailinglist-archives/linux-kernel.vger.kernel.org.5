Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075047CA042
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjJPHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjJPHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:14:04 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E79F1;
        Mon, 16 Oct 2023 00:13:53 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=966793e2c5=fe@dev.tdt.de>)
        id 1qsHnI-007WDP-7j; Mon, 16 Oct 2023 09:13:40 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qsHnH-00A6JI-D9; Mon, 16 Oct 2023 09:13:39 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 11C8C240052;
        Mon, 16 Oct 2023 09:13:39 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 5C94624004D;
        Mon, 16 Oct 2023 09:13:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 27CD12BE05;
        Mon, 16 Oct 2023 09:13:38 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v3 3/4] trigger: ledtrig-tty: move variable definition to the top
Date:   Mon, 16 Oct 2023 09:13:31 +0200
Message-ID: <20231016071332.597654-4-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231016071332.597654-1-fe@dev.tdt.de>
References: <20231016071332.597654-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1697440420-076036AA-82120C7B/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Has complained about the following construct:
drivers/leds/trigger/ledtrig-tty.c:362:3: error: a label can only be
part of a statement and a declaration is not a statement

Hence move the variable definition to the beginning of the function.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@i=
ntel.com/
Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/leds/trigger/ledtrig-tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
index 8ae0d2d284af..1c6fadf0b856 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -82,6 +82,7 @@ static void ledtrig_tty_work(struct work_struct *work)
 {
 	struct ledtrig_tty_data *trigger_data =3D
 		container_of(work, struct ledtrig_tty_data, dwork.work);
+	unsigned long interval =3D LEDTRIG_TTY_INTERVAL;
 	struct serial_icounter_struct icount;
 	int ret;
=20
@@ -124,8 +125,6 @@ static void ledtrig_tty_work(struct work_struct *work=
)
=20
 	if (icount.rx !=3D trigger_data->rx ||
 	    icount.tx !=3D trigger_data->tx) {
-		unsigned long interval =3D LEDTRIG_TTY_INTERVAL;
-
 		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
 				      &interval, 0);
=20
--=20
2.30.2

