Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBCC7C6AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377775AbjJLKX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347111AbjJLKXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:23:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A0CD3;
        Thu, 12 Oct 2023 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697106227;
        bh=dcNGhXp5FPTom7QF06OFWt6twK9Wx0jnbCF/HnZ41vM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IxEIFffOIC37ReXiTicel+yXLwHpChvLvrPq5QvxGftNl0sTXr6LNSyA3qazcweoj
         kEp0rmPIun58vHqP6kaUkoSA4vTSKCd+WrY6xBl0PdPlPGdQX7lO0RFGa0MW2rF+tl
         F7d+9YguOHYV/qFTj11zoovw6XbwvJPnG3QgPn1E=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 12 Oct 2023 12:23:38 +0200
Subject: [PATCH 1/4] HID: core: remove #ifdef CONFIG_PM from hid_driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231012-hid-pm_ptr-v1-1-0a71531ca93b@weissschuh.net>
References: <20231012-hid-pm_ptr-v1-0-0a71531ca93b@weissschuh.net>
In-Reply-To: <20231012-hid-pm_ptr-v1-0-0a71531ca93b@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697106227; l=1175;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dcNGhXp5FPTom7QF06OFWt6twK9Wx0jnbCF/HnZ41vM=;
 b=Iad8VW67+qA6YLgatRKUO/dbPz3xzTYuvOSHdHEpMdPKfTICbIfy4mSCjas9tG9y14b1Q5eNN
 58M7fGLO+jMAhHHV3SuHZoD3CSvt+G3f25G61eBrc9MgUUFGGNLWWuL
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

Allow HID drivers to pass ->suspend, ->resume and ->reset_resume via
pm_ptr().
Through the usage of pm_ptr() the CONFIG_PM-dependent code will always be
compiled, protecting against bitrot.
The linker will then garbage-collect the unused function avoiding any overhead.

The only overhead in the final kernel image and at runtime are a few
extra bytes in 'struct hid_driver'.

The same approach is chosen by 'struct usb_driver' and other subsystems.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/hid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 964ca1f15e3f..5a8387a4a712 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -833,11 +833,11 @@ struct hid_driver {
 	void (*feature_mapping)(struct hid_device *hdev,
 			struct hid_field *field,
 			struct hid_usage *usage);
-#ifdef CONFIG_PM
+
 	int (*suspend)(struct hid_device *hdev, pm_message_t message);
 	int (*resume)(struct hid_device *hdev);
 	int (*reset_resume)(struct hid_device *hdev);
-#endif
+
 /* private: */
 	struct device_driver driver;
 };

-- 
2.42.0

