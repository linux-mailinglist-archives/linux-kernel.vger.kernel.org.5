Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0EA770EAF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjHEIKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHEIKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:10:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8010C4;
        Sat,  5 Aug 2023 01:10:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD27521850;
        Sat,  5 Aug 2023 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691223012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rc19v92ZKafrhVQKT2HLoHZy05f/qnyul6RyA91HupU=;
        b=B6KiFOWHoOIn5u1j98c+r7UwASnbrsREC4fVUPsApdI2L4eB33gNQo6ScfEsDvSUuCOIVx
        np2c4OX5c8AuRm1RM2Qbb9WgRS9lMsaXBZtQGPL/cDSh3J52sKttCzfADK7R1WKDX2rBrr
        I7U6xkQvI5bwzebbFO+UdGVGGbEJ4wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691223012;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rc19v92ZKafrhVQKT2HLoHZy05f/qnyul6RyA91HupU=;
        b=Dj/Fr446/aTkfAy501dU9GiOzgjCwpDuN0K+hG10rP/YnhgT2FtNjw2ux7aCxIp3IQnPcr
        AkmBM6gAzy7i8RBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C520139BC;
        Sat,  5 Aug 2023 08:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UahEJOQDzmRCNAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Sat, 05 Aug 2023 08:10:12 +0000
Date:   Sat, 5 Aug 2023 10:10:10 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     platform-driver-x86@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Nikita@imap2.suse-dmz.suse.de,
        "Kravets <teackot"@gmail.com, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH] platform/x86: msi-ec: Fix the build
Message-ID: <20230805101010.54d49e91@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msi-ec driver fails to build for me (gcc 7.5):

  CC [M]  drivers/platform/x86/msi-ec.o
drivers/platform/x86/msi-ec.c:72:6: error: initializer element is not const=
ant
    { SM_ECO_NAME,     0xc2 },
      ^~~~~~~~~~~
drivers/platform/x86/msi-ec.c:72:6: note: (near initialization for =E2=80=
=98CONF0.shift_mode.modes[0].name=E2=80=99)
drivers/platform/x86/msi-ec.c:73:6: error: initializer element is not const=
ant
    { SM_COMFORT_NAME, 0xc1 },
      ^~~~~~~~~~~~~~~
drivers/platform/x86/msi-ec.c:73:6: note: (near initialization for =E2=80=
=98CONF0.shift_mode.modes[1].name=E2=80=99)
drivers/platform/x86/msi-ec.c:74:6: error: initializer element is not const=
ant
    { SM_SPORT_NAME,   0xc0 },
      ^~~~~~~~~~~~~
drivers/platform/x86/msi-ec.c:74:6: note: (near initialization for =E2=80=
=98CONF0.shift_mode.modes[2].name=E2=80=99)
(...)

Don't try to be smart, just use defines for the constant strings. The
compiler will recognize it's the same string and will store it only
once in the data section anyway.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 392cacf2aa10 ("platform/x86: Add new msi-ec driver")
Cc: stable@vger.kernel.org
Cc: Nikita Kravets <teackot@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
---
 drivers/platform/x86/msi-ec.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-6.4.orig/drivers/platform/x86/msi-ec.c
+++ linux-6.4/drivers/platform/x86/msi-ec.c
@@ -27,15 +27,15 @@
 #include <linux/seq_file.h>
 #include <linux/string.h>
=20
-static const char *const SM_ECO_NAME       =3D "eco";
-static const char *const SM_COMFORT_NAME   =3D "comfort";
-static const char *const SM_SPORT_NAME     =3D "sport";
-static const char *const SM_TURBO_NAME     =3D "turbo";
+#define SM_ECO_NAME		"eco"
+#define SM_COMFORT_NAME		"comfort"
+#define SM_SPORT_NAME		"sport"
+#define SM_TURBO_NAME		"turbo"
=20
-static const char *const FM_AUTO_NAME     =3D "auto";
-static const char *const FM_SILENT_NAME   =3D "silent";
-static const char *const FM_BASIC_NAME    =3D "basic";
-static const char *const FM_ADVANCED_NAME =3D "advanced";
+#define FM_AUTO_NAME		"auto"
+#define FM_SILENT_NAME		"silent"
+#define FM_BASIC_NAME		"basic"
+#define FM_ADVANCED_NAME	"advanced"
=20
 static const char * const ALLOWED_FW_0[] __initconst =3D {
 	"14C1EMS1.012",


--=20
Jean Delvare
SUSE L3 Support
