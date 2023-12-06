Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CEB806A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjLFJYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFJX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:23:57 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA5CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:24:04 -0800 (PST)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d8662073e7so777822a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701854643; x=1702459443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfaNvcc2ovlsQNcb2crkLuEhnmOXqf/vlvGMqovaojo=;
        b=OQ86cnNy/bxX932UXEfGwOxGk3VYvCRPIdXJUGJfErQKcd6ALdgz8MzraIRI3p9+oq
         GSJrmBN1Z8uwY3buTbH0svmeGxt+B84riGErLgGqeAhvb4PFgb0GHrhhDB3ilHyelQ9Z
         bP5PIuMJUdmSc1J3hVEUUw6qTV6kVZ6b6zT1fDqSYVd8P9Hojx5mAR/SFwmFMTaVJb8E
         awmUrmfF9JrspV/YTkd0pJh5CGcBQPVUvpUlite7iTg3nS9qKY5J53Jkd2li1rA11Es5
         BKYaOEhTVwtWFJjFC3eGwTsWgGC7g9bElzcZ9o+7l98HlTzSxa9PPxamcK+cFeis2AbV
         15xg==
X-Gm-Message-State: AOJu0Yzu71OyxUKFdoFmo49fZIMVXsI+u5vLpWUMv/YUqUq6Ue46Kgvj
        fFiklwF3EBBWC2+XLA3dYlIM8mwA8391xdwdI7qzjex/Mxn8
X-Google-Smtp-Source: AGHT+IF0ZGJij6eQLS/36NE1ehjzCPD//d1pUBTz+WZhz53rmfRKVJY2Xnr2IGBAGMNlapVBTxx+IoP3PaI/2QlrL3r5ADkvgwIc
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a0f:b0:3b8:43d6:8ce4 with SMTP id
 bk15-20020a0568081a0f00b003b843d68ce4mr3000044oib.4.1701854643477; Wed, 06
 Dec 2023 01:24:03 -0800 (PST)
Date:   Wed, 06 Dec 2023 01:24:03 -0800
In-Reply-To: <tencent_7D2FCFAD8DEEA5D60DCF9236DD9B5DAD9907@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007be1ae060bd3e9ab@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/llc/llc_input.c:130:6: error: expected ')'


Tested on:

commit:         1c410411 Merge tag 'i3c/for-6.7' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1367debae80000

