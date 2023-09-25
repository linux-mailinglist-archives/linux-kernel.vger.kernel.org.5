Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8E77AD91D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjIYN3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjIYN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:29:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DD910E;
        Mon, 25 Sep 2023 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695648529; x=1696253329; i=w_armin@gmx.de;
 bh=RDTGeRg8m+ex27ocQe6qZsyvm1iCvXo28qa08fOWNpg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DZdUHsv5crvlVJFTTrkY9MfX+IbjoaHe0C3vAVj2EW5VIst6ZdXcVhNJDk5Im9vPvYt+77oHNzJ
 c1r+OcTL8S6b9h+YOxyQrA6k6jV2tCMUAS8M8ppwqbCiNUxMEwtSpRXFcLnzmMc3nDtt+2mpdJ2ux
 4OFVdGHf0gbUBnQFQ2kuasbpFv+pQsMSp02ZLfoqytydGWyER/4QocBB0QWweTQNAz6fyT0Au7VVe
 7+Ruu73mGWpALy8z5TIGcgSoPf2lCl1KnruX4sH8tqgcRPjtSKB8EwcqGhRpAS/mCz5R0jpDgrb2W
 RhokTrLhRzyOtPNEiTbPJadFHRyQ5U8pmTVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MBm1U-1qwtfZ0BCO-00CAir; Mon, 25 Sep 2023 15:28:49 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] platform/x86: think-lmi: Fix reference leak
Date:   Mon, 25 Sep 2023 15:28:43 +0200
Message-Id: <20230925132844.72479-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925132844.72479-1-W_Armin@gmx.de>
References: <20230925132844.72479-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f8bun32Dbxt8C5XhmyOMmc0eZElWdHxIhVgx1/DLOtGjEPENrAn
 7RbawcWQuYm/dHl6Bp4tjUV0BuEWA79RoFEGdXdcSjBOMit2zztBEjmvVIb8R6OtyRL8oqx
 cMZnMpf6EIl8A69vYOSi7yCmbMdfiAQBDBqViQRHI74oaHyj8iLROrGVniAPw5ffPaTvpwN
 d1ZKlZkiFFAQuWQjjUYDg==
UI-OutboundReport: notjunk:1;M01:P0:ZUToJMOjej4=;whp+qgCHvgDB5g9yWRRyqv4536Z
 Lh5m2+vMP0w4w/tT4gTNohXUPoRm92tZsKx47ZtafcqaLAdB/+9ruOls/vuhQ/pLxKRi4lSdz
 iLn1JIoxYxLgE79Ue1TjkJFyINxBJJAYxLmmGfQZl42Mr5CIlz2teJSiQt46GgdNqeFZChym7
 ORXwWkqg9LZhX/NMP+tFSG6bI5ws45vwMygW/ThIFN4K9lH42ysxDSmaac7eR52ty1QxpMlTq
 xLkyjiyUuzY58tpRsFCvBrnBiY9C1G2PiqNPz9hs7Dvtyel4OmzhvrYZuVvqZtXDubPXPQ3VQ
 5LALlYBDDLCiT1UN5RdzeZwoqHx5JklUH1uL+rNJmqvaV3H0NIifv4Xu0iBY57CfePU+AkDI+
 U4f99lojc8Ez4dBxPyahIOVTJnaPM5laOfkEHBjOlR75yOsyjZgcMaSHYbfeJkbGJ4fEAnHFA
 xFzsAzBXg92Lr5isjaj+sS7NJj0WfPl2aK+H2vxZxa2jWvS6aWUK4sjY5e9VkUip+90hP9Gre
 0xGVgM8Vqwn/evA0902vuo4+BNvYAvqB9PSIM3+BfFecCVQmQKGcga/NuLbdzw6tgGTIBmyFJ
 IEb1FUY0Dl6lNfjpdyPN9OLzKKbJx0KFSRde6VjD1enc1metUzRWw7ZEqGKJbJ+py+qGPvjY+
 qzhEw9S61SvpVgEFsfCOQIyo07tMcW6ikNf5L4TD3a+rZEg+7W+uis4O6m16aYZdCmrCBWOtP
 s6L5gLCCkuTMqxzNos5ZGASXsb8YyPGDck/WsX3Rnt3ZXHJegaz+WtXxcBh4C9pa+8kbFZaZI
 JYUtVtOzaZgvwIkm/ZXv8IDu8f+RiTjoJI2PobTQc27qYERJbUD9CIfKciGHnEgoG9Rl+XBE7
 9A2G4njOFTSW78QTg2kpzMjFm7lfK4Tu794XXIdCVVusEJV6hsqk17953pqZokz6G4BcHKg6Y
 WFloDY2CrnNEHyIxE/V7QNtpbsQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a duplicate attribute is found using kset_find_obj(), a reference
to that attribute is returned which needs to be disposed accordingly
using kobject_put(). Move the setting name validation into a separate
function to allow for this change without having to duplicate the
cleanup code for this setting.
As a side note, a very similar bug was fixed in
commit 7295a996fdab ("platform/x86: dell-sysman: Fix reference leak"),
so it seems that the bug was copied from that driver.

Compile-tested only.

Fixes: 1bcad8e510b2 ("platform/x86: think-lmi: Fix issues with duplicate a=
ttributes")
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v3:
- add Reviewed-by
Changes in v2:
- no changes
=2D--
 drivers/platform/x86/think-lmi.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think=
-lmi.c
index 4be6f28d4600..3a396b763c49 100644
=2D-- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1344,6 +1344,24 @@ static void tlmi_release_attr(void)
 	kset_unregister(tlmi_priv.authentication_kset);
 }

+static int tlmi_validate_setting_name(struct kset *attribute_kset, char *=
name)
+{
+	struct kobject *duplicate;
+
+	if (!strcmp(name, "Reserved"))
+		return -EINVAL;
+
+	duplicate =3D kset_find_obj(attribute_kset, name);
+	if (duplicate) {
+		pr_debug("Duplicate attribute name found - %s\n", name);
+		/* kset_find_obj() returns a reference */
+		kobject_put(duplicate);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int tlmi_sysfs_init(void)
 {
 	int i, ret;
@@ -1372,10 +1390,8 @@ static int tlmi_sysfs_init(void)
 			continue;

 		/* check for duplicate or reserved values */
-		if (kset_find_obj(tlmi_priv.attribute_kset, tlmi_priv.setting[i]->displ=
ay_name) ||
-		    !strcmp(tlmi_priv.setting[i]->display_name, "Reserved")) {
-			pr_debug("duplicate or reserved attribute name found - %s\n",
-				tlmi_priv.setting[i]->display_name);
+		if (tlmi_validate_setting_name(tlmi_priv.attribute_kset,
+					       tlmi_priv.setting[i]->display_name) < 0) {
 			kfree(tlmi_priv.setting[i]->possible_values);
 			kfree(tlmi_priv.setting[i]);
 			tlmi_priv.setting[i] =3D NULL;
=2D-
2.39.2

