Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF2D7F10F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjKTK4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjKTK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:56:10 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170B7126
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:56:05 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2839b3bc8b0so2766619a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477764; x=1701082564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Oxol6J5SAxypG+SDeR5WnYRHbHYTyYmnZEb1Xi8RF4=;
        b=X4Ltzmiv1J8YWratwfSwxEQIwjgisbThzfn8xL2flCDcC3gBB+d5M8QhWUWiCPDI+g
         9s4iC06bZzYXN3SS0YozxsDf134I+aF0mMfbKNaeU0Z+hy+1ZMSgXnzaJOIkxrrBSHqH
         DEGti1wwqKzZvEn2+2oWs+iSe7P9OEwmVthQ//nI46MJG28B6PxF7jxnFZ9vv3x8kuD5
         2YD4+lwKHtTFYdYoadhZZ3Cidkuljd0+ikY05z6IdLe0vJWLH6wBTk/s3cqwag5dEsEi
         aD9l3eHA36x2DLl6QhEqvgBoJxehS9ldmxGkMS/rFcC1/QOLjJa54f8aJix8vMMR5O/c
         FggQ==
X-Gm-Message-State: AOJu0Yz8rQQc62wA/30nJw0M6/FGQ2Aqv2H3O7e/v8RdCl0JNGsi7Qfa
        XSx8R7ztIBMNA/6XV0d/dkOP+C+1OUI430sZdFOezW0aPCZ/pbw=
X-Google-Smtp-Source: AGHT+IHIDun885DaEdLNyYJeanv+aVN1Vp8gp8yp9uVoCUgJ8bypGcXZWWeCtYOYJzSOCP0cdKS0HZG18pDGqBltder67Ee0ed/k
MIME-Version: 1.0
X-Received: by 2002:a17:90a:62cc:b0:27d:dffa:b374 with SMTP id
 k12-20020a17090a62cc00b0027ddffab374mr1811873pjs.6.1700477764658; Mon, 20 Nov
 2023 02:56:04 -0800 (PST)
Date:   Mon, 20 Nov 2023 02:56:04 -0800
In-Reply-To: <000000000000635bfa0607ed5cdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c6cc3060a935506@google.com>
Subject: Re: [syzbot] [PATCH] Test for 6465e260f487
From:   syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 680fe557686e..246f381a8970 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -368,6 +368,9 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 	    event != NETDEV_CHANGENAME)
 		return NOTIFY_DONE;
 
+	if (!check_net(ctx.net))
+		return NOTIFY_DONE;
+
 	nft_net = nft_pernet(ctx.net);
 	mutex_lock(&nft_net->commit_mutex);
 	list_for_each_entry(table, &nft_net->tables, list) {
