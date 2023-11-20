Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD07F1A86
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjKTRhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjKTRhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:37:01 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15741D7B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:36:50 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b6ccaf0516so2764186b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700501809; x=1701106609; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6S4PK8WT3cwW+G2GrOmybB1YODe/+PbVzMA49NRihL0=;
        b=jfWnXtvPi63Cju5W8DokCsYXVKltwu06qExZQhXmrNK805rrNt2syRzhkyHNDFWuSz
         NvW4sr8gfJTysw4g+oS51ZWOEXTkGSjyD26M7Tn6ZultHte+S0N3Tie+MFMjYYcFBFvD
         2eHGAjirUmwCgbfu07BZ5kfE4tAyl7J5bjA1x8MpwymukN8OCt6pLS2yytLKu52seIE8
         ldLBdfR13qsTtw3e7/XZQ09oLtFLi91ARUs/9KWDF6FCXZue3fUgxrCMoPwFm1hfdous
         HfzfnBX+D7Ast5rqCFMsYE6mBl2zeSq84e/6kZrc8W6GjElPS05Ta1xtE77i4FRGOPjd
         jzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501809; x=1701106609;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6S4PK8WT3cwW+G2GrOmybB1YODe/+PbVzMA49NRihL0=;
        b=GK/YUSVukeOZrMX3GofYNkTC2DkU5VLpjNLYdb8Z8jN+jhUO4SX9CH8nrUzUpzGV6R
         nwj30TYS6wBs69V1frKx6Z6zalim2wYLV43IzzpyCrA8WSI+maMBdJxVeM8AX0alGY6S
         KWy0BMcrkj6uid92YKN9jOWZ8RQ16XEL9bHi1ychPhyxrfp02AGVFuomamE9jZ+GFsPW
         j8xz9lfqBKxb1vssCupA1VtZxImLQbEsskOhXvt8AXaUjX84Q4Ua8C1MYBGTzGRs6Ke+
         KEDLJqviHjRvaxMyc7X+5Np12G4xIwQnJRFb/MI5Irqj0HdMHlTZ1HtmgwV9hSKWrMfS
         jTZw==
X-Gm-Message-State: AOJu0Yy7aH7VK68Iucm8B9nspV3sJUjevjzCDTZANWWo2VjCfymvnSaY
        4qbYvJxLhHChnDl65tU+24KwpQ==
X-Google-Smtp-Source: AGHT+IGl6FR1QPuWw83tR4YZijGxBbFwW2zBDfGjF5hcAg8Pg3Q6u4xrWAUQF0k15hXtsQj+Z3VEbA==
X-Received: by 2002:a05:6870:d3c3:b0:1f0:4e1f:e09a with SMTP id l3-20020a056870d3c300b001f04e1fe09amr116089oag.4.1700501809323;
        Mon, 20 Nov 2023 09:36:49 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x55-20020a056830247700b006d64b970519sm1245547otr.2.2023.11.20.09.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:36:48 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Mon, 20 Nov 2023 09:36:39 -0800
Subject: [PATCH] riscv: Safely remove entries from relocation list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-module_linking_freeing-v1-1-fff81d7289fc@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIACaZW2UC/x2MQQqAIBQFrxJ/naA/3HSViMh61aeyUIogvHvSa
 pjFzEsRQRCpLl4KuCXK4bOYsqBh6f0MJWN2Ys2VMazVfozXhm4Tv4qfuykAmYqd7SvH1joLyvE
 ZMMnzj5s2pQ90t4V7aAAAAA==
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safe versions of list and hlist iteration to safely remove
entries from the module relocation lists.

Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/module.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 56a8c78e9e21..209db949a06e 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -624,18 +624,25 @@ void process_accumulated_relocations(struct module *me)
 	 *	- Each relocation entry for a location address
 	 */
 	struct used_bucket *bucket_iter;
+	struct used_bucket *bucket_iter_tmp;
 	struct relocation_head *rel_head_iter;
+	struct hlist_node *rel_head_iter_tmp;
 	struct relocation_entry *rel_entry_iter;
+	struct relocation_entry *rel_entry_iter_tmp;
 	int curr_type;
 	void *location;
 	long buffer;
 
-	list_for_each_entry(bucket_iter, &used_buckets_list, head) {
-		hlist_for_each_entry(rel_head_iter, bucket_iter->bucket, node) {
+	list_for_each_entry_safe(bucket_iter, bucket_iter_tmp,
+				 &used_buckets_list, head) {
+		hlist_for_each_entry_safe(rel_head_iter, rel_head_iter_tmp,
+					  bucket_iter->bucket, node) {
 			buffer = 0;
 			location = rel_head_iter->location;
-			list_for_each_entry(rel_entry_iter,
-					    rel_head_iter->rel_entry, head) {
+			list_for_each_entry_safe(rel_entry_iter,
+						 rel_entry_iter_tmp,
+						 rel_head_iter->rel_entry,
+						 head) {
 				curr_type = rel_entry_iter->type;
 				reloc_handlers[curr_type].reloc_handler(
 					me, &buffer, rel_entry_iter->value);

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231120-module_linking_freeing-2b5a3b255b5e
-- 
- Charlie

