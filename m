Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3507884FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbjHYKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbjHYKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:35:23 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92E09E;
        Fri, 25 Aug 2023 03:35:21 -0700 (PDT)
Received: from tundra.lovozera (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6568940737D8;
        Fri, 25 Aug 2023 10:35:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6568940737D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1692959720;
        bh=uv+IGT4dtbWYssOH0uP0zeBxYNaNR++H+3chAhwj5ws=;
        h=From:To:Cc:Subject:Date:From;
        b=osJaHnhkqdkAdWqmYSriLWVluoqWhAysw/ID2ZUT0fc2ryVDXdaa5EKj+qyeIe9yY
         3vWmNuPJiOEvEMvjksPK82R0d48pDLa2Uli3nrMgpFVPQtRm9l/E8n5UFehyFW/Zv4
         7meozk039IrpMLUP49beXfgMsELrKOswIl8a/Rkw=
From:   Mikhail Kobuk <m.kobuk@ispras.ru>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mikhail Kobuk <m.kobuk@ispras.ru>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] trace/hwlat: remove extra space at the end of hwlat_detector/mode
Date:   Fri, 25 Aug 2023 13:34:30 +0300
Message-ID: <20230825103432.7750-1-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Space is printed after each mode value including the last one:
$ echo \"$(sudo cat /sys/kernel/tracing/hwlat_detector/mode)\"
"none [round-robin] per-cpu "

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8fa826b7344d ("trace/hwlat: Implement the mode config option")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 kernel/trace/trace_hwlat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 2f37a6e68aa9..b791524a6536 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -635,7 +635,7 @@ static int s_mode_show(struct seq_file *s, void *v)
 	else
 		seq_printf(s, "%s", thread_mode_str[mode]);
 
-	if (mode != MODE_MAX)
+	if (mode < MODE_MAX - 1) /* if mode is any but last */
 		seq_puts(s, " ");
 
 	return 0;
-- 
2.42.0

