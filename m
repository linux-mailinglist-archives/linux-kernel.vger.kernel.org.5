Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFCD7C6AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377651AbjJLKYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347116AbjJLKXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:23:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BD9CF;
        Thu, 12 Oct 2023 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697106227;
        bh=77/5kGZDvjmKJEmjKc9G1sLtjI9zG6J4vpqdH8+SQGY=;
        h=From:Subject:Date:To:Cc:From;
        b=OOe/SE0wShL27Fslgwqvy93fVw7awrnvU8D2bkkXFq/r+co5D3qEk9HKsY2e29q6Y
         TqhR6mGFrEcKshNAL4P+wEky9sOiuLjM6p8RWDXzzX7HcR5p7ZCoF0VO7y3RXbeIqf
         fDFuHGiU9pjynsOOHYjQgI0cuqKfGvzUSPxixZFA=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] HID: remove #ifdef CONFIG_PM
Date:   Thu, 12 Oct 2023 12:23:37 +0200
Message-Id: <20231012-hid-pm_ptr-v1-0-0a71531ca93b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACnJJ2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0Mj3YzMFN2C3PiCkiLdVCPLxCTT1FTz5FRzJaCGgqLUtMwKsGHRsbW
 1AKVsz9VcAAAA
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697106226; l=1006;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=77/5kGZDvjmKJEmjKc9G1sLtjI9zG6J4vpqdH8+SQGY=;
 b=ovkq4dcnyDQcOqGDKIT5r4EQk2ywTf9xcY8S7c8/L061zmU/czps+DfP99Ls6+uwKg8Q6ZEDn
 TvD2u8RI2ehCRk5yIato/BSXdwSt0WW88Wk6jJLklbHIP3tOPqtuiYa
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Through the usage of pm_ptr() the CONFIG_PM-dependent code will always be
compiled, protecting against bitrot.
The linker will then garbage-collect the unused function avoiding any overhead.

This series only converts three users of CONFIG_PM in drivers/hid/ but
most of the others should be convertible, too.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      HID: core: remove #ifdef CONFIG_PM from hid_driver
      HID: usbhid: remove #ifdef CONFIG_PM
      HID: multitouch: remove #ifdef CONFIG_PM
      HID: rmi: remove #ifdef CONFIG_PM

 drivers/hid/hid-multitouch.c  | 10 +++-------
 drivers/hid/hid-rmi.c         | 10 +++-------
 drivers/hid/usbhid/hid-core.c | 11 +++--------
 include/linux/hid.h           |  4 ++--
 4 files changed, 11 insertions(+), 24 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231012-hid-pm_ptr-e29ab5ee7ce7

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

