Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F2E7B9937
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244211AbjJEAXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjJEAXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:23:30 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823C8AD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:23:27 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6c4b9cab821so502363a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 17:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696465407; x=1697070207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uamWKvizGVLyWmbe/E5IO6qRkfMAehoyNPcply0ANnU=;
        b=2hUKNhbR9vKCCV5YuwK/SPNOsu2YRcTyH8sPQNSjvhsQnF4mhkPIeo+SFNTOrQf7ze
         vvMWjQ+UpF/YRgusTu2nIDkiwEqajZgH4HZCEWj8cTZnzxjCtHj70W9GmKnQIGkgDWk1
         RP4etEfPvhKhfkuVkG5v/xUXdJ8frxEStnFVo7cZ21I9ihywsntJcOzHe7FZaemKKWGk
         2njmA+8ubhaXX/0XV0vtsiqnWVBWQB8L/kGXly8LFhGbjZ1CnYC5I+jRYnL+E4mPD/i2
         v4+srZX4DG1//ZnJ4nydf1XsGnEqBO3pWX6ghWoBQR7lbaegVayOZbkHAfViPcOhZPDf
         rSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696465407; x=1697070207;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uamWKvizGVLyWmbe/E5IO6qRkfMAehoyNPcply0ANnU=;
        b=kTP6O0Oz1scrrVhDbD96UBbsGPpmsQrVhVPekZGX2AZbUYIS2j8dbUe2d/Iu4llbMW
         yNsNWn7CSE6wr4AOilPisOeqz/J5nxSJezDjCW1vx0LJbNxkYP0abWgQO4iK6AKIUnps
         N/+RKc/nFNXFNh3pKAYjIDldRNts0+xDpoKy0J+gZWxjTW5Qnr0xr1sS6sJWp3a5mYo5
         DHHq/b+6xFmitfATmXBeT/MhxqaPoAZElxv6AEI+LuSwEuUX1O38MJNSvDSxmtUHcndO
         cz5KfvBjtRB93MGuP15VdAC6HdCAQKSI3ZQuZJChn/xt8K+vHIGkXFL0hzwRczgeQCkt
         OkJg==
X-Gm-Message-State: AOJu0YyiFp6yDoTU4DK6cgCrBsGPkvCS7IEZMadUSkxYU+RRFZPBIx8s
        ZAbDOZrg+fm5ahGUwKV49Y6LLIa/2rP4POlr/y7K
X-Google-Smtp-Source: AGHT+IGPTG6blfnNFLzCOFXwIz6xwDPRyA8tMfVvzBK24OalkQInaEHCeTFIYhQ1E7glzzbZnd/emD62BfZSvrMcAHMT
X-Received: from horchata.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:5b3])
 (user=jefferymiller job=sendgmr) by 2002:a05:6830:1114:b0:6c0:b1b2:9504 with
 SMTP id w20-20020a056830111400b006c0b1b29504mr1021192otq.3.1696465406857;
 Wed, 04 Oct 2023 17:23:26 -0700 (PDT)
Date:   Wed,  4 Oct 2023 19:20:20 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231005002249.554877-1-jefferymiller@google.com>
Subject: [PATCH v2] Input: psmouse - fix fast_reconnect function for PS/2 mode
From:   Jeffery Miller <jefferymiller@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Andrew Duggan <andrew@duggan.us>,
        Andrew Duggan <aduggan@synaptics.com>, loic.poulain@linaro.org,
        linux@leemhuis.info, benjamin.tissoires@redhat.com,
        Jeffery Miller <jefferymiller@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make elantech_setup_ps2 and synaptics_init_ps2 set an appropriate
fast_reconnect pointer when the PS/2 mode is used.

When the SMBus connection is attempted psmouse_smbus_init sets
the fast_reconnect pointer to psmouse_smbus_reconnect. When this fails
elantech_setup_ps2 and synaptics_init_ps2 will fallback to PS/2
mode replacing the psmouse private data.
This was causing an issue on resume since psmouse_smbus_reconnect was
being called while in PS/2 mode and attempting to use the invalid
private data.

This issue was uncovered when psmouse_smbus_reconnect started attempting
to use more of the data structure.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/all/ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info/
Fixes: 92e24e0e57f7 ("Input: psmouse - add delay when deactivating for SMBus mode")

Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Signed-off-by: Jeffery Miller <jefferymiller@google.com>
---

The other callbacks set in psmouse_smbus_init are already replaced.


Changes in v2:
- Also set fast_reconnect in the synaptics ps2 fallback path from review
  comments.
- Add Fixes: tag to the commit that uncovered the problem.

 drivers/input/mouse/elantech.c  | 1 +
 drivers/input/mouse/synaptics.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2118b2075f43..4e38229404b4 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -2114,6 +2114,7 @@ static int elantech_setup_ps2(struct psmouse *psmouse,
 	psmouse->protocol_handler = elantech_process_byte;
 	psmouse->disconnect = elantech_disconnect;
 	psmouse->reconnect = elantech_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->pktsize = info->hw_version > 1 ? 6 : 4;
 
 	return 0;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ada299ec5bba..cefc74b3b34b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1623,6 +1623,7 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->cleanup = synaptics_reset;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;
-- 
2.42.0.582.g8ccd20d70d-goog

