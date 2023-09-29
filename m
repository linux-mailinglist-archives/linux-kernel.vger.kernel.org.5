Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A897B3AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjI2UIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjI2UIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:08:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB91B2;
        Fri, 29 Sep 2023 13:08:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50305abe5f0so22435395e87.2;
        Fri, 29 Sep 2023 13:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696018128; x=1696622928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDGRbz3/4C2hmwrNEK5ft/G6qK5MXkxmd0OoDsLxkpo=;
        b=Zzx6DnbBbkptzyIt+sgJvJz3I/jyWjGeXrNB44fAv/548zxUnfISBJMrPlPZUYa9YJ
         nv7cx+FoU/1IXVfsn/fZFPbsj3i85XAgFzhum2VXtk/a043I7TK5qjTpBYsfGVrOmvjM
         85XLwVC7W2XIUODBQWIxYeOmydxabMPkPblMT9/XLPYioPGMiMCLTP3PO117M5ouiesI
         76r8lSUEq3ZCG7J4d7piNtq74q14dY7C+AMZz9GEmpp3vnWfEQEC54fzbgHK3L/rxGmk
         nUIZdWLl+Hu5yFwmJfrHAoiCykcUzXxshsgjTjAusQIsDAr8JGCPgCzq8AcH3huTHoTi
         6A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696018128; x=1696622928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDGRbz3/4C2hmwrNEK5ft/G6qK5MXkxmd0OoDsLxkpo=;
        b=XJzRHhrEv5TdDsdI//ZF5zrCrA5Npjyecy/xDSRGc+6/HcKNjqyNGyxlR8pUO3MuXX
         R4aevqpqF5yMpBRL9+isURP5JPmlWewqlpyiduvlzFhI06Zj6A/FEG7VzmyFT7rn4f+0
         UjR4FN8kVejI2NSsrIipVQyq6MleUaofZ4Kv6ztzncbh2/dox3amFnvkCJMI50L+Eri6
         9GlcPsWuQTjo9BgXhGdP58eKz5xbVYs4U2BmD35NfjRnWXI2AoArYHFyOYpDQBzJHW7I
         go+RdqpLYgcoXAIuZtV5mUAJE8yufSCSjxvmrqlSkNfIB4bI8qevx5C6bjNzWiCeN3wl
         Y6Mg==
X-Gm-Message-State: AOJu0Yyw+eTM7mac9LIOtBqMDGD/q2DcoCTh6kvaypXVcKWnK1cZ+2j3
        k+IQPDIMqLuqeUVk9ZdYAg0=
X-Google-Smtp-Source: AGHT+IE038yl8rHpctqVa0hPo7QffjlSoFFfiqhm+waWPPgii0GO65uj4vs+ziygkZkq2B3YZpJmEg==
X-Received: by 2002:a19:6549:0:b0:500:acf1:b432 with SMTP id c9-20020a196549000000b00500acf1b432mr4377345lfj.63.1696018128022;
        Fri, 29 Sep 2023 13:08:48 -0700 (PDT)
Received: from fr.lan ([46.31.31.132])
        by smtp.googlemail.com with ESMTPSA id v12-20020a19740c000000b005056e9b734esm422439lfe.151.2023.09.29.13.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:08:47 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v2 0/2] Add maxim max34408/34409 ADC driver and yaml
Date:   Fri, 29 Sep 2023 23:08:42 +0300
Message-ID: <20230929200844.23316-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Maxim max34408/34409 ADC driver and yaml for it. Until now it
supports only current monitioring function without overcurrent
threshold/delay, shutdown delay configuration, alert interrupt.

Changes from v1:
   - minor changes from Rob's comments for yaml
   - add ena, shtdn and make 4 inputs for R sense from Jonathan's comments for yaml
   - add _REG suffix and make prefix for bitmasks and statuses
   - add SCALE/OFFSET instead of AVG/PROCESSED from Jonathan and
     Lars-Peter comments
   - add chip data from Jonathan and Lars-Peter comments
   - minor changes from Lars-Peter and Jonathan comments for driver
  
Ivan Mikhaylov (2):
  dt-bindings: adc: provide max34408/9 device tree binding document
  iio: adc: Add driver support for MAX34408/9

 .../bindings/iio/adc/maxim,max34408.yaml      | 101 ++++++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max34408.c                    | 334 ++++++++++++++++++
 4 files changed, 447 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
 create mode 100644 drivers/iio/adc/max34408.c

-- 
2.42.0

