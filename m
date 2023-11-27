Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59477FAD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjK0WY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjK0WYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:24:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097BD448C;
        Mon, 27 Nov 2023 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701123769; x=1701728569; i=w_armin@gmx.de;
        bh=LLseh1WBNY3acRfVxKNOM1h/XCUUg3y/Z3ShI+u1G3k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QhOY4wzGbHMpU6vP6aclNlgV6vqLpTFNuAQF5w5TQRGxAYukRPY7cwm3EI9TNG1z
         HVPyUTJez0Ik6hk0YJIceNPJoFMe7l1N/UeFlt9zYHYwQ6eMehJEYt1jAb43hNYoy
         E6djuAgx975qZbXYp7/KA7Ig30i9+Qg4uelGpdA2OqriUY+0jE9x8gv6fEV8igak7
         ogpLULBK5GagyXtAloqaLFJZPDqvZPTPhSEk6MkvKyl5M1i7RqwuIBgfVwWdh4amf
         5CuLZZDZCCKZtUe1vku2rer1tPOwWXW23P/FuZjuU0KUuOwl01JeqFr3asSo+wQhy
         hkyJJNep3lmaq7Gi5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MtOKi-1rRCKM3JyI-00unC4; Mon, 27 Nov 2023 23:22:48 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: wmi: Skip blocks with zero instances
Date:   Mon, 27 Nov 2023 23:22:42 +0100
Message-Id: <20231127222242.115507-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uql5fq+wzeyEGJ+9O7GxoRDLArDFJM7bvKlt/xBVlGEfFBiaaR4
 BLKj9TEv7VNvtT4+Ij03vHFnmX3+mfTFoWw1OGhq9abRZ7xUzD3/3VPWJQJRXAebxiliXtf
 09XGkGoEpXMZ4fEN2LCwNUTfQznxkMyhTyp35gkHlFf+6Zti6TbUIhaF3lhLpkSb+F9qETv
 2oWidarHfaP4p8uMnewUQ==
UI-OutboundReport: notjunk:1;M01:P0:u1v7O1NqHIk=;5EPE0aB3XeowpXGjQmXvEeixaX8
 8ZLEqOqoHVbRGs6UXB3qal2SXkTpKGdoE/i3LVtHqahhykEwalnhVzZA4UGi0v0IyIcExRrFX
 LdQmbmY+g0X8nwJoK/UZH3lSh/wzXORcQxlojqTxFJfWZuL4FS8jCtKWg3b7vu4Tc/xbsy6WH
 673m5iFEaeuAZlMvaQEkcef7c0jatu84bVcMEpC+1a91p/ybAxtbWKPCfNpLyREaz3hfDQ2Qt
 JXxCJaeDLgmdIBSqU9I3QhC+yuNNzuA5gDWRtM573qaEE45rca9qJuZGljEB+A06S6UrKLIuC
 XqLXMJkfHDI7RsWuE9Fcxw1Wg3e4RiKRm1Kz+80wZsPPbyCRNdGn7/bHwGqsx+XriDvUdrhWA
 AdNlOing73ojbVj4iqMnup2hDMRzQPbzMKkVU+tuS75yfGMaJZpiUAoR/VA4E7DlkdESWVncx
 Gs1nJ+Xh30zRL0FOXJ4aVLUQBiWVGRCDxPrV3/RBNUyWVTluYmWT/faZyjjbutOK7Qw7Fa0ma
 /ZaD2X9FY/gQoKO8wgz53VahNzikd//6rf+Y252+UkNszv1BLdtpQj9CZK9WVRy0Eynqh1oiW
 8G67v2Ljh0C4/XLTDL0AKmGfAmZngj9CTv00DS/KEG4lkbzVoIFkhvySKNfBPq0DihBKq3ALi
 xoe+mDMDAcAJwac5AACK5cvGIQwt0vfXr8BXwfA7YcLoWtttOBExbtTwXJt256j5lBNo4Md4a
 aGJxI3dg4xZRMEMd3QIeW/SlkZtb3Y9831SCzcMa7CxiixqgqxXPg4jKrEXz+KP/Sg56h3F1P
 DmEQFoVkuA/phU2qxzT+VH0yQT2ioQxDzJbkO8SUvu1kKM8+PJsusUUR/UMUHpntxH5CdXYdz
 Xg2fCrW8q0FiR99uqI8i2+MSRUMt94iYB2UNja22bvmHIUCtod66uZxGA6MSJwTTuu1/R2p7D
 AtnVOcINiKQWi1A3nWz0aNT4/Ic=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some machines like the HP Omen 17 ck2000nf contain WMI blocks
with zero instances, so any WMI driver which tries to handle the
associated WMI device will fail.
Skip such WMI blocks to avoid confusing any WMI drivers.

Reported-by: Alexis Belmonte <alexbelm48@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218188
Tested-by: Alexis Belmonte <alexbelm48@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index cb7e74f2b009..4f94e4b117f1 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1346,6 +1346,11 @@ static int parse_wdg(struct device *wmi_bus_dev, st=
ruct platform_device *pdev)
 		if (debug_dump_wdg)
 			wmi_dump_wdg(&gblock[i]);

+		if (!gblock[i].instance_count) {
+			dev_info(wmi_bus_dev, FW_INFO "%pUL has zero instances\n", &gblock[i].=
guid);
+			continue;
+		}
+
 		if (guid_already_parsed_for_legacy(device, &gblock[i].guid))
 			continue;

=2D-
2.39.2

