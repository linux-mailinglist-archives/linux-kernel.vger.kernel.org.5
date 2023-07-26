Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C03C762C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjGZG6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjGZG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:57:52 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA63A9C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:57:25 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1b03f7fb970so12389554fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690354643; x=1690959443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9IC2Px3hsKC6Dxupx1FkylpkrCD57M7Lz4dPPJQv8I=;
        b=hvmkGs3H8/m4qVAq5kcBRzzelFKJfa9zPGKDcPlR+eJrqc4Zk5qYiDpgMXeeqJHy0j
         m57CB7UbGYC0S/ikWWAzG4jCugbrTrKnZhs4ob8OHAcTPzUm+AWmLkBrnX1qeu/0ZbLD
         33+C37EmoIIKdt1DR75J4dtu7XO0Ya7YXCMzNeVbp9I7A1lNQH4tJGN913JKcdl5dDDM
         cNjYao2oKRpTLzV4F1UvHgk4LnU2jomXzn0okLWMBpRlFGCWY6JPOoxIMh5N0Xsm16po
         /JyeJBWGPAFATrWU1rD+oOXLB2W8yR4sBwS6+5xDY+ufhmtNKbMtgGfVJUP1Q2KfYrjt
         iV/w==
X-Gm-Message-State: ABy/qLZGZVZyAksEqJV81Q1FvMJbN/4FzvVvVmigc7T68LPkAb2dfKZ/
        vNOwXR0HLSRWE1rRrzsWLzJJSzgBFoDBG/YOZP2w8V48N6fQ
X-Google-Smtp-Source: APBJJlEi0z/gxY9IKB9ZOROVZVrRiCmSqriMamO7iN1Vub7x4hmgU++d1Fui/uaeIMI5hdqa5e1O7nWfnmEEYHKIO1e0Dkad+4F7
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c7a8:b0:1ba:e872:7a2e with SMTP id
 dy40-20020a056870c7a800b001bae8727a2emr2252504oab.11.1690354643035; Tue, 25
 Jul 2023 23:57:23 -0700 (PDT)
Date:   Tue, 25 Jul 2023 23:57:22 -0700
In-Reply-To: <000000000000607ff905ffc8e477@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000aeb7f06015e5cbd@google.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
From:   syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit a52f58b34afe095ebc5823684eb264404dad6f7b
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Jul 24 18:54:10 2023 +0000

    mm: handle faults that merely update the accessed bit under the VMA lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1783585ea80000
start commit:   [unknown] 
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1443585ea80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1043585ea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481ab36ce878b84
dashboard link: https://syzkaller.appspot.com/bug?extid=8645fe63c4d22c8d27b8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1697cec9a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1566986ea80000

Reported-by: syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com
Fixes: a52f58b34afe ("mm: handle faults that merely update the accessed bit under the VMA lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
