Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454357AD90B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjIYN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjIYN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:26:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A9FE;
        Mon, 25 Sep 2023 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695648364; x=1696253164; i=w_armin@gmx.de;
 bh=HuxM/YA2tL+Nxb3XbOiEayEMzeuXm9d7Y7jDyRhIyiI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VKVc/BWvHKGaj+bdhNV7t6yB429gQ6Bt6haE/svnGm63xPd2Dy2oDDq4/KDA7J26meRsL7Iw3/o
 nYGleMmIBdgUo8NOwdxznnGewqRxuOdDLCgMXdZ6CvW4f51DjUD4gkxUa2kFzm532AEwAcG3/bQdN
 LjBB1VkMR6APrX7pkbQBzpo5aW2w/P7UifE1E/Nh1Yf8xqcQgaLRelSrKt0c611VJP/LVwJHBLw5J
 O9mKDS1dArKNlNia5VmFAD6kDDFdl0gmBwH7uwfVc+H9e3mbGDoO7/+hQIk14s6sVC16p7lPofZVD
 xBge58yq4t8TkkZbwsvHhJb8sIlD2dRJicJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MBUqL-1qxAaR1PJv-00D3cD; Mon, 25 Sep 2023 15:26:04 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: hp-bioscfg: Fix reference leak
Date:   Mon, 25 Sep 2023 15:25:57 +0200
Message-Id: <20230925132557.72138-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925132557.72138-1-W_Armin@gmx.de>
References: <20230925132557.72138-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9azWTG25P1Zwv+Vklh1b4AJuOY/Ayb+9h38VSE0fLLG1HLeCbpT
 IYO0wioZb73wugkZrI2dd8cAED4fhiYRCKCo4c1r87FS0qSsGDSMQAQj0BwF5Wb7Rw/2XWT
 Zf+EmGW/yuvsqMH3+mXXt8kTtojsNzZ9TbIxmuyvxL229rJwQbTcIy9CUMhIjer6pUuo+/a
 Yyl1nt0BlK58Wk/PfiJAA==
UI-OutboundReport: notjunk:1;M01:P0:BxGyA+hcLDo=;ji+C+bzn2UDVWoQ3hjpkQAPx4+w
 uVsI5UdC3pFqp/cn4mMOrSPn1g6o5o/6JkhzOfB4nYIV470qYisKbSRFJfmbRwDjufkRjg3kV
 0dN0N9JIcRGnPu12Jts0mI36rrS6FJSt7cZKIZlaDY4cN8JWvlpzzuW9lewQfp2Z4nj4hk89x
 E4rjpwO7a4PcLwPUJ9b9cMwoWzynCfSthJn7jsgbZ5A/ZoKXjY3VUchnqPqZ+c+wu2LySdtlE
 rYNgXyIhDZzob8QDSfIKSmLWJZE6pECVhA1vim5ljzgZa4lijbtK1ntzqhQIWJeWtVHXD23Rq
 Ac/D1KOUs32iBw3yFPw1/iCb2FD3cseR3+Ead4Eo/60dYiubtpW9kD0HMqme6w6Sg0/BykJw9
 QcH/aimCA80cxS2Y0+H4iDc5W4GDHyDNE0hvP+YvbuUrgGElbdujD8E/llpYgIWy3Gdcf5cgZ
 6bZeTJWcyHqtcC/z65i0ArrKxdDcaZ/D04UNDroKVUgwd6UOhbWTxtrgzBu0fio1Coty3dPN9
 XNK348ibeblWi7ZshqxXEwToVF+mGBLqspUwlk3MZ4avAFb79YnbSVcPl1g/w4CunnHNXeKBs
 3whFd4SBwg12lGYb+09KpFKhZTRHfIM3K+lVt2rFvU26fMITtP2LO+z0pj6VJGGKGlXyObuH0
 vkygQahNijZilicVIQTscveAMsQMVp+XQZRu0O+RZlw4oxoDnLJo71pCz/U/7y2krlVrpWDny
 spwuxouhBhWw8rTUfC5jwz+KD1XxKhsXYV2HP3eC+sd0pRwmwwI64Cjjg4XHb4FnqdRqcZtC+
 nZi6ukjK/BJW0ibJTyeBkxRufDXL0LVZ2mXcU2m1zhT/+q64aPmSKc8OzlQu3SvJRb9zHicDV
 U4awbguxuGYJFU122MAWstQ+bRqW7V+4tujYJ+NIv8Kol/oxblIoUQ3XXnmKnjwzTtgJaWHmE
 s9e92aUPgqY4UrKtnahBHheMYlM=
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
using kobject_put(). Use kobject_put() to dispose the duplicate
attribute in such a case.
As a side note, a very similar bug was fixed in
commit 7295a996fdab ("platform/x86: dell-sysman: Fix reference leak"),
so it seems that the bug was copied from that driver.

Compile-tested only.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- add patch
=2D--
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platfo=
rm/x86/hp/hp-bioscfg/bioscfg.c
index 8c4f9e12f018..0c83e66f8d0b 100644
=2D-- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -659,7 +659,7 @@ static int hp_init_bios_package_attribute(enum hp_wmi_=
data_type attr_type,
 					  const char *guid, int min_elements,
 					  int instance_id)
 {
-	struct kobject *attr_name_kobj;
+	struct kobject *attr_name_kobj, *duplicate;
 	union acpi_object *elements;
 	struct kset *temp_kset;

@@ -704,8 +704,11 @@ static int hp_init_bios_package_attribute(enum hp_wmi=
_data_type attr_type,
 	}

 	/* All duplicate attributes found are ignored */
-	if (kset_find_obj(temp_kset, str_value)) {
+	duplicate =3D kset_find_obj(temp_kset, str_value);
+	if (duplicate) {
 		pr_debug("Duplicate attribute name found - %s\n", str_value);
+		/* kset_find_obj() returns a reference */
+		kobject_put(duplicate);
 		goto pack_attr_exit;
 	}

@@ -768,7 +771,7 @@ static int hp_init_bios_buffer_attribute(enum hp_wmi_d=
ata_type attr_type,
 					 const char *guid, int min_elements,
 					 int instance_id)
 {
-	struct kobject *attr_name_kobj;
+	struct kobject *attr_name_kobj, *duplicate;
 	struct kset *temp_kset;
 	char str[MAX_BUFF_SIZE];

@@ -794,8 +797,11 @@ static int hp_init_bios_buffer_attribute(enum hp_wmi_=
data_type attr_type,
 		temp_kset =3D bioscfg_drv.main_dir_kset;

 	/* All duplicate attributes found are ignored */
-	if (kset_find_obj(temp_kset, str)) {
+	duplicate =3D kset_find_obj(temp_kset, str);
+	if (duplicate) {
 		pr_debug("Duplicate attribute name found - %s\n", str);
+		/*kset_find_obj() returns a reference */
+		kobject_put(duplicate);
 		goto buff_attr_exit;
 	}

=2D-
2.39.2

