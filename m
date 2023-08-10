Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B2778383
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjHJWOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjHJWOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:14:39 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111B273D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:14:38 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-564fec87e4fso1793649a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691705678; x=1692310478;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iSfVQKiy94ihvevaPz7mdBT1Zd/e8n0em7o/WIjuQ0=;
        b=Y80Rx2IVd3b4bwrhLoP4PNglj/RAVQ3G3UqqKu0ikGN1RWKvx7JXSGoLISBMWq8a/P
         62GASIKJGg6U7FDWBKEf4dmfzh83w8iBFHu4BRvRiXMYGmPC8sHv5WcKRHJL/TNzvcBW
         qzVqKAKuhpiOGFv/xKYbz29i4IIjBAZtZxoP04r/Ml5KXVojrgzJkeLcn573b44KRH4d
         5QxgGVkv4KEPmTn3Vew1tottYDei6+4eSHJ05B4eLh023JDnCk+v/4ppxdwn+THDQpOw
         jv5qZ+DVcMCLbhdPCaiFL2kWFBRSTJ+W9HcyBeVsoKUWowClL7yE2NUUk9aVzh5peiaE
         dr/A==
X-Gm-Message-State: AOJu0YzyXfFIjzWXs14Tgz6F+iw2/790uOpVTTIpFByv6uojFIZgyJdk
        lJX3Wm1vKYOb1J5Xsql1g4Lrdo2dJtbgea9+W710B8dCnpzn
X-Google-Smtp-Source: AGHT+IHTzTABqpJVuLtnELQWEcoBDNkcI7acDmY68LAjTTfOxK2QXJmkSMtIbz4lbKeoczQf+GCJ8xGSG+P8VQnPmUL+jm88OSVl
MIME-Version: 1.0
X-Received: by 2002:a17:902:e748:b0:1bd:9c78:8042 with SMTP id
 p8-20020a170902e74800b001bd9c788042mr13632plf.11.1691705678229; Thu, 10 Aug
 2023 15:14:38 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:14:38 -0700
In-Reply-To: <00000000000040e14205ffbf333f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003f591060298ecc6@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in wnd_add_free_ext (2)
From:   syzbot <syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
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

syzbot has bisected this issue to:

commit 3880f2b816a7e4ca889b7e8a42e6c62c5706ed36
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Oct 25 15:31:28 2021 +0000

    fs/ntfs3: Fix fiemap + fix shrink file size (to remove preallocated space)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168fd89ba80000
start commit:   f6a691685962 Merge tag '6.5-rc4-smb3-client-fix' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=158fd89ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=118fd89ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=5b2f934f08ab03d473ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f56679a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118b8eeda80000

Reported-by: syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com
Fixes: 3880f2b816a7 ("fs/ntfs3: Fix fiemap + fix shrink file size (to remove preallocated space)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
