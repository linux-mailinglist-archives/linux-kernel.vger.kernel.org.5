Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDD7F16D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjKTPLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjKTPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:11:08 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FFBAC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:11:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507adc3381cso5759774e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1700493059; x=1701097859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAmZGLTmGJXV9YK2C2V+/HZinpAhQyW4PPvI5BLDSDo=;
        b=NEjJ9VGTvnXQkawfgAfjIFIOcbQBdGjRz7cCI1K7qN0jLSQ60AP8lb+KTguop8FMqr
         IwJV80RC9juiO2uF7B4Jz9MqEIbZeLQNlXFOn1ppxB4ChULaQ0yrCqBsBtzk6KhOoXxW
         t0hRWzRwMALigKqulTmJb69ObiJh6gIs8/hyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700493059; x=1701097859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAmZGLTmGJXV9YK2C2V+/HZinpAhQyW4PPvI5BLDSDo=;
        b=r9/xIKKx9J8vrlpsUfjfwzwF0M3/wPNvznBlODYxsjLpXwIOWeRrI+vVrEzUuTiTY5
         QT23/SrPTEiof7rCCDS4ou+GhyfeA2NrI93V3+6JV9krHzslbgUsfXcgtVFP6AdHTkWp
         n8qjI3Ro07HBgiRcu2x0YOWKStwAvxqrZlE6SNrA+EpOxwwXsYj6ktrTpjUN5CW9nDgR
         buDDgZIvL6fl7Vu5v/Je8HOQngZQk0nuiWajd4d8HChveRM65HuQrl0rT4yXb5DLCftL
         m3gkWhJQQvQr38lBObx7t7RDf2WQv76yYs+ocZpT5YQzgLQAfcGIpQOMUxLz5T3Y3xJx
         fXeQ==
X-Gm-Message-State: AOJu0YwFFj4F07Bck+uV0wJ1orXykkt3baBTdW/0AtvS2XmtiODwVLTt
        amE7Sf4KEES1cP5WMSDHi/CRXw==
X-Google-Smtp-Source: AGHT+IHnH6t+aeDZ2FqFjKKHLM2XTE0idpLSs9mJN3M22iquOYikzcCdnM4RSlQfzqzHdoWacElXnA==
X-Received: by 2002:a19:5218:0:b0:507:a66f:55e2 with SMTP id m24-20020a195218000000b00507a66f55e2mr5161118lfb.10.1700493059459;
        Mon, 20 Nov 2023 07:10:59 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g29-20020a0565123b9d00b00502e2ab7118sm1207444lfv.50.2023.11.20.07.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:10:59 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 0/2] serial: add rs485-mux-gpio dt binding and support
Date:   Mon, 20 Nov 2023 16:10:53 +0100
Message-Id: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards are wired so that they support both rs232 and rs485, with
a gpio controlling a mux connecting the SOC's pins to the appropriate
external circuitry. Instead of requiring the application to know about
such details and handle the gpio appropriately, allow it to be
described in device tree and let the serial core code handle it if
present.

Tested on a board based on imx8mp.

Rasmus Villemoes (2):
  dt-bindings: serial: rs485: add rs485-mux-gpios binding
  serial: core: implement support for rs485-mux-gpios

 .../devicetree/bindings/serial/rs485.yaml     |  5 +++
 drivers/tty/serial/serial_core.c              | 35 +++++++++++++++++--
 include/linux/serial_core.h                   |  1 +
 3 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.40.1.1.g1c60b9335d

