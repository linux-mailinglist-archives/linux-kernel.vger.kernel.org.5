Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255DD802C6D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbjLDHxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjLDHwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:52:46 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B79136;
        Sun,  3 Dec 2023 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701676352;
        bh=TZdNqn1SiSNc5YcuC4mCIk7Ynn2gUU/Or228atMtaJs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Az7F8rfSpThZ1n25BdEvJp2p9E/AzY0X3wozV/MY1/PAa1/Qj0RAhj7z6fiRqI7kK
         7HDAJXx5XOu/S6imHwuojXsRcbfmd6OiQSZzb0GGBpHVT+IA2v6TKvAaAa/d2HWf+4
         /NehtYiQxYEIopU8YBWhQpz/RtDsgc+T9zG7k1jA=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 04 Dec 2023 08:52:18 +0100
Subject: [PATCH v2 05/18] seccomp: constify ctl_table arguments of utility
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-5-7a5060b11447@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=1238;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TZdNqn1SiSNc5YcuC4mCIk7Ynn2gUU/Or228atMtaJs=;
 b=+bb7R1dzvflk2V91q1B3apYuSZNzsswX5hsEfkK3Q7Bi6c2nVr2JfTll1pVlMP5bZS2K4J5GB
 XaPAF3lxcvpDah0XCW1ntvvsW9fI5ifFd/kDIevoOjVDZbSHl4zCMEZ
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
helpers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..a23672674ff6 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2334,7 +2334,7 @@ static bool seccomp_actions_logged_from_names(u32 *actions_logged, char *names)
 	return true;
 }
 
-static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
+static int read_actions_logged(const struct ctl_table *ro_table, void *buffer,
 			       size_t *lenp, loff_t *ppos)
 {
 	char names[sizeof(seccomp_actions_avail)];
@@ -2352,7 +2352,7 @@ static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
 	return proc_dostring(&table, 0, buffer, lenp, ppos);
 }
 
-static int write_actions_logged(struct ctl_table *ro_table, void *buffer,
+static int write_actions_logged(const struct ctl_table *ro_table, void *buffer,
 				size_t *lenp, loff_t *ppos, u32 *actions_logged)
 {
 	char names[sizeof(seccomp_actions_avail)];

-- 
2.43.0

