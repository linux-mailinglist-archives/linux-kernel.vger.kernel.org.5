Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847477F47E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbjKVNhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjKVNhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:37:03 -0500
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5AA197;
        Wed, 22 Nov 2023 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yoYSoNhdAF3uXBwTO4gK9Bk/r0jln6+8mWgf09zTa3g=; b=3eGNhZDHZUrMK6QDA4zcwmBBhC
        cAIannDpqj1mmS6JDkxwCHToW3wTS0egVE8MSQOAORkExFzL/aGpsEYyEn2+8EYU6XxY8herW9Lsr
        LirO4R3WDSJ5QFb3sjtSZMPXmkZTLp7oPEf4vFJD2zp1moX64Wdz+lIOzMi6cizZAJdA3HhZIk8q/
        Zx8cKTjdV4mYV4eqsu5vqE8RuqwktQk01Eh21BaQyu0ibpoqLEWcSzNg3hDWHT3VgdS8Wcnw2Msmp
        VAUPUyoQ4UqkXddjMiLgtcf5uuxsPC31h4+85DwclL9hiCT6gcG6g3dIYI4h8X3R5QQKRY7QYN/F6
        oERHm3ZA==;
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r5nPU-004MK7-JZ; Wed, 22 Nov 2023 13:36:57 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
        (envelope-from <ben@rainbowdash>)
        id 1r5nPU-00000001DZJ-30xf;
        Wed, 22 Nov 2023 13:36:56 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] bpf: add __printf() to for printf fmt strings
Date:   Wed, 22 Nov 2023 13:36:56 +0000
Message-Id: <20231122133656.290475-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The btf_seq_show() and btf_snprintf_show() take a printk format
string so add a __printf() to these two functions. This fixes the
following extended warnings:

kernel/bpf/btf.c:7094:29: error: function ‘btf_seq_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
kernel/bpf/btf.c:7131:9: error: function ‘btf_snprintf_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/bpf/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..46c2e87c383d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7088,8 +7088,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
 	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
 }
 
-static void btf_seq_show(struct btf_show *show, const char *fmt,
-			 va_list args)
+static __printf(2,0) void btf_seq_show(struct btf_show *show, const char *fmt,
+				       va_list args)
 {
 	seq_vprintf((struct seq_file *)show->target, fmt, args);
 }
@@ -7122,7 +7122,7 @@ struct btf_show_snprintf {
 	int len;		/* length we would have written */
 };
 
-static void btf_snprintf_show(struct btf_show *show, const char *fmt,
+static __printf(2,0) void btf_snprintf_show(struct btf_show *show, const char *fmt,
 			      va_list args)
 {
 	struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;
-- 
2.37.2.352.g3c44437643

