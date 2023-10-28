Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71307DA769
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjJ1NzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjJ1NzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:55:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4961CED
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:55:10 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id wjmMqrqoPLilFwjmMqmAXJ; Sat, 28 Oct 2023 15:55:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698501308;
        bh=QDDAkjDTfNEpw/wshaLCFDIwV6LReU6Ggu0GJWjqj6Q=;
        h=From:To:Cc:Subject:Date;
        b=pczJLlS4Ft5Nsvs8VT0hKx66s+tQvUDKhbWvAV+q1ZWhNbgM8tNhTceHCv0wmjUeQ
         4ChR4r7nOQgaJcglERdNOyWwEN0NMK8yviJXFqpoePokbXMfQWoI/PqA+2OTZImwS8
         c3cQMTajHH3zR0e7tpni7NlgyLvk7PsgNuFtmKoiXNnX6yyZ7bUQsLTLiZfTtE9uH8
         IHOHzzNEu9EQurDmgr3UTpteovLjp2O69CtgNCB8FUMoG0PvBzuNjiIXtDzlttQqen
         RI8U5KtJaDHLQ/DmooE5dyrEJfFsldW/FK9ngV0OmRq0/3vBbLc9I6cZTr1B+thNqa
         YN6cPqqRRLQjQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 28 Oct 2023 15:55:08 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Martin Hicks <mort@sgi.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH] kdb: Fix a potential buffer overflow in kdb_local()
Date:   Sat, 28 Oct 2023 15:55:00 +0200
Message-Id: <0b1790ca91b71e3362a6a4c2863bc5787b4d60c9.1698501284.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When appending "[defcmd]" to 'kdb_prompt_str', the size of the string
already in the buffer should be taken into account.

Switch from strncat() to strlcat() which does the correct test to avoid
such an overflow.

Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 438b868cbfa9..e5f0bf0f45d1 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1350,7 +1350,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		snprintf(kdb_prompt_str, CMD_BUFLEN, kdbgetenv("PROMPT"),
 			 raw_smp_processor_id());
 		if (defcmd_in_progress)
-			strncat(kdb_prompt_str, "[defcmd]", CMD_BUFLEN);
+			strlcat(kdb_prompt_str, "[defcmd]", CMD_BUFLEN);
 
 		/*
 		 * Fetch command from keyboard
-- 
2.34.1

