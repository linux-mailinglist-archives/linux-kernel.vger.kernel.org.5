Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF897ADA1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjIYO24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjIYO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:28:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1864F115;
        Mon, 25 Sep 2023 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695652108; x=1696256908; i=w_armin@gmx.de;
 bh=BSN1lAPim3C7cFgrpEJfQYsSVYTrivCGYVKBfhFk7K4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PneQQp95etoJT0cI/lUkkdbdDS2YbbaG1CO9D7QV0IU4nO1BCrDhkP2O9AeU33OvgVzE5yyxwi8
 1bwg/xrYFERdwtV7EZfpJJYDN5vEpR0lnBsX0OOf8a6CfWSErdgQSiClVwx2vcgt3wnNQo8goQ863
 ZETctxIA3qNLjE3CXe0hFSY0Ouo8/+M/ietCGIR8s+A/6bSd3H7Bm+jRSc282HYz7UTSj2RLl0zvl
 q5zmFe850NJ8VCY7QEw0LQTAeLQbMZtoOnv3DvupJkoRAxwZxvr2iGoF7wn2OZUtb2I+jh2wGaEE8
 3jClp/1av/tOUdef9Bp7Y4Elt+wxFQciQ7ig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N0G1n-1rYTU43x4B-00xLCm; Mon, 25 Sep 2023 16:28:28 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] platform/x86: hp-bioscfg: Fix reference leak
Date:   Mon, 25 Sep 2023 16:28:19 +0200
Message-Id: <20230925142819.74525-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925142819.74525-1-W_Armin@gmx.de>
References: <20230925142819.74525-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QdZMaBWIEMhEI+i7SEL5ArqLK9URNCHAxIOTsXjqOlzpvSUz9km
 vbaY8ghXMed0iu5rxDL9ouEOMM/DLstv5fHVcBzhX99DFG8zQ8htGneYUeDh3wX30qDOfld
 6SNS2P0BTwEySdtXy5x1JBGwCiuP5+qnjJh2Tc1sl/CBCmP3z/lo1HFGiVjIQfkc/CLx5ko
 D+W7QkBzPnX4hbEJshnOw==
UI-OutboundReport: notjunk:1;M01:P0:fI+oM7hxZKA=;5hnQkW9m/NydIG2Vt70g4KBQKkv
 FyLbbdAuhWVox7ScpJWKA1qxOztjSJdp/rJJ35LdJNdmmNDM8nLBmIMoWfWr+weCoW+GY/S4m
 iN66ACs/WFF1Cl6aky+d4znv85uLnngAT3daGUdt1wlqK2RjLQNUtAPSKssrnR4ko3JEx8Qu1
 fPyWkFgp5imCLCufw+UEsXjNc3U8SCB9TLKKmZ1LDBi52rgWGtHd1Q9DRV0Bj6ZiFlRujH+we
 ZZy3oVY3fO5ZmjP+A9KB93IL72a2Um9VuKP36Avs19c5HJlq/4iz6OkqS7yo5Wz0/CZGdIN4F
 BvnrZgzt4oJ0bVGtL6VmVAM4mV4VS0x+nhfWI+X29HOnaJrcfu26te8A3mYE1SL9Fzt575S/h
 5ay65zostYwEUAwZqql6B6EZiBW4R1bsxMgqW3uDNssVnWsa4Cn/Fxz4PRAcIysUbw9cN0y60
 vm9pulmIm6dLh1kX2her98qnNzXsLjssfT0TY37WVsbFUfsPD85LgpV37mMUKd7QnNpvHVMlF
 2peef/UzrDs22ADUmbirADBmyOJrZHvKbHp0XBYU1idHE/zB545l6Kz8bALKnM/dbaBzVbDn0
 tUZHaFo1q3lf3+MXuqwhrjX4si/yDtwZOGW7KCmZH9bqwKwXz8wNKziKAZj4XsudhlUZG2ZnG
 0F95VyqhWFcU1d0e4hm1tBivz5+m69hRZ7+rfiWur9lgOin2e2fNWBOYAvrlX4RBczTfeEzjn
 ISa4PU6i4chLtQIu5t/ggviOLo/9qJFsF7ana2KbooAZQt4UXH5N8W8OCf9wC2jX+P402MdVW
 aSE3f3DTbTqJ0WzZvig+Zml8X5CVXD3OYRUxYCO6tieLonQVbSYZT9Qw1JP317crf77h+ijxt
 V5FpHxozIjLtXLYKhnbFJ6DBmn0dZvOLBv6rKJ9VSJ8RQeGyA7y48tiYc5oc4rqINEecY/U31
 wsfviDSraNzts6wduymF+m3Le18=
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
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Chnages in v4:
- fix missing whitespace
- add Reviewed-by
Changes in v3:
- no changes
Changes in v2:
- add patch
=2D--
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platfo=
rm/x86/hp/hp-bioscfg/bioscfg.c
index 8c4f9e12f018..5798b49ddaba 100644
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
+		/* kset_find_obj() returns a reference */
+		kobject_put(duplicate);
 		goto buff_attr_exit;
 	}

=2D-
2.39.2

