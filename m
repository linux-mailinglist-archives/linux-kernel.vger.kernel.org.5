Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92137F0ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjKTDHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTDHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:07:18 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367C012D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:07:15 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cf644b090cso2297845ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700449634; x=1701054434;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F7lAGCmRps5BVo1zAwdb2KHRvdZqHojJw6y2FwSktw=;
        b=T5xkQbLUDWIyS+tXTlifIse3rgix51DWjVqG7EOfjjModMPbCClSL2ipd07REniMx+
         fhoUOJclgzLjgSMHRwD6G3pQdYGgsuxnelfGqoeGFyqfCcx+aDjtS7M864EzUW41dJs9
         LqmbLSiITiCiJHbixe8l0WbLADxtahpQUBeOraLd4JI5Vl21oykDUhqZ/T2D/WQpB+X/
         gyDrpCpr9FOJInKqRXsHoXXniO3k3mYzZ++QcHcSo8w/klpxjisCeAa4/PglTJkulqG8
         UTy5GwlY6wAcJfb0U3iGhtiHWdTcO7QEwJEVcSP6M21PZUJUsl+oJcd1ycBSfSElaYoI
         BYrw==
X-Gm-Message-State: AOJu0YzpekZwRvVI5JacgXgTx3WGrflgtNAj9S/4BV1kxXYIURFjouVp
        tExwaexJNICkmyLDLkWn+d7F2E3idnQ7+10smVWwtv8O318denI=
X-Google-Smtp-Source: AGHT+IFY7jW0OFMbwZmdbkRYIzPI8VOuIi5OKYbEoW1MieS3QmHruCTbB392yvPQ4tuF60tngAot8O1DHv3srn/Z5RWijIlQThR4
MIME-Version: 1.0
X-Received: by 2002:a17:902:e74a:b0:1cc:274c:20fc with SMTP id
 p10-20020a170902e74a00b001cc274c20fcmr1894044plf.9.1700449634840; Sun, 19 Nov
 2023 19:07:14 -0800 (PST)
Date:   Sun, 19 Nov 2023 19:07:14 -0800
In-Reply-To: <000000000000635bfa0607ed5cdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000717aaa060a8cc8f5@google.com>
Subject: Re: [syzbot] [PATCH] Test for 6465e260f487
From:   syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 3126911f5042..bec4aeef6a82 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -200,8 +200,10 @@ int nf_hook_entries_insert_raw(struct nf_hook_entries __rcu **pp,
 	struct nf_hook_entries *new_hooks;
 	struct nf_hook_entries *p;
 
+	mutex_lock(&nf_hook_mutex);
 	p = rcu_dereference_raw(*pp);
 	new_hooks = nf_hook_entries_grow(p, reg);
+	mutex_unlock(&nf_hook_mutex);
 	if (IS_ERR(new_hooks))
 		return PTR_ERR(new_hooks);
 
@@ -546,11 +548,13 @@ void nf_hook_entries_delete_raw(struct nf_hook_entries __rcu **pp,
 {
 	struct nf_hook_entries *p;
 
+	mutex_lock(&nf_hook_mutex);
 	p = rcu_dereference_raw(*pp);
 	if (nf_remove_net_hook(p, reg)) {
 		p = __nf_hook_entries_try_shrink(p, pp);
 		nf_hook_entries_free(p);
 	}
+	mutex_unlock(&nf_hook_mutex);
 }
 EXPORT_SYMBOL_GPL(nf_hook_entries_delete_raw);
 
