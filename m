Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71667F912A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 04:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjKZDwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 22:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZDws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 22:52:48 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F46DD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 19:52:55 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cfba9f385aso10037945ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 19:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700970774; x=1701575574;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cyfdML5Yaj1ozZFsgN9DnR1LNm/Kzbc18PAHGzkQGA=;
        b=HwjP/rtNj1APH96s2D4hY/8qj7Lx9K1gHQ1iioZqSafBWaHQ1qsTGpW7REIEymy7P2
         QbAF3ufM5EtG7DesBdH0LdvJeGBxrFYMyHgoRKsWipUVeaDgJ8kLUGA6ao68ZXuiqs6C
         TxyMoayKlW/KhCrMjr/CFJ2OXYRk42SvEEVHmdpNJ2wjXcKC/eeAbnIHxwvfD80WomIz
         ULKE0b2ZLBysw7LTAUgWjLNEtCU0Ayn71RcymQgIEBI4ynHM3FmLv/0WQBIDvHWKa2CA
         H+Cd5B8wtCHpwFXOInAiqltcLRjJVGv4vOq8ad2d6D9t9LLunL4nfSTMsCMeeC79jUfJ
         AwMw==
X-Gm-Message-State: AOJu0YwnDz447N/JF0Ss3bVwYJ4hFu7RurXn60Na8Cl2YgdZ3DBWy/9t
        ODGBzTopqLOy2F1uRa1YJZYF73EE7kEfHmTp3JTgOO8a6faIL2U=
X-Google-Smtp-Source: AGHT+IFkYgog9g9iJtMIDWD4HQVe6wcboC0bORmi5NuAkWaHj/9wYh0gSBadA+oWdyEYwC3pMPGDaT7ASgbfhuouMCK0OSVQcpII
MIME-Version: 1.0
X-Received: by 2002:a17:903:22d2:b0:1cc:bb7f:bd60 with SMTP id
 y18-20020a17090322d200b001ccbb7fbd60mr1759775plg.6.1700970774689; Sat, 25 Nov
 2023 19:52:54 -0800 (PST)
Date:   Sat, 25 Nov 2023 19:52:54 -0800
In-Reply-To: <0000000000003d77e6060af9f233@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc7d45060b061e5b@google.com>
Subject: Re: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
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

Subject: [crypto?] INFO: task hung in hwrng_fillfn
Author: eadavis@qq.com

please test task hung in hwrng_fillfn

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 98b1cc82c4af

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 420f155d251f..ebfa5eab84df 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -501,7 +501,10 @@ static int hwrng_fillfn(void *unused)
 		rng = get_current_rng();
 		if (IS_ERR(rng) || !rng)
 			break;
-		mutex_lock(&reading_mutex);
+		if (mutex_lock_interruptible(&reading_mutex)) {
+			put_rng(rng);
+			return = -ERESTARTSYS;
+		}
 		rc = rng_get_data(rng, rng_fillbuf,
 				  rng_buffer_size(), 1);
 		if (current_quality != rng->quality)

