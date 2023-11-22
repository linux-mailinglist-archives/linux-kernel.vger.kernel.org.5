Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA68E7F43A7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjKVKXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343841AbjKVKXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:23:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5805B197
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:23:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b2979a74eso12441325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1700648604; x=1701253404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24ax012WMEMM4FUonPPNS9MbOgLZBi9d6mGqyl9IrhI=;
        b=BZ1nnaTScFhP9Gw03T9ExH9f7p+9HZllkhs1lO+S7zr3IRjzmm2hV86241+xhEjO9y
         bROCHxQxx7uHBJYY59x757Z4rJgabfcVR2DvNaPaM9eELcsYNRKsWlR/gw/ru3Cn/LoA
         GYmxuJw7+FV59qB4DcvxJBJUkAswH33O6hnZ78iCSIYIuDlda5HaMDmsn4FZG3kz6CH4
         aD2Oa4bMWu5FkHGPUWrlX1KveDwc4M1P1OCfm7bNPbiG7jTwP91a04VcX/mY4WJcgIFY
         i2sI2AOP4W8FiDbfacbOpjEtJSH0CibSx99YflORSssRi/gdsxaRahqkJUUDyy5U5Gwv
         iGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648604; x=1701253404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24ax012WMEMM4FUonPPNS9MbOgLZBi9d6mGqyl9IrhI=;
        b=XmphwTTkLbXiHuvDsnyU4X7bJ1Uv0h31y/Jzv72X3GnjTOYlFl0AMliJAXe1D9Nuks
         NDbRzRMcOfyFcSYlNwZLpIKY/vf088OzjtLwc1hXwOS6254cSLUdULSYhaIq3nCwY7PG
         hQmYcimiWlS/Xi4sbvC3F65CjnOqw2/24xJBuAKlp9qm0cCnRjhY0jBy+U4cDWgPB0+9
         tWjhUO3XHYpfq6pzwpCVSXsGXq7t7oW3iR8/+twvfE/AVgAYqgGknWvBYlyFI6Gcwild
         UX325NXZ6CqT/dC/3qfl6BW16AtuRbsJsmcSrtPwjB3lojEach7VNMQbPij/sq9GqNbw
         lPog==
X-Gm-Message-State: AOJu0YymePeisApKs2hJp3UvmsVOq7SfIYMRYXV3jReZZug/KaEsCnJx
        +NgaSEYagKkBa1xurCVfpF+btw==
X-Google-Smtp-Source: AGHT+IFWAIlMEC43UhV7Pji8JRcvxELt0MfpwGRHxrjpQijlN2jzXiFo4DpO/Xe5fOYNjugEaOLTRA==
X-Received: by 2002:a05:600c:510b:b0:40b:32fa:d8a3 with SMTP id o11-20020a05600c510b00b0040b32fad8a3mr685774wms.18.1700648603635;
        Wed, 22 Nov 2023 02:23:23 -0800 (PST)
Received: from localhost.localdomain (d54C3956F.access.telenet.be. [84.195.149.111])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b004060f0a0fd5sm1729282wmq.13.2023.11.22.02.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:23:23 -0800 (PST)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Crt Mori <cmo@melexis.com>
Subject: [PATCH 0/2] iio: temperature: mlx90635 Driver for MLX90635 IR temperature sensor
Date:   Wed, 22 Nov 2023 11:20:39 +0100
Message-Id: <cover.1700648164.git.cmo@melexis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

There is a new contactless sensor in Melexis portfolio. MLX90635 is just
1.8x1.8mm in size, but with factory calibration offers instant usage
in every project. It offers wide refresh rate range that is configurable
between 100ms and 4s.

Driver currently provides temperature calculations, power management and
changes to the refresh rate. Since sensor is aimed towards the consumer
market there is really low number of EEPROM write cycles available, so
driver changes refresh rate only in run time registers to avoid writing
to EEPROM. Reading EEPROM is not available in Sleep Step mode, so I am
using caching at the driver initialization to ensure that measurements
can still be taken in Sleep Step mode.

Crt Mori (2):
  iio: temperature: mlx90635 MLX90635 IR Temperature sensor
  dt-bindings: iio: temperature: add MLX90635 device bindings

 .../iio/temperature/melexis,mlx90635.yaml     |   60 +
 MAINTAINERS                                   |    7 +
 drivers/iio/temperature/Kconfig               |   12 +
 drivers/iio/temperature/Makefile              |    1 +
 drivers/iio/temperature/mlx90635.c            | 1099 +++++++++++++++++
 5 files changed, 1179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
 create mode 100644 drivers/iio/temperature/mlx90635.c

-- 
2.40.1

