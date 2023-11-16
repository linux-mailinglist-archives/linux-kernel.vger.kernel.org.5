Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19E37EDB93
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjKPGbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKPGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:31:08 -0500
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E51A5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:31:01 -0800 (PST)
Received: from mail.nppct.ru (localhost [127.0.0.1])
        by mail.nppct.ru (Postfix) with ESMTP id 7368C1C0D74
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:30:58 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :date:subject:subject:to:from:from; s=dkim; t=1700116258; x=
        1700980259; bh=/9MO8o7o6nntPf+7n/of28fm2Es83s6OBU6s1H6hwTA=; b=k
        PjlYx5ZWDj+EpWLiT3v60MmQyXnhu+8FlV9aPRkwbH+idUXuV7+J7zUFtVCV3xTM
        sJewLvpk6FMhZIvUT4Z1uwxLaZ5QA/USQ/1yBayGwfRX4anAuTmWR4aX2Ni85Ayl
        vh0VFv3L7eNXGF29bRZAVLF/MxREFAs7Wax1NiS42Q=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
        by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fe-r_TlrEIJv for <linux-kernel@vger.kernel.org>;
        Thu, 16 Nov 2023 09:30:58 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
        by mail.nppct.ru (Postfix) with ESMTPSA id 57B921C061A;
        Thu, 16 Nov 2023 09:30:55 +0300 (MSK)
From:   Andrey Shumilin <shum.sdl@nppct.ru>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Andrey Shumilin <shum.sdl@nppct.ru>, Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, khoroshilov@ispras.ru,
        ykarpov@ispras.ru, vmerzlyakov@ispras.ru, vefanov@ispras.ru
Subject: [PATCH] therm.c: Adding an array index check before accessing an element.
Date:   Thu, 16 Nov 2023 09:30:28 +0300
Message-Id: <20231116063028.35871-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to access an element at index -1 if at the first iteration of the loop the result of switch is equal to 0x25

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
index 5babc5a7c7d5..78387053f214 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
@@ -180,6 +180,8 @@ nvbios_therm_fan_parse(struct nvkm_bios *bios, struct nvbios_therm_fan *fan)
 			cur_trip->fan_duty = duty_lut[(value & 0xf000) >> 12];
 			break;
 		case 0x25:
+			if (fan->nr_fan_trip == 0)
+				fan->nr_fan_trip++;
 			cur_trip = &fan->trip[fan->nr_fan_trip - 1];
 			cur_trip->fan_duty = value;
 			break;
-- 
2.30.2

