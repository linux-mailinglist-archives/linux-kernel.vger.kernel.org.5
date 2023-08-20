Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155FD781DAA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjHTL6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 07:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjHTL55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 07:57:57 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9320FE0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 04:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692531659; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ek3e3y9GOcm5974pXHNyLpAvxQT+705O80UhMMJr9xH92PU2ffAiryJ/bpBwR8XU7fln+sW10PyDjZ+bTOWY/4gJe1XqUSQF8LksBzmlWcOcXxr99PvhCvZ68HBj3GkxXr9qMJtOh4n9R8D+LdpEUlAla9AbxqI8nArjzZdsStk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1692531659; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Rr2GJyTzOvqC9ojrVWp3/LdZY/8h6WIR2AH1THkN3KY=; 
        b=IqZOEYcVNml3VzAWYdLmHvWLTBqkE/IYXUM2I7uPLW560kSHNAWwDlgp/9sOTo//pujvOQRntKZNSvvgDVte19G5RXl4/6aFs0H/FbDvqrAsd4LH1NaEcHwdI0JQykzrbW5FzkOQGCDPlMUWRWPeOlk7KZrhUqZL2rMWdu6SSuo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1692531659;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=Rr2GJyTzOvqC9ojrVWp3/LdZY/8h6WIR2AH1THkN3KY=;
        b=agrVD4JWKAq2uIzY50YRGTtlaH+f+o0g3Qp6RAefi4DSCLkmvFTxO+col1dfiUnS
        W+PmKvyNEOTfF8RkTOu4XzMHehU1IeZNGdS9yvcYoxHJ9tkzDnk+lF6qndO9TaWWT+M
        S+qrYPDNCsFsHcaQrKNtIYS0wUjJbSCeS+WDDJvI=
Received: from kampyooter.. (110.226.17.164 [110.226.17.164]) by mx.zoho.in
        with SMTPS id 1692531657120238.70066710620415; Sun, 20 Aug 2023 17:10:57 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Suraj Upadhyay <usuraj35@gmail.com>
Message-ID: <daefbf6504f833cbd28249afc77ef3a07254ed08.1692531217.git.code@siddh.me>
Subject: [PATCH v11 4/8] drm: Remove usage of deprecated DRM_NOTE in DRM core
Date:   Sun, 20 Aug 2023 17:10:40 +0530
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1692531217.git.code@siddh.me>
References: <cover.1692531217.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_print.h says DRM_NOTE is deprecated in favor of drm_notice().

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 drivers/gpu/drm/drm_displayid.c         | 2 +-
 drivers/gpu/drm/drm_kms_helper_common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_displayid.c b/drivers/gpu/drm/drm_displayi=
d.c
index 9edc111be7ee..27ffeee09e4f 100644
--- a/drivers/gpu/drm/drm_displayid.c
+++ b/drivers/gpu/drm/drm_displayid.c
@@ -42,7 +42,7 @@ validate_displayid(const u8 *displayid, int length, int i=
dx)
 =09for (i =3D 0; i < dispid_length; i++)
 =09=09csum +=3D displayid[idx + i];
 =09if (csum) {
-=09=09DRM_NOTE("DisplayID checksum invalid, remainder is %d\n", csum);
+=09=09drm_notice(NULL, "DisplayID checksum invalid, remainder is %d\n", cs=
um);
 =09=09return ERR_PTR(-EINVAL);
 =09}
=20
diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_=
kms_helper_common.c
index 0bf0fc1abf54..7a41373b67dc 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -41,7 +41,7 @@ MODULE_LICENSE("GPL and additional rights");
 /* Backward compatibility for drm_kms_helper.edid_firmware */
 static int edid_firmware_set(const char *val, const struct kernel_param *k=
p)
 {
-=09DRM_NOTE("drm_kms_helper.edid_firmware is deprecated, please use drm.ed=
id_firmware instead.\n");
+=09drm_notice(NULL, "drm_kms_helper.edid_firmware is deprecated, please us=
e drm.edid_firmware instead.\n");
=20
 =09return __drm_set_edid_firmware_path(val);
 }
--=20
2.40.1


