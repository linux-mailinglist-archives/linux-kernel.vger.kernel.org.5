Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403CD7AC515
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 22:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIWUmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 16:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWUmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 16:42:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCF3139;
        Sat, 23 Sep 2023 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695501717; x=1696106517; i=w_armin@gmx.de;
 bh=v8QTdDa9zizuofuXHY/8uWirblQY/wodxLqL6Wr/bh4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=nSY+xcav6HcNXj0H+FD9aQOyGVkoM3Y/zPvsuVu/Evk6KcpBNY047gfHG1/6+BjkwD/Sbn/BIFW
 1WQFcTz77bkcQAtoMWG+9s4hE5Cv2jQTIVOss6lOCMqAXO35hP0WtzEs/XYRMMMRpXBFkI6wdRdbN
 0GUNCXY1nZ6qtlH2oCKF6E2CAARNOVysttimWQF5lrJk7Yk9zzokeHZhPtwCHsHM3ZIPKCXRsOCSB
 LDBtFvPJOx3CfUONodNc4YKQM7PgxUI7kmMlYk1E68TTYF6qO+uFefeOvbouGySCNawRkNRWYIJeQ
 TMZjwtfqokrJgGs6LOERyD695Ayrk5rxUUWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N1OXZ-1rgoms0Q27-012rgk; Sat, 23 Sep 2023 22:41:57 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: think-lmi: Fix reference leak
Date:   Sat, 23 Sep 2023 22:41:54 +0200
Message-Id: <20230923204154.86815-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A8Y1TadaPlcC7con133CLsGUu8oyqTJZHMLWI4w835xYwWYF1T+
 VW8PsSkZFtnYgxPQBcjURCv+8unV+t/nr0gyJiMdsyT0KHIcLZf2+CvhAGi1wrd2yJK1spv
 VhPxoiGFwWN8DU/WmyTvhCjd6/1nB5Brs3vJj502KcsKpw3GLr0EigrQCq6unUH6FePmF9W
 jSenDXrcaGmyXtWAMVvDA==
UI-OutboundReport: notjunk:1;M01:P0:QgkEX0nLQlY=;Z0REzsNaj1uN8TD51J9SUaNiQ0e
 PPB7g+n2S0xea9o+ceBERExF07/vyzaLnoYphOFmAzV7P7ZlolDuYfw0X+NMAlYBWTHAptuHh
 i6uOGTYrVuCNHZKdB20gOWr9oL2mBsWSsyIk/NkskPg2vpyZDwU5+eVIgNmg+wk0xZkQf5LNb
 tSdhKBE6MxlgQ4Zk/I8Xa1qimrQSb9r3MwF0PnFJmKCgTw1EPfhY4mrow6ZjDi20lDLAACqXu
 Uc2NwxceNZdWtYKWU3P9LkA5BGhGvGpU16/OEA35CCQM1B1bkJBL3+3Rfdq1oLXTljzaq4lCF
 5eS3PsyC9yT944JzJr+NoI3fHvmjuG/t4jroNhA28SGrK92ouVkJ6WNss1nHq4ee9TFxrYjgZ
 kiyvwtMa1pH0pMCphncL4xf8IxwG/GdtbaXSCnTadcoe5dxAaOU+nRSkZmLwnVcrmjRhhgM1a
 JeH7dNkxAPefwuZV2FBrcVAU/ibtqzVRHnu3ktxARHOuhgwqFQHmRotspEBALooZ369fseY80
 fLzCwvHg1FFfoUVPziY3SP5ND1/S34yyC8UFqP97iuSasxoCAsDIAotWC55seTVF79HObCHCV
 PHMXMTI76ig+Ge0xVWIuG+OFg/A2BCmOvSr2fCJUQ3UQcaaA9B88taxkI2hkGkc2nPkwG4W45
 n/9lcZyNq2zypB3Jxbykz56/j7FHiAKiiXcpLA78/Z4Ji3LMTZy5lVwfpc+lohsvmG3qalOrC
 mH+3KV0iZuqfW6cM2ZKxiu7bQisD1sDnHrpgJoPwIhfY5XYCXdnUTGnQPAgAE35l6LuwkQTW2
 rBEAgWaLT4RiHaI667hjNEPQvbOtYVvMIzRddbkDbv3+3tskBe31h3RKMvfDnCABkHXXnCfwl
 Yqp2r0VFMKv0VlbSz6ATmj9ByY4iKrp1FYcStmtzRYz5CIBaOlT7FliWakyN6gKoIh20kJUPJ
 HXAO00QB9M6VMTENqtzv0FCre2o=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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

