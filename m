Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761847ADA19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjIYO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjIYO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:28:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82369103;
        Mon, 25 Sep 2023 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695652105; x=1696256905; i=w_armin@gmx.de;
 bh=071gcdDLNBkCgiGL7swJLhOyDt5nxBTUzKca3uuN28I=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jAhHtiLe0mXfe5UVvmsdPX9jfFWA1024EWDUdqqkw0pSUm8yjVOOCieVqQ0bVbpeCQxWXfh/wWD
 vJWW34+3v+huqyI6lr/SBmbXI4BqkylgPon3Yom3mheZN9CfV/hgKneP2SGrH6Sc/JRtXh7fcyV+2
 MWMQBvnX64jVx3qbRqrhFRYZR3l7P0qNUWQHTTJjkVoy/CzAjLbeJpRyGE05wVZtKAZuUzX8R4gsa
 BUdb1qMSkJpBViOHTb7xvzfA3J5KxwTOsjkptpzU3RYSJ6v7QUnuLW0znml5oZlLIbyiDZoRCgpIB
 owkVmghaLFmTo58iZItYH63l++lY+HGRHagw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MDQiS-1qvGyF0ntG-00AVWy; Mon, 25 Sep 2023 16:28:25 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] platform/x86: think-lmi: Fix reference leak
Date:   Mon, 25 Sep 2023 16:28:18 +0200
Message-Id: <20230925142819.74525-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925142819.74525-1-W_Armin@gmx.de>
References: <20230925142819.74525-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xLW589ADbeBLaSbObW/IkKlsPjnKinoeWFHFlYP2yKvjOxeMix8
 tdH0CEbnJayZjjm/mr1pbvi56B/IKWGdkBL5BFEnC/AXdXRYPJ+5RD/3ZOPl6yL6zBSoH8j
 /gaxh0qorTWzE4tcIPq0vFxexNWee0VdCBZxXZRqLZH4ZFehyciEgNXHtKuPnvVJOIvi1Xb
 rVLF8F0sHGINhq1/tWQ3g==
UI-OutboundReport: notjunk:1;M01:P0:DBTTDir0fBc=;/3Xslu3UF0jR4+NVqaPx8Dqb8zZ
 dM/LHUyK+XDNJArl7D4LGGWhQSMPK5fmlnyOLvKebr5bB5RYYwAMPnwj3WWmYqt8eo2aptPdv
 OADuvWhgiPfJMrFkEM5kPGVFH+c3NGL1l5ZeDqdgCfgvfPY7J2sd2RtgEttKUBj/u9Av6rvRC
 PI//uiEe+L6noLQKtQrHoBUKEDLa0iNoWLX9ifU9nAXWUNpH353gfZg0LC/pTn3NZIyxz7iI1
 GI4S2cQYzGBGvQg98V/HafMm+eKApFAU6JEZ1ZesBofM3rPTSF/5I+8r4DQR0i0VW6FdqAHP2
 NoC5VY1iqNc+Qa2oR0N3zQi4waUlo6FirvH+srgYFSTdftDKqEZcwyOZKkZ8omOCeILHAFaNc
 N7gTp0TKtkg4TGB54RTZ+ADaRAJLFt1hTNjOR65qPBooOVSE0BaLHXqOL1rOhKC7Kle16hM13
 rZDdwG+/oHr7XB70qSR976vLJDzNyeblZSuU98ZDBOz3EmMLIGw2N+Qo4J8as+QW5XXLQZjpZ
 usfk3s/QTaakbceoHgVMyAcl0CZS9F0zM5HxCBqXl5Gq+G6G+QLNEsi/PIFCI9QJZu8b0oTUW
 Aj2pEnpCS3jM9i1Lg4BzPH35veaAu8d0y9dJOnMF3bhE9vtiJYbVy9Tu9DHGICfOa9CjC94/S
 DoELJVzVirWfGz0SPYJpZllU08Q5G0c0YAvj3IIfnOrldFI9GLoMzgzo2eSuJ9Haric2+XpgD
 oFwVU09j3VX/B/7jp3p8c5mrGWUw82Gt0MYGZj3MUKi8v+jArQ40cURDmZgSylIprD5JNU9Aw
 GCvso72kenBUUCH86+hAk1carRvmtqJ+GKNWsPHhsiBaKy58QfUUDHDLRTvo1ko46tDXtjmfd
 m/NaysBnRVlII3X2qnjMwbQJZfG6a48QSnqBrtjvYEaNFdzVI3xtTToDG9S3oXm+Z5mc/xN7K
 XpF/lZpW0HeWYgQOuJkozTQ50rg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v4:
- add another Reviewed-by
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

