Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73597BCA84
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjJGXkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344264AbjJGXkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:40:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFC9F4;
        Sat,  7 Oct 2023 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696721987; x=1697326787; i=w_armin@gmx.de;
 bh=mQwZ7HovL0XAV0BMMBNTr9Ft336d/JL1LOfzD0c2oJs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GpUofq/aXvm6L4Hol4uEH/q4j0fHDgrqI8pj72Q2icXcTlhE1R534hZ/ykfRRD5vdxsHpiJEbZN
 zrkdEo36wSr6p9ivNdE7d6Skh/WGBI29MN9BqRzMkaqMHHfFc0cHo0nrM+AYcwJHly9Uzb17ivPbO
 Za4rA7ksQsW5ucR8QDsjBx4UgTkGghG5b/+XiNn2mcfvqJoc0WkXjOiwfTagmaSUOaWVsCc9EaAAc
 i0JI1ufGCgW8YLxDICYkVFink/XsAw71lPBoeCWRvCSgFTMRGwNi4WstiOJIYWDp7g3kI2uOZ3pGc
 YMCYNBi1Vu1jb5nREVjIU2HtNA4aCIGK3g9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mw9UK-1rgxRn13BM-00s8P5; Sun, 08 Oct 2023 01:39:47 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] platform/x86: wmi: Fix probe failure when failing to register WMI devices
Date:   Sun,  8 Oct 2023 01:39:31 +0200
Message-Id: <20231007233933.72121-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007233933.72121-1-W_Armin@gmx.de>
References: <20231007233933.72121-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9P7xsS13HCRdXoo2mkDLbWm2pkjVkLOF1PVs64A7a7WDKEt49k2
 TtQBFf7YKQUTV/arre+n6fRGfFSg3SXd1I33HiTOF55GR59moVQRjU31jN2HZJ++9qa7ZXF
 GD8HvpMUTrJD7my4E+brtcWXlPEyvRDKjarGc2uiIKnXOH2EUxcIFsk3vWUCmyEXOXaNPxI
 gG5yfLXll/59vPUqK3rkg==
UI-OutboundReport: notjunk:1;M01:P0:sEpCZUQHoqs=;nEHA27N2QBChWwPVv4zSmSsNhE+
 9qtFprUpplMHJSSlqS/J02RX+lQp1GRSjbai40YPGxB8Se7uJ0g7whgIlSmiwB6THC9xsN6c/
 he6JLCgTbfZxddNMKOaCq5scXkBqxHj63ari2SVSMpz2nJD1DTUDkArRa6RxUdWZo+YEzZxRj
 S6O+JZYYcvWUBHbULnXROqEodKNEVLMBtN+Bjw6BH5qvzX885x58ipvkXD4g9cfl28Tr7voet
 fzQWaC6abngd4GA04TiBAktyLcO5nDFPJPzMvLMLm+6qoOYhvLv1rVEjswO4es5eakdqW5pca
 fdsNWlq60ttfO1BzGanPwuODsojwVlq0p+iqrm8On+H4r9Z+OwesS/UyRmrZgnM63fye3kVTg
 1xa1QzCSreg+h/ShRijUmdR8PZS9Yfx7J9aPSxKYMimc57qOUJgIyXMM8wEdaYmlc1c2Zc5q4
 gzO8WBodkSVKWBH15Gty3dZI/v6WTaue5hPLBi5wSOXBvMT1kSnb/joJrAEusWGIyN0UT0zx2
 yjF5oeNPoGV7Tl1UpGvuDipmdWThTU4JTahkFlRLE3kVUvEvtPCv8iqUiDLBzoOlii94Ua3Cn
 C1aDchuz4x10xVUFRBjvdsCtq9diCUmwK+/Rmj96M0DmxIN7PhRZw17QO9X16vEEA590dDj65
 h8axTHurVGIaAqnKCwIKJL8iODQx/9EI2Tus846l9HzhT1Fq4a4Rq6b5cSZPJWhFzJ9nOyYmN
 GZ4ZOjp3rd1rQW3noE5AtlNaFPMP3KAZDxctYj8ON/dPvsPFvk78FoGxy22uZZ5YTsL74IRd6
 fz9NUljTnTF3JLFGJAvAGQq0K4jBMbjiPVdc01rNEuP9BiBQZvX8OHMXCjktXYLC7zMcuv+oF
 ABX7ClrIaunjwbcA6fZEphxq9bvRCJc7+7tlQebuD0TNA59FGSPZ8vKd6W06CIMr44c6LUD7b
 0109KGht1T4nNtFifjbK1kZdBMI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a WMI device besides the first one somehow fails to register, retval
is returned while still containing a negative error code. This causes the
ACPI device failing to probe, leaving behind zombie WMI devices leading
to various errors later.
Fix this by handling the single error path separately and return 0 after
trying to register all WMI devices. Also continue to register WMI devices
even if some fail to allocate.

Fixes: 6ee50aaa9a20 ("platform/x86: wmi: Instantiate all devices before ad=
ding them")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e3984801883a..ab24ea9ffc9a 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1338,8 +1338,8 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)
 	struct wmi_block *wblock;
 	union acpi_object *obj;
 	acpi_status status;
-	int retval =3D 0;
 	u32 i, total;
+	int retval;

 	status =3D acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
@@ -1350,8 +1350,8 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)
 		return -ENXIO;

 	if (obj->type !=3D ACPI_TYPE_BUFFER) {
-		retval =3D -ENXIO;
-		goto out_free_pointer;
+		kfree(obj);
+		return -ENXIO;
 	}

 	gblock =3D (const struct guid_block *)obj->buffer.pointer;
@@ -1366,8 +1366,8 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)

 		wblock =3D kzalloc(sizeof(*wblock), GFP_KERNEL);
 		if (!wblock) {
-			retval =3D -ENOMEM;
-			break;
+			dev_err(wmi_bus_dev, "Failed to allocate %pUL\n", &gblock[i].guid);
+			continue;
 		}

 		wblock->acpi_device =3D device;
@@ -1398,9 +1398,9 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)
 		}
 	}

-out_free_pointer:
-	kfree(out.pointer);
-	return retval;
+	kfree(obj);
+
+	return 0;
 }

 /*
=2D-
2.39.2

