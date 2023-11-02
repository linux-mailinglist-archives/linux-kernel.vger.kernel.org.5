Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2E7DED9F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbjKBHth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjKBHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:49:36 -0400
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD9E116;
        Thu,  2 Nov 2023 00:49:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB0E3147A5E;
        Thu,  2 Nov 2023 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1698911363; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding; bh=GoLjHDRTTW8k5/1bTK3z5jsye70DcJV8VXEiUmIhCQU=;
        b=f2TVScPohn6mMajkHmoB9lQPM9mD8PdGq8rL7/PE0KikPEz59iBRBdg5ySrvpx4WcQmNxP
        xabPeg/SfOcTsxa6TTivRdcH/TcRn25tA12YjRKKMB52OVkHKqrX1dUy7qO64mRA6udHx+
        RB9nptRE6s6h5E/IxWyYdaI+keRcSp/JipBi4crQL836fm/MpT8+ZIJ9VYETBwrqyEI3OP
        ZWBM6orm8F3VpxD8yoHtPZbG98jfcstnjCj9lQliF2DiGubC7jV5Pe5dnsLGS5VfKigBE3
        lE67obYwbdTbpkGW2Z+FHImn21kSGQ6rVCXemoulIDDgpyQ1NAfJ8YDP1lib6w==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/4] RFC: firmware: meson-sm: add chipid sysfs export
Date:   Thu,  2 Nov 2023 10:49:12 +0300
Message-Id: <20231102074916.3280809-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
unique SoC ID starting from the GX Family and all new families.
But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.

This patchset introduces an exported sysfs string for the 128-bit chipid,
considering a check for the version of the returned value. If the chip
does not support version 2 of the call, it falls back to (where possible)
information from the meson-gx-socinfo driver to supplement the data from OTP.

Viacheslav Bocharov (4):
  firmware: meson-sm: change sprintf to scnprintf
  firmware: meson_sm: Add chipid number sysfs entry
  soc: amlogic: meson-gx-socinfo: export socinfo for use in other
    modules
  firmware: meson_sm: use meson_gx_socinfo for compatibility

 drivers/firmware/meson/meson_sm.c      | 72 +++++++++++++++++++++++++-
 drivers/soc/amlogic/meson-gx-socinfo.c | 34 +++++++-----
 2 files changed, 90 insertions(+), 16 deletions(-)

-- 
2.34.1

