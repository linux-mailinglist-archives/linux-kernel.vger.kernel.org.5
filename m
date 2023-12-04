Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91D0802C69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjLDHwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjLDHwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:52:45 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3444018E;
        Sun,  3 Dec 2023 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701676352;
        bh=XX/0Dgv+i6b2iH4R1etXfooZRb2dy5KXDGiPQVphnWA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ebZp+DVYTEEAfjfaE0tgQxKbgsqYJFjNAFwcUYjBzNwvnbfhz3uNMC236Sa1fPfTw
         NyY5igxxS9b4fxVKkbyqn/gh+YLiw9R55X5EIHr6YQgzV7wOrcR9JY8Vf91oNlaGDV
         YtvSFjz8UWu4u5MQAanh2PNkPYJH1h1eebMkon+0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 04 Dec 2023 08:52:20 +0100
Subject: [PATCH v2 07/18] utsname: constify ctl_table arguments of utility
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-7-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=696;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XX/0Dgv+i6b2iH4R1etXfooZRb2dy5KXDGiPQVphnWA=;
 b=zWbb03OQ8wfovwcUfOlCCPX491ahk1eH62Nq+pjCquKuyWlS5cMqfrOW//ibS7ErluyLMRkWU
 8/+YmIhOrdlDhhbBdhUvQ1jGzJTdwvIKPQmgi1Kr/jqFOIqsESa0dt6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future commit the proc_handlers themselves will change to
"const struct ctl_table". As a preparation for that adapt the internal
helper.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/utsname_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 019e3a1566cf..46590d4addc8 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_PROC_SYSCTL
 
-static void *get_uts(struct ctl_table *table)
+static void *get_uts(const struct ctl_table *table)
 {
 	char *which = table->data;
 	struct uts_namespace *uts_ns;

-- 
2.43.0

