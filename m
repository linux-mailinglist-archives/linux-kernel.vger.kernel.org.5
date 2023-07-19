Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D7F75946B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGSLjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGSLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:39:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA01FDC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:39:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98e011f45ffso833629266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20221208.gappssmtp.com; s=20221208; t=1689766724; x=1690371524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bxBFdS57cHORvtflck/fJjDDdTOyQiFBPvjnTTOIAo=;
        b=AWChI1fTZP0qKW2nktEcwMabEnYnuQc6o4Bkgb9UUQBnPd6ZLhbkUBLU4Zn5PX/VHH
         XeWW+MH4OFoDZK6828TPkJpTpQgJoDnYriYFWbx4HtjBuV9tTRxvKoO8/w+Lvp9h8Xow
         kyyWYbivXDugnlJNaONTBTj4kYzuNU4jyA2q44YioXa3tXdw9KF5y/v/llHXH/MQzkkz
         i0ptN/4u6ERcLXNEEdTqdFdtpVPG8r5MQZuQoKaTS++6P1yPttgq1mtx8nU34ePhvEJz
         F29bwltJIp8KVhC+5EDPsjyHeVFoHCSFWNfmDwPUuBW0gcWgbkq/nyvoWEYFy8CMKMIB
         FS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766724; x=1690371524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bxBFdS57cHORvtflck/fJjDDdTOyQiFBPvjnTTOIAo=;
        b=dSbPTiH7098wPnybvq71Pf112DY3ON/equ31uA/DnNE8XgfMsz/uptbl6L6R285x+e
         O8mKYGCxesr77DR/Jj7hi/Mh4aAI70yOyjz1IBBhE3z3E3m8EnzxACPvdsObQZypgWpC
         6Zxv3/FSt26Fw6GuF8F0KhxNy+Sks8/va9PTUqdYmdAGiTTUioQeKo5OxQf3FBjZK8To
         lNi5NhZ3DTmdjK2s2X0UfsPh7k9iZmyLVKAsI9BoxKf0D06k5B6fvX6EtUd2lJBoLc5L
         h0+quXmFZFcYRU1ZwbD3kyQSVfAC/tREnq//GVj3I1q9d6uxui/QTdwKn/o0ldeasfUp
         Ok8Q==
X-Gm-Message-State: ABy/qLYKI9hzrUeDuQgbHHhelDrCJ+lpLC7UuUlsG/+sZyruZqF50xxI
        nJrpnGRHSocVofNw1cEIWsLwVw==
X-Google-Smtp-Source: APBJJlFfYCJ6/WfRjAdI1uynrlVTweGQDlLU/PsO+gbBUoM2Ni+z0AbFT9zuRv+ZncjMDPta3LXPpA==
X-Received: by 2002:a17:906:73d2:b0:982:8c28:c50d with SMTP id n18-20020a17090673d200b009828c28c50dmr2272964ejl.58.1689766724443;
        Wed, 19 Jul 2023 04:38:44 -0700 (PDT)
Received: from DevTop.lan ([212.82.82.3])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090668d700b00997cfef52fasm2235979ejr.94.2023.07.19.04.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:38:44 -0700 (PDT)
From:   Harry Geyer <harry.geyer@devtank.co.uk>
To:     Till Harbaum <till@harbaum.org>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     harry.geyer@devtank.co.uk
Subject: [PATCH] i2c: tiny-usb: check usb base class before assuming the interface on device is for this driver
Date:   Wed, 19 Jul 2023 12:38:38 +0100
Message-Id: <20230719113838.17714-1-harry.geyer@devtank.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch allows usb devices with multiple interfaces to use this driver without
this driver assuming all interfaces are i2c-tiny-usb.

Signed-off-by: Harry Geyer <harry.geyer@devtank.co.uk>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index d1fa9ff5aeab..fc194c65e50e 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -222,6 +222,11 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	int retval = -ENOMEM;
 	u16 version;
 
+	if (interface->intf_assoc &&
+		interface->intf_assoc->bFunctionClass != USB_CLASS_VENDOR_SPEC) {
+		return -ENODEV;
+	}
+
 	dev_dbg(&interface->dev, "probing usb device\n");
 
 	/* allocate memory for our device state and initialize it */
-- 
2.34.1

