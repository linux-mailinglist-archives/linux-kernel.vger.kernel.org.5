Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9872E7E4E01
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjKHAbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKHAbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:31:14 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB4510F8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:31:11 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b56bf3d7a9so9689962b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403471; x=1700008271;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KA8DKN3PN2+0kooQrItJM6dxHNU7uW5d+V3yQzt6i4A=;
        b=B9CWVsxSyWmPnK0JEorBIQpROzPBqEkSCsDQNcOkEV3tuJT5hUOk5K49EO2E7WXRXN
         Y902y745nHOuh5Y01F8tBjuNSruoFAN0BD3H46ClenUtwO4Xzqxzv+bkrLbtUQlMXoc1
         SoSuAa0JAKp43MBgpj5DimXNXTNWokfQ7hIs/+7kX4vgoZ9GBkknXUYxJiE98AdxcBsH
         gs4ChuXKmJj/zXd+Jm2pBxB+9GuJIDBmio5mq8malEAAgmjh37xhsD0RJhQxwJK3s1Uv
         P4bML74ZKS3nbWfb/rcwcOl2jwtnUVstLm5Qen6SqdgwvuX79T7CGovIzm8cEQcoHK/c
         WySQ==
X-Gm-Message-State: AOJu0YyTrAsmWnBJ4zlanyxRKW69qHv1ADRXkVzJxgAtJlY4FLMP48r3
        evOfRHzd4H+vENhrdG82am+HZL8DQd8cdynBZb6PDs9nmcS6g7M=
X-Google-Smtp-Source: AGHT+IEVktKlDlteWGEJu2yGWjIJ4uk0xFSu5HNOCVRDP1vpFFB2hbSVCtqWBgctw338d56YHx8JsbYmwI6W4HVqFULbe6grFCpk
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9692:b0:1e1:3152:93fc with SMTP id
 o18-20020a056870969200b001e1315293fcmr126828oaq.6.1699403471105; Tue, 07 Nov
 2023 16:31:11 -0800 (PST)
Date:   Tue, 07 Nov 2023 16:31:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039bb8a0609993470@google.com>
Subject: [syzbot] [PATCH] Test for 4652b8e4f3ff
From:   syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Test for 4652b8e4f3ff
Author: eadavis@qq.com

please test warning in blk_mq_start_request

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4652b8e4f3ff


diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 22a3cf7f32e2..397bdfad6d27 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1724,6 +1724,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmd->fake_timeout = should_timeout_request(rq) ||
 		blk_should_fake_timeout(rq->q);
 
+	printk("%d, %s\n", READ_ONCE(rq->state), __func__);
+	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	blk_mq_start_request(rq);
 
 	if (should_requeue_request(rq)) {

