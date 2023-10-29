Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0481F7DB0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjJ2XSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjJ2XSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:18:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1579619152;
        Sun, 29 Oct 2023 16:07:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543FBC41679;
        Sun, 29 Oct 2023 23:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620482;
        bh=wwrwW0Yn+32NRBtfeWbSsa77sRdw9s+n7SbG3Xk1XOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDhW3cOYvnZ9jygwfOrXz1jGg7L9KSflgDhllLa3+ZhVpV3LR10+V6DW1F35z/iob
         kYAuzH6ltUqYOxYUrI6FvSNsLoabSGwHuXhEAlj95q8VXt7XisVhV2JK+ryuBIeHJR
         VwZAYWETyITXNWn7XC5z6dqmPchuI7lowrM23CLucgciVE3qm55Oeoru3FHx0PWUiS
         565s3ginMKSHImRsYgVjiF65TL3t1Qr6lSqpnQZacNptuCYkmFfx9kts6MCSiyoisT
         KrMjLOB+Y6np3xYi8t+QSndtnOT2jwpO5YP0buN+OKCpCaRSZX3cysQNjQUuidhzN2
         BQaOPFThfponw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, James John <me@donjajo.com>,
        Sasha Levin <sashal@kernel.org>, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 12/13] platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e
Date:   Sun, 29 Oct 2023 19:00:45 -0400
Message-ID: <20231029230057.792930-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230057.792930-1-sashal@kernel.org>
References: <20231029230057.792930-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f37cc2fc277b371fc491890afb7d8a26e36bb3a1 ]

Older Asus laptops change the backlight level themselves and then send
WMI events with different codes for different backlight levels.

The asus-wmi.c code maps the entire range of codes reported on
brightness down keypresses to an internal ASUS_WMI_BRN_DOWN code:

define NOTIFY_BRNUP_MIN                0x11
define NOTIFY_BRNUP_MAX                0x1f
define NOTIFY_BRNDOWN_MIN              0x20
define NOTIFY_BRNDOWN_MAX              0x2e

        if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
                code = ASUS_WMI_BRN_UP;
        else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
                code = ASUS_WMI_BRN_DOWN;

Before this commit all the NOTIFY_BRNDOWN_MIN - NOTIFY_BRNDOWN_MAX
aka 0x20 - 0x2e events were mapped to 0x20.

This mapping is causing issues on new laptop models which actually
send 0x2b events for printscreen presses and 0x2c events for
capslock presses, which get translated into spurious brightness-down
presses.

The plan is disable the 0x11-0x2e special mapping on laptops
where asus-wmi does not register a backlight-device to avoid
the spurious brightness-down keypresses. New laptops always send
0x2e for brightness-down presses, change the special internal
ASUS_WMI_BRN_DOWN value from 0x20 to 0x2e to match this in
preparation for fixing the spurious brightness-down presses.

This change does not have any functional impact since all
of 0x20 - 0x2e is mapped to ASUS_WMI_BRN_DOWN first and only
then checked against the keymap code and the new 0x2e
value is still in the 0x20 - 0x2e range.

Reported-by: James John <me@donjajo.com>
Closes: https://lore.kernel.org/platform-driver-x86/a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com/
Closes: https://bbs.archlinux.org/viewtopic.php?pid=2123716
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231017090725.38163-2-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 4f31b68642a08..6faf213f687a3 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -18,7 +18,7 @@
 #include <linux/i8042.h>
 
 #define ASUS_WMI_KEY_IGNORE (-1)
-#define ASUS_WMI_BRN_DOWN	0x20
+#define ASUS_WMI_BRN_DOWN	0x2e
 #define ASUS_WMI_BRN_UP		0x2f
 
 struct module;
-- 
2.42.0

