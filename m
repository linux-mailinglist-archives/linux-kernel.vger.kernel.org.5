Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17847F8B15
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjKYNKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjKYNKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:10:32 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E98BA1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:10:39 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cfb2811203so5357785ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700917838; x=1701522638;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2x57+4D+SJs7wSbCC7T2hfTUa0WP/L6d0DTYOeJG0Nc=;
        b=IchKyD6owVnX9d4WuGVTjAqknEdginmU/aC3pl9n9+bhJo+moaiwAFviOOANqoaszH
         6dPEVML4ytr0liBpVevR/7vOpfvAt5Wz0baB88d/dH49x1+JrQjdgIvwAPkMldiB7rrj
         VLrsuUb88fW4qwxAXvcp+6OI9EGU/cpeeep+Q5kl8HkhdnXjD4wJ3lwpzp2w076K2LF1
         OTrSCQAdvwUKoJtXN8kJ2WdsSodn+ADTvJpSwCt2ku9nStMx69LE0Cl5+zMkhCzNiJjd
         vptnfZZ21IkpkPc4WoN96OAXH+t/AMUX6UB8oQLE7D8za3iI7MHL8ulukaaZXibYVzXS
         bzsQ==
X-Gm-Message-State: AOJu0Yw6AzejPahky45BhCH8+po65mgxbaYNwYEpMWlrT3qyFbJwMpk2
        IaKsbTIZua+jJrrLQu7gniqEWrQNFU00wLMar7zt5ooQB61K288=
X-Google-Smtp-Source: AGHT+IGzxKWUKKNqh6e+pR5nx4q0WpRG8UUZAdkQlad63ywqXIH/tnzRYi4XPNtgIzS76Fo/oN2PxS+bKfo+swwDEOFNCgcF3QsM
MIME-Version: 1.0
X-Received: by 2002:a17:902:c944:b0:1cf:a2e7:f849 with SMTP id
 i4-20020a170902c94400b001cfa2e7f849mr1243657pla.4.1700917838750; Sat, 25 Nov
 2023 05:10:38 -0800 (PST)
Date:   Sat, 25 Nov 2023 05:10:38 -0800
In-Reply-To: <000000000000d40c3c05fdc05cd1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000922bec060af9cbc2@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-use-after-free Read in udf_free_blocks
From:   syzbot <syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com>
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

Subject: [udf?] KASAN: slab-use-after-free Read in udf_free_blocks
Author: eadavis@qq.com

please test uaf in udf_free_blocks

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 123212f53f3e

diff --git a/fs/open.c b/fs/open.c
index 02dc608d40d8..bc2d1db2fcba 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1441,11 +1441,11 @@ static long do_sys_openat2(int dfd, const char __user *filename,
 		if (IS_ERR(f)) {
 			put_unused_fd(fd);
 			fd = PTR_ERR(f);
+			putname(tmp);
 		} else {
 			fd_install(fd, f);
 		}
 	}
-	putname(tmp);
 	return fd;
 }
 

