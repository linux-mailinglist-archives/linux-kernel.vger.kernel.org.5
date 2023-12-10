Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1268580B99E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 08:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjLJHYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJHYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:24:46 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E441D1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 23:24:49 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9f1f500c1so2411120b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 23:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702193089; x=1702797889;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTyF6y3uRgpqq2Xm0C6+L9Ujvqmp/bVfVEz/ph30LvM=;
        b=kT3T7JLXrFQT8KdXhfgXKC7shdpoHp9ZfYKnoox4PQgqyABG3N8rQd4SRZdMa4Rlph
         Lbupc4PXhB7B4igGxIsdHC/0FTaCOOijWqBjqOqBEHTUVYPoyCnD27vTWCsjsZ0Wawlw
         MJ051Sz8eU5GwYvJ1+Ej+mJ+hfDBVebBJyimjav/nrAxI20rCWzMPbFFJY38i5IDMFfW
         Gr6mLTkcELL1fYD1cyUI7U/RgG0Yo4tGzbMo8rpiFD4MNMCcgnQFiV0zIIikegUehIQW
         pYBsiaJKeN/hp3jsLVVTgHoTrapX9qd9nhr3lF0K0+xuDJkawltqQYNIaCCv9vZoKi80
         kmJw==
X-Gm-Message-State: AOJu0YylyrwFR5czJAOyZIb82i2QWqm6P+g+2d4Vo0sMlJZL/447MvFy
        PZQelSsyhQRrhA6R8+O1qnXVhBs/faLsObN4xMUbGmgUlmEq5Tg=
X-Google-Smtp-Source: AGHT+IFmRUAUoaGBZxAyYRnDY3MdzKUVY9p60tnlYi2Yvzyf+WDqKPgZ3+5qX31wANx8UdfLNqmHdpm34jPmPxgvOM2o4+60CSJi
MIME-Version: 1.0
X-Received: by 2002:a05:6808:148a:b0:3b9:dc53:7c2c with SMTP id
 e10-20020a056808148a00b003b9dc537c2cmr2771957oiw.5.1702193088866; Sat, 09 Dec
 2023 23:24:48 -0800 (PST)
Date:   Sat, 09 Dec 2023 23:24:48 -0800
In-Reply-To: <00000000000062a4cc060c2217de@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066ae2f060c22b674@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diNewExt
From:   syzbot <syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
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
index a037ee59e398..4e17e261de26 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -2179,6 +2179,11 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 	/* get the ag and iag numbers for this iag.
 	 */
 	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
+	printk("agno: %d, ipimap: %p, iagp: %p, sbi: %p, agl2s: %d\n", 
+			agno, ipimap, iagp, sbi, sbi->bmap->db_agl2size);
+	if (agno > MAXAG)
+		return -EINVAL;
+
 	iagno = le32_to_cpu(iagp->iagnum);
 
 	/* check if this is the last free extent within the
@@ -2357,6 +2362,8 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 
 	/* update the free and backed inode counts for the ag.
 	 */
+	printk("agno: %d, ipimap: %p, iagp: %p, sbi: %p, agl2s: %d\n", 
+			agno, ipimap, iagp, sbi, sbi->bmap->db_agl2size);
 	imap->im_agctl[agno].numfree += (INOSPEREXT - 1);
 	imap->im_agctl[agno].numinos += INOSPEREXT;
 

