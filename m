Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2A7DEBDC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348487AbjKBEap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbjKBEaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:30:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7B9DE;
        Wed,  1 Nov 2023 21:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698899412; x=1699504212; i=w_armin@gmx.de;
        bh=HfgLBfuhdhyyVQd0Svg8PK5e8u/Fu2fbuxkzO+iKCZw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=BEhBPV1PjET98tn5jLKug9mLBkZmcDA7+PMDtVIkRkOGLoeNPSsJ27/iTdmo+PkG
         8Oph2/8AbCXEVOCOJ/M6deoCqV0Fl9FIoX7YNO8IYos84+MS2q0dSwlyTuUfsN55a
         TY4Bu+ENa4CIGSP6jN08BP1tpjtFfxvuURTj4sBL75GBKymuQLGqD4Y7pSsA/I3AG
         yWHYP3b5lXyOKpqnf9p1NJhlfT52M21jBTFgJncu0jgnf5qHw0YvjfFt/L6P+HGut
         HVcjmF0fVMsRB23AqvKw6He91nAZN6pNq56du13L54h0EBUwvJDvHbbnUBKmudMx2
         /r+Jaih2C9qLMHtCaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N79yQ-1rWhLs0jwy-017TvD; Thu, 02 Nov 2023 05:30:12 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jithu.joseph@intel.com, maurice.ma@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86/intel/wmi: thunderbolt: Use bus-based WMI interface
Date:   Thu,  2 Nov 2023 05:29:59 +0100
Message-Id: <20231102042959.11816-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102042959.11816-1-W_Armin@gmx.de>
References: <20231102042959.11816-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5RSM1K8nSQI5KQV5exXrYTjw7yWqWGkTtWBczPDi6Xf2u9bc61A
 /NWyhxMGt7PG+6HXbBZ60xUOqGRokci4QMJ4dBIRxM7eoHn7KpMYQ9P3TlczIsmF27IqKw8
 0RyJjb9xuVVw3r+6JKgce1GfCvedRKHUqHna+mjOy/dDDiuZNdJtN0Vqz0FniTf0hYkwU5J
 EX0Ob65RIJamWQLziYkuw==
UI-OutboundReport: notjunk:1;M01:P0:kNuQK5NYFiA=;7ViY7jBwB04uscd59ANqsIWbWMz
 xWyD5XGkMDQwE3e7qd5bWTgFAYF91fQLJPAj+5oiKoeLjPbDliy/H86LlbDHN3dyXEEZtHRpI
 c8RKPhYQv+akAA9OCSF+NcX6AeOcOl3vgMj8+iRS19zxCQ3Cy0jWauMWuDqcrrkOPe04lkf55
 x41YyRE5c/xPFp8G2aIt0OcKeRd/EWPxPnXBlTqap5j2XGAudXlVagqLXkUQ9l9ONxiRDObU0
 cqO8rxTTEdNiNvBCFAd15nxvS8OrBhTKSpsRPwIBAGwEiW8LjohoGSMtjjUtk7+KVioVxJUNC
 LibEReIpTTUVOg73yctFOCKcgVLVdfDhuZvI0PB8VgUaViecB1JjmbGz9d/2TzqDo/AqUCBfu
 8Hjvp9SjOF8Mw4jUZZ7tXgwhjQmy78Q8BAQ3xTDkBbCmiIBUbGCL5ZyxVovp5MnO/xEGuBFPO
 BLg55qi8JsQTYVKEWGstMAuLK/iy2cvA4qvQ8r6qkZaNnf7mP+Ty1EBZ+YIX/yqcqAuBYGpp0
 2b9/QrBX+XTYoheYaGmSoi39FmsvrEyChD1c+dSZk17TjB0Kc3SPlVNIej59Am4NAdWTxKoxa
 hMJBWpNF+Y8cc5OyVYYkBPw68tpidUcn+PqGDZPwOvpj4G5llrcmLXvzJ7nh2MwmGXudOVKGE
 WxvassnEtnNUOGxYTH3+v+hYY42f+M3AM4jko7H23DsOXIs4r53m3nJuixwL7Pq4o0RRAZFnE
 8PxXC9y2al6LnZ57C8Rf0S0rkOas5jAQ7Buo7o4eMf72ifdramRtaXd53tFsOGCmh6r0otfFP
 lm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver still uses the legacy GUID-based interface
to invoke WMI methods. Use the modern bus-based interface instead.

Tested on a Lenovo E51-80.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/intel/wmi/thunderbolt.c | 3 +--
 drivers/platform/x86/wmi.c                   | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/wmi/thunderbolt.c b/drivers/platfo=
rm/x86/intel/wmi/thunderbolt.c
index fc333ff82d1e..e2ad3f46f356 100644
=2D-- a/drivers/platform/x86/intel/wmi/thunderbolt.c
+++ b/drivers/platform/x86/intel/wmi/thunderbolt.c
@@ -32,8 +32,7 @@ static ssize_t force_power_store(struct device *dev,
 	mode =3D hex_to_bin(buf[0]);
 	dev_dbg(dev, "force_power: storing %#x\n", mode);
 	if (mode =3D=3D 0 || mode =3D=3D 1) {
-		status =3D wmi_evaluate_method(INTEL_WMI_THUNDERBOLT_GUID, 0, 1,
-					     &input, NULL);
+		status =3D wmidev_evaluate_method(to_wmi_device(dev), 0, 1, &input, NUL=
L);
 		if (ACPI_FAILURE(status)) {
 			dev_dbg(dev, "force_power: failed to evaluate ACPI method\n");
 			return -ENODEV;
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 4c4effc883ae..58e7d5d535ba 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -107,6 +107,7 @@ static const char * const allow_duplicates[] =3D {
 	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
 	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
 	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
+	"86CCFD48-205E-4A77-9C48-2021CBEDE341",	/* intel-wmi-thunderbold */
 	NULL
 };

=2D-
2.39.2

