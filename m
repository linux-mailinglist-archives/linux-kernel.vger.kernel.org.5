Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9772C754C19
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 23:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjGOVYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOVYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 17:24:32 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21E62738
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 14:24:31 -0700 (PDT)
Date:   Sat, 15 Jul 2023 21:24:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689456269; x=1689715469;
        bh=D16/wC9ybg52jiDQV5+eLtWgvfFQ5TkNWX0NVbvr7UM=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=HEgOvr1gXJfy3G3zyZiPwPxBdoD7tktehWXIfQl+Sm1e2Hm0s/k6GRcV8TV+XeZNz
         hh8E2Eq8rjgZURZ0ZRfjRfW072M6VW2tbTnwUmR68cifj5lxylUJ4SuXjdwjbtzp4j
         m6TA4hW/B4Qm7a7kCNlzCvAarU8o9HHaytB9V9zCCUOo/iBXBKSccN4t4deV7xOzig
         BZhJaXNO8bYWBO4lGuqrWPg1+ySeA2MC5iYBCsq9yDmYF218ldwWyH8bj4V7Z2Mh5b
         GB2iE57fDk0zm0nOV1dMfg4J7FiTD4WUwn7GeTo+TqAtbz0eo2NLOwFHVfCouI3faf
         ikSm1Ec7BpaIA==
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Armin Wolf <W_Armin@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [RFC PATCH v1] platform/x86: wmi: Do not register driver with invalid GUID
Message-ID: <20230715211604.1272227-1-pobrn@protonmail.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a WMI driver's ID table contains strings it is relatively
easy to make mistakes. At the moment, there is no feedback
if any of the specified GUIDs are invalid (since
028e6e204ace1f080cfeacd72c50397eb8ae8883).

So check if the GUIDs in the driver's ID table are valid,
print all invalid ones, and refuse to register the driver
if any of the GUIDs are invalid.

Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---
 drivers/platform/x86/wmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index a78ddd83cda0..bf0be40b418a 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1513,6 +1513,19 @@ static int acpi_wmi_probe(struct platform_device *de=
vice)
 int __must_check __wmi_driver_register(struct wmi_driver *driver,
 =09=09=09=09       struct module *owner)
 {
+=09bool any_id_invalid =3D false;
+
+=09for (const struct wmi_device_id *id =3D driver->id_table; *id->guid_str=
ing; id++) {
+=09=09if (!uuid_is_valid(id->guid_string)) {
+=09=09=09pr_err("driver '%s' has invalid GUID: %s",
+=09=09=09       driver->driver.name, id->guid_string);
+=09=09=09any_id_invalid =3D true;
+=09=09}
+=09}
+
+=09if (any_id_invalid)
+=09=09return -EINVAL;
+
 =09driver->driver.owner =3D owner;
 =09driver->driver.bus =3D &wmi_bus_type;
=20
--=20
2.41.0


