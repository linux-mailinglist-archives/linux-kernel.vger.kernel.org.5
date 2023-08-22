Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350FB78425D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbjHVNtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjHVNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:49:50 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D26619A;
        Tue, 22 Aug 2023 06:49:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9338e4695so70329301fa.2;
        Tue, 22 Aug 2023 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692712186; x=1693316986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLn/3efpd2FHK1XF98uw9PrjC+AofRAhsZ6yDmk96uo=;
        b=Hq+666VAOjMKQc8i4v58ma2fvIlzw8wBHTHtgxiuRGUtxJBUjXWjE6NPj7GckmJbLg
         B+/LSa/l0aOf7zBDPaRWDltoOHpMhbLUMBO7Pflgrv6nsIEmzFp5ScWiKrOIRf3trrma
         cQMnTxXz4ygPvvWIXPzviTkJMHD+0Y1MGVbZ2AZvjrlXhCVmMfEokQoIogJIvWfp3f3o
         sVxMt4rvexPgfQQlbeoLxyvE0mwEBcGOLxWbeniLKLYtLJDNzv6RIR99E5vcVmEKUAiG
         XqSWloto3QdQwSazy0wuhIC4286NEFi7/hzNEXKuTD3hPgSZCxW/WEMyuXI9dEFGS4RF
         5rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692712186; x=1693316986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLn/3efpd2FHK1XF98uw9PrjC+AofRAhsZ6yDmk96uo=;
        b=KKlOposIKOWMwXCRM6Yqdz+SQWifqQngRRD3PsW2DGfleUptC07wqpQDG6maXFvZ7W
         TpSiz3ZdB2SwLQy0wjmHsjz712g+G3jhnv84ApVA9WFfTU5sTxowesswRZ5HqQ+yKEzE
         VfiDv92UYU+xrzAJWIYvxZnfpXZaImLHRpvrZKN17YSgi9FsXQ/qcS4xnvO71NONSxyw
         8BLIBRGM73V/BpIxsvhwXKdPpR9UKDx20TGIyyrLsFFwSt3Ebybi/ciDOJFGYSCkdQfj
         rmyjAqhwDLVR+K/LKEqh0lVbYZ191xteWiZN6aMRLb9NbHURwdMVnIISyQQiZoIsXmUe
         2Ijg==
X-Gm-Message-State: AOJu0Yyyoa8Wv98SEW5upj/ZtbeXtF84PjrWUeaFGdxWIs4MUOoCDmpm
        50wVZkSAysKprRjABrYWHHA=
X-Google-Smtp-Source: AGHT+IHjITXPvnbT+VWFJqJbcw0NgpsWG1mFhuUyAyxMRR9lUZv6B8mGeGhDbNv4II1EuFxqD626oA==
X-Received: by 2002:a19:385e:0:b0:4fe:7dcb:8ea5 with SMTP id d30-20020a19385e000000b004fe7dcb8ea5mr6087643lfj.25.1692712186038;
        Tue, 22 Aug 2023 06:49:46 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id l19-20020a1c7913000000b003fe26bf65e7sm15740528wme.13.2023.08.22.06.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:49:44 -0700 (PDT)
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Cc:     Alessandro Carminati <alessandro.carminati@gmail.com>,
        Philip Daly <pdaly@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
Date:   Tue, 22 Aug 2023 13:48:49 +0000
Message-Id: <20230822134849.3352329-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the possible_parent_show function, ensure proper handling of the return
value from of_clk_get_parent_name to prevent potential issues arising from
a NULL return.
The current implementation invokes seq_puts directly on the result of
of_clk_get_parent_name without verifying the return value, which can lead
to kernel panic if the function returns NULL.

This patch addresses the concern by introducing a check on the return
value of of_clk_get_parent_name. If the return value is not NULL, the
function proceeds to call seq_puts, providing the returned value as
argument.
However, if of_clk_get_parent_name returns NULL, the function provides a
static string as argument, avoiding the panic.

Reported-by: Philip Daly <pdaly@redhat.com>
Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 drivers/clk/clk.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c249f9791ae8..ab999644e185 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
 				 unsigned int i, char terminator)
 {
 	struct clk_core *parent;
+	const char *tmp;
 
 	/*
 	 * Go through the following options to fetch a parent's name.
@@ -3436,12 +3437,12 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
 		seq_puts(s, core->parents[i].name);
 	else if (core->parents[i].fw_name)
 		seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
-	else if (core->parents[i].index >= 0)
-		seq_puts(s,
-			 of_clk_get_parent_name(core->of_node,
-						core->parents[i].index));
-	else
+	else if (core->parents[i].index >= 0) {
+		tmp = of_clk_get_parent_name(core->of_node, core->parents[i].index);
+		seq_puts(s, tmp ? tmp : "(none)");
+	} else {
 		seq_puts(s, "(missing)");
+	}
 
 	seq_putc(s, terminator);
 }
-- 
2.34.1

