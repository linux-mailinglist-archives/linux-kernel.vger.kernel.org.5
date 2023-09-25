Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBF7AD90A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjIYN0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIYN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:26:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EE410A;
        Mon, 25 Sep 2023 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695648363; x=1696253163; i=w_armin@gmx.de;
 bh=Qe06h0Bi3b8dnIdSEPIlPP+FKLAjfJF1Asqt/X6SREI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RtnCNe075xbF4h002PPb+P87CErOfGjkR5LmaLDmMZRx67D3X3DaRowqCB3673rof4LWWBmZS+/
 zBmEV6UEdvyvjTsZjNmsUAmmKrXToMJQooRFBuzvy4ZP2GGeCT0LLCpvwXQG3jb53b5ebVHW+GpCS
 ohjwu4wc5SfY3piyRKla9+u6bfdxsgWVyZdPeNST/MHKOriv5Y7Lobx5MmfuSzhTfcqMqIwS8xRMR
 hvLo0tIaYC6pJaAqJONHhBNPYQKajdljeY52O/Z/oyEPljsvSPj4icXfGgfzhIRGkvW9leRjhkR1d
 CxZqbVPzPUqnY2++vvQb9cM+n9GssLRyqlAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MfpSl-1rHMWo0NDN-00gHwR; Mon, 25 Sep 2023 15:26:03 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] platform/x86: think-lmi: Fix reference leak
Date:   Mon, 25 Sep 2023 15:25:56 +0200
Message-Id: <20230925132557.72138-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925132557.72138-1-W_Armin@gmx.de>
References: <20230925132557.72138-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MdlvI2rMo4ZbRgRZJpII8yGgRGBWT1SmjNKnupMnvboAYdAhAY2
 8TPq5ZWrPjcQNwtrkr8S4Uv9pbSuxyAXOGuIuPtUww0l6EDtk5hsITk3hcchD5tCCLuKVh4
 NSD4m1FIsNMIJtB/v+h8mC3s+wQYA+wUm8tBiTuGe7n81rLrJxlRmQ0VR4CTRm5gF24I7nQ
 V4b5TUsvK8TXC3u4aQO0Q==
UI-OutboundReport: notjunk:1;M01:P0:olKkaJhfIwc=;oa51/MpZQBVGURUzVJ8ACTj9OH8
 VWyPJ21gjdF6ZFd9RNfUdY4JnzA0TiKUAsNZbt4F7kbESFSqe7P1q8kO6RiHzlnsNsMYW3lI6
 RVOEhc06QaeY/BLoi6ux0cBaQvaomXZkwVecDTt5+HR2l/+GWMSS5IDqglLOCZI/w3dqsZiLX
 d02WH+kCqlWVWF3ZhBFIhXZSKUafI+klipjrY96TpqKIpVeWjPgAMkSuUl2Y+3noTUT5TJ8A/
 6ZF2/jvRe2lWnAklwrfG0UEnyu1VLQmT9KnsJJkkfaGt19QVK0jNsUZ7kEllvof1jLET7haFE
 uPre5pfkW/B0Ue1D+1STIB1SDwG+Z8K5rcnL1w1lrL3n93zZNrUm5h6oa7HNKJlUxCav6OOTd
 sfmAQWdYH2YoXS7TdEgX8e9kF30FgGjshkfP3mvDKSkwqmXrZW00qFNkscxjMijzdoQB9/Tpe
 mZtSMKSr/2/Plc/7K1n/LVqKI2hvt0tClszPwWCDtUnmB8FBbiTd+5kNSnfv5IQuUUVQ9Qu6G
 NF2SMpwMNUi07cn6B73HUE+scWh21tppUgmd8HSrWAmIWAncbMvLi2Ol/tM18j+Nw6c61+txu
 73P35Qyq+zxfXu5jsw1X1VzkyByWU7wPYkWINBGKTJOGSE4VGFhrdVWMRD0wBTTAMr0rguvIf
 ctewVpR16DFjMvxZvKdNWDszCdgbqWT7qi0k8ndFES0ULAlRz1X+a3lP9bRIvuR/nnBeTYNtr
 99j3cWWQS3HMhp8K0umoTazM5we/sg3c4SCBrTc43BY05+FwbTcvf0EFO2kln8k468d+O1fQ2
 7gFNj9CwrkkoCL5eZKsCl04u5Lqyv+QQsZ0Tij+SyuyuhTrp4YS4suAUe0cuddEXTjt8S9kbN
 G6d/ZMeMdIDG4dJTSPr4XGJj4Bjt1fAH9lasfJaHTeBUNOD0WdjhOwH++GQRxjVXqb4cVxARk
 vEQpuQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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

