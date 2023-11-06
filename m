Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271687E248E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjKFNXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjKFNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:23:01 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC718125;
        Mon,  6 Nov 2023 05:22:57 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=068806c1c2=fe@dev.tdt.de>)
        id 1qzzZ6-000L82-3a; Mon, 06 Nov 2023 14:22:52 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qzzZ5-001A4L-Bm; Mon, 06 Nov 2023 14:22:51 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id F1D66240049;
        Mon,  6 Nov 2023 14:22:50 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 5D9C6240040;
        Mon,  6 Nov 2023 14:22:50 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id D0A4722029;
        Mon,  6 Nov 2023 14:22:49 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, gregkh@linuxfoundation.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: ledtrig-tty: free allocated ttyname buffer on deactivate
Date:   Mon,  6 Nov 2023 14:22:46 +0100
Message-ID: <20231106132246.3369826-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1699276972-86F347EA-2CBEC2A8/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ttyname buffer for the ledtrig_tty_data struct is allocated in the
sysfs ttyname_store() function. This buffer must be released on trigger
deactivation. This was missing and is thus a memory leak.

While we are at it, the tty handler in the ledtrig_tty_data struct should
also be returned in case of the trigger deactivation call.

Fixes: fd4a641ac88f ("leds: trigger: implement a tty trigger")
Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/leds/trigger/ledtrig-tty.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
index 8ae0d2d284af..3e69a7bde928 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -168,6 +168,10 @@ static void ledtrig_tty_deactivate(struct led_classd=
ev *led_cdev)
=20
 	cancel_delayed_work_sync(&trigger_data->dwork);
=20
+	kfree(trigger_data->ttyname);
+	tty_kref_put(trigger_data->tty);
+	trigger_data->tty =3D NULL;
+
 	kfree(trigger_data);
 }
=20
--=20
2.30.2

