Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18B798649
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbjIHLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjIHLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:10:39 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAED173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 04:10:35 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c093862623so27173325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 04:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694171435; x=1694776235;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Pj200tvpklwfbEgbw8/nQ7ByLVdPtnnvWAycl/WhDk=;
        b=rlZ7iKhekKcHCqgCTt9rV4oHhBZS96g78THOQiJPUMqCdMWPVQfPuilHXGXEEaEbQf
         Rw22nxyvgCy2ybwFJR63O9i+RySQ4I3+tS6RIG0+z/rtsd5xb5U3OKEkKq+W53GRQMWO
         RG1+TvOza7Ndm9DCCy1WlASK3eUyt7ZDTBF2OWQHUQoV1zjQ9zytLVgm9LEDzgjMgsOl
         QLtqhO4+sMSRf4n5OR2NQaq2I1DsNTu8m46Z42VaogymgmdvoU5Ip41CuTCQbdY3ZsN1
         i8smtEJtaeVnZeV+YEQqfKuOsHAbu2qMHnnj3SBExHK6+CwXr8478BUUCKsbmNaa1LkG
         Oq+A==
X-Gm-Message-State: AOJu0YzctJDng9P439EZDNKRkCJrCHcWtwEKX2zzB/Ds4c0mkz+5MWrJ
        pwMiIM36CjouQJuy4td7VnmIhyKMdyBuNuSPINVbjXeF+x/Z
X-Google-Smtp-Source: AGHT+IFd3SqZrhD1n3tzdTdBWxexLj2lz8EWKIYHvV9ePNfmUTmka016X91x19EQ1YSCmG+S3TPEkMjU3BxkmYUnc4Mrym7ynwUH
MIME-Version: 1.0
X-Received: by 2002:a17:902:dad1:b0:1ba:a36d:f82c with SMTP id
 q17-20020a170902dad100b001baa36df82cmr738084plx.7.1694171435065; Fri, 08 Sep
 2023 04:10:35 -0700 (PDT)
Date:   Fri, 08 Sep 2023 04:10:34 -0700
In-Reply-To: <000000000000d04ea90604a6efcc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009367d80604d706ab@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in usb_hub_create_port_device
From:   syzbot <syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit d21fdd07cea418c0d98c8a15fc95b8b8970801e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Aug 17 09:12:21 2023 +0000

    driver core: Return proper error code when dev_set_name() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146569c8680000
start commit:   7733171926cc Merge tag 'mailbox-v6.6' of git://git.linaro...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=166569c8680000
console output: https://syzkaller.appspot.com/x/log.txt?x=126569c8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b273cdfbc13e9a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=c063a4e176681d2e0380
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a4ca00680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bed168680000

Reported-by: syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com
Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
