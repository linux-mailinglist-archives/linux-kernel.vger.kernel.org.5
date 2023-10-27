Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162227D8E02
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbjJ0FLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJ0FLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:11:08 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3EBD48
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:11:05 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-581df11b5b4so2407803eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698383464; x=1698988264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYRbdaBgJS+wSJ4gmYrUGgqbPKYTSmw6Nqiyq4u7xTs=;
        b=sxXCIjrjVQonWIxfRnPHsbDZcvprhDmBFHcMrwzq7ZlMuZDJC00EHU5VlT9jSMD/2P
         bTaGQxGWNQIP6LCIi5xbq2FIauDXcPqYzQ/wGh2FJ+JmSQr1ZJjcyFYYqEeHmapGha5m
         wbprJPWysJrRP7x7o2VkGy6+RlIgbq5N8Wh4hs7oK99BwqJUBknUstN+yIWz4P3Bbvn5
         NUwkDGPyBGlNaNI5Edderncp3AA3gDraZ7g5MfW58+uguCxpYDrrU3ZMWiRmb34FJhae
         1rGGZO15TQnSs/E6KbFn8r+7fZOe0D/7in9o4PlVqaRtNCvBp86x5/n0GkzPkVxWNhL8
         Km7A==
X-Gm-Message-State: AOJu0YyHZ1opInkWTXie9T0FKx3O22jm5OKS8G3e2rBO1aysac8Bl5Eu
        r2B8UcWa5gW9hDArZ6HjMATUvnoAFAO1oe4tJZIPTgjYpW0X
X-Google-Smtp-Source: AGHT+IFdDepfBdz8j2YWRcZSFB2dfFx87KPOrv4q6e9N8Ug/QH/LE98GYKgHIneccbhlUkeKjg1dLUe+WtPm2/q9DIqUn81hzVTW
MIME-Version: 1.0
X-Received: by 2002:a4a:ea4a:0:b0:581:e2d5:a088 with SMTP id
 j10-20020a4aea4a000000b00581e2d5a088mr478614ooe.0.1698383464607; Thu, 26 Oct
 2023 22:11:04 -0700 (PDT)
Date:   Thu, 26 Oct 2023 22:11:04 -0700
In-Reply-To: <000000000000f3aeec05f025c6b8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019b7280608abb7f8@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in unlock_page (2)
From:   syzbot <syzbot+9d014e6e0df70d97c103@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, n.zhandarovich@fintech.ru,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 013ff63b649475f0ee134e2c8d0c8e65284ede50
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Jun 30 12:17:02 2023 +0000

    fs/ntfs3: Add more attributes checks in mi_enum_attr()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10677ddb680000
start commit:   18940c888c85 Merge tag 'sched_urgent_for_v6.3_rc4' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=9d014e6e0df70d97c103
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bf0adec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1391fcd5c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Add more attributes checks in mi_enum_attr()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
