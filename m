Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9937DD701
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjJaUWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjJaUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:22:06 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7095EF7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:22:04 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b2d8caadfbso242012b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698783723; x=1699388523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABxS/Y/dEawUUeKH6gAmQ1oQDLcOIlAS+uqExwFT3Yw=;
        b=n00FeHSnkTDMGWtYsJMyNg7AOdEoM4UifgkZj4WlStwTAPdtgu/RHdge5x5fvXK4Ha
         njk2OeOqqmxjqSMoTScSFq/9SPJN1dj2H4XeqZNSGsjijQfIBIK6DThgxCN2BYMf8TJG
         UV7Ai/VROBNJZhRmIl9AXtBYEkdOI0FWOauIG36vOATHkucPqgTyv205STMS8XlvyfI4
         5wqFwvqo5RQYI/mUIoijrsK50Chy1lJqHkwApKhpWwT9iFAKgdDyEqyCGek3tZfh2zZK
         f8eYI7SR1s8k5dtTtfYPSzokoajIlOUrO6cH8dZxQxsKlfd0QGpSAFgg3NcFyKjI367W
         avbw==
X-Gm-Message-State: AOJu0Yw9LuKPGT/ppH7GIBM2uewpWcVy4uV+pHvJUXtEAm/rWnIjIiE9
        pTzpSrKxQfNfYbd4p8VsPk7Gqbw5aRXfjbrFgQrMSK9PjxlT
X-Google-Smtp-Source: AGHT+IGb7b5+s5UWXuPaOfwbI5gjTxsrXeswNqM5+abNosVgXBYVP27oyqTOzSqlnYSpScnMXbpfJavMqzWhIqrVn1kjNJ71QDEp
MIME-Version: 1.0
X-Received: by 2002:a05:6808:150e:b0:3b2:e7b3:5fc5 with SMTP id
 u14-20020a056808150e00b003b2e7b35fc5mr1621301oiw.3.1698783723868; Tue, 31 Oct
 2023 13:22:03 -0700 (PDT)
Date:   Tue, 31 Oct 2023 13:22:03 -0700
In-Reply-To: <00000000000019db4e05e9712237@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000695613060908e8ed@google.com>
Subject: Re: [syzbot] [ntfs3] kernel panic: stack is corrupted in lock_acquire (2)
From:   syzbot <syzbot+db99576f362a5c1e9f7a@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 4ad5c924df6cd6d85708fa23f9d9a2b78a2e428e
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Sep 22 10:07:59 2023 +0000

    fs/ntfs3: Allow repeated call to ntfs3_put_sbi

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125d173b680000
start commit:   45a3e24f65e9 Linux 6.4-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=db99576f362a5c1e9f7a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1734eb5b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ddb22f280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Allow repeated call to ntfs3_put_sbi

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
