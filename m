Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B027BE9B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378264AbjJIShU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378179AbjJIShH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B97B4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696876575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zsxGVSfsuhfbNcHVttLtmT7ohtovb+UILcIo39l8Suw=;
        b=PBguWiFfo11m5Uvdaj1ek/U+8vkwsxUyoe7j3JmIgVXo1s+g7EZKM3XDL/Tg1Oeisd7rhp
        t+jIkeYeRcJHsOHikPPVbxjEuLcSAZsxnFaigC0hRygt8cgdl32KSIBuyvRHQ6ml0dj3r+
        2D6L82WPKTFRpyJTpchOOySCCx5qcQY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-MlxH1A66P5mrVkk2jFTfpw-1; Mon, 09 Oct 2023 14:35:59 -0400
X-MC-Unique: MlxH1A66P5mrVkk2jFTfpw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso3409588f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876558; x=1697481358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsxGVSfsuhfbNcHVttLtmT7ohtovb+UILcIo39l8Suw=;
        b=weqXS5jAb5v1IV7tpO0DI5JPJ0gz6hOYSUrTY0DRiGoyGwAQVA+Fo3i8CYUPB+52s8
         GupBm1P0GhBizi13kwoUD1H3+12ZFPkb5L2PZLqIPf5pE0pP9UDUOZSWT/Kf12S3r2cF
         Hv4pJUabWUch2GU5GCjmy39x74NW7wci0HzXPg8gtrqfkQS8DKNzdkH8AchiCVWxDWqL
         qQIgP/2XqequtpB2KxxHPPaYnXdhBvZbQ77lkkpQ145VfhWSNGy70d6gR2wQ70RR3YoK
         zKLZw26+kQmBbx9jw+JRwb75eSGSgDGJGBA1g6o8hJEhwDY0xWUO+dIx79Sd5FYcUY1z
         mJcA==
X-Gm-Message-State: AOJu0YwA9hutW+KsvO0wps5q4q5QRpNgAl72Kf2o7OLPQD8Bll3+DdJg
        EZ1x2WVNzV811ZLqV494SfMhqGH7sZ0epmSEt2vNW9KUK8AcPbKunoqhTtnQhjA9X0VoDthkfyI
        Dmkwr5nUS4sbYi0LiUecq4NqT8abxWzDq1acMdNX9Wp8LLwCq1qgKDTxklY9Is6vT3m7xgvf67M
        TTPlmUVw8=
X-Received: by 2002:a5d:46cf:0:b0:31f:8e7c:6ebe with SMTP id g15-20020a5d46cf000000b0031f8e7c6ebemr13528790wrs.5.1696876558013;
        Mon, 09 Oct 2023 11:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+JcBXZXNGTEmKnDAtxnhtdraUNMsB+1F+EutebIzxSPaz9pa+gYUnBEZnCiXhnydilDCYXQ==
X-Received: by 2002:a5d:46cf:0:b0:31f:8e7c:6ebe with SMTP id g15-20020a5d46cf000000b0031f8e7c6ebemr13528764wrs.5.1696876557507;
        Mon, 09 Oct 2023 11:35:57 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f16-20020adfdb50000000b0031ff89af0e4sm10318981wrj.99.2023.10.09.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:35:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Subject: [PATCH 0/8] drm/solomon: Add support for the SSD132x controller family
Date:   Mon,  9 Oct 2023 20:34:14 +0200
Message-ID: <20231009183522.543918-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch-set adds support for the family of SSD132x Solomon controllers,
such as the SSD1322, SSD1325 and SSD1327 chips. These are used for 16 Gray
Scale Dot Matrix OLED panels.

The patches were tested on a Waveshare SSD1327 display using glmark2-drm,
fbcon, fbtests and the retroarch emulator.

Patch #1 renames the ssd130x driver to ssd13xx since it will support both
the SSD130x and SSD132x Solomon families and at least the SSD133x family
in the future.

Patch #2 also renames the data structures and functions prefixes with the
ssd13xx name.

Patch #3 drops the .page_height field from the device info with a constant
because it's only needed by the SSD130x family and not the SSD132x family.

Patch #4 changes the driver to use drm_format_info_min_pitch() instead of
open coding the same calculation.

Patch #5 adds a per controller family functions table to have logic that
could be shared by both SSD130x and SSD132x callbacks.

Patch #6 renames some SSD130X_* commands that are shared by both families
and patch #7 adds the support for the SSD132x controller family.

Finally patch #8 adds a DT binding schema for the SSD132x device nodes.

Best regards,
Javier


Javier Martinez Canillas (8):
  drm/solomon: Rename ssd130x driver to ssd13xx
  drm/ssd13xx: Rename data structures and functions prefixes
  drm/ssd13xx: Replace .page_height field in device info with a constant
  drm/ssd13xx: Use drm_format_info_min_pitch() to calculate the
    dest_pitch
  drm/ssd13xx: Add a per controller family functions table
  drm/ssd13xx: Rename commands that are shared across chip families
  drm/ssd13xx: Add support for the SSD132x OLED controller family
  dt-bindings: display: Add SSD132x OLED controllers

 .../bindings/display/solomon,ssd132x.yaml     |  116 ++
 MAINTAINERS                                   |    6 +-
 drivers/gpu/drm/solomon/Kconfig               |   28 +-
 drivers/gpu/drm/solomon/Makefile              |    6 +-
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |  112 --
 drivers/gpu/drm/solomon/ssd130x.c             | 1260 --------------
 drivers/gpu/drm/solomon/ssd13xx-i2c.c         |  126 ++
 .../solomon/{ssd130x-spi.c => ssd13xx-spi.c}  |  104 +-
 drivers/gpu/drm/solomon/ssd13xx.c             | 1508 +++++++++++++++++
 .../gpu/drm/solomon/{ssd130x.h => ssd13xx.h}  |   63 +-
 10 files changed, 1876 insertions(+), 1453 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
 delete mode 100644 drivers/gpu/drm/solomon/ssd130x-i2c.c
 delete mode 100644 drivers/gpu/drm/solomon/ssd130x.c
 create mode 100644 drivers/gpu/drm/solomon/ssd13xx-i2c.c
 rename drivers/gpu/drm/solomon/{ssd130x-spi.c => ssd13xx-spi.c} (54%)
 create mode 100644 drivers/gpu/drm/solomon/ssd13xx.c
 rename drivers/gpu/drm/solomon/{ssd130x.h => ssd13xx.h} (51%)

-- 
2.41.0

