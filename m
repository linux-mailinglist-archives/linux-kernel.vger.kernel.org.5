Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B5F80E048
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjLLAar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjLLAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:30:45 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144FAA7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:30:52 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5906e23aeb9so5405494eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341051; x=1702945851;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvsaIGy9HfhasYCr6lsYwv343tWKCokMeAwxsZ8UmgU=;
        b=fGK7gUkOPH0+lkoyWC3i8iLXzS0HV+ikbK6cX0IQALSW4Zau5pj5YV/28ol//VEvd6
         wnq3c6Nw48f6xyNFE2HYUAO38qYoS6OBifaPqn79DCMvU11JXuwoWKD4KRwHKJ0NLwz9
         HRtf4pJR6LjiqqXwLolBwsn1b71mdu55Edq0QCWM8rmK3PdIXGwV5N84pfZ3B1pBMZAc
         Nw/V1Kq2pXK91oLQdtbQR+xR2PUpURz5eF/ZlA6c6ju2VT4xjZEkeZUtdZhxtLojMzkR
         2BePzj7RJLFygTpzcdHvl842OOqRTxca9nwgf+MLfy73r4FA9Xoc4H1+5ocKEIqSRCxC
         zc+A==
X-Gm-Message-State: AOJu0YzUcZn4b//rMhSCfhQrRZ94a+PNyy5NvcB3HTqKf/xF1bQFeWFa
        Yc1iqbyB7QBf2eIul/bX2SkTZorZuuJT8ch7OhI21uWJxUOjcPo=
X-Google-Smtp-Source: AGHT+IHkP5R+yVp9sZ10oU1dhB14n6pa+HZt2Iq+tdxP6K0a3aZgghpzk8pKgmvILFBB9s/riSU/gUkh4jrZFfPb3pN4f7HtZchy
MIME-Version: 1.0
X-Received: by 2002:a05:6870:214b:b0:1fa:da34:99d9 with SMTP id
 g11-20020a056870214b00b001fada3499d9mr6331184oae.5.1702341051423; Mon, 11 Dec
 2023 16:30:51 -0800 (PST)
Date:   Mon, 11 Dec 2023 16:30:51 -0800
In-Reply-To: <00000000000062a4cc060c2217de@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a82240060c452911@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diNewExt
From:   syzbot <syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com>
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

Subject: [jfs?] UBSAN: array-index-out-of-bounds in diNewExt
Author: eadavis@qq.com

please test array-index-out-of-bounds in diNewExt

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bee0e7762ad2

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index a037ee59e398..b52f34e04f6a 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1341,6 +1341,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	 */
 	if (dir) {
 		agno = dbNextAG(JFS_SBI(pip->i_sb)->ipbmap);
+		printk("agno/dbNextAG: %d, %s\n", agno, __func__);
 		AG_LOCK(imap, agno);
 		goto tryag;
 	}
@@ -1356,6 +1357,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	printk("agno/agstart: %d, %s\n", agno, __func__);
 	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
 	if (agno < 0 || agno > dn_numag)
 		return -EIO;
@@ -1584,6 +1586,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	/*
 	 * try to allocate anywhere within the same AG as the parent inode.
 	 */
+	printk("agno: %d, agstart: %llu, %s\n", agno, JFS_IP(pip)->agstart, __func__);
 	rc = diAllocAG(imap, agno, dir, ip);
 
 	AG_UNLOCK(imap, agno);
@@ -1919,6 +1922,7 @@ static int diAllocExt(struct inomap * imap, int agno, struct inode *ip)
 		}
 		iagp = (struct iag *) mp->data;
 	}
+	printk("iagno: %d, %llu, %s\n", iagno, iagp->agstart, __func__);
 
 	/* using the free extent summary map, find a free extent.
 	 */
@@ -2179,6 +2183,9 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 	/* get the ag and iag numbers for this iag.
 	 */
 	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
+	if (agno > MAXAG || agno < 0)
+		return -EIO;
+
 	iagno = le32_to_cpu(iagp->iagnum);
 
 	/* check if this is the last free extent within the

