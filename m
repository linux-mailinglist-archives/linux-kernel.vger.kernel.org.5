Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F8802112
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 06:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjLCFZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 00:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCFY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 00:24:59 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7877FFB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 21:25:05 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b88c1f5ecaso2822552b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 21:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701581104; x=1702185904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gh8kA0wvcEudJg4sTCzviSk9gPRZ58CLaMI+8dOTqeg=;
        b=Ma0kwdym7c1Xhz3x8RaU9xIBQxgksz6lKsIFTC6X7gS0g9Ds0hgL10mCGgxDAWSsT9
         JPNminhUCuUdamqX5ySUilaJv1fp455RO05n5qnu7MrbCSKqr3G/HDQk1XrA18rvux8g
         FA6VBtiXw4q+/DiefUxhnjehxquGTKJhJtiebCYu0NpxHpN9jLYaOY9VhywjMfY/v8xc
         zCsDwsfMtoNbMbhyTPXljbN2tMv0/7hO3E00reEVXcR7mmCBAnUgn7HLY7CKibFXbaFo
         IctvHjHUkQ3ZXjkH5qN2K8XmENuR4Uz4yGROoRtpFk6vI96WfbJRXQ0bVatL8ABMSjYY
         onqA==
X-Gm-Message-State: AOJu0YxoFtfZqrgsO4VKEhTSncW3u5ETv9Og+gk201MMbClBzokVuEL8
        0ZhlfgUqxIQXWqEN2rIyKRdsr687NpCFnjCV9cVCOk9B84zu
X-Google-Smtp-Source: AGHT+IEDkTe1NFy8Y5QzTTM+crOH53QnZSWciCcsTjwYdrTuB7mIO4LDXoZqEvhZEj1GGk+/ZWWcmX0wDRoOmUA5vaOGR++lr6JE
MIME-Version: 1.0
X-Received: by 2002:a05:6808:344:b0:3ae:61f:335e with SMTP id
 j4-20020a056808034400b003ae061f335emr1111285oie.5.1701581104799; Sat, 02 Dec
 2023 21:25:04 -0800 (PST)
Date:   Sat, 02 Dec 2023 21:25:04 -0800
In-Reply-To: <000000000000f841fb05eb364ce6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ee8c3060b943920@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in txCommit
From:   syzbot <syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com>
To:     brauner@kernel.org, dave.kleikamp@oracle.com,
        ghandatmanas@gmail.com, jack@suse.cz,
        jfs-discussion@lists.sourceforge.net, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, liushixin2@huawei.com,
        mirimmad17@gmail.com, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a779ed754e52d582b8c0e17959df063108bd0656
Author: Dave Kleikamp <dave.kleikamp@oracle.com>
Date:   Thu Oct 5 14:16:14 2023 +0000

    jfs: define xtree root and page independently

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f67ce2e80000
start commit:   d88520ad73b7 Merge tag 'pull-nfsd-fix' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ee601744db6e780
dashboard link: https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e974ed680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b2588b680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: jfs: define xtree root and page independently

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
