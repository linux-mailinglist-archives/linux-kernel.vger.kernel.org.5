Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E277D17DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjJTVKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjJTVK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:10:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA4FD68;
        Fri, 20 Oct 2023 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697836213; x=1698441013; i=w_armin@gmx.de;
        bh=mQwZ7HovL0XAV0BMMBNTr9Ft336d/JL1LOfzD0c2oJs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Eh/dJbbsnRvIaOb/QLKYI3GmINne3a2xuiYHq0DnFEeiRyeVXFKSVIH5KFTL36NL
         YhCkhm4rb9bpQKtdF4VhUw1u4xfoJHS61lIpHA4LhdXdifi4zLhBBrx5GQAEZKZxJ
         3i/TNQjYfYrfWgkOZLRIY9vPLNqhxL/zLKnwmui4TwgE8b6gamhjPjSR1NxEz1Az3
         QNNpDYZVucwLuOk0RjHFPuhZ0I07uHPsh0ZK3k79EhOKgGFyY3K6hFok0xalXCbc9
         Vd9xuzZsanyFIXCXmLSk25A07/CpbaFfgB2JzyXvOpP6wvKSNB46L54z3KHcC9G+O
         irYXG4blPWRoojIkoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MCbEf-1qkqCl3eN9-009exu; Fri, 20 Oct 2023 23:10:12 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] platform/x86: wmi: Fix probe failure when failing to register WMI devices
Date:   Fri, 20 Oct 2023 23:10:03 +0200
Message-Id: <20231020211005.38216-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020211005.38216-1-W_Armin@gmx.de>
References: <20231020211005.38216-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K8Pj/GqNVdzXRi5ZvkOjbKr+5ZLjUujG7t6fVgbkc3m717NSP6V
 Y18A7m5/H1ElSS70TACGg0s4+zszPRBQdNBmlSu0yntNwkakCl+vkswZ37THoqauK53Njnz
 /M7Bg9mj/7UtKKdoM4//HwY0UWMURUUPyaWGdbuu9iMyUxHJUCO01yvvfvMYKjwQN7loDml
 8XDfdskdYda4YvnAV/BaQ==
UI-OutboundReport: notjunk:1;M01:P0:drImnaOOQ28=;AA/Bxy6dHJnX38U588CRcqYdFvo
 /jRkmv+JeN8SLIm4kh3GrVJAbSRyVKOBXH5rZP1EUYIKjo9Ew9rtrrZ8Xq0dTNAClLUAcYPMc
 15uDjz66NLlLeba6LnOkydhmnz0NpZoyuR9U65hNEs/Nv+lF6USmavIXk9X90W0T+4e29nKA+
 pPwaQKJNnIhibLU/IG6zcIVZzIrGR9Zsa57t3G7o208+UeN/3+InO3gvi5OIsz8NwkI83XKZ6
 iWSwyvB67f/MrAZC1Bu6jsk/ZB3O3K3PUWZhWEGruED4U2Cqm/v3U/2WeF1jsKg8mDi1r9eFN
 PNpt89hteaJMaB4UT5uG17PA3pOkykCp1V3xOBdO9+zNJ1odVYa+0ss3qyXgXkSvwQacWnHmd
 0yXKxuh64CCjfwVvXMM1Y0TtNKkw8Bx3q0cY7YGTI10OqHdzvPtswozKz/0IsyQe+++uvTRvt
 7iCR0xMLnFTO0THocJShK2apS9uNfCuip/ADLzuzN4ssllLIN2trWFNrQ1ljqvid94AnZHhvg
 4QikppiZspfFHJgxfYKNsDgEAOP1xq+pfGx2mZWmax/0W9MOXMu893F/twuDiaOSDTYc9JOK7
 slGnwqaaFCiFwxeREF8TFd7GaqwRF/7uY7dI5RM4NaOT04eOf/e3jonbtGY7em0DDREc+9wxs
 0IPZHIobq9f255Ipt1tWX70EDB39we3NzzxTvDSpmVXowfwLl+3flcA4xt7W3cWdBQ9B7kaZS
 iHNtOjI3MAs/Vlhj2OjEQN+ZjcK/R915Fi9OyDaQuobHi/lPv8W03HKqmM2Lt4qUQnLXNHLZ0
 t/WujHUiHtTuIaH5Wzv561NSywc8t59TMa6zGv7rho7ZpHVtBec7G3OD+jqq0KmZa9eX5NRuk
 rRqAAgBikONjg0qlaeM01CRubWhUDPUHjOk9BxoEkKauQ3bVROT4gFT56myYBegwMH5vPM6Ah
 jqLnp+HT3Zyh7/KvZmcsj469OOA=
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

