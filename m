Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964B6781E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjHTPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjHTPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:05:17 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F149D6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:02:52 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Xjx3q3THNLJHlXjx3qAvDw; Sun, 20 Aug 2023 17:02:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692543770;
        bh=kzvm+R76qxOFMP8OSiSP2Bx28/FrmYY6yJvbRtaD+SM=;
        h=From:To:Cc:Subject:Date;
        b=MwNqm3iiS3cYDdbfC+jrHpoGxtqaTfj9gLNUlImPCIEkZltyM2xKlkpmEymujxh/E
         BNTChImY1keRQegBPrML8oxUKgYha5JXhtBgmvY7D+4LhwHuaTFfn8pcBTs/hTko+K
         uz4GrOlq5itb6o1W5oaZlPqn7/1o93VtxsRzFTnFP9qRLpjk31QRZWKfeOqddMSnuX
         sUiZvg/FGkS8pKuffSymf8U0xBCkngX+lPhuwvKETo7xdK2LyRfIlyU8rdDudq20k0
         pdkyiIzrH4ci3eJpi+LfvAbNVF+eD/yXLkSfStLE7XX/wnQpXO15U2KuuwA5wU2gQw
         vzr1Dbi7w8h1g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Aug 2023 17:02:50 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/user_events: Fix an erroneous usage of struct_size()
Date:   Sun, 20 Aug 2023 17:02:42 +0200
Message-Id: <7a20160628fa586a74936c9212102dbf896e7332.1692543738.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If struct_size() returns a value that does not fit in a 'int', the size
passed to kzalloc() is wrong.

Remove the intermediate 'size' variable and use struct_size() directly.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I don't know if 'size' can get bigger than a int in the real world, but the
change looks safe in any cases.

On x86_64, looking at the .s files, the previous code had an extra:
    movslq	%r13d, %r13
which really looks wrong to me.
---
 kernel/trace/trace_events_user.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 33cb6af31f39..67cc71a872b0 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2153,7 +2153,7 @@ static int user_events_ref_add(struct user_event_file_info *info,
 {
 	struct user_event_group *group = info->group;
 	struct user_event_refs *refs, *new_refs;
-	int i, size, count = 0;
+	int i, count = 0;
 
 	refs = rcu_dereference_protected(info->refs,
 					 lockdep_is_held(&group->reg_mutex));
@@ -2166,10 +2166,8 @@ static int user_events_ref_add(struct user_event_file_info *info,
 				return i;
 	}
 
-	size = struct_size(refs, events, count + 1);
-
-	new_refs = kzalloc(size, GFP_KERNEL_ACCOUNT);
-
+	new_refs = kzalloc(struct_size(refs, events, count + 1),
+			   GFP_KERNEL_ACCOUNT);
 	if (!new_refs)
 		return -ENOMEM;
 
-- 
2.34.1

