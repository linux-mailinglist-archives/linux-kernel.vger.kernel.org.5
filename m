Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2697B7606
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbjJDA6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDA6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:58:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C5DAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 17:58:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a21e8ee1b7so3241607b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 17:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696381082; x=1696985882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uThSy4yEdZygz3nx9AdT/+Ka5ZDArvLjVeK3y4dcvFg=;
        b=WcIa0QSlaApCsdXeQUUsE4MkFxt49fgzs+mlRdsqiRPMmuoyFgluspgbGzYFgMmtlM
         Kkm+P7HDgNfZOonNCu7mOi4W2PNZVw+/lhiUzFG9cCIKDQK+i4XGjmpj5byQ6b+d2Pm6
         xLGjSesmmQ1EsoHtsITqgK7uuhQxS2inGwBUyHbFrLvX67awXgs+tInu14Lfdao48IrN
         fwWUJx/sgvfEPwJvOCGxXf0f4g/vEufHBOMwRDsr6MHChVwYuI9PvdIyZJ+iTSbyO3+j
         M/nWdsyYCgVXm4yi6/BLIxhufZOz5VSi6cYXpeaP3KCtnsfxtCMg/LOGJCVQ5GQtDVR6
         loAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696381082; x=1696985882;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uThSy4yEdZygz3nx9AdT/+Ka5ZDArvLjVeK3y4dcvFg=;
        b=vjMRTVi7bBHrjJ9VztxCmQ/yi1MHLqWp0Hd3XahBPWDvsA4RBoclVVVl6fhH0t8VIC
         dnZ30A4xX86VygH4O54FITR9FfLr0KjxlEJlEjgvFAE7Vg2A6peVVj4PTUyhja/e/usG
         yx/6de5UZWy38PeDotSE+m8d47sQ7WWGORRXi5VjrZc27HPWB/MMY9nopIds0dNYSy0E
         aJsBFh/xUy05DVZsBPRoNBDuahMshlae1tV4wz6yUQg0Cjxx6ssjLM80Xq32V7V9I4ju
         Bz2k3z5n9JjukBn9dr4yoyRlCB3KZPhx/7eGqq6NFvVpCXSYURwIJG99KgmJ41PWuHZE
         HsFw==
X-Gm-Message-State: AOJu0YwSQ2D/T2qf8Luan/yUXJR7O9tkaqo/sI01rmcWj0BBv5/UqML7
        7+Oop5N1R5nHu2P/lxOb02LnUuT65YhToimRNTug
X-Google-Smtp-Source: AGHT+IGMPS6riiI0T9ofgPM70mrTKqdYfgP6uvgJ51Ftij4XuTNLRixV8U6nH5DOAQqNufqzPO4Xi4IrIJQsw+E9dJwJ
X-Received: from horchata.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:5b3])
 (user=jefferymiller job=sendgmr) by 2002:a25:b8d:0:b0:d89:42d7:e72d with SMTP
 id 135-20020a250b8d000000b00d8942d7e72dmr82813ybl.3.1696381082437; Tue, 03
 Oct 2023 17:58:02 -0700 (PDT)
Date:   Tue,  3 Oct 2023 19:57:24 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231004005729.3943515-1-jefferymiller@google.com>
Subject: [PATCH] Input: elantech - fix fast_reconnect callback in ps2 mode
From:   Jeffery Miller <jefferymiller@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     regressions@lists.linux.dev, benjamin.tissoires@redhat.com,
        linux@leemhuis.info, Andrew Duggan <aduggan@synaptics.com>,
        Andrew Duggan <andrew@duggan.us>, loic.poulain@linaro.org,
        Jeffery Miller <jefferymiller@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make `elantech_setup_ps2` set a compatible fast_reconnect pointer
when its ps2 mode is used.

When an SMBus connection is attempted and fails `psmouse_smbus_init`
sets fast_reconnect to `psmouse_smbus_reconnect`.
`psmouse_smbus_reconnect` expects `psmouse->private` to be
`struct psmouse_smbus_dev` but `elantech_setup_ps2` replaces
it with its private data. This was causing an issue on resume
since psmouse_smbus_reconnect was being called while in ps2, not SMBus
mode.

This was uncovered by commit 92e24e0e57f7 ("Input: psmouse - add delay when
deactivating for SMBus mode")

Closes:
Link:https://lore.kernel.org/all/ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info/
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>

Signed-off-by: Jeffery Miller <jefferymiller@google.com>
---

The other callbacks set in psmouse_smbus_init are already replaced.
Should fast_reconnect be set to `elantech_reconnect` instead?


 drivers/input/mouse/elantech.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.42.0.582.g8ccd20d70d-goog

