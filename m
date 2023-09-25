Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8771B7AD91C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjIYN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjIYN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:29:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA81FF;
        Mon, 25 Sep 2023 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695648530; x=1696253330; i=w_armin@gmx.de;
 bh=RvUmrJpI8L7JM1w0AgZ8nzrY2l+SMzgiJ9T5DMWjVFU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gS1bxp5eWBF+smPOfnh75xFR/dlXq5911ngC83XvuGbJXg6fr+wLlF1YKjnSNtbZfidkBSsm00O
 lMrczo5fq9cSzWonBwVB6OtLdqjacEfmEX4ov+smDKRjD6LiIAjMZLhZoYG66nA5+LsV7AUnwmtc8
 eIKCr01/vDaYOwRRjTX2zX9h4aIHUrhUHrSevZsyJNhCYT7Ecrvd2UeuGz21Q9JiGdDtAD2uCfX5R
 JU89oIiV7WJIMIqNyCkggTYQpZ4anFBEtJVeuiAHBh4HvPzjX8FbPst7LohkflfbdmIFxPIFRszYN
 hMu6JW/q6yuAErL3jspB7bMB1AaA+leazJ/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mzhj9-1rWpz11ziz-00vg5V; Mon, 25 Sep 2023 15:28:50 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] platform/x86: hp-bioscfg: Fix reference leak
Date:   Mon, 25 Sep 2023 15:28:44 +0200
Message-Id: <20230925132844.72479-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925132844.72479-1-W_Armin@gmx.de>
References: <20230925132844.72479-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wVU/vvnTaXPRlpfetkvvBU2Zdlhe7jV9e10G0/ZGWrqbbgyNtvq
 xBekzlXdpOcCqQ4svJlyU7WBVJfvZngztNMS7F1S86nR/UfyLv38j5tESdmMycIkM6fWyii
 YxG2nsTzhk0I4vmeeYrw3/dkXnRKT0gAC8CFHpIOjbaHrrVK+wwJM6CMJKy+quAwjJJTEYr
 NyCrdTA3QvcrlK8cRvs1g==
UI-OutboundReport: notjunk:1;M01:P0:GSnf9eeADtg=;xxaEpJW0WiO5EqPgGDnYGCQtVB1
 uZH1P6q+Xxm4wDcREARAx0vv26BpbuIEnbuTF7A7iQ6e46nLOhrtWgX6GJdUMlXOwryxXQRyp
 WVcV69dY3vpi1ovGv52qqZyf2uvIlHpibtVzvCvlw6KtooVEKDhHrZqJhB+jgM938r9Kr5N1A
 sk6ZQXrBmcWVVUymCA0KRb/D+ewtPltJjv9NHxh2pEJTWLq3OgTXJklydXJJ+xP/SFmV5jOuB
 DVVS2mTZHJyC/LdTAJIzRTaeOYGKDe8OXW2k8EF8wr6XfLC+4RHHTEEG9bqqGYDsh/0cUnT9R
 3QSw4Xy2mbfhqsNbiYkpiG0DTYZyM5+StoSdLn47t3aWODgI8b7h0FJxcxmCVaZW5fbm8LEnZ
 VHNytsetZoezoAFy9KaNu943mKl9r6gbYM04WqW9hXukCMalPME21O2ujKTFQMBMI+ZRwrl5N
 rVfm6GNEHgHADSuE99ThTR6by6xY3XHscHVAWiZfMl7NdRIjehueLpWHX6G4ECe2nNsOSYEVI
 D65sUHpmduvDXU2TlimHKzR7o/ganM2W7JxXEq4sPdN+RwguDCa7uoeqfevLYZ4EKGCQ5rmvj
 WW7ldrvehSgndoX6ViqXxEUQxLUaEAo+ASBJfuvvYugCHlnz07pwybwion3ZGr7WRK/Ce7I5Y
 DBJ5nfmAcyhPWCIbmjRTYAhXIUyrME5vI9EP3g/0JIP7X9E92nmOjx9dzp4WeZnfjjeci4EvR
 Twsrd/Mhtzf/gJ3dB+18Htog9F638lrKuGurBaeiEmMbza8ciBokjMQVZgxCGXCJcQ+fRvTK6
 Lv64Ckf6VdqrcoJMniZOE2BI5OyluM9fr7IbdX9CFlJqk/fQGSz7b9+DpBhgRcwcbsqdoq9or
 b8s4UFfxMNDmm3oYpOBB9hwQ3HgB5KGtVd4bPCDwIibWg/E6LpzDhd3bdQK9DyblVuP1Dzu4Z
 ZceKSw8oiPWEYRULD1K3KXTc0pM=
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
Changes in v3:
- no changes
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

