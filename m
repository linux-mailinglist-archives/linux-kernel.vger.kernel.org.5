Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B067C78BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442964AbjJLVkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347423AbjJLVkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A18D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697146762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4HjQ38FaqAqOPBHqQYuQ0KM6yn2TAQcFHI6s0KVsEyk=;
        b=JCzpM25C6esoT7OHfnD9fuzRwnBi9u7DWJ3mkH5RyHh9+Zbwhk6YpP7MZgvkfwCsfI9EIM
        Se5fIxQakmNCOVDks0cdJWVNGSja9dwbR0wKCmBb722NnUBAAazfSB7vFqA2noJGyjb6ew
        9Auaz2fd09O4MMyDOd7EsedzV7cfrNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25--RoyMUsANqa5xTHV5qxgjQ-1; Thu, 12 Oct 2023 17:39:06 -0400
X-MC-Unique: -RoyMUsANqa5xTHV5qxgjQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4074f9d17a5so9884465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146745; x=1697751545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HjQ38FaqAqOPBHqQYuQ0KM6yn2TAQcFHI6s0KVsEyk=;
        b=ncSrkK9lcxh2WbRMDGHjuXCcNotZAR41prPQ4UjHc2BwEE6MCgBKjUzRxSVzOZL+G2
         5vf4g51tad3D86nvVE2rtgGO5mFWk1NAnrRMCJDuIyIt9xS2XplrLHDkN5dEy6B+yvYQ
         uLcvK1yxbHxq7LiSjuxIjFATfOfWp42TD7iq/zWGINfxpEPFP5NsI8QqnWGR+meagftw
         x+fe0AXRaTw6C+hgR7WyN2b3NW11ONBJWcH4FdrOqZOEi2jNkJhYavi+uuAsQ8l8HBTO
         YqPujPxFw6sqhM664gjKriRVJdrtqyIZQTgqIsyT2vOhfCRnCNESeD7sxKFIPr0an5aa
         77AA==
X-Gm-Message-State: AOJu0Yy64t6i6jgiC2G3Wzyat6N7I48YBqrguewgIcn5hQlMNUKPYARe
        rc1AepPmfKpWAupXxPvsi+JYs/BJDOvvwz7GtpcTMwMRNvS3AUuJ3py9QXtF2MYXQoAYX7K/cB8
        Qrst4NZ8Cqk86DazsxfuvwL7TrEOWNamH5ptBCkLSV4Y/ob82kHJihOyyPl5eENZoDnfQzSkv8k
        ZZdVUha+E=
X-Received: by 2002:a1c:7419:0:b0:405:7b92:453e with SMTP id p25-20020a1c7419000000b004057b92453emr22304327wmc.37.1697146744850;
        Thu, 12 Oct 2023 14:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFId6vEUm6lLY12c7Khxf6C447HYWMwZjfxbHOw/t6gc3FOvk/WHTGkr1lL9jQkvffet2nE3g==
X-Received: by 2002:a1c:7419:0:b0:405:7b92:453e with SMTP id p25-20020a1c7419000000b004057b92453emr22304296wmc.37.1697146744355;
        Thu, 12 Oct 2023 14:39:04 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g9-20020a7bc4c9000000b00405959469afsm822140wmk.3.2023.10.12.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:39:03 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/6] drm/solomon: Add support for the SSD132x controller family
Date:   Thu, 12 Oct 2023 23:38:30 +0200
Message-ID: <20231012213843.1151060-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch-set adds support for the family of SSD132x Solomon controllers,
such as the SSD1322, SSD1325 and SSD1327 chips. These are used for 16 Gray
Scale Dot Matrix OLED panels.

This is a v3 that address issues pointed out during review of the v2:

https://lists.freedesktop.org/archives/dri-devel/2023-October/426448.html

The patches were tested on a Waveshare SSD1327 display using glmark2-drm,
fbcon, fbtests and the retroarch emulator.

Patch #1 drops the .page_height field from the device info with a constant
because it's only needed by the SSD130x family and not the SSD132x family.

Patch #2 adds a per controller family id field to the device info data, to
allow the driver to support different Solomon display controller families.

Patch #3 renames some SSD130X_* commands that are shared by both families.

Patch #4 adds the support for the SSD132x controller family.

Patch #5 splits out some properties that are shared across both controller
families bindings and move them into a separate solomon,ssd-common schema.

Finally patch #6 adds a DT binding schema for the SSD132x controllers.

Best regards,
Javier

Changes in v3:
- Drop the per controller family functions table (Thomas Zimmermann).
- Use different modesetting pipelines for chip families (Thomas Zimmermann).
- Change the i,j variables type to unsigned int (Geert Uytterhoeven).
- Fix "No newline at end of file" in solomon,ssd-common.yaml (Rob Herring).
- Add Rob Herring's Reviewed-by tag to patch #5.
- Add Rob Herring's Reviewed-by tag to patch #6.

Changes in v2:
- Add Geert Uytterhoeven's Reviewed-by tag to patch #1.
- Squash patch that uses drm_format_info_min_pitch() to calculate dest_pitch
  with the following patch (Geert Uytterhoeven).
- Store ssd13xx_family_funcs[SSD130X_FAMILY] in struct ssd130x_deviceinfo
  (Geert Uytterhoeven).
- Don't mix switch (family_id) and ssd13xx_funcs[family_id] (Geert Uytterhoeven).
- Replace switch (family_id) by an .set_buffer_sizes (Geert Uytterhoeven).
- Move the rect alignment to a per chip family function (Geert Uytterhoeven).
- Align the rectangle to the segment width (Geert Uytterhoeven).
- Drop patches that rename driver and prefixes (Maxime Ripard, Peter Robinson).
- Remove unnecessary 'oneOf' in the SSD132x DT binding schema (Conor Dooley).
- Remove unused DT nodes labels in the binding schema examples (Conor Dooley).
- Split out common Solomon properties into a separate schema (Rob Herring).

Javier Martinez Canillas (6):
  drm/ssd130x: Replace .page_height field in device info with a constant
  drm/ssd130x: Add a controller family id to the device info data
  drm/ssd130x: Rename commands that are shared across chip families
  drm/ssd130x: Add support for the SSD132x OLED controller family
  dt-bindings: display: Split common Solomon properties in their own
    schema
  dt-bindings: display: Add SSD132x OLED controllers

 .../bindings/display/solomon,ssd-common.yaml  |  42 ++
 .../bindings/display/solomon,ssd1307fb.yaml   |  28 +-
 .../bindings/display/solomon,ssd132x.yaml     |  89 +++
 MAINTAINERS                                   |   3 +-
 drivers/gpu/drm/solomon/Kconfig               |  12 +-
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |  18 +-
 drivers/gpu/drm/solomon/ssd130x-spi.c         |  27 +-
 drivers/gpu/drm/solomon/ssd130x.c             | 507 ++++++++++++++++--
 drivers/gpu/drm/solomon/ssd130x.h             |  17 +-
 9 files changed, 644 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd132x.yaml

-- 
2.41.0

