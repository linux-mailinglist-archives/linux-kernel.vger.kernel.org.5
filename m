Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD977A595
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjHMI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjHMI0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 04:26:34 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6941710
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 01:26:37 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2685bc4f867so3770023a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 01:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691915196; x=1692519996;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHx5pQ865kQdSV3oc1VTb4RJPNDKiF3qG2AurMf0uII=;
        b=e8+a1P7vdkdBNUxeV3dPg1FOrHvV7Lu3yIeDujNZMdMJBWRyserKNyUc6oZgA6lHQm
         J8TD0r00AGdfzIegQOLPNwKNpUQE9Rw3PCl61Lq/Wauo5WtwuyuPaDG9Ilhkgx8acCqe
         j9XfKKxAFddF/dQTgJ7ddxtTgRovvThB720Rkq9oNUpHHITA5LUXrA6hymv4j/iuv6vk
         17IJslW2Gou1mEOTV9wix7xbPin0awROdIxOKrX1kde7gQ0AkKRLv7L9RkCGfDMuWvZw
         mFIxSpLSnSUEQnjbzA8sl1oHv+6CKhFti059i1tNKn0OS0Gq3OkApMa9W7IFnBaAK1vf
         gB+Q==
X-Gm-Message-State: AOJu0YzyG6t3WBZ9hquFtVgt6AKZu87mhZAEQFSXqkRlvOyhusUqspqG
        J01WcQFD9LQXdKweUhnk7iz8PujBvcbRzNBnwBdDzFBce4xM
X-Google-Smtp-Source: AGHT+IGYYglPH140FdNSx5GvsuVJ9WH70GFQwHtLb3I+yri16v2vev+Mrj3Md4vQp1vtP9PmR5/bEgHfq46nCDEv22uWoOcw8OKQ
MIME-Version: 1.0
X-Received: by 2002:a17:90b:ed5:b0:263:f16:3192 with SMTP id
 gz21-20020a17090b0ed500b002630f163192mr1355601pjb.3.1691915196654; Sun, 13
 Aug 2023 01:26:36 -0700 (PDT)
Date:   Sun, 13 Aug 2023 01:26:36 -0700
In-Reply-To: <00000000000090196d0602a6167d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000496a0f0602c9b43c@google.com>
Subject: Re: [syzbot] [net?] WARNING in unregister_vlan_dev
From:   syzbot <syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com>
To:     amir.hanania@intel.com, davem@davemloft.net, edumazet@google.com,
        hdanton@sina.com, horms@kernel.org, idosch@idosch.org,
        idosch@nvidia.com, jeffrey.t.kirsher@intel.com,
        john.fastabend@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        vladbu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 718cb09aaa6fa78cc8124e9517efbc6c92665384
Author: Vlad Buslov <vladbu@nvidia.com>
Date:   Tue Aug 8 09:35:21 2023 +0000

    vlan: Fix VLAN 0 memory leak

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ac8d6fa80000
start commit:   048c796beb6e ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ac8d6fa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac8d6fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=662f783a5cdf3add2719
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1604a23da80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15261ffda80000

Reported-by: syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com
Fixes: 718cb09aaa6f ("vlan: Fix VLAN 0 memory leak")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
