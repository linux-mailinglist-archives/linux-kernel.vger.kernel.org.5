Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E1B7FE91C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjK3GZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3GZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:25:11 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B34810C6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:25:18 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fa260d2a26so818761fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701325517; x=1701930317;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dn2PFurWeu95+lMrLv8tNx24GrEjNahyw/IcH2X1Gg=;
        b=EgQfn9SJsH6C4CxJkuU0LN7Gm5sjyWPbnykkFNYXuranWAmhR45f3Q+bZwm9/5GFC9
         uN+9tW7nAswKhboajLwPrELYeVZ5EmA3LEbCE/tvYjtaKh32CaCFYAWCbDRtesWWXrx0
         PQvV92NDs+kVBdxZ9xSjSJskwP5ilu8w/qHTn4dX6ThYbcPoMEAne/EB/FEv2EYkpW6L
         FgHEvOKN1soIgMTjgIfFmNPZEcDZD19ZSPNN3OZfweIk4k9NobTDkNUBeqxTdC0k/M5y
         eqKXkqfTsF3cKi6Ym7qXMXu7PVbP3a3XsV2canFfemjZquWg9I1RXffLCzJa01dgfW4Z
         rhsw==
X-Gm-Message-State: AOJu0YxpFc4icnpv8QO7SuUtOiYnhqUUXurRN22b+hMmxXivwCd3k8Ay
        dUcttkpHy7eTN35ilZztj0h6oQMuoxjzyfbNe1r0RKsFiLNDKdE=
X-Google-Smtp-Source: AGHT+IFqJk/bb7YKO99S7ovwxafWNXXBwD463UzH6j0aCF9KhHClV95FV/h3/KOKKJZfdzVkvUPBiGXCf5NLnxTXJrF1FRExrfyn
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e0cc:b0:1fa:2607:4cb3 with SMTP id
 a12-20020a056870e0cc00b001fa26074cb3mr574917oab.3.1701325517683; Wed, 29 Nov
 2023 22:25:17 -0800 (PST)
Date:   Wed, 29 Nov 2023 22:25:17 -0800
In-Reply-To: <000000000000f2b6b0060b488674@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002101d0060b58b70b@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com>
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

Subject: [ntfs3?] WARNING in indx_insert_into_buffer
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git a379972973a8

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 1426434a7e15..ca71f4103b3a 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -339,7 +339,8 @@ void page_pool_unlist(struct page_pool *pool)
 	mutex_lock(&page_pools_lock);
 	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_DEL_NTF);
 	xa_erase(&page_pools, pool->user.id);
-	hlist_del(&pool->user.list);
+	if (pool->slow.netdev)
+		hlist_del(&pool->user.list);
 	mutex_unlock(&page_pools_lock);
 }
 
