Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1FA7F89FD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 11:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjKYKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 05:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjKYKfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 05:35:45 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3058CD72
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:35:52 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cf9a581e0fso18717225ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700908551; x=1701513351;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maAGWhCr6KM+58v+3BpUuEbsHQHwSuSD67Ls8Wn0Q4s=;
        b=C5HHuhrWX/B/JlkrRpJYwm80QJblcdYyfbI0OQQJxX+qFfjRZPx3cwL18MSdvrD1dn
         yojtwB9bJUd4tHHEFRUSISBD8z81wdMFaaeSZAZl0YaLRUOruhC7+/p6Nem1L6vAHSRX
         GtA7Y/jNJ1wGLuHCfFnLBUh87erEBra3gZy1HA5JJ/yeeyguuTKuJLBdlgU0EoFCMeZQ
         bbFY+ag7cBIs140nmaChfZMhcwirn85Ib3qvU7PWQtY5aD6YlgMQmMYl/xubOwIL49w5
         XCyUZryXMl7AAR8xDfDVhiDKtb/5fetS1ESHbtxULvpiELQdA6KFOKuhggdJnLiAZbnn
         7m+g==
X-Gm-Message-State: AOJu0YzwTtLGsJyGKRAc9sCbZUmIr/VfXV6vTii40IQltxi8co94t0lV
        mE2EqPQK7U7lS/y54MKkruqsFGsijbVM0ppEDkxXtIXOPUJTHQM=
X-Google-Smtp-Source: AGHT+IF6yayotaSisLsjHpna1ZXN6OAaS4Sjp2slI8k+a12YNiPbT8qwx+joV1x+ui/CTByoZ51vIgKIDFe31hXIhjE2P0XamIiH
MIME-Version: 1.0
X-Received: by 2002:a17:903:442:b0:1cf:a57c:b21d with SMTP id
 iw2-20020a170903044200b001cfa57cb21dmr825208plb.9.1700908551831; Sat, 25 Nov
 2023 02:35:51 -0800 (PST)
Date:   Sat, 25 Nov 2023 02:35:51 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000070ae2060af7a2d6@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
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
Author: eadavis@qq.com

please test WARNING in indx_insert_into_buffer

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 037266a5f723

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index cf92b2433f7a..a625302a3b1e 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1909,8 +1909,11 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Undo critical operations.
 		 */
 		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
-		memcpy(hdr1, hdr1_saved, used1);
+		n1->index->ihdr = (struct INDEX_HDR *)hdr1_saved;
 		indx_write(indx, ni, n1, 0);
+		kfree(up_e);
+		kfree(hdr1);
+		return err;
 	}
 
 out:

