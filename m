Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1B7F8AE1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjKYMw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:52:54 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932558F;
        Sat, 25 Nov 2023 04:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1700916776;
        bh=TvazAFFGE0otnXYiwQcMdxMBACDm5WWzmf21WwSH3Jk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fC4/kcbE39t3cktG8KvZ2tjeXuGXOswHwzsR9Gbqe2FNKM8mZv2a+fLAb/OkUoGQl
         Ct/I3PU+OUB6zbRuI69jF5cGRu7dywPWwb2ewjxr+wSLSHc7HJdYyMbfjqrPEGja3h
         89Rxn9tr6/tsHgNX0DJeeLmHsqiKHK5+aomenuXY=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 25 Nov 2023 13:52:51 +0100
Subject: [PATCH RFC 2/7] bpf: cgroup: call proc handler through helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231125-const-sysctl-v1-2-5e881b0e0290@weissschuh.net>
References: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
In-Reply-To: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700916776; l=855;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TvazAFFGE0otnXYiwQcMdxMBACDm5WWzmf21WwSH3Jk=;
 b=YdEbKegum1nk5186ZhIPwqPFp/VAJDdMZA4InijjRqP/7NAbrS1Qk9V7T+OhbslhbSi4ispVx
 jKuxCmX8CtFDorBAPbKAyM+pny1qZQU2W6Xbolh5PbFIiyaTYTPoO6C
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

The sysctl core will introduce a second handler function.
To prepare for this use the provided helper function to call either
handler function.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 491d20038cbe..d537b1c80a36 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1715,7 +1715,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 
 	ctx.cur_val = kmalloc_track_caller(ctx.cur_len, GFP_KERNEL);
 	if (!ctx.cur_val ||
-	    table->proc_handler(table, 0, ctx.cur_val, &ctx.cur_len, &pos)) {
+	    sysctl_run_handler(table, 0, ctx.cur_val, &ctx.cur_len, &pos)) {
 		/* Let BPF program decide how to proceed. */
 		ctx.cur_len = 0;
 	}

-- 
2.43.0

