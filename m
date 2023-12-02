Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C6801A93
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjLBESV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjLBESQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:18:16 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AB7D7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 20:18:23 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fafc2d40dfso1320599fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 20:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701490702; x=1702095502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KfGQmksiLfWKreO3KwREXHNWZfvg2vvc+tmLL1KKQw=;
        b=GOfITuUuson/XG6DA2sAbKHvItncRv4FYEMfJAeADZSoAGrzlcH857TtTStlqcEaXG
         YNSH5L6ogqFpB7J5+YuFrqSFyJlD/rLGjQP3cKt0BGvmzDMPTEaugPEWeVfpdOwtfqx7
         BJd0WjPP6CyaI+QvIZb3N++kqGTJpWwfHhXYH/BcKmv8kP3QWZR/QimT6iJtdCOHgd+o
         c0FPhylE8sjbEeDAJuXItU9OCG7/yHyeRxGZfnbXZWB+WT6XJ1/JLBQRgqnY3PWXopOu
         LspwtAtcM/wHi16JfJtgnGFaL6k+NYdlj65btm8x4uPS6tKwSASxQyqqcj1G9fIfpl27
         vHIA==
X-Gm-Message-State: AOJu0YyVV6Gk76y1yg+qcwDA5xHAzpQYGxvZFGzSGpAjkMGIOQVQvdhM
        VdNT/8oDjvinZdwZckuHqD+WhjtYOO/UuVYDVkCtXOEfyOTdXSk=
X-Google-Smtp-Source: AGHT+IH1y6cmgY5D13RUMjKaV6QJTQ7pv2RzEOa165eSra43SwkD82XTRQNYY4xO1uaPLPWNcNs+dhdaJYonoqscI9QceIMvZIQv
MIME-Version: 1.0
X-Received: by 2002:a05:6870:65a0:b0:1fb:564:5c10 with SMTP id
 fp32-20020a05687065a000b001fb05645c10mr139945oab.3.1701490702637; Fri, 01 Dec
 2023 20:18:22 -0800 (PST)
Date:   Fri, 01 Dec 2023 20:18:22 -0800
In-Reply-To: <000000000000f0bfe70605025941@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb645a060b7f2c3e@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup
From:   syzbot <syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com>
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

Subject: [gfs2?] kernel BUG in gfs2_quota_cleanup
Author: eadavis@qq.com

please test kernel BUG in gfs2_quota_cleanup

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 994d5c58e50e

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 95dae7838b4e..af32dd8a72fa 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1505,7 +1505,8 @@ void gfs2_quota_cleanup(struct gfs2_sbd *sdp)
 	LIST_HEAD(dispose);
 	int count;
 
-	BUG_ON(test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
+	BUG_ON(!test_bit(SDF_NORECOVERY, &sdp->sd_flags) && 
+		test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
 
 	spin_lock(&qd_lock);
 	list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {

