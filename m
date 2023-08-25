Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0157788E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjHYSVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjHYSVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:21:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29510C7;
        Fri, 25 Aug 2023 11:21:08 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-410904c823bso7063371cf.3;
        Fri, 25 Aug 2023 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692987667; x=1693592467;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z110zb+uUe01JxJfvJEqDFJZzL1afGPC609bfkFpAaQ=;
        b=pTR0DJBwXDTXbBsjp/bTlYao85WFbpwUlbuM6WQE6gTLmwc8o3cyHqYRXzBYB4k3L0
         jVutGgj9GKT0/uLb1PilD1XJEGM3BAWQC6ivtfhl4A0YUaFLqONRZ2PvnIU0Wz1htw2Z
         jDdcpmnOt95oLLoraT+a/p0cDrZIbodWxm6Ugah+jaRgUEeMBD7y4y6tr5Kddb+iQpf1
         H7Cqd9ULCap6hZF3xQBLyFIlk2JABRFJr1xwTCXhg/65UdAFfO3XAuEZc4KSpR+DTDUG
         /zeed/Pg8cpFjpsKcDMCpMs0/ZQCRQw/knehbS6uA9865Myf5hDzRrrv5RfiYH67FqKI
         CJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987667; x=1693592467;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z110zb+uUe01JxJfvJEqDFJZzL1afGPC609bfkFpAaQ=;
        b=HrmevJWEtYleQbxmaRTNqxP7vB5+tUI+lAr2ZpRxJlQ4XBZhHjVmeQxBWXNvEFFt19
         TKd8+WAHkPXGpUPUWiFv3d/Ht+563pkBMDPv0ksPEjyWMFiHnYKTdQFKcHBk55nSf7/r
         4SuvZSuqIps2Sdr2aT3z6XIwJtk+lmfge5F5sl5N+XIHdDUeH3Ikr+aaW7zd2P5evTU4
         y2uwiQwVar8TE9wjECzT7z4JSULOru+hz5wzJ6bIdSxTQ07/GgVJxpuSt9yULAYtpYa5
         hjHNdJcUBqm18oLpX5W9bSyWw/+10KQ7idba2dvYl2wiPWyMn3UEhGCy7cbB4PGY25Ih
         uy7w==
X-Gm-Message-State: AOJu0YyE+Sz1otmYj37WuIyITcIbD5/PqrIIc67EN9xzI2mHDaAAVPLo
        H7NFrAzAci1sTumQ8GZv/xU=
X-Google-Smtp-Source: AGHT+IE0xI+I4z+a/4l/xX9I3N6Jz+xSLG7RjzsWZabojEnLZbltgo2IoAMABNCSIORHDyr+BnosoQ==
X-Received: by 2002:ac8:7fc9:0:b0:410:60a4:ffbc with SMTP id b9-20020ac87fc9000000b0041060a4ffbcmr26138036qtk.66.1692987667586;
        Fri, 25 Aug 2023 11:21:07 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id ew9-20020a05622a514900b004109928c607sm679747qtb.43.2023.08.25.11.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:21:07 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: add LTC2309 support
Date:   Fri, 25 Aug 2023 14:20:57 -0400
Message-Id: <20230825-ltc2309-v2-0-6d75f2b3fb50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAnx6GQC/z3MTQrCMBCG4auUWRvJn5i48h7SRRPHdqBtJCnBU
 nL3xoLu5h0+ng0SRsIEt2aDiJkShbmGPDXgh27ukdGzNkguFTdSsXHx9bJMWH1BgVZbJaCu3xF
 f9DmkR1t7oLSEuB5wFt/vz9B/IwvGmTNXp9EZrri/91NH49mHCdpSyg7kmOvRngAAAA==
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692987666; l=1187;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=t4n8fYT5QP5mnRM+DLQ5slBMOm2MVRylLP0wAbn/JuM=;
 b=u5bqKSfzNo7kApN1XGrF2cC2EEwkniWroTIwWv5xoqVlF5OzWQuwwVxzxpTJyxCmDuVp/cNd4
 pPDecpM0KYXBYI/kCxv13/0p7liCC9b7WOFEazriQ5uKdswkQ53jQHD
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.

This implements support for all single-ended and differential channels,
in unipolar mode only.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
Changes in v2:
- reduce critical section scope to i2c accesses only
- fixup .probe() commit
- fix unbalanced regulator
- rename refcomp to vref
- update lltc,2497.yaml instead of duplicating bindings
- commit dt-bindings before driver
- fix checkpatch --strict warnings
- Link to v1: https://lore.kernel.org/r/20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com

---
Liam Beguin (2):
      dt-bindings: iio: adc: add lltc,ltc2309 bindings
      iio: adc: add ltc2309 support

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |  20 +-
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ltc2309.c                          | 248 +++++++++++++++++++++
 4 files changed, 274 insertions(+), 5 deletions(-)
---
base-commit: a5e505a99ca748583dbe558b691be1b26f05d678
change-id: 20230823-ltc2309-1945e1e94931

Best regards,
-- 
Liam Beguin <liambeguin@gmail.com>

