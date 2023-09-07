Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AC3797012
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjIGF1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjIGF1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:27:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2A1BC1;
        Wed,  6 Sep 2023 22:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694064407; x=1694669207; i=w_armin@gmx.de;
 bh=VL89bgwCVumbjJHekcMuzXVA40kQqHLT81C/Fqe5Plk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nN1ugWyyYXysS8jjEXB6WbZ6GtnkT1A8PS4GPjrzRG/PFYfwd5wrZOYWcOANtmnUip1RFuv
 mDt0vSm9elSNU9pWCuBA93AJGK3YLgJ7H59iTV2tdlBRdympka7FOdtlre/kXNx5INUd25gk2
 RzYX2bD7zams2OoTyf1qm0I3ysR4bgPOcTotxAdZO7qNLhyvBKncC5LS47TQNS+1YezzW4U4H
 OrIsXTu7Dk2mBXEdicV7xvnWxMODiSf8rR4gLVbeVqs+Jc0EVgpW5TP4Q0msaCwUjeK5UKP9K
 cidOL4gvsPqrPPkZLW2DilHyUv8lo0rsFRI06r/dn0D0r7H3W0Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MVeI2-1qEmfL17x6-00RVa4; Thu, 07 Sep 2023 07:26:47 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] hwmon: (sch5627) Disallow write access if virtual registers are locked
Date:   Thu,  7 Sep 2023 07:26:36 +0200
Message-Id: <20230907052639.16491-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907052639.16491-1-W_Armin@gmx.de>
References: <20230907052639.16491-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V2fE8OIZE8d2olKNcZEIJ3FsaigRDSkLapPtWqWI5T7ks7ZZlfC
 CflLr5/epONeoXjuu1e7GPSs9X6B2gQ3T1W3NzRe0v6DyrTsf8XnmEfm+4S0Xg52nNwyMmk
 SZ0GnMLwWKItjZ6aeB/FyKgAh5R8auRR/IsBbBvle1ymkhPlNqcMs+VwovmQow912/UYoXN
 xVUFfRv/QYcgBA0YWJtzQ==
UI-OutboundReport: notjunk:1;M01:P0:xtplv7GNq3A=;gK9d4wS87xn8uR7BHOhEMkiHTlP
 HtxR7FG7SPQ4tL1KwpRG93dbkh0rpeMSQRC5kRIGmnlHoT2giktz01RvSTIXAPBqS0yqhd1cl
 xETPvlaTVIiqUjew5PoQmNxD5gOzs6l8uk8qAdSbGliN2mDVJqniEjv2WqHvKRXO/OkSpPl/b
 dQLmKWvn24ggUnPZs2i4ewSrGZc14Hdiw05oA5r/HNNjpWdW3SRBJKjg7jzVRW+rFeqDvoxQx
 kJGZL/8XfPFUUD/Mw5IbwXu9H37voZLoNQkGl0ggg82FksOuZzc0ukd+DBICgVUSjBDQwpBk7
 HzOQR7hkiOjZCtHh2O8SewFJId3naeGw7R3saPXVTFg6NVBnVx2NWWD4d70hfq3Bk3aOfBoSF
 YMSbjl6JFOzrT8+3BCC1qP5cr6j2AxF2+nAQBfoP64Ywwh2LwxENVxqmobLnKS5kA+NY9hxnA
 auYrm+YA1/MmsM0IPUGihHBZwXfXDjYDfZHEPom1DWxbWyX3WZM2B7HIVBUt1Y4ojWiwbOK8Q
 la7RsOZJ4u//joezE9tW6hXeJSZaNH7mqPoLCr51z4HDjwFmtfcSRcU448Dv5FwqLixlx4pJn
 JrRsLiv9r4o1LjqMUqkyyvGdUgP9GX60/8GrZMitZrwRTfM+4qqVOw3iCT3xAZPGnr+nOLNF9
 PmAtdNp59cg31VonvNDEpE4PPmx0IaJ93RbGsmOYEfPxR0s8b4m+gbDdlXYFJC7a9uYhfq/Xt
 sk8t1UXGVgn48Hzw+nBe1ArcaVaz2FhwC4cF2nLUlUNGTFVO9HNxveI8cYm9LUbHnFNUAIvSC
 iTcIz8HC51GaI7nzAfpeyX9aLEM0SS3OCk6zMGKiTmQz5CwRZcRxpT2+Cpdt785XHfyLA6mJq
 r+okl8lmMOboT6gJBUDDRjmMBqqjdb5/+KHvvWPDKVuvqgjnQEzWtk9UatF8+cCx9aGI4Pxn7
 SV2aa6KBCkl5d347TEPChDcW9Nk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the lock bit inside SCH5627_REG_CTRL is set, then the virtual
registers become read-only until the next power cycle.
Disallow write access to those registers in such a case.

Tested on a Fujitsu Esprimo P720.

Fixes: aa9f833dfc12 ("hwmon: (sch5627) Add pwmX_auto_channels_temp support=
")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch5627.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 0eefb8c0aef2..bf408e35e2c3 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -34,6 +34,7 @@
 #define SCH5627_REG_CTRL		0x40

 #define SCH5627_CTRL_START		BIT(0)
+#define SCH5627_CTRL_LOCK		BIT(1)
 #define SCH5627_CTRL_VBAT		BIT(4)

 #define SCH5627_NO_TEMPS		8
@@ -231,6 +232,14 @@ static int reg_to_rpm(u16 reg)
 static umode_t sch5627_is_visible(const void *drvdata, enum hwmon_sensor_=
types type, u32 attr,
 				  int channel)
 {
+	const struct sch5627_data *data =3D drvdata;
+
+	/* Once the lock bit is set, the virtual registers become read-only
+	 * until the next power cycle.
+	 */
+	if (data->control & SCH5627_CTRL_LOCK)
+		return 0444;
+
 	if (type =3D=3D hwmon_pwm && attr =3D=3D hwmon_pwm_auto_channels_temp)
 		return 0644;

=2D-
2.39.2

