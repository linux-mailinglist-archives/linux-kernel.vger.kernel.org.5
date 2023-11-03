Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D57E02C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376321AbjKCM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376270AbjKCM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:27:11 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33081A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:27:04 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ce37a2b2e9so2469068a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 05:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699014424; x=1699619224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbURBXZ/3HBo11neS1hBFiZneNWug5j0JM5oUnIOIkc=;
        b=PTw3B7vfJ6YXswSJ7f9JYaYgRk5gklX7B7fVvW4sJ9NHEN1cJW97KxrnKuqfW/hl7S
         Dve7Off/BTRzN/iQTOuTfZXQnmfP/M+ZKwFc83L6wypI9PypKzp4tox3qvUP/t2uui4J
         1LwY+m9CPiUb9WzseahovPr2JTGCwqLaPQAwJp1fEUA6yNyDBRIyaDR4gzRljGvUsaf6
         mZkg7IUeaBx7V519PgmXiQ1fDP0sxvxK54yp9apHa8Pde2LZE+7ZJYe35obASapGnImZ
         4zFQwyrQlQp4OeF5KTXk7IW36cD1krukjdWYWbPJOzArNcgrBcGOXFo4tfpn/HnZFmx/
         G/AQ==
X-Gm-Message-State: AOJu0YyZ7q6Wtx0Yb1spcufQHilyyRh2Yy2LmJF+jmAhjuqkQTFpu5qY
        i1R1V1UMo5Ab/RRlM9l0stwUpv1b9rwRWMZiyTtusRXyhDHU
X-Google-Smtp-Source: AGHT+IF432B2k/4JgF8MvDVFRRX/gAgDGc4yukU2jI9h9EJThloFIMpXblHdmi8bUUS4mHAw67tALiKWRT92dEEXtFtICAKoXVO9
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a11a:b0:1ea:85b:62a3 with SMTP id
 m26-20020a056870a11a00b001ea085b62a3mr10048223oae.1.1699014424405; Fri, 03
 Nov 2023 05:27:04 -0700 (PDT)
Date:   Fri, 03 Nov 2023 05:27:04 -0700
In-Reply-To: <000000000000af7bd706084b7cb2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c325306093e9f25@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in fat_write_inode
From:   syzbot <syzbot+6f75830acb2e4cdc8e50@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org,
        hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit fb96458067a8043c256befe4bfe4fb3ebc81de1b
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Oct 16 20:10:48 2023 +0000

    buffer: return bool from grow_dev_folio()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154b4ef7680000
start commit:   2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=174b4ef7680000
console output: https://syzkaller.appspot.com/x/log.txt?x=134b4ef7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=6f75830acb2e4cdc8e50
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148fed9d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1019f523680000

Reported-by: syzbot+6f75830acb2e4cdc8e50@syzkaller.appspotmail.com
Fixes: fb96458067a8 ("buffer: return bool from grow_dev_folio()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
