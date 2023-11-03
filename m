Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF97E0818
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbjKCS0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbjKCS0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:26:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01FDDB;
        Fri,  3 Nov 2023 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699035940; x=1699640740; i=w_armin@gmx.de;
        bh=i36tD1QYn9dhwHa25UoRBx7h0+TmiSBQDnw2y+DAsqM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=nzLRXjwpXJ1pWX41eBLZj01F254cLyGM0EF+pRdpKPXFFrvY5LRbRH9EfeomGQ0t
         KOmo18PwkpGw1kdmZiXtjp58Kg+o3gLj3/bv1wQ7mXgsQTXDC2dcWr6yeGXUn0M7x
         O77zQY1hcJ9fXvElSgvXtiiK6EPuEAtlnS+ms/AOPMJPxZ3qEzcVaCSH5B7A0dGAi
         rv/D7gjP4xp/sK36BRBclCp4VLCekB2JfcYMS7arc9blYvW01zMDSo5zpORBqbqux
         0dzPemJVUNnZoDf60mDCQ5l8gWqn1UvlfDybP+InCFOvbmW/gLgw+kvD8/klH7Jq2
         EEMTGg4vHuRWpsi+6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6ll8-1r50Ti0mDu-008FW7; Fri, 03 Nov 2023 19:25:40 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jithu.joseph@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] platform/x86: intel-wmi-sbl-fw-update: Use bus-based WMI interface
Date:   Fri,  3 Nov 2023 19:25:25 +0100
Message-Id: <20231103182526.3524-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103182526.3524-1-W_Armin@gmx.de>
References: <20231103182526.3524-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AaP64+KHZnr5BXSZcOx2OVUpcDL3+HBKoHw8xuWWKttoJuB0VEn
 2TfKdnq89H4jop8qmWyNWHVKJYxXAQ5psCIuPncldDOAIVVN9QcqV92RpWCqTjnNQtiw+RL
 l5ppe3f5Rj+B7d+X2wpCKpfbde9ai1sfKV4A5e0PspAdzBiROegx69st3pmRNfBkZjSCKDb
 Nq4UG1NWZlwuoNLmb2PKw==
UI-OutboundReport: notjunk:1;M01:P0:ziCUaDBy414=;+U93VciwvS+TRr4boOX27R6534O
 WVrw3/+tNPc+UQ5/X0m5vs2mJWj7FIXj0kabmQt0qSC7qsUMhY+C5djm/gE1h2YB2xng/TM/M
 1CzHweGotv3FjRNVhIwrvqsq7HlZksqrIzyVrKzGBZArztVByQc5W0Dw78ItnWZC5Rmuo8GOX
 QhK7OOYjbrLTryDhbkgrxHEgoPs3ZLHQg4tQHbS7LkhcyMaqtQJ9MppXRIWGSv9A8rlUeWTmt
 rtCVNdk/xb3p2UqwFwGG+MN8CdV2pHpanQy3uLGmfwV/yKECRbAo2p1tRrlaOa6F+dY55y4hn
 VEKwRAEdYMc4jTHekY5Dspx7cmpZQ75sP19DeGBpCq3F5nApNNaESmhLJryStT3XeGTp0SxsQ
 DeDhtVPiwVkf1mREN0pxZ9iAz+jxE/oT1TT6JQ22oShljNVv36XwyiVx1w1zr46zd8N5RkhBE
 jhYnF9Ji1b6FEzHKIDpidE4UgSJ2CdFxgrPmSHVzI2+ZUnbUmFEcsy5E92iyLk1hf3PfAglEg
 rhg9KlJXQmrYwAW/CBqCG9TZt3mLmjClxO80QPIk7bYLBvOR6WCRzM6fmva1it0rXEOjJRzAe
 DmFsCigJsTL48BY/mWbwPZDR80BFzf2bwhaQgb1bbcxrWIr++EpEZc8j5JfYUJbVqRucNtkto
 dhRaydiVM84FdOJjiuzzUnuXhWvtdzBIbUnXvlJcojMXaDopyve+wY/8o4yeV7QTGk96rNBws
 ESPnHPgYMt+6lF5K4P0L6vS5Rd6zp6cYh1i+6wx8keoNK2ExgB+UzXvBUwJRQkV48LQVVsaMQ
 x8nsE+mdOOWb0lvgMEjs+ya3f07fm6gq4aW1FLIX8WtjDIA2vjLYaR0QPc3liGUcjik1k2h/E
 k236nNZhpynvZ3uaot1qrmXnixgqtoQu1YcmTfkQmqKY3K5mXrUZYZXmjBALPHiumPKi7gSNb
 1JzY4bCUwvDxqKODQ4FOcmP0ym8=
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

Currently, the driver was still using the deprecated GUID-based
interface to query/set data blocks. Use the modern bus-based
interface for this.

Tested with a custom SSDT from the Intel Slim Bootloader project.

Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- add Reviewed-by
=2D--
 drivers/platform/x86/intel/wmi/sbl-fw-update.c | 13 ++++---------
 drivers/platform/x86/wmi.c                     |  1 +
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/wmi/sbl-fw-update.c b/drivers/plat=
form/x86/intel/wmi/sbl-fw-update.c
index 3c86e0108a24..9cf5ed0f8dc2 100644
=2D-- a/drivers/platform/x86/intel/wmi/sbl-fw-update.c
+++ b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
@@ -25,18 +25,13 @@

 static int get_fwu_request(struct device *dev, u32 *out)
 {
-	struct acpi_buffer result =3D {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *obj;
-	acpi_status status;

-	status =3D wmi_query_block(INTEL_WMI_SBL_GUID, 0, &result);
-	if (ACPI_FAILURE(status)) {
-		dev_err(dev, "wmi_query_block failed\n");
+	obj =3D wmidev_block_query(to_wmi_device(dev), 0);
+	if (!obj)
 		return -ENODEV;
-	}

-	obj =3D (union acpi_object *)result.pointer;
-	if (!obj || obj->type !=3D ACPI_TYPE_INTEGER) {
+	if (obj->type !=3D ACPI_TYPE_INTEGER) {
 		dev_warn(dev, "wmi_query_block returned invalid value\n");
 		kfree(obj);
 		return -EINVAL;
@@ -58,7 +53,7 @@ static int set_fwu_request(struct device *dev, u32 in)
 	input.length =3D sizeof(u32);
 	input.pointer =3D &value;

-	status =3D wmi_set_block(INTEL_WMI_SBL_GUID, 0, &input);
+	status =3D wmidev_block_set(to_wmi_device(dev), 0, &input);
 	if (ACPI_FAILURE(status)) {
 		dev_err(dev, "wmi_set_block failed\n");
 		return -ENODEV;
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 9d9a050e7086..4c4effc883ae 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -106,6 +106,7 @@ MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
 static const char * const allow_duplicates[] =3D {
 	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
 	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
+	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
 	NULL
 };

=2D-
2.39.2

