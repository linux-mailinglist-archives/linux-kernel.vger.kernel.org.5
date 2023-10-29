Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4147DB051
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjJ2XFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjJ2XEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:04:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588157684;
        Sun, 29 Oct 2023 16:02:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF138C433BD;
        Sun, 29 Oct 2023 23:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620520;
        bh=FR9TuDE8cvaTgCQf2VjcMAKlIGXbxEROPyRSbVTPsIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqXm8i778iPcbs1T59ln5e2Taj2+++EvIbEuB7pYGxevTfenN0RHr/Vr08t+/DQg/
         XEi9KOkALK/5BatwXBxAj2Q70SyRe/l+AYC4MZRF5JBnqvwSegVjxaKRKTGMziiVBs
         Ok6s8HSK34Wak56F1sAyQLc/rAaEGQ8DcOuvjX+04cWpRuuQIC5bsco/t7O+wIjQxF
         LMJqPQInymqDyyXvZxYeULu3t9lu2nI7StormZEQRSCirhGHcirnfOkKxOr6rHnmyM
         vquvdriNSzkWcv/RLpEX3IlHe6TLtUpDNs+jT11Fl1YV70vRSYfI3ZSNHENIBzuSIN
         iQJL5vZqs6CbA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, James John <me@donjajo.com>,
        Sasha Levin <sashal@kernel.org>, corentin.chary@gmail.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/12] platform/x86: asus-wmi: Map 0x2a code, Ignore 0x2b and 0x2c events
Date:   Sun, 29 Oct 2023 19:01:25 -0400
Message-ID: <20231029230135.793281-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230135.793281-1-sashal@kernel.org>
References: <20231029230135.793281-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
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

[ Upstream commit 235985d1763f7aba92c1c64e5f5aaec26c2c9b18 ]

Newer Asus laptops send the following new WMI event codes when some
of the F1 - F12 "media" hotkeys are pressed:

0x2a Screen Capture
0x2b PrintScreen
0x2c CapsLock

Map 0x2a to KEY_SELECTIVE_SCREENSHOT mirroring how similar hotkeys
are mapped on other laptops.

PrintScreem and CapsLock are also reported as normal PS/2 keyboard events,
map these event codes to KE_IGNORE to avoid "Unknown key code 0x%x\n" log
messages.

Reported-by: James John <me@donjajo.com>
Closes: https://lore.kernel.org/platform-driver-x86/a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com/
Closes: https://bbs.archlinux.org/viewtopic.php?pid=2123716
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231017090725.38163-4-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 8db2dc05b8cf2..d1c34eb3ebb1d 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -447,6 +447,9 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, ASUS_WMI_BRN_DOWN, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY, ASUS_WMI_BRN_UP, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x2a, { KEY_SELECTIVE_SCREENSHOT } },
+	{ KE_IGNORE, 0x2b, }, /* PrintScreen (also send via PS/2) on newer models */
+	{ KE_IGNORE, 0x2c, }, /* CapsLock (also send via PS/2) on newer models */
 	{ KE_KEY, 0x30, { KEY_VOLUMEUP } },
 	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
 	{ KE_KEY, 0x32, { KEY_MUTE } },
-- 
2.42.0

