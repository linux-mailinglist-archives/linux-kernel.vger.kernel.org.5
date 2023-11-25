Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F417F8A81
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjKYMFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:05:04 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13AD72
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:05:09 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id 6rPGrkVZQMoj46rPGrYOrl; Sat, 25 Nov 2023 13:05:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700913907;
        bh=D8jRKKW7qYyj5J7AMcOnTnbOZsoLLJ3CuZOXne3T+xE=;
        h=From:To:Cc:Subject:Date;
        b=FpZCFyMhyfkRQVTlJ+ul3K9wjaFgrtqzimdWGweVS/sVW5yp047fClM6sgjK4qoLo
         BFv3hWrTDEW4138OnhsK5IGjpj48AmQGQ5LTTR4pFERCD/ib/XfiNJLBdQuBrDpX2S
         hV8e4JUq/z/s2hYuYIvhPF5d8OqOgyE2AUbvNv2Mu7j9/WVOzsNy15QeLgLf1P4MKE
         WmPEigmenEo5j42E04jl2HMYeyq2sguWOPiTmo70ebZzBZoRb2GciK6FSuo1twSShn
         +gz0Ux5v0TSvc93oqlD20I7ntiK5lD7Dpr6AJJoidrlcCITvFTg4QUji+tv2OPPN4P
         Aug0puK1mLLrg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 25 Nov 2023 13:05:07 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Martin Hicks <mort@sgi.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH v2] kdb: Fix a potential buffer overflow in kdb_local()
Date:   Sat, 25 Nov 2023 13:05:04 +0100
Message-Id: <dfb1a9a26d7f974371ff1d3e29eba80ef075d465.1700913863.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When appending "[defcmd]" to 'kdb_prompt_str', the size of the string
already in the buffer should be taken into account.

An option could be to switch from strncat() to strlcat() which does the
correct test to avoid such an overflow.

However, this actually looks as dead code, because 'defcmd_in_progress'
can't be true here.
See a more detailed explanation at [1].

[1]: https://lore.kernel.org/all/CAD=FV=WSh7wKN7Yp-3wWiDgX4E3isQ8uh0LCzTmd1v9Cg9j+nQ@mail.gmail.com/

Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
   - Delete the strncat() call   [Doug Anderson]

v1: https://lore.kernel.org/all/0b1790ca91b71e3362a6a4c2863bc5787b4d60c9.1698501284.git.christophe.jaillet@wanadoo.fr/
---
 kernel/debug/kdb/kdb_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 6b213c8252d6..d05066cb40b2 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1348,8 +1348,6 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		/* PROMPT can only be set if we have MEM_READ permission. */
 		snprintf(kdb_prompt_str, CMD_BUFLEN, kdbgetenv("PROMPT"),
 			 raw_smp_processor_id());
-		if (defcmd_in_progress)
-			strncat(kdb_prompt_str, "[defcmd]", CMD_BUFLEN);
 
 		/*
 		 * Fetch command from keyboard
-- 
2.34.1

