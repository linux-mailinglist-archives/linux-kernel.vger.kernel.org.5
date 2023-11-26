Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1557F9674
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjKZXYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZXYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:24:23 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3287B113
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:24:27 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5be3799791fso4860607a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701041066; x=1701645866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMD1VPT4oPx+TnMWb8nGovYgUy1HkbaA60b54JFMFHU=;
        b=jeTtFG+2ucexGFhdxBwQyT8d++f6qFOWtGXdeEsW801weg5WAVzdzHsEdiWSCEZUV6
         N3QDCPv2VADeQ9HRk61NGAMvvu1yVAFp0qHWn6ew1j6mm9hyyuAlN6xfkTeyy1zes5qI
         +kYXQZ9fMfvv14U5d+1L+iNqDDUcPpgJVYk7fb/NE17/Dx7p7fkbeqfynIddoWiRnFFd
         X1ZuwC5mEhErFyHJaKlI3IsdMc9YHQcc9E/IezdlmxlE6xD+fQw5uew46pylkiLcvsXb
         k088jdpJO5KDNwarGYty4zRx0fcnNX6kTfAjGf8aBBCykDqhaHIfRVqfbh4pJup8BeHi
         kV8w==
X-Gm-Message-State: AOJu0YwRhMnae0kvr+ZbI2UZde9VcMKGCvNaQZ4Bg/R8QISb48pD24yc
        NCEpsrWk8Sk0VP2DIqYXmm0SnIqI6yElGUMpBCmuciNU8/jUNlE=
X-Google-Smtp-Source: AGHT+IEkfhMEU8YrpdRphSlCZU1He801WUA3cARCq/WgFbbuGFbmKh9j/FusAM1rQFWWIaJ42qlXHvCE13j8mu08Hrm0rp5r/Q5n
MIME-Version: 1.0
X-Received: by 2002:a65:6408:0:b0:5c2:2000:a0d0 with SMTP id
 a8-20020a656408000000b005c22000a0d0mr1693782pgv.5.1701041066219; Sun, 26 Nov
 2023 15:24:26 -0800 (PST)
Date:   Sun, 26 Nov 2023 15:24:26 -0800
In-Reply-To: <000000000000653bb6060afad327@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000801fe5060b167cdb@google.com>
Subject: Re: [syzbot] Test patch
From:   syzbot <syzbot+dc6ed11a88fb40d6e184@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test patch
Author: yuran.pereira@hotmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/bfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index adc2230079c6..8a97909b1484 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -38,7 +38,12 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 	bh = sb_bread(sb, from);
 	if (!bh)
 		return -EIO;
+
 	new = sb_getblk(sb, to);
+	if (!new) {
+		bforget(bh);
+		return -ENOMEM;
+	}
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
 	bforget(bh);
-- 
2.25.1

