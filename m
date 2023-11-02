Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB27DEBDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbjKBEak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348454AbjKBEab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:30:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAA3DC;
        Wed,  1 Nov 2023 21:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698899407; x=1699504207; i=w_armin@gmx.de;
        bh=hiCnCOOKWqIILjoanAScpgqs9mhmW2+u8CmTFsuuU28=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=naalsUcRbrnoQi3Aoy2bY4ZYVgwLl2laFZSWa2Jgc4Yp9kfatwQzO1ozrrGnJFYq
         9p86IU5KYcCZAnmfqGOWLGvHOKQ0zFzLQs9jNvyIQBHkhp0+hTPo8AFXD80KaMJWy
         uXQvhhJG7av5R6CxOLKjp7suCTbq1Sh9B6Z/toyEyqX6mk23/SVT/de4/7tNQSufp
         woUM83976i/1GIRylAvsTtBPQwxSaofXapvH0V4iA67D+mu/YWDmthaQhE2aIJOo8
         K5FSY7rBM7YCYJiIkWczSg+VrglkA73U+KEcm7erCbfIOAIp5P0Dg5sog/FDLYjwd
         ba4gMuHPUSgPX6ZIPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N49lJ-1rOhXK1UtV-0104sp; Thu, 02 Nov 2023 05:30:07 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jithu.joseph@intel.com, maurice.ma@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: wmi: Add to_wmi_device() helper macro
Date:   Thu,  2 Nov 2023 05:29:57 +0100
Message-Id: <20231102042959.11816-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102042959.11816-1-W_Armin@gmx.de>
References: <20231102042959.11816-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dXH4wpvIg0gTmaf5/YM921ChFWiWve+0jtvCzuS1MvLPWeT6n38
 iblE/GhPGuyuLOj9qyDxHuklktXeQ6+aSDoD0Gm5Cgd80M81bJToHS4MUx48oxwN0HALVzZ
 /3q4geFP8xjXoDJ5a0rli162yPeQ0OD6pzLYExvLEGmVf3X9Yvp7bTtYO8MRZ8bvKXsvRLm
 R+TuFUKSdvI1RDOJt+weA==
UI-OutboundReport: notjunk:1;M01:P0:trv4r8aoRJM=;CBGUIJImpu+EV61NDFRnVqdB7Yg
 fXVnPix1GTkEo7pQDYciSthxq6sOHPIOHZJr6DIrqeLnEZ0LHfzxcWBEwAvDCT7HEXG4qmjQI
 kURO2PNLt9/wWMaoiQPVe89PrkrmuVUtJYGqHG7bckVBoS0rgueLPuXxFsIW2wp8XgdKQQFUb
 QvuxewWJV8VI+aey1aGHMlvbG/Lh/p/6dsvk7Q22z+txGOuSlSf9ylUioeFRg8DHeIFBc7O+R
 4iXKSQ1uqdSOQgH7V5tzpI24Z7KQ30u1WDtpxHxcaBcU5xplcEdWe/A7gJ3/cOZul9bOwPYdA
 UOmVgmqsCYVb4sdfjwLJZSt83Gv0gw2A8+FgQ99/Za9iWJuVRR3avxzm3GVmEYGMHjwyrWgR6
 ZIDnFRNBVvaT5EBCoE53j4XhG/V/qKga1Wih7wpjNGc5VMnwrTWxhuEHO2EZZ4HUu+DLXsGkO
 uplKtkUOx+QDwMujYeIN9Y7Ieq5OmBFkA04HQ1TL+Xa4+xBnJWbQNVarkliGeCMq052fltVkw
 dmcREbGPEo96fe5OEO9CEdrQoklbaAT/P0Kv9DqwqY0VfMwbweMNKfJ+lJbXMS33S6644rCHm
 ZW/h7P5INb+DWzYNpc4U+3XaLEEHHuIV09NULy5Z0tFY9X94IUvLsqcmlT2+ldoVado8mvvoE
 nxcY4Mm1W+aah4ycxsk1L1x5PwxNCbOB+oIdlzwLuvERQohbt8gdTujvxqJ7f2NxFmOaBsQNn
 mxe6f8Xu4d51I8+bCWxf1roJ+kS0nepbuYdzu/QDib/O9PoacQFCCo8JoOnB3CGqrzZpenhgT
 T9EISt77CIvtIPI6teD8dbZSDJ7ziRTTt8Xp3nwZAWhzbKwqoeIv0D14TkKv5WHNYPklSCD73
 AjlXpDxZI+Ay5yD99ymipQqqcHFsZeY2Mo8L0EHhWHG8tLfRQ/7xQfW4Ukp/6fNwC4e0QUUU2
 qUj7+U1wE6qJGj/oSd9D0VSCtrg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper macro for WMI drivers to cast a device to
the corresponding WMI device. This should replace some
boilerplate code.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 include/linux/wmi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 207544968268..8a643c39fcce 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -27,6 +27,14 @@ struct wmi_device {
 	bool setable;
 };

+/**
+ * to_wmi_device() - Helper macro to cast a device to a wmi_device
+ * @device: device struct
+ *
+ * Cast a struct device to a struct wmi_device.
+ */
+#define to_wmi_device(device)	container_of(device, struct wmi_device, dev=
)
+
 extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
 					  u8 instance, u32 method_id,
 					  const struct acpi_buffer *in,
=2D-
2.39.2

