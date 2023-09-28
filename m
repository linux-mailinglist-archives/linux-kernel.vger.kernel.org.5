Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FA97B203D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjI1O4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1O4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:56:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10DFF9;
        Thu, 28 Sep 2023 07:56:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53406799540so10753664a12.1;
        Thu, 28 Sep 2023 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695913003; x=1696517803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6Ow1bv29rjgv5srlJSkWPtfCUBuq9oaZwHZ3Ajhxlw=;
        b=l37LomDVwaqt5gVAnvumZU4fA77WXTsz6DJ8Xvje/wuktx9wRA/lDgn8tEPBggnH0V
         Ra5rmfPYDSnfzFYGnaKHjpWAyEI9jv2uA1T6+60NHPgTPwwrghW7h4TlPtF1L61KgQqd
         sjvYpPpr/4esntFbs7s7zHS06PI/+ioY/n0G+srPZ6TWp92u1NqNO5SR/jNAb/uvrfBv
         yGTmqWSmz5xK/Iw7VcaNH4K/oIFeB5fldXaAMsYLZ+lCDXjqi67yjwuAfhVeKtC8TdVs
         AQsscp1TbLfPl5ML/KdKjsk7eCNu6r3mCjoWPQA39ISofBrXZ1bIFn6AWynGPctTiqqf
         Oblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695913003; x=1696517803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6Ow1bv29rjgv5srlJSkWPtfCUBuq9oaZwHZ3Ajhxlw=;
        b=TbPKXGbtq+kNo2PK80yFaVoGWkKUcgXu+iE5186X3T89eD+ONSrCOD4frL3DNwWCdT
         wzo61i9mbv+WMo81mqrwkeRoBx2tWxjtOAuRkNaHLm0TxDrsPncbF0xNvREil7hwNpJk
         msxu1Dmk8myn/nm/4YSiaJ4bjqvPGjwfh7YN1gSZqx5sdNCG1UdCr7Oe/336BPawopIi
         KcAEksOLfPHzOeUoFjgH07yvc8cFuH+bxwJm9nxgnAI2FWS5G1LhXDACUcn7aVl27zy7
         l27iG3SdSbGgJNCux+u8JYow3T9wJDVcmipZpvouaXJm9kQG1op92TpiDUvq18378/db
         36aA==
X-Gm-Message-State: AOJu0YzBtsnN9gRRCodn9R2KGcFUOPoofSRqeAvy7Y3B0Z0VBkb/NYm/
        bsFSFcDlbnKNIU+x3cOYbIM=
X-Google-Smtp-Source: AGHT+IE6HA2dCfRfr6VR4b9a0f9SxlZavfmm0Pxw/ZbQNGs1hhZTkydDl+1xhURuH9qlJoVyA73lmA==
X-Received: by 2002:aa7:d793:0:b0:523:3754:a4e1 with SMTP id s19-20020aa7d793000000b005233754a4e1mr1470169edq.22.1695913003031;
        Thu, 28 Sep 2023 07:56:43 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-54-79.cust.vodafonedsl.it. [188.217.54.79])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402068300b005256771db39sm9784459edy.58.2023.09.28.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:56:42 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Martin Hecht <martin.hecht@avnet.eu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v9 0/3] media: i2c: Add support for alvium camera
Date:   Thu, 28 Sep 2023 16:56:31 +0200
Message-Id: <20230928145638.2268331-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series add support for Allied Vision Alvium camera.
The Alvium camera is shipped with sensor + isp in the same housing.
The camera can be equipped with one out of various sensor and abstract
the user from this. Camera is connected via MIPI CSI-2.

Driver use last v4l2 V4L2_CCI_I2C.

https://www.alliedvision.com/en/products/embedded-vision-solutions/

Tested the following alvium models:
 - alvium 1500c-c500
 - alvium 1800c-2050c
 - alvium 1800c-1240c
 - alvium 1800c-0040c

Note:
 - Driver is rebased on top of [1], commit [2].

Thanks & Regards,
Tommaso

 - [1] https://git.linuxtv.org/sailus/media_tree.git/log/
 - [2] media: dt-bindings: hynix,hi846: Document orientation and rotation (5801d7688e4f)

Tommaso Merciai (3):
  dt-bindings: vendor-prefixes: Add prefix alliedvision
  media: dt-bindings: alvium: add document YAML binding
  media: i2c: Add support for alvium camera

 .../media/i2c/alliedvision,alvium-csi2.yaml   |   97 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    9 +
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium-csi2.c               | 2761 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  474 +++
 7 files changed, 3354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

