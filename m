Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECD37ABCEE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 03:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjIWBO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 21:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjIWBO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 21:14:28 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B59F7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 18:14:22 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6c0f2a1da4fso4784686a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 18:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695431661; x=1696036461;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1E+KUp9qL3xSH9StfXpjXNrOTBrC5tT6GQbM3TmFV/w=;
        b=UdLv0bXWcAulaG8WUFsCj+pB5gPFm9B0mFjis6lQzcukboI8y+IugznSswSx1Mteny
         H8tkH9yhUbW4ZTfWqRNhorkKFz002NYwd1K3mfA6IrV6NUlb9yn6nuLSALkgV+HbmsdN
         7Yb7067kIqlSAx1ywnLleOisx2+JEwD+6+deFYEPg1/74hZwVPZ353EG/9ijfqo16//d
         jbfYmwTU0z3ZjP5jERVfTzVOtH/SUhramlU3jd9zm13mMztywSS6pHK6yhkh+8iQ7Gc1
         9DwtAIfyM7ainULLUNc+4jGCQH7y9Q5OAiLuD56NPHuojKXRdNHgqNIhGL7JuQHhInrn
         6BsQ==
X-Gm-Message-State: AOJu0YxSPutCSaw44+xGTPL2VSLkKHFYtESqeyft5u9aCkNEQQToLkB/
        NlEp5yZcur57hVQQ3FlwWONwWoND5kGpWmwGZ8tE4wBMKi1I
X-Google-Smtp-Source: AGHT+IE4Wea6ngKfujPPMv7GfPADBsf2YLRamGS45Lq4n6x1lJwY7OQvGgRve21xt+otYyWjRq5llMEJMzRxN3qPluesNhniX1U4
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1259:b0:6bc:fb26:499e with SMTP id
 s25-20020a056830125900b006bcfb26499emr430876otp.2.1695431661304; Fri, 22 Sep
 2023 18:14:21 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:14:21 -0700
In-Reply-To: <20230923010437.297-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9c0240605fc71a5@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/super.c:663:9: error: 'put' undeclared (first use in this function); did you mean 'fput'?


Tested on:

commit:         2cf0f715 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cc0642680000

