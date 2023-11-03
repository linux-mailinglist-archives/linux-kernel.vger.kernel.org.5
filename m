Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C07E0817
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbjKCS0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343926AbjKCS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:26:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28C1D42;
        Fri,  3 Nov 2023 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699035941; x=1699640741; i=w_armin@gmx.de;
        bh=Z5dAMbcnBQxUiQr+2i6K8kI0C37Gu0hZctzXQKi7oBo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=ThsaoY8nA4byoh7XPEfkZCVloF+sGNgsvqofk/YhOBFGJbVQI7rXh9DFgKwObkAD
         Bho5ihwj6+blZnLHt34Dnyu3AXwom/+A3LCuJg2S1+L1E+Pr6rzA81riMG7cJXG1A
         27QBt79AvMhRRghaCn4LVsxAQcSWbDYFJ+p0C8h79qoSADEXxCTOAvMZyinSDyU2v
         GAnSHCH6gaQUA/3YkzJ0UQBep+nAvO3QsZ+yMvyLbf22yOLjDDSv/TA3LJJlvAs+0
         XSAijv8B/7zczN0c8VjHvBcu8Iom5CT7YkssBebUUPOK+C4NWDHyKbwKKIVyurj8A
         xuXmdZzmjKSxqTyACQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MRCOE-1qkjnl1plk-00N6Rq; Fri, 03 Nov 2023 19:25:41 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jithu.joseph@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86/intel/wmi: thunderbolt: Use bus-based WMI interface
Date:   Fri,  3 Nov 2023 19:25:26 +0100
Message-Id: <20231103182526.3524-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103182526.3524-1-W_Armin@gmx.de>
References: <20231103182526.3524-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gaIKG+CePLf19X+gUNd0+a0OakueDvCLal+nVnqDeKTwBqsF3mo
 H9iqgnsMgP8xf1zU4A/kkw4FaI79FkDsOyO3xoqai8a8P6inHGY7tfFSIZ3uESqLVyaZ5dz
 SMx33Darc9YVcmAm0025UD8P+ioywLZXqLzzalRXAykfjKaJ/UIjTNfgIMRL6to07k0MQAm
 ofKa2ZmvG1o8sB1XPg+yQ==
UI-OutboundReport: notjunk:1;M01:P0:q8UMX7KAnko=;4OSPvC/EVc8P4XuVJXRiDEyNCdx
 8QvXoSv3IXtwguCojCI51nzg1QG605jASOAec/CafX/7v/IcMtmuvJlLW5fvU3k7ro5AwOqQW
 GKozNSCkOXcaIPfzkmoU6NWv7xhD6S7ynZGLjxqPMrcROc/lrUEANZ7QsHg9TVKUzsOHltFfF
 ZCHpJO35lgTGp6FD/7XLrILJxgaIMUwaVb9VRI4Ofk8C+DY3PFyQAN4qDuuOMf/Kh3eiuxRih
 mjVKWSeDIxfO+PC0NwYWo0k90yxJz2rsoBy5UgYcgfBLs6lqWhR0pckwTNNvewivVcpBaTC4Q
 DJUY7PVFkc57dyVaWMEcciN/afh9eGbtOZqdBM44hqBVOUWZIAo+GfWDhfld2QIYfD8KTbniw
 GEFhcWcqC5UPdd1XPAQgokRzAf/YVG/aTFD+xldRHOEeRiw1bsoq4RYqsPxefluc+U0B7ez0+
 NcXsNFkwfedlEOAXYIo1FfPOa44V9IxtZwY0X1p4MMt16V1XQ1QyY0Y24d8fSX6pjBjiv0iFO
 rpT6EKyljV82tTYTKetCJfs1YruX84PJaJXzYfarOPcIH65pTDp1/jACSdWNliMeBW/M+5iGh
 Z0lm5Jw7xRJGoMojUQlWhIKNExme+YL1m60jXXVRjHrrbPAA0V/jA7SI95ClTffnpF7WSgt2h
 e2iHI8uBW63TCTwj44/5e75vbL6NOgfU9eqBr62ow1jh1ZzEJVESbiPCKB1iLqEzySdbDuENB
 x9TntJS160+QyjwSpfRu1sw895GEqqf3cxSrCejtfb0TWhlGhR80Wm5HwnDnjSo7qJQIpucSY
 4zYey2bQMyNNhn1hMhznliRwlZrhq0wiJaLOMdXhfqz4uAJ8M4Tk3ILXLr4bBOBxm6AP6vbrM
 4i4ycZ+A+mf+bsWMMqIaQCpXyuslp7M91NZUOd1LxKrtGmqltUlco8BdxrsC3fFwC0BNALg3W
 XwV+nj15MIj5ETQRVsDp8kYQtNk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v2:
- fix spelling issue
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
index 4c4effc883ae..cb7e74f2b009 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -107,6 +107,7 @@ static const char * const allow_duplicates[] =3D {
 	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
 	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
 	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
+	"86CCFD48-205E-4A77-9C48-2021CBEDE341",	/* intel-wmi-thunderbolt */
 	NULL
 };

=2D-
2.39.2

