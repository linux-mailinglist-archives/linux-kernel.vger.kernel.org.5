Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C697EA096
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjKMPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjKMPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:52:18 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4761706;
        Mon, 13 Nov 2023 07:52:15 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso3620879a12.0;
        Mon, 13 Nov 2023 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699890735; x=1700495535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jiIhV9DFibjmf1A//2ZxFoGuCAARSTTwjZBrQOQbB8=;
        b=ItumgvMWUzqxUgnZp0bi4+j2xW34XvxgCO7h0jk53/9F3ocVNFEgo98PGMQ1Z0u3Eq
         yicD8GqU9Od1dP20y0RvSkBODjQSohqFnSjP9mu3hi120bZKxjXMM5eFENRCtc+HsEsT
         fw5N4KLxQInjf33Ns7miXySWqgb+g/iZGegyvEOU3IcH/8PYryLP+ZdHkIARYvjgjmOh
         NRlcLaBFasM5GcvfjKqTuIwxEhyf9NXkLFO7BVb5ObU1zxVEfN9ccy7zlnB6Pq69Q5U+
         fZZFK0pFLM1Q70gK5rDrpdcmulumdtbKiu74xhZjR5PuRStspbfdDsQxtXL2d6LXxJmr
         WAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890735; x=1700495535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jiIhV9DFibjmf1A//2ZxFoGuCAARSTTwjZBrQOQbB8=;
        b=G22EwgYhMjNGr3llWEbSIoY3nbFFYZiIibqRu07JyEjxLllYqgMfKAviWGNpBlSHM8
         mxcrKpMGWkkUkPIhfB0j8Inrr1u0LesQxEliSwa75jb3U6UKxVBSIuE0C7sFAhBT9kuM
         vT+LbLUXOO02ZCSqCeriKNDAtzlTGPtKnoAUS/ptRHtrMwzJ1TAXNud7xo4dYZPqjGE8
         34gHx9nQZS/E/wbBMjSNyGXkHO7WMCAkY3RqEILAd/1ayZOGwd5t11mOqgdRCUeVYPmj
         x1tXfVa35h/HAqhXL3IWD/kejYgVtS3gPRQ1J04eSc/llOcC/fXpeGDO2aZEz5m049Pa
         yhNg==
X-Gm-Message-State: AOJu0Yw7yQo3io/B2b17oUuAPH3XKPHA17Gi1jCbvHCEORm4+UAHQFeD
        qfxf+BRRz65Dm9S5ps/cBEc=
X-Google-Smtp-Source: AGHT+IGiozukvnwHo8HdL9zk0/k60TRl7q3tJFGoho8ElMGsowkeipgUoC4RQAHLXiHOmvytznW5dQ==
X-Received: by 2002:a05:6a21:7785:b0:186:6cb3:4bb with SMTP id bd5-20020a056a21778500b001866cb304bbmr4643446pzc.62.1699890735060;
        Mon, 13 Nov 2023 07:52:15 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001c5076ae6absm4155925plb.126.2023.11.13.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:52:14 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        Peter Yin <peteryin.openbmc@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 0/2] hwmon: (pmbus) MPS mp5990 hsc controller
Date:   Mon, 13 Nov 2023 23:50:06 +0800
Message-Id: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MPS mp5990 hot-swap controller.

Change log:

v2 -> v3:
  - Support linear mode.
v1 -> v2:
  - Corrected dt-bindings description.
  - Added comments for Vout mode command.
  - Removed of_match_ptr()
v1:
  - Add support for MPS Multi-phase mp5990 Hot-Swap controller.

---
Peter Yin (2):
  dt-bindings: hwmon: Add mps mp5990 driver bindings
  hwmon: (pmbus) Add support for MPS Multi-phase mp5990

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/mp5990.rst                |  84 +++++++++
 drivers/hwmon/pmbus/Kconfig                   |   9 +
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/mp5990.c                  | 177 ++++++++++++++++++
 6 files changed, 274 insertions(+)
 create mode 100644 Documentation/hwmon/mp5990.rst
 create mode 100644 drivers/hwmon/pmbus/mp5990.c

-- 
2.25.1

