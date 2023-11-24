Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8287F6A89
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjKXCHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXCHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:07:42 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB7B11F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:07:49 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cf8b6db1a3so10914625ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700791669; x=1701396469;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hef1CweRu8e7llvgBLATHqueH57m7YXFqXw0SCYijI4=;
        b=dX4kxnaKG6F6loyS9KSWhsweYuZ0hYb+xS5UYSfbFih9gv/EwVLB0XD5IO2qBWYWp9
         D1q3iBX3smyNhnm8fHojzzrzvgrT7QNa2KiNJMcU38gcG86Kiewbb/Oo9Mps4dGgZwCe
         PY3X5typ6Wn88s4GV3SmZCHIKmrqc7uWlHfAdZptCqdpbODmnFX2eYGnIPtEgRC6F1Py
         NyxAwkxyTHQjXUSjAE6ou8GOhRUzX2+EkSahgV8Tq2uuG78SNpNmUt4t4vGHStKBPGDh
         EYL3Q1DSvLGM3wPHQN44CzEKO2MoJEb95xwotCvQKwb4ojhCuMTBA2cpzLv9fa6cd8cU
         QIFg==
X-Gm-Message-State: AOJu0YyiAAttCNTKPDRjOLyxuTCJR7OfnZzeTxiZBmxrd+T2Xh2ibuGZ
        HtazlVrKbjDQ94mXB8A96k3UFlckyfOEaYlZOrDIAPD+okAl1YE=
X-Google-Smtp-Source: AGHT+IEocPKaGGjnu151nmzDBw3/MW6ei9NJI7UNYr06ODzmCzgnLFx9Wf5o4YChbe6+f0G5yfd9vB+cuCIk629CYXz8MntuV4Ln
MIME-Version: 1.0
X-Received: by 2002:a17:902:74c5:b0:1cc:6684:4ee0 with SMTP id
 f5-20020a17090274c500b001cc66844ee0mr218426plt.2.1700791669104; Thu, 23 Nov
 2023 18:07:49 -0800 (PST)
Date:   Thu, 23 Nov 2023 18:07:48 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000462659060adc6b43@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [ntfs3?] WARNING in indx_insert_into_buffer
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 037266a5f723

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index cf92b2433f7a..540886474c0e 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1905,6 +1905,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}
 
 	if (err) {
+		if (!hdr1_saved)
+			goto out;
 		/*
 		 * Undo critical operations.
 		 */
