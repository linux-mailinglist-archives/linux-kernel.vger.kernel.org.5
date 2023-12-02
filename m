Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF19801CF4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjLBNJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjLBNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:09:36 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF26198;
        Sat,  2 Dec 2023 05:09:42 -0800 (PST)
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id CB41528BDE5;
        Sat,  2 Dec 2023 14:00:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
        s=gen1; t=1701522018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xcZHxF0TOnC7j0lzNEeq08B9JFECUUdheP0hD3aOB9U=;
        b=DcC1Hdrnh66CtqoxKlvEgAxrQRvSsBH9T20U46E+seBHNwP+ijXbh4l9l3LIHLApYhelqR
        kIgBevmC9Y3NWCUqBM0GlkC+fAJhh+27W85tYMk3IzEbzwfN0mX8lHXNSAf5eFnFuYdz2N
        u0JjyigAXg62HpOhLJSMrSyz1o5V4mE=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: karelb)
        by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id AA1EC4443E5;
        Sat,  2 Dec 2023 14:00:18 +0100 (CET)
From:   Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH v3 0/5] input/touchscreen: imagis: add support for IST3032C
Date:   Sat,  2 Dec 2023 13:48:31 +0100
Message-ID: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karel Balej <balejk@matfyz.cz>

This patch series generalizes the Imagis touchscreen driver to support
other Imagis chips, namely IST3038B, which use a slightly different
protocol.

It also adds necessary information to the driver so that the IST3032C
touchscreen can be used with it. The motivation for this is the
samsung,coreprimevelte smartphone with which this series has been
tested. However, the support for this device is not yet in-tree, the
effort is happening at [1]. In particular, the driver for the regulator
needed by the touchscreen on this device has not been rewritten for
mainline yet.

Note that this is a prerequisite for this patch [2] which implements
support for touch keys for Imagis touchscreens that have it.

[1] https://lore.kernel.org/all/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr/
[2] https://lore.kernel.org/all/20231112194124.24916-1-duje.mihanovic@skole.hr/
---
v3:
- Rebase to v6.7-rc3.
- v2: https://lore.kernel.org/all/20231003133440.4696-1-karelb@gimli.ms.mff.cuni.cz/
v2:
- Do not rename the driver.
- Do not hardcode voltage required by the IST3032C.
- Use Markuss' series which generalizes the driver. Link to the original
  series: https://lore.kernel.org/all/20220504152406.8730-1-markuss.broks@gmail.com/
- Separate bindings into separate patch.
- v1: https://lore.kernel.org/all/20230926173531.18715-1-balejk@matfyz.cz/
---

Karel Balej (2):
  dt-bindings: input/touchscreen: imagis: add compatible for IST3032C
  input/touchscreen: imagis: add support for IST3032C

Markuss Broks (3):
  input/touchscreen: imagis: Correct the maximum touch area value
  dt-bindings: input/touchscreen: Add compatible for IST3038B
  input/touchscreen: imagis: Add support for Imagis IST3038B

 .../input/touchscreen/imagis,ist3038c.yaml    |  2 +
 drivers/input/touchscreen/imagis.c            | 70 +++++++++++++++----
 2 files changed, 60 insertions(+), 12 deletions(-)

-- 
2.43.0

