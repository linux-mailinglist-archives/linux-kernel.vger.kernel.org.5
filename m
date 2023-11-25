Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79887F87F8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjKYC6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYC6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:58:00 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8EC170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 18:58:06 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c19a3369c2so2829625a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 18:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700881086; x=1701485886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8DQuk5kP+XuY+MGoq4wAMbolfg46SX/GgKXIWrvdY4=;
        b=TuNCbGwgXIwoKqHU4vTeAOK1SQxFNwmGbsQNnUHHDdhJC2u4DWN6hBBhfTO7/X0x4e
         ljbbO2E4owUdmDFVIeJa0xtGP/lWlpQDwxAqij2wtYg/cAOOFhNcoJrSy7Bqwt9UCetS
         Cvk/gDUoUw1jOxfDNZKhus6x/Do1bQcLVt4Pcyp651p3vCNMj/2EvP679DL+4WcYWxQM
         wG8yRZo0TrKr/3Le5dKXhXkJ5SLAqh51qY6evV0X8tM5SawS0QQFzQCpN00YiScUNh0u
         RPag6gWibklHWpcZuOPNhl9/fmTOaOl6l40I+eUJOFCf3Ete1ydj5wdpjXUTKrWNUp8u
         3waA==
X-Gm-Message-State: AOJu0YwQ7alTl3ibp894tmlQZYAxiO8eRXF3hubSa4qIvFGzPUzKEYr0
        860G9fGwF0jNJ1G8IWQCfVDbhNrz/aYp7G0eEn5AWvpGRzrA
X-Google-Smtp-Source: AGHT+IG7kj65TP44Sxk2+W3fkTIzr1ZfRRO5xNUqPX3s0CBfR5uBxM5KOp4Vm7K4P/GN369NN09ek7u1L6uZ1OuSMpNt/tq+lRXI
MIME-Version: 1.0
X-Received: by 2002:a63:e44b:0:b0:5b9:89a4:e381 with SMTP id
 i11-20020a63e44b000000b005b989a4e381mr721634pgk.8.1700881086495; Fri, 24 Nov
 2023 18:58:06 -0800 (PST)
Date:   Fri, 24 Nov 2023 18:58:06 -0800
In-Reply-To: <tencent_056CDC97A4E816ED46CDD879F66C402C450A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f74387060af13cab@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct INDEX_BUFFER) == 0x28"
fs/ntfs3/ntfs.h:769:52: error: passing argument 1 of 'hdr_first_de' from incompatible pointer type [-Werror=incompatible-pointer-types]
fs/ntfs3/ntfs.h:776:26: error: '(const struct INDEX_HDR *)&ib-><Ueed8>.ihdr' is a pointer; did you mean to use '->'?


Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14254c08e80000

