Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE217F8901
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjKYIMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:12:19 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36666B5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:12:26 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cf8ea601c8so26553025ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700899945; x=1701504745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWlsrCiXMDkX+kmHi/95qDobHPA04X5c361ye8TzFaE=;
        b=A3M8IOvrpfQkZIx3XK+kT4e6A2cI9LsIa1RrTEnMziQbZPRL4BE+z5iFMKa+q3K0Pp
         qmbfuoq5Px6RPU03v8P9sYAuASJl6w7R+Vd4OdB4+AkLYNUYbBWPk9MnFM7vg4RMwopP
         ahQSWpgGR7L+ddHVu8B1Qw9Xk++7JdgwJao4Dg1mv9pon7o5TxSnkOTRULIC0FXvkBS1
         ayHLj25vMriIQCHNqcmFVIg6ixwUfDWnWAXVI5e/p37sUwDYdPCH+ZQLV0M4X5iUkFuD
         pWOl8cE48tXR4enyOC1XR/TVUiFUApi++Qf7SxZuNhxcoTrkyJUtuOpkN8qmsCjsy1yv
         rOYQ==
X-Gm-Message-State: AOJu0YxeSWvhasF/A9CMN12kHgopMUP3KJk6gYTtaHl/a41nveWM6Q8u
        iNbRK3Vvs7wINseIlyQI9q6Ar3XhrO1XpwJCkh0sgDKYLR7I2OY=
X-Google-Smtp-Source: AGHT+IHoHfT1ITVJygA5Ouu3PtOdEZPPy6CpmMj0a4zPsg2bJq1qOgBCSy7CSa81Fb8dHopUXJfKXZfmgPGp8idOTCNZlXzYQvXA
MIME-Version: 1.0
X-Received: by 2002:a17:902:c412:b0:1cf:abb3:eb36 with SMTP id
 k18-20020a170902c41200b001cfabb3eb36mr776614plk.8.1700899945791; Sat, 25 Nov
 2023 00:12:25 -0800 (PST)
Date:   Sat, 25 Nov 2023 00:12:25 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011492b060af5a145@google.com>
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
index cf92b2433f7a..be08cde7e117 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1909,8 +1909,11 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Undo critical operations.
 		 */
 		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
-		memcpy(hdr1, hdr1_saved, used1);
+		n1->index->ihdr = hdr1_saved;
 		indx_write(indx, ni, n1, 0);
+		kfree(up_e);
+		kfree(hdr1);
+		return err;
 	}
 
 out:

