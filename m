Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77717DB613
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjJ3JYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjJ3JYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:24:48 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38650C4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=bBSFA3O82q5iuXanYrFgC4j6cxLDU7YW1ZtrgC7Y3fQ=; b=0i9XiiD3icqdfgdsbZu5BLEMid
        cS9woy/3gvS6RBrn2M1x3OKOVc1X12GA2/EEI/3QQXBiB8ybG/8Xf87UFw03IVGBKe2rhjtrZ+095
        nndV9Et1lyJ0ySN8GDxTBxzW6imjnbuof6yN4PmToK9XjWNj+uxKYfqPGNoSQmOnmuH/vk28dUQcQ
        Jb2i4xvph1eIRRmlQyd29PPhd66f74FbsfG0gpAtTpnz1hZ4bsMUhjiHnEw2gIrBNeDDTkqalHBlv
        miwJfLr48KA1ursYK9m8Tu5k49MCFFCZehhbDTm3Lr53g+qp6Nk9GKvvdVw2zYPqWrnTeVRbY3uBd
        ZJXnFkAg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qxOVn-000GoW-KS; Mon, 30 Oct 2023 10:24:43 +0100
Received: from [185.17.218.86] (helo=rap..)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qxOVn-000DPP-9i; Mon, 30 Oct 2023 10:24:43 +0100
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 2/2] reboot: flush printk buffers before final shutdown
Date:   Mon, 30 Oct 2023 10:24:32 +0100
Message-ID: <20231030092432.3434623-2-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030092432.3434623-1-martin@geanix.com>
References: <20231030092432.3434623-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27077/Mon Oct 30 08:39:55 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure printed messages are in fact printed before putting the system
down.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3bba88c7ffc6..bab8350d5dae 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -273,6 +273,7 @@ void kernel_restart(char *cmd)
 	else
 		pr_emerg("Restarting system with command '%s'\n", cmd);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
+	pr_flush(1000, false);
 	machine_restart(cmd);
 }
 EXPORT_SYMBOL_GPL(kernel_restart);
-- 
2.42.0

