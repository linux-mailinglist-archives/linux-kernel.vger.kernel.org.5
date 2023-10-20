Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E90A7D0619
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346802AbjJTBVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJTBVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:21:39 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FB9119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:21:35 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1dd886536f2so395612fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697764894; x=1698369694;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks5xFPz0neLCFVgjA9rWdPJvEARtx5SNCe643jmQpmM=;
        b=KNtHcSCy2dMrrWa4k4cyUl63s2dWn9ic33tLXmfQTwnZdmo2b8rKIRKbocrCoHM7zW
         uznfNUcVpslsDhxjccpZr6avETwKTRHSZy5y3UZf/rvpFg/lCU83Fr2w7lZMPTZN1L6J
         ft1jJDBXBX6dPbmh3lXd+eVhGFvK4Xa3/uZR6wu9l/+xUF8LUaAfhBDRFlxKHBXzeE4v
         zpzuR0731lYjOd7MzLygL/YGBSLaS0RjhMMuUj7Uj31447OjfxPauGfiytnngzCmfj2O
         wSUxWc9jRptTB1D+MX7F8zzPmLyFish+aHY6SvyzuWxsqhXHW3B8Nk32XUzug/cEFFG9
         quxQ==
X-Gm-Message-State: AOJu0YyiRcVbqbgoAyWWzasA45kkfOUU/ngq9sr4E04hdMpwM1eja+XJ
        EOhXsTWS6TeR9CfsXPDlQP7sZDd4nqxKBhLxNjLhM66hwSdX
X-Google-Smtp-Source: AGHT+IHrpg6TOpxK0winCe43JcIjSqnD2Q6uxA1D9TsKfUrc5sYWG4eYpImadqLZDozuSnEkCVr8rbmstAsQm80ippX351MpbQw+
MIME-Version: 1.0
X-Received: by 2002:a05:6871:331e:b0:1e9:c2a7:6593 with SMTP id
 nf30-20020a056871331e00b001e9c2a76593mr256478oac.6.1697764894315; Thu, 19 Oct
 2023 18:21:34 -0700 (PDT)
Date:   Thu, 19 Oct 2023 18:21:34 -0700
In-Reply-To: <000000000000f014150604d5040a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000701c7d06081bb14d@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in serio_handle_event
From:   syzbot <syzbot+bbc59256015533127d80@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        ricardo@marliere.net, skhan@linuxfoundation.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Aug 28 14:58:24 2023 +0000

    driver core: return an error when dev_set_name() hasn't happened

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a45b9d680000
start commit:   65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=bbc59256015533127d80
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d70614680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130eedb8680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: driver core: return an error when dev_set_name() hasn't happened

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
