Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDF7E62EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjKIEuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjKIEux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:50:53 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C6626A2;
        Wed,  8 Nov 2023 20:50:50 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a8ee23f043so5451677b3.3;
        Wed, 08 Nov 2023 20:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699505450; x=1700110250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lwGmUxjNB3mfZYYivbffyDrgTFuLtabf4YWM4WgX8Ng=;
        b=R30KMKZ5EcckK+J9tVwZ7e9Z60CzOM0D6fRFayp2Y6sVgUCsnFgbThrVhB3oJ0xyaK
         agaIXylwalq0VZVW5AWb35RI1z9zr0pTXVFyBedkZaF5B3pREh9mXeXjplSHjE8KuHTg
         RPv1E0xQMJ0V9Tfy4oeGYZgO+35qN+VxXtYyyz59/1R4BHMUNfGv4ez410N8H9QNOaR6
         D51ST7ygS9r9qygmRVAsam0c3nPxGVHy4DJb01Idq21BfGzJJNs7MTJt7UtdyS5BXNas
         pwvq8P+D94+9M5Be1SFDs+0yiwHc62EUNGyACq4GyZJ6Gw0uSOrUirAVe6jfNQgY9Vq5
         tmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699505450; x=1700110250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwGmUxjNB3mfZYYivbffyDrgTFuLtabf4YWM4WgX8Ng=;
        b=dI0jXYQC3+jIq4RgyQvLDtejUc2Fr8IKaapY/F91LA/C1niC3ouJ6cgvFlP6xup16G
         VqAInJCPVYEgSvLrZf69cVTlpOOgR61vYBlAGYs23bravLfHMDmh8OlMcQ1zZJhgXMXn
         wxZ3CrAkij09vx0i/j3CDfvSYt/UXDXwd0WqegdEHRG2/cLUcjlkT7goWjEz3Vr/thAF
         mvF03pCfwaf8cWCgcH9Edd7miTUJ6iasVA1v/ajFVoz+TxmIxKWNZ8hwTbslPG0LQesm
         mTquTJXL8SZYKQYp2O3LxurzS9czelPgzK20olabfvKNAvYX7tZuM+pOpNQw8F7CPiex
         2iVA==
X-Gm-Message-State: AOJu0Yz6ITNabjIbmxZ/6plt77e6jhruTUA32idhmyNIUljuJ/q+5CAu
        RszFwzf9JqmzHERLg/f1v4o=
X-Google-Smtp-Source: AGHT+IHZ4Gjo8VXSlL7M9ESyBwxgL1YuCeDYcqJ89za1XQvDAh51yvbZtpyBI/NXwqfWZUExbQcN9Q==
X-Received: by 2002:a0d:ea0d:0:b0:5a8:dd5f:dbf with SMTP id t13-20020a0dea0d000000b005a8dd5f0dbfmr4037373ywe.34.1699505449792;
        Wed, 08 Nov 2023 20:50:49 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id q189-20020a6343c6000000b005bcebc93d7asm3869035pga.47.2023.11.08.20.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 20:50:49 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Yin <peteryin.openbmc@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: (pmbus) MPS mp5990 hsc controller
Date:   Thu,  9 Nov 2023 12:48:41 +0800
Message-Id: <20231109044844.614007-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MPS mp5990 hot-swap controller.

Change log:

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

 .../devicetree/bindings/hwmon/mps,mp5990.yaml | 41 +++++++++
 Documentation/hwmon/index.rst                 |  1 +
 Documentation/hwmon/mp5990.rst                | 84 ++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig                   |  9 ++
 drivers/hwmon/pmbus/Makefile                  |  1 +
 drivers/hwmon/pmbus/mp5990.c                  | 86 +++++++++++++++++++
 6 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/mps,mp5990.yaml
 create mode 100644 Documentation/hwmon/mp5990.rst
 create mode 100644 drivers/hwmon/pmbus/mp5990.c

-- 
2.25.1

