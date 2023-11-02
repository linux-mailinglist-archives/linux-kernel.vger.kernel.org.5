Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1757DEBDA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348496AbjKBEat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348479AbjKBEai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:30:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A33DC;
        Wed,  1 Nov 2023 21:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698899410; x=1699504210; i=w_armin@gmx.de;
        bh=hLJcvl2uQbgsowxxxnXe5xll4Jmp97e5Gnt7rMy50UE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=hQjlsz2FdHq/Gp/SWwdiq58Uo6Baq184LLy58UiDXpV3Png6Ap8PAffkLCZgItub
         N7Sto7VQ1etfJH/4m7drJueiYr1EvJkrqNtK4jk6x3v45fLSMNtcOZ43jhWrxV+7K
         KJDb+iGLU6jkuuTN/5CSI2A0j/+47a9eWCRJhrwGOObG5MxxyKO4VLy8RQh7Wf5VQ
         4qa2hC7kbnJGR1CD3qIqEEzdphKBq0SDfm6aDZozUC/lsvz+JL52isdYkcqB/Xj7v
         7yU1KxUlUxVUiwRw6az6eAIy4+OWpEyLpXz39ZT/fP8bvW+aFgg9pSKYC413OzziG
         dGhs8zfyFzql5xBlsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N2E1M-1rRjXo1rXa-013eBD; Thu, 02 Nov 2023 05:30:10 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jithu.joseph@intel.com, maurice.ma@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: intel-wmi-sbl-fw-update: Use bus-based WMI interface
Date:   Thu,  2 Nov 2023 05:29:58 +0100
Message-Id: <20231102042959.11816-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102042959.11816-1-W_Armin@gmx.de>
References: <20231102042959.11816-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HvqwgZNpPRgNT8UEBU2kERwOvH9bi8li4uWzO0eLl0ccRcgW4er
 gRgC+erttsAFsV1s4V1ii8XK/gh1lyJIPQag19w/igTdePy3NypHeBL45vDRq1znSep8SEz
 NU+weGYW9r5N275NiwNy4YgBLGFNQTIHDzxeYaACeHsT8ObvaDpf4DKKAf9m9NesK58rA+1
 RMDxYJdTV7LGNIg9jJ0ng==
UI-OutboundReport: notjunk:1;M01:P0:Kq3UfDcC7MI=;2K6kRDDh1rV2NB816prkxJ9vsT6
 nA0pwekp8fzTBMFl9eANc7UZBgCsNKKa1Iv9WcnoWI+fhHudzZeTdX7i6NNAdmyPbRGTOKXQR
 HgTZIefbyJgnrKKVLsGq3HTjj899RTohWZXWHj+7JSAZNc6kWTC0FPJAXLyMf5ZkXyZMGlfmh
 VdDxZeoaToAodsP/2JNqqclOXDPa3EqGuOzr4ArWHsVESKpOTlRcjgc2rBMr7BWdsT2m2vveq
 f4xUKke+H6EcrBu+DTSlWhq1TzYXy6bvWatbpCa+IkoQodGfD4ofHtPVqZ+lrDpHBzk220Hw2
 sT7PEemCjGNIv5Evjb0fwNTIPA47ygOsOUTo9FmDcveJ+b3sHa8L/0s/at5lhtG+aC8G1UsVh
 hvCa5pbeVcXoLOyuc23riJOvN1lr0UEUFPH+JIkCDxGRINz3km0kSbDcF8zERuG6Sc+wkq8Vb
 FHPxKgRjptu/PXltFJJ7Tj284MAMgJaDpTVFueyDNfL5PhyNOOFnfzfshYISnRCqIPxw+g+XV
 SvWVGrvzKj0LHY1Xih9oi19egDwuxTFEae0bpUG6ZLsmfHLsgopQVRW+khAx5v++/uYO+Kdvo
 nWmLjP+/rTlSgFaU+g1HtspUZbifMAsgKY0rVknWJ3bCnShXFDEDLnHOIGP3MFbVTQBQBSd4l
 YB44c3So2Afz+0DyVCqCQ1hs+h3AzZSPCXzTtgcVNqty57cqNKSPJy78J3De6ghRQT45KPuu1
 7RxkYSmqz3pqIZff9D0J1g3znRr/EEHMcK0Dw+R4WQCg0St/89xL+0NpfMV0PitztBuQf2Mq2
 kH
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

Currently, the driver was still using the deprecated GUID-based
interface to query/set data blocks. Use the modern bus-based
interface for this.

Tested with a custom SSDT from the Intel Slim Bootloader project.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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

