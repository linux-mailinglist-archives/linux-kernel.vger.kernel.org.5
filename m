Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565117E1249
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 06:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjKEFAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 01:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEFAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 01:00:24 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F1136
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 22:00:21 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e9c2c00182so4592772fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 22:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699160421; x=1699765221;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1vXEBDfpbblSY/yGpjZe1OHHucru8YCsR7pQhwcyqw=;
        b=dZFxCbB1YCY6bjbmuA1KtccW96tTUWatSgZiwThCZ624jYffwuM/xgOHtbZEfLAD1d
         4io9fmyfW5UzsvJ4/+7CLhhw+8/KhMIKSPKkWVazhC/QcQwqc94Xqc1Gft6FYsxlmwwu
         zat3lzlhlQILa12bfJ88yYGSOzRBmFrdA61huXSHfvA/6k+vKuiBHol3pZXFiju7qg79
         cLzao2FDADnhYZJH+UNGKA15p+uLNzn6RJXu5yNCZgBGRbD5jBVi6Cofcgk2+v4OyH5R
         /AJdkmQ328yoTavw1TagpuqX35sfnW1QZkYpFYHeJZHCToDKxUigeiD1IQesMZwArDO6
         dZ+w==
X-Gm-Message-State: AOJu0YwvZgfX7V8U/39AtTsH+qgmg9G0ofEV07S44QW4jV5b8SgDyOm7
        9NDugEV0LYZ61B0lvQxDDuQaNGYzbG9RrfRdrZxPVlQlM35SBYo=
X-Google-Smtp-Source: AGHT+IGq9nqxyEYrEWM8lXmNsrM+8qmv/U+soh6CTLy43C+DXLHt1yne7Q7+WIlzLk7zuvwXqZ9hCj+uYCYXscnO/1rg4XS/Q6uC
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c0c4:b0:1e9:c2a7:6593 with SMTP id
 e4-20020a056870c0c400b001e9c2a76593mr11866146oad.6.1699160421171; Sat, 04 Nov
 2023 22:00:21 -0700 (PDT)
Date:   Sat, 04 Nov 2023 22:00:21 -0700
In-Reply-To: <000000000000635bfa0607ed5cdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052081e0609609d8e@google.com>
Subject: Re: [syzbot] [PATCH] Test for 6465e260f487
From:   syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Test for 6465e260f487
Author: eadavis@sina.com

please test warn in __nf_unregister_net_hook

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6465e260f487

diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 3126911f5042..fc1b337aec8f 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -117,7 +117,8 @@ nf_hook_entries_grow(const struct nf_hook_entries *old,
 		orig_ops = nf_hook_entries_get_hook_ops(old);
 
 		for (i = 0; i < old_entries; i++) {
-			if (orig_ops[i] != &dummy_ops)
+			if (!__kernel_text_address(orig_ops[i]) && 
+			    orig_ops[i] != &dummy_ops)
 				alloc_entries++;
 
 			/* Restrict BPF hook type to force a unique priority, not
@@ -146,7 +147,8 @@ nf_hook_entries_grow(const struct nf_hook_entries *old,
 	i = 0;
 	nhooks = 0;
 	while (i < old_entries) {
-		if (orig_ops[i] == &dummy_ops) {
+		if (__kernel_text_address(orig_ops[i]) || 
+		    orig_ops[i] == &dummy_ops) {
 			++i;
 			continue;
 		}
@@ -263,10 +265,12 @@ static void *__nf_hook_entries_try_shrink(struct nf_hook_entries *old,
 
 	new_ops = nf_hook_entries_get_hook_ops(new);
 	for (i = 0, j = 0; i < old->num_hook_entries; i++) {
-		if (orig_ops[i] == &dummy_ops)
+		if (IS_ERR_OR_NULL(orig_ops[i]) || orig_ops[i] == &dummy_ops)
 			continue;
 		new->hooks[j] = old->hooks[i];
 		new_ops[j] = (void *)orig_ops[i];
+		printk("new ents: %p, new uo h: %p, new ops: %p, %s\n",
+			new, new->hooks[j], new_ops[j], __func__);
 		j++;
 	}
 	hooks_validate(new);
@@ -479,6 +483,7 @@ static bool nf_remove_net_hook(struct nf_hook_entries *old,
 			continue;
 		WRITE_ONCE(old->hooks[i].hook, accept_all);
 		WRITE_ONCE(orig_ops[i], (void *)&dummy_ops);
+		printk("ents: %p, deled ops: %p, i: %d, %s\n", old, orig_ops[i], i, __func__);
 		return true;
 	}
 
