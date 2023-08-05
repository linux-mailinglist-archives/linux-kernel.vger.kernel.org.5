Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC6770DF0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 07:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjHEFg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEFgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 01:36:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8146B3;
        Fri,  4 Aug 2023 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691213772; x=1691818572; i=w_armin@gmx.de;
 bh=Xc5Uz3yHM1cYmTbfdHFbQvSyh54bIq4BmIZkafOGP8Q=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=WztmmToYD9V4MELG/sZBCibor6a4SSfMWRdoyJwHc7C0tXWvmk3fm8nxyAbcqUfSXxfkXJe
 k28cl35Y2q8MG3wnrNhURND5OZxLtlHM3JuAGpiU9IXEm3ef7qZciXWR681lqMjlYWmX757Xo
 Z4Zu9YgtYe66nxjySsjLkYbpkQNmwY4JYKiqL1f0LdnPAFq+F7ynjM8xfZWC1q8jb5IO7zzvk
 mnas6TjctvI9KBwczHsxQXDkJEjvoDssLcR5gWbZNQuD/1M8YCW7cls5jtLwsui1z5FWuxZ+n
 qN7mM0A/o8Q7DzUOGBVa12xXz3OSNt11IPQYRGfh1Ve2+MzQu6Sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N6bfw-1plbjW1n14-01816B; Sat, 05 Aug 2023 07:36:12 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     prasanth.ksr@dell.com, hdegoede@redhat.com, markgross@kernel.org
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-sysman: Fix reference leak
Date:   Sat,  5 Aug 2023 07:36:10 +0200
Message-Id: <20230805053610.7106-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Ex/nogT+uSYoxHzoSeE2GZ+pKYhOchFCLlj5z6jUoNGPKe2SjA
 J75Wan7+Iwod2cEJ44K77Zx9Bcfju/lM7QwMk13kUe78nf2kInsQx8mjbMdGFbOp7Hl1Mm7
 qTGOpryQvdv4uQSTAA1oxpKxRxyIDaav/3JojZMz+ZhPurLTG/M6qLSpnE+HxjLnKVXgFBo
 c9CrIVUFE/mXf/ANmuJdw==
UI-OutboundReport: notjunk:1;M01:P0:ngpWxp/2kfA=;g7ty0ncJA6Hjq7/2V689EIaIFfa
 r2C2BIh5qn2LbyRwBRrkia4TROv8AvqnvHj6+W2iAmReszrr6Bwt6lV6yDvlb83Ew00dgb7qh
 1ro3PsrEMUrbtLT+w6OqyMaqlGOJSqIprSS12bJ/dNXHEDfqwHIsup1yCK5npXvSKT3zNOtlz
 pKO6Qwh1DQLYC4cqqdBXcJF+714uAFEy9VSlR28fE9RkfaiFztCaVV1kh4ziZ04jkFDHV+yVo
 pseBOUZuhKX0PbwRwKQK+0EYl06VdD9oexVICYOFPUhdDeZnYF9goF/TkQSlYghD+rvhlML4x
 e551SuEXfiO1Czb9ShWmfjyjCm4/0BBRCH5YhnUultRgcN6nb5WVn/jx9/T+uXYZrMBUYjCSJ
 aw26VTeUO3nh5i7BQO0XsU2O5E4EQIXPFEDeqon+Wp/micIHpYenY1q8sASdpnmXSOnF42UTo
 FjSogej/r/clRC4+9bN1R/aMa4I4FGqYNqkJ0wJZGx7Bd5UHSXsmJTD1McjLcvDxfkQ9jcApu
 jwMWZXe/oZnSbjeRyGvVbzXADoxJX0QJjv7uryMIcYBlviS+qj3vHr2Tbt4O6LMjcUUvg4ehB
 5EHsuvX/G3YtR/TuuFhnPYMkZFYaS1Lw3ItYNykWU9YrNqlilfLPnnND62jMW3SR8D1BlYhBC
 o8mHL9rAfC8lyKnv7J5FvaAD5t0zqW4rMCwiklV1vgK0Yo04VQvGidnGht/RY7vDrZ2V0AXq8
 I1E+Pt+P7rJKxZKzzBvvSSMIXzLjqJuSZ8Nzf245J1qAc8dxr71f8KN0tU2D34k4cSFYy76aP
 Wq8Zn+2wN0FTC3PPu0/uINXWQRl2h/H3+cSEjKHrVFLCe/ILxAyf94EAkSUNWBl3C/n1LtvQY
 mkY5EVMNLEznoNJmsWGkfjvKSWyaA9WdMm8dwUGif/n7JLmxCok76xE0j4Nu/yyHmifFLaxd6
 xtC+tTaLCJiJkPzV4iZ57AOctyM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a duplicate attribute is found using kset_find_obj(),
a reference to that attribute is returned. This means
that we need to dispose it accordingly. Use kobject_put()
to dispose the duplicate attribute in such a case.

Compile-tested only.

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Manageme=
nt Driver over WMI for Dell Systems")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/=
platform/x86/dell/dell-wmi-sysman/sysman.c
index b68dd11cb892..b929b4f82420 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -393,6 +393,7 @@ static int init_bios_attributes(int attr_type, const c=
har *guid)
 	struct kobject *attr_name_kobj; //individual attribute names
 	union acpi_object *obj =3D NULL;
 	union acpi_object *elements;
+	struct kobject *duplicate;
 	struct kset *tmp_set;
 	int min_elements;

@@ -451,9 +452,11 @@ static int init_bios_attributes(int attr_type, const =
char *guid)
 		else
 			tmp_set =3D wmi_priv.main_dir_kset;

-		if (kset_find_obj(tmp_set, elements[ATTR_NAME].string.pointer)) {
-			pr_debug("duplicate attribute name found - %s\n",
-				elements[ATTR_NAME].string.pointer);
+		duplicate =3D kset_find_obj(tmp_set, elements[ATTR_NAME].string.pointer=
);
+		if (duplicate) {
+			pr_debug("Duplicate attribute name found - %s\n",
+				 elements[ATTR_NAME].string.pointer);
+			kobject_put(duplicate);
 			goto nextobj;
 		}

=2D-
2.39.2

