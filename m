Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390D480EA33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbjLLLRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346326AbjLLLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:17:23 -0500
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C339EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:17:24 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id 29F5912012B4;
        Tue, 12 Dec 2023 14:17:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 29F5912012B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1702379842; bh=9bSZRvhCRx5ZJOxhq5dQQZcW3HOYwOVchaVahsGhmC4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=sUS+QwZS/BUI2i+pNguzOC3QXoOfVo8YH+i56eACSvkMkJzIts/9LltTnfytI91Qc
         C76Mxo6v1b4HQv07X//uQZVp4CaqDtpX3TOQ5ZLT3LQ9g+EGlFvagHhqb3jYYy6jV8
         elrpT/F/ZgO3Cq2yYNtBtHUcmxMz7uCqGYjrv764=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
        by mx0.infotecs-nt (Postfix) with ESMTP id 25F4D316AAFE;
        Tue, 12 Dec 2023 14:17:22 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Daniel Starke <daniel.starke@siemens.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russ Gorby <russ.gorby@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com" 
        <syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com>,
        Mazin Al Haddad <mazinalhaddad05@gmail.com>
Subject: [PATCH 5.10 3/3] tty: n_gsm: add sanity check for gsm->receive in
 gsm_receive_buf()
Thread-Topic: [PATCH 5.10 3/3] tty: n_gsm: add sanity check for gsm->receive
 in gsm_receive_buf()
Thread-Index: AQHaLOzG6jNgFQFcyE2RxcW+B/dJcw==
Date:   Tue, 12 Dec 2023 11:17:21 +0000
Message-ID: <20231212111431.4064760-4-Ilia.Gavrilov@infotecs.ru>
References: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/12/12 08:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/12/12 02:27:00 #22664189
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mazin Al Haddad <mazinalhaddad05@gmail.com>

commit f16c6d2e58a4c2b972efcf9eb12390ee0ba3befb upstream

A null pointer dereference can happen when attempting to access the
"gsm->receive()" function in gsmld_receive_buf(). Currently, the code
assumes that gsm->receive is only called after MUX activation.
Since the gsmld_receive_buf() function can be accessed without the need to
initialize the MUX, the gsm->receive() function will not be set and a
NULL pointer dereference will occur.

Fix this by avoiding the call to "gsm->receive()" in case the function is
not initialized by adding a sanity check.

Call Trace:
 <TASK>
 gsmld_receive_buf+0x1c2/0x2f0 drivers/tty/n_gsm.c:2861
 tiocsti drivers/tty/tty_io.c:2293 [inline]
 tty_ioctl+0xa75/0x15d0 drivers/tty/tty_io.c:2692
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Link: https://syzkaller.appspot.com/bug?id=3Dbdf035c61447f8c6e0e6920315d577=
cb5cc35ac5
Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control chann=
el open")
Reported-and-tested-by: syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.c=
om
Signed-off-by: Mazin Al Haddad <mazinalhaddad05@gmail.com>
Link: https://lore.kernel.org/r/20220814015211.84180-1-mazinalhaddad05@gmai=
l.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 drivers/tty/n_gsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 2455f952e0aa..fa49529682ce 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2588,7 +2588,8 @@ static void gsmld_receive_buf(struct tty_struct *tty,=
 const unsigned char *cp,
 			flags =3D *fp++;
 		switch (flags) {
 		case TTY_NORMAL:
-			gsm->receive(gsm, *cp);
+			if (gsm->receive)
+				gsm->receive(gsm, *cp);
 			break;
 		case TTY_OVERRUN:
 		case TTY_BREAK:
--=20
2.39.2
