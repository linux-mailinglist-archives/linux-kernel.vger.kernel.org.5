Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E073780C9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjLKMa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjLKMaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:30:25 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A4F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:30:30 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9e53e2e60so5275675b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297830; x=1702902630;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TroM8i2HOXF8HABtdpTxK6kxc9z46RqWekbDF5+jh+Q=;
        b=eArM83qN7OwZ26/4d1mKwpKHUI9qcyQb7fF/I9qv2n7QgHI84pqsF6Z3Qza5mm+8W8
         E00f49LR3PUa361nQT3V+wa6puety316lubY4BqhwrrsroRqRpyHrWNPK+5gYrvaTVCn
         SSAhx6ehW3F9mGPSgFRSO+1crF2oBu7MnXXdAmNNhIIqZwh0ilcaDPvvVz57u8IQ9xF/
         Gn7uHRjC9HrvV1Iz7wGOCglvmXQ7MkmmYvsO9HtNkLPwbdt5Hr+puOEJoDLmruOcDPRz
         tncBr4F2ouIj7jjbcU22mMwc7jErBaA0tuVnLddbxB4XfxcqWU+bkkeB28ukFPqmX8Xa
         ozSw==
X-Gm-Message-State: AOJu0YyJQcFQ4k6ISuAMtSxPilL+i7CQIBl1NXC5g/zrTAMbD10/R7/w
        yakDPsCBbk53t5lxXJ6PCT2y0Z3UFKukxN5zhxMMc1LcWTJuOqU=
X-Google-Smtp-Source: AGHT+IHX3Qmjzdnn3JXBXPXaHU8K0mWr87/HawTCPXSJD+F7Wv97CMnjOWcKrB7gAQJ9POTCEE1wZQ9SQgkXPKoTso6QgqGW5rCQ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:18a8:b0:3b6:dd92:7372 with SMTP id
 bi40-20020a05680818a800b003b6dd927372mr4290950oib.8.1702297830117; Mon, 11
 Dec 2023 04:30:30 -0800 (PST)
Date:   Mon, 11 Dec 2023 04:30:30 -0800
In-Reply-To: <00000000000062a4cc060c2217de@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000775780060c3b19d2@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diNewExt
From:   syzbot <syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index a037ee59e398..8fc28b655060 100644
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
+	printk("agno: %d, %s\n", agno, __func__);
 	rc = diAllocAG(imap, agno, dir, ip);
 
 	AG_UNLOCK(imap, agno);
@@ -2179,6 +2182,9 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 	/* get the ag and iag numbers for this iag.
 	 */
 	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
+	if (agno > MAXAG || agno < 0)
+		return -EINVAL;
+
 	iagno = le32_to_cpu(iagp->iagnum);
 
 	/* check if this is the last free extent within the

